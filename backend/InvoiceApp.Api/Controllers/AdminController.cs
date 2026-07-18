using InvoiceApp.Api.Extensions;
using InvoiceApp.Common.Dtos.Users;
using InvoiceApp.Common.Paging;
using InvoiceApp.Service.Users;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace InvoiceApp.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize(Roles = "Admin")]
public class AdminController : ControllerBase
{
    private readonly IUserService _userService;

    public AdminController(IUserService userService)
    {
        _userService = userService;
    }

    [HttpGet("users")]
    public async Task<ActionResult<PagedResult<UserResponse>>> GetUsers([FromQuery] PagedRequest request)
    {
        var result = await _userService.GetPagedAsync(request);
        return Ok(result);
    }

    [HttpGet("users/{id:int}")]
    public async Task<ActionResult<UserResponse>> GetUserById(int id)
    {
        var result = await _userService.GetByIdAsync(id);
        return Ok(result);
    }

    [HttpPost("users")]
    public async Task<ActionResult<UserResponse>> CreateUser(UserCreateRequest request)
    {
        var result = await _userService.CreateAsync(request);
        return CreatedAtAction(nameof(GetUserById), new { id = result.UserId }, result);
    }

    [HttpPut("users/{id:int}")]
    public async Task<ActionResult<UserResponse>> UpdateUser(int id, UserUpdateRequest request)
    {
        var result = await _userService.UpdateAsync(id, request);
        return Ok(result);
    }

    [HttpDelete("users/{id:int}")]
    public async Task<IActionResult> DeleteUser(int id)
    {
        await _userService.DeleteAsync(id, User.GetUserId());
        return NoContent();
    }
}