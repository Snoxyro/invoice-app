using InvoiceApp.Api.Authorization;
using InvoiceApp.Api.Extensions;
using InvoiceApp.Common.Dtos.CustomColumns;
using InvoiceApp.Common.Entities;
using InvoiceApp.Service.CustomColumns;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace InvoiceApp.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize(Roles = "FirmUser")]
public class CustomColumnsController : ControllerBase
{
    private readonly ICustomColumnService _customColumnService;

    public CustomColumnsController(ICustomColumnService customColumnService)
    {
        _customColumnService = customColumnService;
    }

    [HttpGet]
    [RequirePermission(PermissionResource.InvoiceSettings, PermissionAction.Read)]
    public async Task<ActionResult<List<CustomColumnResponse>>> GetAll()
    {
        var result = await _customColumnService.GetAllAsync(User.GetUserId());
        return Ok(result);
    }

    [HttpPost]
    [RequirePermission(PermissionResource.InvoiceSettings, PermissionAction.Create)]
    public async Task<ActionResult<CustomColumnResponse>> Create(CustomColumnCreateRequest request)
    {
        var result = await _customColumnService.CreateAsync(User.GetUserId(), request);
        return CreatedAtAction(nameof(GetAll), result);
    }

    [HttpPut("{id:int}")]
    [RequirePermission(PermissionResource.InvoiceSettings, PermissionAction.Update)]
    public async Task<ActionResult<CustomColumnResponse>> Update(int id, CustomColumnUpdateRequest request)
    {
        var result = await _customColumnService.UpdateAsync(User.GetUserId(), id, request);
        return Ok(result);
    }

    [HttpDelete("{id:int}")]
    [RequirePermission(PermissionResource.InvoiceSettings, PermissionAction.Delete)]
    public async Task<IActionResult> Delete(int id)
    {
        await _customColumnService.DeleteAsync(User.GetUserId(), id);
        return NoContent();
    }
}
