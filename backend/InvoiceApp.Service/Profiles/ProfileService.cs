using InvoiceApp.Common.Dtos.Permissions;
using InvoiceApp.Common.Dtos.Profiles;
using InvoiceApp.Common.Dtos.VatRates;
using InvoiceApp.Common.Entities;
using InvoiceApp.Common.Exceptions;
using InvoiceApp.Common.Paging;
using InvoiceApp.Repository;
using InvoiceApp.Repository.Extensions;
using InvoiceApp.Service.Permissions;
using Microsoft.EntityFrameworkCore;

namespace InvoiceApp.Service.Profiles;

public class ProfileService : IProfileService
{
    private readonly IRepository<Profile> _profileRepository;
    private readonly IRepository<Permission> _permissionRepository;
    private readonly IRepository<VatRate> _vatRateRepository;
    private readonly IRepository<ProfilePermission> _profilePermissionRepository;
    private readonly IRepository<ProfileVatRate> _profileVatRateRepository;
    private readonly IRepository<User> _userRepository;
    private readonly IPermissionService _permissionService;

    public ProfileService(
        IRepository<Profile> profileRepository,
        IRepository<Permission> permissionRepository,
        IRepository<VatRate> vatRateRepository,
        IRepository<ProfilePermission> profilePermissionRepository,
        IRepository<ProfileVatRate> profileVatRateRepository,
        IRepository<User> userRepository,
        IPermissionService permissionService)
    {
        _profileRepository = profileRepository;
        _permissionRepository = permissionRepository;
        _vatRateRepository = vatRateRepository;
        _profilePermissionRepository = profilePermissionRepository;
        _profileVatRateRepository = profileVatRateRepository;
        _userRepository = userRepository;
        _permissionService = permissionService;
    }

    public async Task<ProfileResponse> CreateAsync(int currentUserId, ProfileCreateRequest request)
    {
        var callerContext = await _permissionService.GetUserContextAsync(currentUserId);
        var currentFirmId = callerContext.FirmId ?? throw new BusinessRuleException(ErrorCodes.UserHasNoFirm);

        var nameExists = await _profileRepository.Query()
            .AnyAsync(p => p.FirmId == currentFirmId && p.Name == request.Name);

        if (nameExists)
        {
            throw new BusinessRuleException(
                ErrorCodes.ProfileNameAlreadyExists,
                new Dictionary<string, string> { ["name"] = request.Name });
        }

        ValidateInvoiceRange(request.MinInvoiceAmount, request.MaxInvoiceAmount);

        var candidateDefinition = await BuildCandidateDefinitionAsync(
            request.PermissionIds, request.VatRateIds, request.MinInvoiceAmount, request.MaxInvoiceAmount);

        if (!candidateDefinition.IsSubsetOf(callerContext))
        {
            throw new BusinessRuleException(ErrorCodes.CannotGrantBeyondOwnPermissions);
        }

        var profile = new Profile
        {
            FirmId = currentFirmId,
            Name = request.Name,
            IsSystem = false,
            MinInvoiceAmount = request.MinInvoiceAmount,
            MaxInvoiceAmount = request.MaxInvoiceAmount
        };

        foreach (var permissionId in request.PermissionIds.Distinct())
        {
            profile.ProfilePermissions.Add(new ProfilePermission { PermissionId = permissionId });
        }

        foreach (var vatRateId in request.VatRateIds.Distinct())
        {
            profile.ProfileVatRates.Add(new ProfileVatRate { VatRateId = vatRateId });
        }

        await _profileRepository.AddAsync(profile);
        await _profileRepository.SaveChangesAsync();

        return MapToResponse(profile);
    }

    public async Task<ProfileResponse> UpdateAsync(int currentUserId, int profileId, ProfileUpdateRequest request)
    {
        var callerContext = await _permissionService.GetUserContextAsync(currentUserId);
        var currentFirmId = callerContext.FirmId ?? throw new BusinessRuleException(ErrorCodes.UserHasNoFirm);

        var profile = await _profileRepository.Query()
            .FirstOrDefaultAsync(p => p.ProfileId == profileId && p.FirmId == currentFirmId);

        if (profile is null)
        {
            throw new NotFoundException(
                ErrorCodes.ProfileNotFound,
                new Dictionary<string, string> { ["profileId"] = profileId.ToString() });
        }

        if (profile.IsSystem)
        {
            throw new BusinessRuleException(ErrorCodes.ProfileIsSystemCannotModify);
        }

        if (profileId == callerContext.ProfileId)
        {
            throw new BusinessRuleException(ErrorCodes.CannotEditOwnAccount);
        }

        var existingDefinition = await _permissionService.GetProfileDefinitionAsync(profileId);

        if (!existingDefinition.IsSubsetOf(callerContext))
        {
            throw new BusinessRuleException(ErrorCodes.ProfileStrongerThanCaller);
        }

        var nameExists = await _profileRepository.Query()
            .AnyAsync(p => p.FirmId == currentFirmId && p.Name == request.Name && p.ProfileId != profileId);

        if (nameExists)
        {
            throw new BusinessRuleException(
                ErrorCodes.ProfileNameAlreadyExists,
                new Dictionary<string, string> { ["name"] = request.Name });
        }

        ValidateInvoiceRange(request.MinInvoiceAmount, request.MaxInvoiceAmount);

        var candidateDefinition = await BuildCandidateDefinitionAsync(
            request.PermissionIds, request.VatRateIds, request.MinInvoiceAmount, request.MaxInvoiceAmount);

        if (!candidateDefinition.IsSubsetOf(callerContext))
        {
            throw new BusinessRuleException(ErrorCodes.CannotGrantBeyondOwnPermissions);
        }

        profile.Name = request.Name;
        profile.MinInvoiceAmount = request.MinInvoiceAmount;
        profile.MaxInvoiceAmount = request.MaxInvoiceAmount;

        var existingPermissionLinks = await _profilePermissionRepository.Query()
            .Where(pp => pp.ProfileId == profileId)
            .ToListAsync();

        foreach (var link in existingPermissionLinks)
        {
            _profilePermissionRepository.Remove(link);
        }

        foreach (var permissionId in request.PermissionIds.Distinct())
        {
            profile.ProfilePermissions.Add(new ProfilePermission { ProfileId = profileId, PermissionId = permissionId });
        }

        var existingVatLinks = await _profileVatRateRepository.Query()
            .Where(pv => pv.ProfileId == profileId)
            .ToListAsync();

        foreach (var link in existingVatLinks)
        {
            _profileVatRateRepository.Remove(link);
        }

        foreach (var vatRateId in request.VatRateIds.Distinct())
        {
            profile.ProfileVatRates.Add(new ProfileVatRate { ProfileId = profileId, VatRateId = vatRateId });
        }

        _profileRepository.Update(profile);
        await _profileRepository.SaveChangesAsync();

        return MapToResponse(profile);
    }

    public async Task DeleteAsync(int currentUserId, int profileId)
    {
        var callerContext = await _permissionService.GetUserContextAsync(currentUserId);
        var currentFirmId = callerContext.FirmId ?? throw new BusinessRuleException(ErrorCodes.UserHasNoFirm);

        var profile = await _profileRepository.Query()
            .FirstOrDefaultAsync(p => p.ProfileId == profileId && p.FirmId == currentFirmId);

        if (profile is null)
        {
            throw new NotFoundException(
                ErrorCodes.ProfileNotFound,
                new Dictionary<string, string> { ["profileId"] = profileId.ToString() });
        }

        if (profile.IsSystem)
        {
            throw new BusinessRuleException(ErrorCodes.ProfileIsSystemCannotModify);
        }

        if (profileId == callerContext.ProfileId)
        {
            throw new BusinessRuleException(ErrorCodes.CannotEditOwnAccount);
        }

        var existingDefinition = await _permissionService.GetProfileDefinitionAsync(profileId);

        if (!existingDefinition.IsSubsetOf(callerContext))
        {
            throw new BusinessRuleException(ErrorCodes.ProfileStrongerThanCaller);
        }

        var hasUsers = await _userRepository.Query().AnyAsync(u => u.ProfileId == profileId);

        if (hasUsers)
        {
            throw new BusinessRuleException(ErrorCodes.ProfileHasUsersCannotDelete);
        }

        _profileRepository.Remove(profile);
        await _profileRepository.SaveChangesAsync();
    }

    public async Task<ProfileResponse> GetByIdAsync(int currentUserId, int profileId)
    {
        var callerContext = await _permissionService.GetUserContextAsync(currentUserId);
        var currentFirmId = callerContext.FirmId ?? throw new BusinessRuleException(ErrorCodes.UserHasNoFirm);

        var profile = await _profileRepository.Query()
            .Include(p => p.ProfilePermissions)
            .Include(p => p.ProfileVatRates)
            .FirstOrDefaultAsync(p => p.ProfileId == profileId && p.FirmId == currentFirmId);

        if (profile is null)
        {
            throw new NotFoundException(
                ErrorCodes.ProfileNotFound,
                new Dictionary<string, string> { ["profileId"] = profileId.ToString() });
        }

        return MapToResponse(profile);
    }

    public async Task<PagedResult<ProfileResponse>> GetPagedAsync(int currentUserId, PagedRequest request)
    {
        var callerContext = await _permissionService.GetUserContextAsync(currentUserId);
        var currentFirmId = callerContext.FirmId ?? throw new BusinessRuleException(ErrorCodes.UserHasNoFirm);

        var query = _profileRepository.Query()
            .Include(p => p.ProfilePermissions)
            .Include(p => p.ProfileVatRates)
            .Where(p => p.FirmId == currentFirmId);

        if (!string.IsNullOrWhiteSpace(request.SearchTerm))
        {
            query = query.Where(p => p.Name.Contains(request.SearchTerm));
        }

        query = request.SortBy?.ToLower() switch
        {
            "name" => request.SortDirection == SortDirection.Descending
                ? query.OrderByDescending(p => p.Name)
                : query.OrderBy(p => p.Name),
            _ => request.SortDirection == SortDirection.Descending
                ? query.OrderByDescending(p => p.CreatedDate)
                : query.OrderBy(p => p.CreatedDate)
        };

        var pagedProfiles = await query.ToPagedResultAsync(request.Page, request.PageSize);

        return new PagedResult<ProfileResponse>
        {
            Items = pagedProfiles.Items.Select(MapToResponse).ToList(),
            TotalCount = pagedProfiles.TotalCount,
            Page = pagedProfiles.Page,
            PageSize = pagedProfiles.PageSize
        };
    }

    public async Task<List<PermissionCatalogItemResponse>> GetPermissionCatalogAsync()
    {
        var permissions = await _permissionRepository.Query()
            .OrderBy(p => p.Resource).ThenBy(p => p.Action)
            .ToListAsync();

        return permissions.Select(p => new PermissionCatalogItemResponse
        {
            PermissionId = p.PermissionId,
            Resource = p.Resource,
            Action = p.Action
        }).ToList();
    }

    public async Task<List<VatRateResponse>> GetVatRateCatalogAsync()
    {
        var vatRates = await _vatRateRepository.Query()
            .OrderBy(v => v.Rate)
            .ToListAsync();

        return vatRates.Select(v => new VatRateResponse
        {
            VatRateId = v.VatRateId,
            Rate = v.Rate
        }).ToList();
    }

    private async Task<PermissionDefinition> BuildCandidateDefinitionAsync(
        List<int> permissionIds,
        List<int> vatRateIds,
        decimal? minInvoiceAmount,
        decimal? maxInvoiceAmount)
    {
        var distinctPermissionIds = permissionIds.Distinct().ToList();

        var candidatePermissions = await _permissionRepository.Query()
            .Where(p => distinctPermissionIds.Contains(p.PermissionId))
            .ToListAsync();

        if (candidatePermissions.Count != distinctPermissionIds.Count)
        {
            throw new BusinessRuleException(ErrorCodes.InvalidPermissionSelection);
        }

        var permissionPairs = candidatePermissions.Select(p => (p.Resource, p.Action)).ToHashSet();

        foreach (var resource in permissionPairs.Select(p => p.Resource).Distinct())
        {
            var hasMutatingAction = permissionPairs.Any(p =>
                p.Resource == resource &&
                p.Action is PermissionAction.Create or PermissionAction.Update or PermissionAction.Delete);

            var hasRead = permissionPairs.Contains((resource, PermissionAction.Read));

            if (hasMutatingAction && !hasRead)
            {
                throw new BusinessRuleException(
                    ErrorCodes.ReadPermissionRequiredForMutation,
                    new Dictionary<string, string> { ["resource"] = resource.ToString() });
            }
        }

        var distinctVatRateIds = vatRateIds.Distinct().ToList();

        var validVatRateCount = await _vatRateRepository.Query()
            .CountAsync(v => distinctVatRateIds.Contains(v.VatRateId));

        if (validVatRateCount != distinctVatRateIds.Count)
        {
            throw new BusinessRuleException(ErrorCodes.InvalidVatRateSelection);
        }

        return new PermissionDefinition
        {
            PermissionIds = distinctPermissionIds.ToHashSet(),
            Permissions = permissionPairs,
            VatRateIds = distinctVatRateIds.ToHashSet(),
            MinInvoiceAmount = minInvoiceAmount,
            MaxInvoiceAmount = maxInvoiceAmount
        };
    }

    private static void ValidateInvoiceRange(decimal? minInvoiceAmount, decimal? maxInvoiceAmount)
    {
        if (minInvoiceAmount is not null && maxInvoiceAmount is not null && minInvoiceAmount > maxInvoiceAmount)
        {
            throw new BusinessRuleException(ErrorCodes.InvoiceRangeInvalid);
        }
    }

    private static ProfileResponse MapToResponse(Profile profile)
    {
        return new ProfileResponse
        {
            ProfileId = profile.ProfileId,
            Name = profile.Name,
            IsSystem = profile.IsSystem,
            MinInvoiceAmount = profile.MinInvoiceAmount,
            MaxInvoiceAmount = profile.MaxInvoiceAmount,
            PermissionIds = profile.ProfilePermissions.Select(pp => pp.PermissionId).ToList(),
            VatRateIds = profile.ProfileVatRates.Select(pv => pv.VatRateId).ToList(),
            CreatedDate = profile.CreatedDate,
            UpdatedDate = profile.UpdatedDate
        };
    }
}
