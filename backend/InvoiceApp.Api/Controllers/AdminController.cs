using InvoiceApp.Common.Dtos.Firms;
using InvoiceApp.Common.Paging;
using InvoiceApp.Service.Firms;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace InvoiceApp.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize(Roles = "Admin")]
public class AdminController : ControllerBase
{
    private readonly IFirmService _firmService;

    public AdminController(IFirmService firmService)
    {
        _firmService = firmService;
    }

    [HttpGet("firms")]
    public async Task<ActionResult<PagedResult<FirmResponse>>> GetFirms([FromQuery] PagedRequest request)
    {
        var result = await _firmService.GetPagedAsync(request);
        return Ok(result);
    }

    [HttpGet("firms/{id:int}")]
    public async Task<ActionResult<FirmResponse>> GetFirmById(int id)
    {
        var result = await _firmService.GetByIdAsync(id);
        return Ok(result);
    }

    [HttpPost("firms")]
    public async Task<ActionResult<FirmResponse>> CreateFirm(FirmCreateRequest request)
    {
        var result = await _firmService.CreateAsync(request);
        return CreatedAtAction(nameof(GetFirmById), new { id = result.FirmId }, result);
    }

    [HttpPut("firms/{id:int}")]
    public async Task<ActionResult<FirmResponse>> UpdateFirm(int id, FirmUpdateRequest request)
    {
        var result = await _firmService.UpdateAsync(id, request);
        return Ok(result);
    }

    [HttpDelete("firms/{id:int}")]
    public async Task<IActionResult> DeleteFirm(int id)
    {
        await _firmService.DeleteAsync(id);
        return NoContent();
    }
}
