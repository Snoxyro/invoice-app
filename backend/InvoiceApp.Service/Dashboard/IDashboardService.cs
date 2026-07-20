using InvoiceApp.Common.Dtos.Dashboard;

namespace InvoiceApp.Service.Dashboard;

public interface IDashboardService
{
    Task<AdminDashboardResponse> GetAdminSummaryAsync();
    Task<FirmDashboardResponse> GetFirmSummaryAsync(int currentUserId);
}
