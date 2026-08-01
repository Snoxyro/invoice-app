using InvoiceApp.Api.Authorization;
using InvoiceApp.Api.Extensions;
using InvoiceApp.Common.Dtos.Invoices;
using InvoiceApp.Common.Entities;
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
    public async Task<ActionResult<InvoiceListResponse>> GetPaged([FromQuery] InvoiceListRequest request)
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

    [HttpGet("{id:int}/preview")]
    [RequirePermission(PermissionResource.Invoices, PermissionAction.Read)]
    public async Task<ContentResult> Preview(int id)
    {
        var html = await _invoiceService.GetPreviewHtmlAsync(User.GetUserId(), id);
        return Content(html, "text/html");
    }

    [HttpGet("{id:int}/xml")]
    [RequirePermission(PermissionResource.Invoices, PermissionAction.Read)]
    public async Task<IActionResult> DownloadXml(int id)
    {
        var invoice = await _invoiceService.GetByIdAsync(User.GetUserId(), id);
        var xmlBytes = await _invoiceService.GetPreviewXmlAsync(User.GetUserId(), id);
        return File(xmlBytes, "application/xml", BuildFileName(invoice.InvoiceNumber, id, "xml"));
    }

    [HttpGet("{id:int}/pdf")]
    [RequirePermission(PermissionResource.Invoices, PermissionAction.Read)]
    public async Task<IActionResult> DownloadPdf(int id)
    {
        var invoice = await _invoiceService.GetByIdAsync(User.GetUserId(), id);
        var pdfBytes = await _invoiceService.GetPreviewPdfAsync(User.GetUserId(), id);
        return File(pdfBytes, "application/pdf", BuildFileName(invoice.InvoiceNumber, id, "pdf"));
    }

    private static string BuildFileName(string? invoiceNumber, int invoiceId, string extension)
    {
        var baseName = string.IsNullOrWhiteSpace(invoiceNumber) ? $"taslak-{invoiceId}" : invoiceNumber;
        return $"{baseName}.{extension}";
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

    [HttpPost("{id:int}/send")]
    [RequirePermission(PermissionResource.Invoices, PermissionAction.Update)]
    public async Task<ActionResult<InvoiceResponse>> Send(int id)
    {
        var result = await _invoiceService.SendAsync(User.GetUserId(), id);
        return Ok(result);
    }

    [HttpPost("{id:int}/create-return")]
    [RequirePermission(PermissionResource.Invoices, PermissionAction.Create)]
    public async Task<ActionResult<InvoiceResponse>> CreateReturn(int id)
    {
        var result = await _invoiceService.CreateReturnAsync(User.GetUserId(), id);
        return CreatedAtAction(nameof(GetById), new { id = result.InvoiceId }, result);
    }

    [HttpDelete("{id:int}")]
    [RequirePermission(PermissionResource.Invoices, PermissionAction.Delete)]
    public async Task<IActionResult> Delete(int id)
    {
        await _invoiceService.DeleteAsync(User.GetUserId(), id);
        return NoContent();
    }
}
