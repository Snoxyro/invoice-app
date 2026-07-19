using InvoiceApp.Api.Authorization;
using InvoiceApp.Api.Extensions;
using InvoiceApp.Common.Dtos.Permissions;
using InvoiceApp.Common.Dtos.Profiles;
using InvoiceApp.Common.Dtos.VatRates;
using InvoiceApp.Common.Entities;
using InvoiceApp.Common.Paging;
using InvoiceApp.Service.Profiles;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace InvoiceApp.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize(Roles = "FirmUser")]
public class ProfilesController : ControllerBase
{
    private readonly IProfileService _profileService;

    public ProfilesController(IProfileService profileService)
    {
        _profileService = profileService;
    }

    [HttpGet]
    [RequirePermission(PermissionResource.Profiles, PermissionAction.Read)]
    public async Task<ActionResult<PagedResult<ProfileResponse>>> GetPaged([FromQuery] PagedRequest request)
    {
        var result = await _profileService.GetPagedAsync(User.GetUserId(), request);
        return Ok(result);
    }

    [HttpGet("{id:int}")]
    [RequirePermission(PermissionResource.Profiles, PermissionAction.Read)]
    public async Task<ActionResult<ProfileResponse>> GetById(int id)
    {
        var result = await _profileService.GetByIdAsync(User.GetUserId(), id);
        return Ok(result);
    }

    [HttpPost]
    [RequirePermission(PermissionResource.Profiles, PermissionAction.Create)]
    public async Task<ActionResult<ProfileResponse>> Create(ProfileCreateRequest request)
    {
        var result = await _profileService.CreateAsync(User.GetUserId(), request);
        return CreatedAtAction(nameof(GetById), new { id = result.ProfileId }, result);
    }

    [HttpPut("{id:int}")]
    [RequirePermission(PermissionResource.Profiles, PermissionAction.Update)]
    public async Task<ActionResult<ProfileResponse>> Update(int id, ProfileUpdateRequest request)
    {
        var result = await _profileService.UpdateAsync(User.GetUserId(), id, request);
        return Ok(result);
    }

    [HttpDelete("{id:int}")]
    [RequirePermission(PermissionResource.Profiles, PermissionAction.Delete)]
    public async Task<IActionResult> Delete(int id)
    {
        await _profileService.DeleteAsync(User.GetUserId(), id);
        return NoContent();
    }

    [HttpGet("permission-catalog")]
    [RequirePermission(PermissionResource.Profiles, PermissionAction.Read)]
    public async Task<ActionResult<List<PermissionCatalogItemResponse>>> GetPermissionCatalog()
    {
        var result = await _profileService.GetPermissionCatalogAsync();
        return Ok(result);
    }

    [HttpGet("vat-rate-catalog")]
    [RequirePermission(PermissionResource.Profiles, PermissionAction.Read)]
    public async Task<ActionResult<List<VatRateResponse>>> GetVatRateCatalog()
    {
        var result = await _profileService.GetVatRateCatalogAsync();
        return Ok(result);
    }
}
