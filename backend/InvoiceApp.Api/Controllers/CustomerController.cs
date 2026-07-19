using InvoiceApp.Api.Authorization;
using InvoiceApp.Api.Extensions;
using InvoiceApp.Common.Dtos.Customers;
using InvoiceApp.Common.Entities;
using InvoiceApp.Common.Paging;
using InvoiceApp.Service.Customers;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace InvoiceApp.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize(Roles = "FirmUser")]
public class CustomersController : ControllerBase
{
    private readonly ICustomerService _customerService;

    public CustomersController(ICustomerService customerService)
    {
        _customerService = customerService;
    }

    [HttpGet]
    [RequirePermission(PermissionResource.Customers, PermissionAction.Read)]
    public async Task<ActionResult<PagedResult<CustomerResponse>>> GetPaged([FromQuery] PagedRequest request)
    {
        var result = await _customerService.GetPagedAsync(User.GetUserId(), request);
        return Ok(result);
    }

    [HttpGet("{id:int}")]
    [RequirePermission(PermissionResource.Customers, PermissionAction.Read)]
    public async Task<ActionResult<CustomerResponse>> GetById(int id)
    {
        var result = await _customerService.GetByIdAsync(User.GetUserId(), id);
        return Ok(result);
    }

    [HttpPost]
    [RequirePermission(PermissionResource.Customers, PermissionAction.Create)]
    public async Task<ActionResult<CustomerResponse>> Create(CustomerCreateRequest request)
    {
        var result = await _customerService.CreateAsync(User.GetUserId(), request);
        return CreatedAtAction(nameof(GetById), new { id = result.CustomerId }, result);
    }

    [HttpPut("{id:int}")]
    [RequirePermission(PermissionResource.Customers, PermissionAction.Update)]
    public async Task<ActionResult<CustomerResponse>> Update(int id, CustomerUpdateRequest request)
    {
        var result = await _customerService.UpdateAsync(User.GetUserId(), id, request);
        return Ok(result);
    }

    [HttpDelete("{id:int}")]
    [RequirePermission(PermissionResource.Customers, PermissionAction.Delete)]
    public async Task<IActionResult> Delete(int id)
    {
        await _customerService.DeleteAsync(User.GetUserId(), id);
        return NoContent();
    }
}
