using InvoiceApp.Common.Dtos.Dashboard;
using InvoiceApp.Common.Entities;
using InvoiceApp.Common.Exceptions;
using InvoiceApp.Repository;
using InvoiceApp.Service.Permissions;
using Microsoft.EntityFrameworkCore;

namespace InvoiceApp.Service.Dashboard;

public class DashboardService : IDashboardService
{
    private readonly IRepository<Firm> _firmRepository;
    private readonly IRepository<Invoice> _invoiceRepository;
    private readonly IRepository<Customer> _customerRepository;
    private readonly IRepository<User> _userRepository;
    private readonly IRepository<Profile> _profileRepository;
    private readonly IPermissionService _permissionService;

    public DashboardService(
        IRepository<Firm> firmRepository,
        IRepository<Invoice> invoiceRepository,
        IRepository<Customer> customerRepository,
        IRepository<User> userRepository,
        IRepository<Profile> profileRepository,
        IPermissionService permissionService)
    {
        _firmRepository = firmRepository;
        _invoiceRepository = invoiceRepository;
        _customerRepository = customerRepository;
        _userRepository = userRepository;
        _profileRepository = profileRepository;
        _permissionService = permissionService;
    }

    public async Task<AdminDashboardResponse> GetAdminSummaryAsync()
    {
        var monthStart = GetMonthStart();

        var totalFirmCount = await _firmRepository.Query().CountAsync();
        var newFirmsThisMonth = await _firmRepository.Query().CountAsync(f => f.CreatedDate >= monthStart);

        var recentFirms = await _firmRepository.Query()
            .OrderByDescending(f => f.CreatedDate)
            .Take(5)
            .Select(f => new RecentFirmItem
            {
                FirmId = f.FirmId,
                Name = f.Name,
                CreatedDate = f.CreatedDate
            })
            .ToListAsync();

        return new AdminDashboardResponse
        {
            TotalFirmCount = totalFirmCount,
            NewFirmsThisMonth = newFirmsThisMonth,
            RecentFirms = recentFirms
        };
    }

    public async Task<FirmDashboardResponse> GetFirmSummaryAsync(int currentUserId)
    {
        var context = await _permissionService.GetUserContextAsync(currentUserId);
        var firmId = context.FirmId ?? throw new BusinessRuleException(ErrorCodes.UserHasNoFirm);

        var monthStart = GetMonthStart();
        var response = new FirmDashboardResponse();

        if (context.Has(PermissionResource.Invoices, PermissionAction.Read))
        {
            response.InvoiceStats = await BuildInvoiceStatsAsync(firmId, monthStart);
        }

        if (context.Has(PermissionResource.Customers, PermissionAction.Read))
        {
            var customerQuery = _customerRepository.Query().Where(c => c.FirmId == firmId);
            response.CustomerCount = await customerQuery.CountAsync();
            response.NewCustomersThisMonth = await customerQuery.CountAsync(c => c.CreatedDate >= monthStart);
        }

        if (context.Has(PermissionResource.Users, PermissionAction.Read))
        {
            response.UserCount = await _userRepository.Query().CountAsync(u => u.FirmId == firmId);
        }

        if (context.Has(PermissionResource.Profiles, PermissionAction.Read))
        {
            response.ProfileCount = await _profileRepository.Query().CountAsync(p => p.FirmId == firmId);
        }

        return response;
    }

    private async Task<InvoiceStatsResponse> BuildInvoiceStatsAsync(int firmId, DateTime monthStart)
    {
        var invoiceQuery = _invoiceRepository.Query().Where(i => i.FirmId == firmId);

        var totalInvoiceCount = await invoiceQuery.CountAsync();
        var invoiceCountThisMonth = await invoiceQuery.CountAsync(i => i.InvoiceDate >= monthStart);
        var totalRevenue = await invoiceQuery.SumAsync(i => (decimal?)i.GrandTotal) ?? 0;
        var revenueThisMonth = await invoiceQuery
            .Where(i => i.InvoiceDate >= monthStart)
            .SumAsync(i => (decimal?)i.GrandTotal) ?? 0;

        var recentInvoices = await invoiceQuery
            .Include(i => i.Customer)
            .OrderByDescending(i => i.CreatedDate)
            .Take(5)
            .Select(i => new RecentInvoiceItem
            {
                InvoiceId = i.InvoiceId,
                InvoiceNumber = i.InvoiceNumber,
                CustomerTitle = i.Customer.Title,
                GrandTotal = i.GrandTotal,
                InvoiceDate = i.InvoiceDate
            })
            .ToListAsync();

        return new InvoiceStatsResponse
        {
            TotalInvoiceCount = totalInvoiceCount,
            InvoiceCountThisMonth = invoiceCountThisMonth,
            TotalRevenue = totalRevenue,
            RevenueThisMonth = revenueThisMonth,
            RecentInvoices = recentInvoices
        };
    }

    private static DateTime GetMonthStart()
    {
        var now = DateTime.UtcNow;
        return new DateTime(now.Year, now.Month, 1, 0, 0, 0, DateTimeKind.Utc);
    }
}
