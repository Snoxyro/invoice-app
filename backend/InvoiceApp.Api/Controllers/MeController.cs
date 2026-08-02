using InvoiceApp.Api.Extensions;
using InvoiceApp.Common.Dtos.Branches;
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
    private readonly IRepository<Branch> _branchRepository;

    public MeController(
        IPermissionService permissionService,
        IRepository<VatRate> vatRateRepository,
        IRepository<InvoiceSeries> invoiceSeriesRepository,
        IRepository<Branch> branchRepository)
    {
        _permissionService = permissionService;
        _vatRateRepository = vatRateRepository;
        _invoiceSeriesRepository = invoiceSeriesRepository;
        _branchRepository = branchRepository;
    }

    [HttpGet("permissions")]
    public async Task<ActionResult<MyPermissionsResponse>> GetPermissions()
    {
        var context = await _permissionService.GetUserContextAsync(User.GetUserId());

        var vatRates = await _vatRateRepository.Query()
            .Where(v => context.VatRateIds.Contains(v.VatRateId))
            .Select(v => new VatRateResponse { VatRateId = v.VatRateId, Rate = v.Rate, IsExemption = v.IsExemption })
            .ToListAsync();

        var availableSeries = await _invoiceSeriesRepository.Query()
            .Where(s => s.BranchId == context.BranchId && s.IsActive)
            .OrderBy(s => s.Prefix)
            .Select(s => new InvoiceSeriesOptionResponse { InvoiceSeriesId = s.InvoiceSeriesId, Prefix = s.Prefix })
            .ToListAsync();

        var availableBranches = context.CanAccessAllBranches
            ? await _branchRepository.Query()
                .Where(b => b.FirmId == context.FirmId)
                .OrderByDescending(b => b.IsHeadquarters)
                .ThenBy(b => b.Name)
                .Select(b => new BranchOptionResponse
                {
                    BranchId = b.BranchId,
                    Name = b.Name,
                    IsHeadquarters = b.IsHeadquarters
                })
                .ToListAsync()
            : new List<BranchOptionResponse>();

        return Ok(new MyPermissionsResponse
        {
            ProfileId = context.ProfileId,
            ProfileName = context.ProfileName,
            IsSystemProfile = context.IsSystemProfile,
            Permissions = context.Permissions.Select(p => $"{p.Resource}:{p.Action}").ToList(),
            VatRates = vatRates,
            MinInvoiceAmount = context.MinInvoiceAmount,
            MaxInvoiceAmount = context.MaxInvoiceAmount,
            CanAccessAllBranches = context.CanAccessAllBranches,
            BranchId = context.BranchId,
            AvailableInvoiceSeries = availableSeries,
            AvailableBranches = availableBranches
        });
    }
}
