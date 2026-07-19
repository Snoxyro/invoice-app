using InvoiceApp.Api.Extensions;
using InvoiceApp.Common.Dtos.Permissions;
using InvoiceApp.Service.Permissions;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace InvoiceApp.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize]
public class MeController : ControllerBase
{
    private readonly IPermissionService _permissionService;

    public MeController(IPermissionService permissionService)
    {
        _permissionService = permissionService;
    }

    [HttpGet("permissions")]
    public async Task<ActionResult<MyPermissionsResponse>> GetPermissions()
    {
        var context = await _permissionService.GetUserContextAsync(User.GetUserId());

        return Ok(new MyPermissionsResponse
        {
            ProfileId = context.ProfileId,
            IsSystemProfile = context.IsSystemProfile,
            PermissionIds = context.PermissionIds.ToList(),
            VatRateIds = context.VatRateIds.ToList(),
            MinInvoiceAmount = context.MinInvoiceAmount,
            MaxInvoiceAmount = context.MaxInvoiceAmount
        });
    }
}
