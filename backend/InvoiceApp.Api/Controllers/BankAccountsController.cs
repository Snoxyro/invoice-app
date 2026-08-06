using InvoiceApp.Api.Authorization;
using InvoiceApp.Api.Extensions;
using InvoiceApp.Common.Dtos.BankAccounts;
using InvoiceApp.Common.Entities;
using InvoiceApp.Service.BankAccounts;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace InvoiceApp.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize(Roles = "FirmUser")]
public class BankAccountsController : ControllerBase
{
    private readonly IBankAccountService _bankAccountService;

    public BankAccountsController(IBankAccountService bankAccountService)
    {
        _bankAccountService = bankAccountService;
    }

    [HttpGet]
    [RequirePermission(PermissionResource.InvoiceCustomization, PermissionAction.Read)]
    public async Task<ActionResult<List<BankAccountResponse>>> GetAll()
    {
        var result = await _bankAccountService.GetAllAsync(User.GetUserId());
        return Ok(result);
    }

    [HttpPost]
    [RequirePermission(PermissionResource.InvoiceCustomization, PermissionAction.Create)]
    public async Task<ActionResult<BankAccountResponse>> Create(BankAccountCreateRequest request)
    {
        var result = await _bankAccountService.CreateAsync(User.GetUserId(), request);
        return CreatedAtAction(nameof(GetAll), result);
    }

    [HttpPut("{id:int}")]
    [RequirePermission(PermissionResource.InvoiceCustomization, PermissionAction.Update)]
    public async Task<ActionResult<BankAccountResponse>> Update(int id, BankAccountUpdateRequest request)
    {
        var result = await _bankAccountService.UpdateAsync(User.GetUserId(), id, request);
        return Ok(result);
    }

    [HttpDelete("{id:int}")]
    [RequirePermission(PermissionResource.InvoiceCustomization, PermissionAction.Delete)]
    public async Task<IActionResult> Delete(int id)
    {
        await _bankAccountService.DeleteAsync(User.GetUserId(), id);
        return NoContent();
    }
}
