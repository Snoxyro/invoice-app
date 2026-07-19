using InvoiceApp.Common.Entities;

namespace InvoiceApp.Service.Permissions;

public interface IPermissionService
{
    Task<UserPermissionContext> GetUserContextAsync(int userId);
    Task<PermissionDefinition> GetProfileDefinitionAsync(int profileId);
    Task<bool> HasPermissionAsync(int userId, PermissionResource resource, PermissionAction action);
    Task<int> GetProfileHolderCountAsync(int profileId);
}
