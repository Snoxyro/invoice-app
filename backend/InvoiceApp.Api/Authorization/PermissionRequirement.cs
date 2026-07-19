using InvoiceApp.Common.Entities;
using Microsoft.AspNetCore.Authorization;

namespace InvoiceApp.Api.Authorization;

public class PermissionRequirement : IAuthorizationRequirement
{
    public PermissionResource Resource { get; }
    public PermissionAction Action { get; }

    public PermissionRequirement(PermissionResource resource, PermissionAction action)
    {
        Resource = resource;
        Action = action;
    }
}
