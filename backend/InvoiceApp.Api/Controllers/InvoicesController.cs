using InvoiceApp.Api.Authorization;
using InvoiceApp.Api.Extensions;
using InvoiceApp.Common.Dtos.Invoices;
using InvoiceApp.Common.Entities;
using InvoiceApp.Common.Paging;
using InvoiceApp.Service.Invoices;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace InvoiceApp.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize(Roles = "FirmUser")]
public class InvoicesController : ControllerBase
{
    private readonly IInvoiceService _invoiceService;

    public InvoicesController(IInvoiceService invoiceService)
    {
        _invoiceService = invoiceService;
    }

    [HttpGet]
    [RequirePermission(PermissionResource.Invoices, PermissionAction.Read)]
    public async Task<ActionResult<PagedResult<InvoiceListItemResponse>>> GetPaged([FromQuery] InvoiceListRequest request)
    {
        var result = await _invoiceService.GetPagedAsync(User.GetUserId(), request);
        return Ok(result);
    }

    [HttpGet("{id:int}")]
    [RequirePermission(PermissionResource.Invoices, PermissionAction.Read)]
    public async Task<ActionResult<InvoiceResponse>> GetById(int id)
    {
        var result = await _invoiceService.GetByIdAsync(User.GetUserId(), id);
        return Ok(result);
    }

    [HttpPost]
    [RequirePermission(PermissionResource.Invoices, PermissionAction.Create)]
    public async Task<ActionResult<InvoiceResponse>> Create(InvoiceCreateRequest request)
    {
        var result = await _invoiceService.CreateAsync(User.GetUserId(), request);
        return CreatedAtAction(nameof(GetById), new { id = result.InvoiceId }, result);
    }

    [HttpPut("{id:int}")]
    [RequirePermission(PermissionResource.Invoices, PermissionAction.Update)]
    public async Task<ActionResult<InvoiceResponse>> Update(int id, InvoiceUpdateRequest request)
    {
        var result = await _invoiceService.UpdateAsync(User.GetUserId(), id, request);
        return Ok(result);
    }

    [HttpDelete("{id:int}")]
    [RequirePermission(PermissionResource.Invoices, PermissionAction.Delete)]
    public async Task<IActionResult> Delete(int id)
    {
        await _invoiceService.DeleteAsync(User.GetUserId(), id);
        return NoContent();
    }
}
