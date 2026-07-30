using InvoiceApp.Api.Authorization;
using InvoiceApp.Api.Extensions;
using InvoiceApp.Common.Dtos.Branches;
using InvoiceApp.Common.Entities;
using InvoiceApp.Common.Paging;
using InvoiceApp.Service.Branches;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace InvoiceApp.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize(Roles = "FirmUser")]
public class BranchesController : ControllerBase
{
    private readonly IBranchService _branchService;

    public BranchesController(IBranchService branchService)
    {
        _branchService = branchService;
    }

    [HttpGet]
    [RequirePermission(PermissionResource.Branches, PermissionAction.Read)]
    public async Task<ActionResult<PagedResult<BranchResponse>>> GetPaged([FromQuery] PagedRequest request)
    {
        var result = await _branchService.GetPagedAsync(User.GetUserId(), request);
        return Ok(result);
    }

    [HttpGet("{id:int}")]
    [RequirePermission(PermissionResource.Branches, PermissionAction.Read)]
    public async Task<ActionResult<BranchResponse>> GetById(int id)
    {
        var result = await _branchService.GetByIdAsync(User.GetUserId(), id);
        return Ok(result);
    }

    [HttpPost]
    [RequirePermission(PermissionResource.Branches, PermissionAction.Create)]
    public async Task<ActionResult<BranchResponse>> Create(BranchCreateRequest request)
    {
        var result = await _branchService.CreateAsync(User.GetUserId(), request);
        return CreatedAtAction(nameof(GetById), new { id = result.BranchId }, result);
    }

    [HttpPut("{id:int}")]
    [RequirePermission(PermissionResource.Branches, PermissionAction.Update)]
    public async Task<ActionResult<BranchResponse>> Update(int id, BranchUpdateRequest request)
    {
        var result = await _branchService.UpdateAsync(User.GetUserId(), id, request);
        return Ok(result);
    }

    [HttpDelete("{id:int}")]
    [RequirePermission(PermissionResource.Branches, PermissionAction.Delete)]
    public async Task<IActionResult> Delete(int id)
    {
        await _branchService.DeleteAsync(User.GetUserId(), id);
        return NoContent();
    }
}
