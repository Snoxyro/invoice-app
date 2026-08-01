using InvoiceApp.Api.Authorization;
using InvoiceApp.Api.Extensions;
using InvoiceApp.Common.Dtos.Firms;
using InvoiceApp.Common.Entities;
using InvoiceApp.Service.Firms;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace InvoiceApp.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize(Roles = "FirmUser")]
public class FirmBrandingController : ControllerBase
{
    private readonly IFirmService _firmService;

    public FirmBrandingController(IFirmService firmService)
    {
        _firmService = firmService;
    }

    [HttpGet]
    [RequirePermission(PermissionResource.InvoiceSettings, PermissionAction.Read)]
    public async Task<ActionResult<FirmBrandingResponse>> Get()
    {
        var result = await _firmService.GetBrandingAsync(User.GetUserId());
        return Ok(result);
    }

    [HttpPut]
    [RequirePermission(PermissionResource.InvoiceSettings, PermissionAction.Update)]
    public async Task<ActionResult<FirmBrandingResponse>> Update(FirmBrandingUpdateRequest request)
    {
        var result = await _firmService.UpdateBrandingAsync(User.GetUserId(), request);
        return Ok(result);
    }
}
