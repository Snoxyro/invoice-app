using InvoiceApp.Api.Extensions;
using InvoiceApp.Common.Dtos.InvoiceSeries;
using InvoiceApp.Common.Dtos.Permissions;
using InvoiceApp.Common.Dtos.VatRates;
using InvoiceApp.Common.Entities;
using InvoiceApp.Repository;
using InvoiceApp.Service.Permissions;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace InvoiceApp.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
[Authorize]
public class MeController : ControllerBase
{
    private readonly IPermissionService _permissionService;
    private readonly IRepository<VatRate> _vatRateRepository;
    private readonly IRepository<InvoiceSeries> _invoiceSeriesRepository;

    public MeController(
        IPermissionService permissionService,
        IRepository<VatRate> vatRateRepository,
        IRepository<InvoiceSeries> invoiceSeriesRepository)
    {
        _permissionService = permissionService;
        _vatRateRepository = vatRateRepository;
        _invoiceSeriesRepository = invoiceSeriesRepository;
    }

    [HttpGet("permissions")]
    public async Task<ActionResult<MyPermissionsResponse>> GetPermissions()
    {
        var context = await _permissionService.GetUserContextAsync(User.GetUserId());

        var vatRates = await _vatRateRepository.Query()
            .Where(v => context.VatRateIds.Contains(v.VatRateId))
            .Select(v => new VatRateResponse { VatRateId = v.VatRateId, Rate = v.Rate })
            .ToListAsync();

        var availableSeries = await _invoiceSeriesRepository.Query()
            .Where(s => s.BranchId == context.BranchId && s.IsActive)
            .OrderBy(s => s.Prefix)
            .Select(s => new InvoiceSeriesOptionResponse { InvoiceSeriesId = s.InvoiceSeriesId, Prefix = s.Prefix })
            .ToListAsync();

        return Ok(new MyPermissionsResponse
        {
            ProfileId = context.ProfileId,
            ProfileName = context.ProfileName,
            IsSystemProfile = context.IsSystemProfile,
            Permissions = context.Permissions.Select(p => $"{p.Resource}:{p.Action}").ToList(),
            VatRates = vatRates,
            MinInvoiceAmount = context.MinInvoiceAmount,
            MaxInvoiceAmount = context.MaxInvoiceAmount,
            AvailableInvoiceSeries = availableSeries
        });
    }
}
