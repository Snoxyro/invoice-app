using InvoiceApp.Api.Authorization;
using InvoiceApp.Api.Extensions;
using InvoiceApp.Common.Dtos.Users;
using InvoiceApp.Common.Entities;
using InvoiceApp.Common.Paging;
using InvoiceApp.Service.Users;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace InvoiceApp.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize(Roles = "FirmUser")]
public class UsersController : ControllerBase
{
    private readonly IUserService _userService;

    public UsersController(IUserService userService)
    {
        _userService = userService;
    }

    [HttpGet]
    [RequirePermission(PermissionResource.Users, PermissionAction.Read)]
    public async Task<ActionResult<PagedResult<UserResponse>>> GetPaged([FromQuery] PagedRequest request)
    {
        var result = await _userService.GetPagedAsync(User.GetUserId(), request);
        return Ok(result);
    }

    [HttpGet("{id:int}")]
    [RequirePermission(PermissionResource.Users, PermissionAction.Read)]
    public async Task<ActionResult<UserResponse>> GetById(int id)
    {
        var result = await _userService.GetByIdAsync(User.GetUserId(), id);
        return Ok(result);
    }

    [HttpPost]
    [RequirePermission(PermissionResource.Users, PermissionAction.Create)]
    public async Task<ActionResult<UserResponse>> Create(UserCreateRequest request)
    {
        var result = await _userService.CreateAsync(User.GetUserId(), request);
        return CreatedAtAction(nameof(GetById), new { id = result.UserId }, result);
    }

    [HttpPut("{id:int}")]
    [RequirePermission(PermissionResource.Users, PermissionAction.Update)]
    public async Task<ActionResult<UserResponse>> Update(int id, UserUpdateRequest request)
    {
        var result = await _userService.UpdateAsync(User.GetUserId(), id, request);
        return Ok(result);
    }

    [HttpDelete("{id:int}")]
    [RequirePermission(PermissionResource.Users, PermissionAction.Delete)]
    public async Task<IActionResult> Delete(int id)
    {
        await _userService.DeleteAsync(User.GetUserId(), id);
        return NoContent();
    }
}
