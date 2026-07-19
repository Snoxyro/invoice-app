using InvoiceApp.Common.Dtos.Users;
using InvoiceApp.Common.Entities;
using InvoiceApp.Common.Exceptions;
using InvoiceApp.Common.Paging;
using InvoiceApp.Common.Security;
using InvoiceApp.Repository;
using InvoiceApp.Repository.Extensions;
using Microsoft.EntityFrameworkCore;

namespace InvoiceApp.Service.Users;

public class UserService : IUserService
{
    private readonly IRepository<User> _userRepository;
    private readonly IPasswordHasher _passwordHasher;

    public UserService(IRepository<User> userRepository, IPasswordHasher passwordHasher)
    {
        _userRepository = userRepository;
        _passwordHasher = passwordHasher;
    }

    public async Task<UserResponse> CreateAsync(UserCreateRequest request)
    {
        var nameExists = await _userRepository.Query().AnyAsync(u => u.UserName == request.UserName);

        if (nameExists)
        {
            throw new BusinessRuleException(
                ErrorCodes.UsernameAlreadyExists,
                new Dictionary<string, string> { ["userName"] = request.UserName });
        }

        var user = new User
        {
            UserName = request.UserName,
            PasswordHash = _passwordHasher.HashPassword(request.Password),
            Role = request.Role
        };

        await _userRepository.AddAsync(user);
        await _userRepository.SaveChangesAsync();

        return MapToResponse(user);
    }

    public async Task<UserResponse> UpdateAsync(int userId, UserUpdateRequest request)
    {
        var user = await _userRepository.GetByIdAsync(userId)
            ?? throw new NotFoundException(
                ErrorCodes.UserNotFound,
                new Dictionary<string, string> { ["userId"] = userId.ToString() });

        var nameExists = await _userRepository.Query()
            .AnyAsync(u => u.UserName == request.UserName && u.UserId != userId);

        if (nameExists)
        {
            throw new BusinessRuleException(
                ErrorCodes.UsernameAlreadyExists,
                new Dictionary<string, string> { ["userName"] = request.UserName });
        }

        user.UserName = request.UserName;
        user.Role = request.Role;

        if (!string.IsNullOrWhiteSpace(request.NewPassword))
        {
            user.PasswordHash = _passwordHasher.HashPassword(request.NewPassword);
        }

        _userRepository.Update(user);
        await _userRepository.SaveChangesAsync();

        return MapToResponse(user);
    }

    public async Task DeleteAsync(int userId, int currentUserId)
    {
        if (userId == currentUserId)
        {
            throw new BusinessRuleException(ErrorCodes.CannotDeleteOwnAccount);
        }

        var user = await _userRepository.GetByIdAsync(userId)
            ?? throw new NotFoundException(
                ErrorCodes.UserNotFound,
                new Dictionary<string, string> { ["userId"] = userId.ToString() });

        _userRepository.Remove(user);
        await _userRepository.SaveChangesAsync();
    }

    public async Task<UserResponse> GetByIdAsync(int userId)
    {
        var user = await _userRepository.GetByIdAsync(userId)
            ?? throw new NotFoundException(
                ErrorCodes.UserNotFound,
                new Dictionary<string, string> { ["userId"] = userId.ToString() });

        return MapToResponse(user);
    }

    public async Task<PagedResult<UserResponse>> GetPagedAsync(PagedRequest request)
    {
        var query = _userRepository.Query();

        if (!string.IsNullOrWhiteSpace(request.SearchTerm))
        {
            query = query.Where(u => u.UserName.Contains(request.SearchTerm));
        }

        query = request.SortBy?.ToLower() switch
        {
            "username" => request.SortDirection == SortDirection.Descending
                ? query.OrderByDescending(u => u.UserName)
                : query.OrderBy(u => u.UserName),
            "role" => request.SortDirection == SortDirection.Descending
                ? query.OrderByDescending(u => u.Role)
                : query.OrderBy(u => u.Role),
            _ => request.SortDirection == SortDirection.Descending
                ? query.OrderByDescending(u => u.CreatedDate)
                : query.OrderBy(u => u.CreatedDate)
        };

        var pagedUsers = await query.ToPagedResultAsync(request.Page, request.PageSize);

        return new PagedResult<UserResponse>
        {
            Items = pagedUsers.Items.Select(MapToResponse).ToList(),
            TotalCount = pagedUsers.TotalCount,
            Page = pagedUsers.Page,
            PageSize = pagedUsers.PageSize
        };
    }

    private static UserResponse MapToResponse(User user)
    {
        return new UserResponse
        {
            UserId = user.UserId,
            UserName = user.UserName,
            Role = user.Role,
            CreatedDate = user.CreatedDate,
            UpdatedDate = user.UpdatedDate
        };
    }
}