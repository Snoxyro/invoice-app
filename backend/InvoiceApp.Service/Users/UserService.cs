using InvoiceApp.Common.Dtos.Users;
using InvoiceApp.Common.Entities;
using InvoiceApp.Common.Exceptions;
using InvoiceApp.Common.Paging;
using InvoiceApp.Common.Security;
using InvoiceApp.Repository;
using InvoiceApp.Repository.Extensions;
using InvoiceApp.Service.Permissions;
using Microsoft.EntityFrameworkCore;

namespace InvoiceApp.Service.Users;

public class UserService : IUserService
{
    private readonly IRepository<User> _userRepository;
    private readonly IRepository<Profile> _profileRepository;
    private readonly IPasswordHasher _passwordHasher;
    private readonly IPermissionService _permissionService;

    public UserService(
        IRepository<User> userRepository,
        IRepository<Profile> profileRepository,
        IPasswordHasher passwordHasher,
        IPermissionService permissionService)
    {
        _userRepository = userRepository;
        _profileRepository = profileRepository;
        _passwordHasher = passwordHasher;
        _permissionService = permissionService;
    }

    public async Task<UserResponse> CreateAsync(int currentUserId, UserCreateRequest request)
    {
        var callerContext = await _permissionService.GetUserContextAsync(currentUserId);
        var currentFirmId = callerContext.FirmId ?? throw new BusinessRuleException(ErrorCodes.UserHasNoFirm);

        var nameExists = await _userRepository.Query().AnyAsync(u => u.UserName == request.UserName);

        if (nameExists)
        {
            throw new BusinessRuleException(
                ErrorCodes.UsernameAlreadyExists,
                new Dictionary<string, string> { ["userName"] = request.UserName });
        }

        var targetProfile = await _profileRepository.Query()
            .FirstOrDefaultAsync(p => p.ProfileId == request.ProfileId && p.FirmId == currentFirmId);

        if (targetProfile is null)
        {
            throw new NotFoundException(
                ErrorCodes.ProfileNotFound,
                new Dictionary<string, string> { ["profileId"] = request.ProfileId.ToString() });
        }

        var targetDefinition = await _permissionService.GetProfileDefinitionAsync(request.ProfileId);

        if (!targetDefinition.IsSubsetOf(callerContext))
        {
            throw new BusinessRuleException(ErrorCodes.CannotGrantBeyondOwnPermissions);
        }

        var user = new User
        {
            UserName = request.UserName,
            PasswordHash = _passwordHasher.HashPassword(request.Password),
            Role = UserRole.FirmUser,
            FirmId = currentFirmId,
            ProfileId = request.ProfileId
        };

        await _userRepository.AddAsync(user);
        await _userRepository.SaveChangesAsync();

        return MapToResponse(user, targetProfile.Name);
    }

    public async Task<UserResponse> UpdateAsync(int currentUserId, int userId, UserUpdateRequest request)
    {
        if (userId == currentUserId)
        {
            throw new BusinessRuleException(ErrorCodes.CannotEditOwnAccount);
        }

        var callerContext = await _permissionService.GetUserContextAsync(currentUserId);
        var currentFirmId = callerContext.FirmId ?? throw new BusinessRuleException(ErrorCodes.UserHasNoFirm);

        var user = await _userRepository.Query()
            .FirstOrDefaultAsync(u => u.UserId == userId && u.FirmId == currentFirmId);

        if (user is null)
        {
            throw new NotFoundException(
                ErrorCodes.UserNotFound,
                new Dictionary<string, string> { ["userId"] = userId.ToString() });
        }

        if (user.ProfileId is not null)
        {
            var currentProfileDefinition = await _permissionService.GetProfileDefinitionAsync(user.ProfileId.Value);

            if (!currentProfileDefinition.IsSubsetOf(callerContext))
            {
                throw new BusinessRuleException(ErrorCodes.CannotManageStrongerUser);
            }
        }

        var nameExists = await _userRepository.Query()
            .AnyAsync(u => u.UserName == request.UserName && u.UserId != userId);

        if (nameExists)
        {
            throw new BusinessRuleException(
                ErrorCodes.UsernameAlreadyExists,
                new Dictionary<string, string> { ["userName"] = request.UserName });
        }

        var targetProfile = await _profileRepository.Query()
            .FirstOrDefaultAsync(p => p.ProfileId == request.ProfileId && p.FirmId == currentFirmId);

        if (targetProfile is null)
        {
            throw new NotFoundException(
                ErrorCodes.ProfileNotFound,
                new Dictionary<string, string> { ["profileId"] = request.ProfileId.ToString() });
        }

        var targetDefinition = await _permissionService.GetProfileDefinitionAsync(request.ProfileId);

        if (!targetDefinition.IsSubsetOf(callerContext))
        {
            throw new BusinessRuleException(ErrorCodes.CannotGrantBeyondOwnPermissions);
        }

        if (user.ProfileId is not null && user.ProfileId != request.ProfileId)
        {
            var currentHolderProfile = await _profileRepository.GetByIdAsync(user.ProfileId.Value);

            if (currentHolderProfile is { IsSystem: true })
            {
                var holderCount = await _permissionService.GetProfileHolderCountAsync(user.ProfileId.Value);

                if (holderCount <= 1)
                {
                    throw new BusinessRuleException(ErrorCodes.LastFullPermissionUserCannotBeRemoved);
                }
            }
        }

        user.UserName = request.UserName;
        user.ProfileId = request.ProfileId;

        if (!string.IsNullOrWhiteSpace(request.NewPassword))
        {
            user.PasswordHash = _passwordHasher.HashPassword(request.NewPassword);
        }

        _userRepository.Update(user);
        await _userRepository.SaveChangesAsync();

        return MapToResponse(user, targetProfile.Name);
    }

    public async Task DeleteAsync(int currentUserId, int userId)
    {
        if (userId == currentUserId)
        {
            throw new BusinessRuleException(ErrorCodes.CannotDeleteOwnAccount);
        }

        var callerContext = await _permissionService.GetUserContextAsync(currentUserId);
        var currentFirmId = callerContext.FirmId ?? throw new BusinessRuleException(ErrorCodes.UserHasNoFirm);

        var user = await _userRepository.Query()
            .FirstOrDefaultAsync(u => u.UserId == userId && u.FirmId == currentFirmId);

        if (user is null)
        {
            throw new NotFoundException(
                ErrorCodes.UserNotFound,
                new Dictionary<string, string> { ["userId"] = userId.ToString() });
        }

        if (user.ProfileId is not null)
        {
            var currentProfileDefinition = await _permissionService.GetProfileDefinitionAsync(user.ProfileId.Value);

            if (!currentProfileDefinition.IsSubsetOf(callerContext))
            {
                throw new BusinessRuleException(ErrorCodes.CannotManageStrongerUser);
            }

            var currentHolderProfile = await _profileRepository.GetByIdAsync(user.ProfileId.Value);

            if (currentHolderProfile is { IsSystem: true })
            {
                var holderCount = await _permissionService.GetProfileHolderCountAsync(user.ProfileId.Value);

                if (holderCount <= 1)
                {
                    throw new BusinessRuleException(ErrorCodes.LastFullPermissionUserCannotBeRemoved);
                }
            }
        }

        _userRepository.Remove(user);
        await _userRepository.SaveChangesAsync();
    }

    public async Task<UserResponse> GetByIdAsync(int currentUserId, int userId)
    {
        var callerContext = await _permissionService.GetUserContextAsync(currentUserId);
        var currentFirmId = callerContext.FirmId ?? throw new BusinessRuleException(ErrorCodes.UserHasNoFirm);

        var user = await _userRepository.Query()
            .Include(u => u.Profile)
            .FirstOrDefaultAsync(u => u.UserId == userId && u.FirmId == currentFirmId);

        if (user is null)
        {
            throw new NotFoundException(
                ErrorCodes.UserNotFound,
                new Dictionary<string, string> { ["userId"] = userId.ToString() });
        }

        return MapToResponse(user, user.Profile?.Name);
    }

    public async Task<PagedResult<UserResponse>> GetPagedAsync(int currentUserId, PagedRequest request)
    {
        var callerContext = await _permissionService.GetUserContextAsync(currentUserId);
        var currentFirmId = callerContext.FirmId ?? throw new BusinessRuleException(ErrorCodes.UserHasNoFirm);

        var query = _userRepository.Query()
            .Include(u => u.Profile)
            .Where(u => u.FirmId == currentFirmId);

        if (!string.IsNullOrWhiteSpace(request.SearchTerm))
        {
            query = query.Where(u => u.UserName.Contains(request.SearchTerm));
        }

        query = request.SortBy?.ToLower() switch
        {
            "username" => request.SortDirection == SortDirection.Descending
                ? query.OrderByDescending(u => u.UserName)
                : query.OrderBy(u => u.UserName),
            "profilename" => request.SortDirection == SortDirection.Descending
                ? query.OrderByDescending(u => u.Profile!.Name)
                : query.OrderBy(u => u.Profile!.Name),
            _ => request.SortDirection == SortDirection.Descending
                ? query.OrderByDescending(u => u.CreatedDate)
                : query.OrderBy(u => u.CreatedDate)
        };

        var pagedUsers = await query.ToPagedResultAsync(request.Page, request.PageSize);

        return new PagedResult<UserResponse>
        {
            Items = pagedUsers.Items.Select(u => MapToResponse(u, u.Profile?.Name)).ToList(),
            TotalCount = pagedUsers.TotalCount,
            Page = pagedUsers.Page,
            PageSize = pagedUsers.PageSize
        };
    }

    private static UserResponse MapToResponse(User user, string? profileName)
    {
        return new UserResponse
        {
            UserId = user.UserId,
            UserName = user.UserName,
            Role = user.Role,
            ProfileId = user.ProfileId,
            ProfileName = profileName,
            CreatedDate = user.CreatedDate,
            UpdatedDate = user.UpdatedDate
        };
    }
}
