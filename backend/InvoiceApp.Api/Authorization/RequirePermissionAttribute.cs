using InvoiceApp.Common.Entities;
using Microsoft.AspNetCore.Authorization;

namespace InvoiceApp.Api.Authorization;

public class RequirePermissionAttribute : AuthorizeAttribute
{
    public RequirePermissionAttribute(PermissionResource resource, PermissionAction action)
        : base($"Permission:{resource}:{action}")
    {
    }
}
