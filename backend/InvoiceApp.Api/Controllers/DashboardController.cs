using InvoiceApp.Api.Extensions;
using InvoiceApp.Common.Dtos.Dashboard;
using InvoiceApp.Service.Dashboard;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace InvoiceApp.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public class DashboardController : ControllerBase
{
    private readonly IDashboardService _dashboardService;

    public DashboardController(IDashboardService dashboardService)
    {
        _dashboardService = dashboardService;
    }

    [HttpGet("admin-summary")]
    [Authorize(Roles = "Admin")]
    public async Task<ActionResult<AdminDashboardResponse>> GetAdminSummary()
    {
        var result = await _dashboardService.GetAdminSummaryAsync();
        return Ok(result);
    }

    [HttpGet("summary")]
    [Authorize(Roles = "FirmUser")]
    public async Task<ActionResult<FirmDashboardResponse>> GetSummary()
    {
        var result = await _dashboardService.GetFirmSummaryAsync(User.GetUserId());
        return Ok(result);
    }
}
