using InvoiceApp.Common.Entities;
using InvoiceApp.Common.Exceptions;
using InvoiceApp.Repository;
using Microsoft.EntityFrameworkCore;

namespace InvoiceApp.Service.Permissions;

public class PermissionService : IPermissionService
{
    private readonly IRepository<User> _userRepository;
    private readonly IRepository<Profile> _profileRepository;

    public PermissionService(IRepository<User> userRepository, IRepository<Profile> profileRepository)
    {
        _userRepository = userRepository;
        _profileRepository = profileRepository;
    }

    public async Task<UserPermissionContext> GetUserContextAsync(int userId)
    {
        var user = await _userRepository.Query()
            .FirstOrDefaultAsync(u => u.UserId == userId);

        if (user is null)
        {
            throw new NotFoundException(
                ErrorCodes.UserNotFound,
                new Dictionary<string, string> { ["userId"] = userId.ToString() });
        }

        var context = new UserPermissionContext
        {
            UserId = user.UserId,
            FirmId = user.FirmId,
            ProfileId = user.ProfileId
        };

        if (user.ProfileId is null)
        {
            return context;
        }

        var definition = await GetProfileDefinitionAsync(user.ProfileId.Value);

        context.PermissionIds = definition.PermissionIds;
        context.Permissions = definition.Permissions;
        context.VatRateIds = definition.VatRateIds;
        context.MinInvoiceAmount = definition.MinInvoiceAmount;
        context.MaxInvoiceAmount = definition.MaxInvoiceAmount;

        var profile = await _profileRepository.GetByIdAsync(user.ProfileId.Value);
        context.IsSystemProfile = profile?.IsSystem ?? false;

        return context;
    }

    public async Task<PermissionDefinition> GetProfileDefinitionAsync(int profileId)
    {
        var profile = await _profileRepository.Query()
            .Include(p => p.ProfilePermissions).ThenInclude(pp => pp.Permission)
            .Include(p => p.ProfileVatRates)
            .FirstOrDefaultAsync(p => p.ProfileId == profileId);

        if (profile is null)
        {
            throw new NotFoundException(
                ErrorCodes.ProfileNotFound,
                new Dictionary<string, string> { ["profileId"] = profileId.ToString() });
        }

        return new PermissionDefinition
        {
            MinInvoiceAmount = profile.MinInvoiceAmount,
            MaxInvoiceAmount = profile.MaxInvoiceAmount,
            PermissionIds = profile.ProfilePermissions.Select(pp => pp.PermissionId).ToHashSet(),
            Permissions = profile.ProfilePermissions
                .Select(pp => (pp.Permission.Resource, pp.Permission.Action))
                .ToHashSet(),
            VatRateIds = profile.ProfileVatRates.Select(pv => pv.VatRateId).ToHashSet()
        };
    }

    public async Task<bool> HasPermissionAsync(int userId, PermissionResource resource, PermissionAction action)
    {
        var context = await GetUserContextAsync(userId);
        return context.Has(resource, action);
    }

    public async Task<int> GetProfileHolderCountAsync(int profileId)
    {
        return await _userRepository.Query().CountAsync(u => u.ProfileId == profileId);
    }
}
