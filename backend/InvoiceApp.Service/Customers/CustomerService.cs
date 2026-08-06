using InvoiceApp.Common.Dtos.Customers;
using InvoiceApp.Common.Entities;
using InvoiceApp.Common.Exceptions;
using InvoiceApp.Common.Paging;
using InvoiceApp.Repository;
using InvoiceApp.Repository.Extensions;
using InvoiceApp.Service.Permissions;
using Microsoft.EntityFrameworkCore;
using System.Text.RegularExpressions;

namespace InvoiceApp.Service.Customers;

public class CustomerService : ICustomerService
{
    private readonly IRepository<Customer> _customerRepository;
    private readonly IRepository<Invoice> _invoiceRepository;
    private readonly IRepository<Branch> _branchRepository;
    private readonly IPermissionService _permissionService;

    public CustomerService(
        IRepository<Customer> customerRepository,
        IRepository<Invoice> invoiceRepository,
        IRepository<Branch> branchRepository,
        IPermissionService permissionService)
    {
        _customerRepository = customerRepository;
        _invoiceRepository = invoiceRepository;
        _branchRepository = branchRepository;
        _permissionService = permissionService;
    }

    public async Task<CustomerResponse> CreateAsync(int currentUserId, CustomerCreateRequest request)
    {
        var context = await GetCallerContextAsync(currentUserId);
        var currentFirmId = context.FirmId!.Value;

        if (!Regex.IsMatch(request.TaxNumber, "^[0-9]+$"))
        {
            throw new BusinessRuleException(ErrorCodes.InvalidTaxNumberFormat);
        }

        var taxNumberExists = await _customerRepository.Query()
            .AnyAsync(c => c.FirmId == currentFirmId && c.TaxNumber == request.TaxNumber);

        if (taxNumberExists)
        {
            throw new BusinessRuleException(
                ErrorCodes.CustomerTaxNumberAlreadyExists,
                new Dictionary<string, string> { ["taxNumber"] = request.TaxNumber });
        }

        var branchId = await ResolveBranchIdForCreateAsync(context, currentFirmId, request.BranchId);

        var customer = new Customer
        {
            TaxNumber = request.TaxNumber,
            Title = request.Title,
            Address = request.Address,
            Email = request.Email,
            Phone = string.IsNullOrWhiteSpace(request.Phone) ? null : request.Phone,
            FirmId = currentFirmId,
            BranchId = branchId
        };

        await _customerRepository.AddAsync(customer);
        await _customerRepository.SaveChangesAsync();

        var branchName = await GetBranchNameAsync(branchId);

        return MapToResponse(customer, branchName);
    }

    public async Task<CustomerResponse> UpdateAsync(int currentUserId, int customerId, CustomerUpdateRequest request)
    {
        var context = await GetCallerContextAsync(currentUserId);
        var customer = await GetOwnedCustomerAsync(context, customerId);

        if (!Regex.IsMatch(request.TaxNumber, "^[0-9]+$"))
        {
            throw new BusinessRuleException(ErrorCodes.InvalidTaxNumberFormat);
        }

        var taxNumberExists = await _customerRepository.Query()
            .AnyAsync(c =>
                c.FirmId == context.FirmId &&
                c.TaxNumber == request.TaxNumber &&
                c.CustomerId != customerId);

        if (taxNumberExists)
        {
            throw new BusinessRuleException(
                ErrorCodes.CustomerTaxNumberAlreadyExists,
                new Dictionary<string, string> { ["taxNumber"] = request.TaxNumber });
        }

        customer.TaxNumber = request.TaxNumber;
        customer.Title = request.Title;
        customer.Address = request.Address;
        customer.Email = request.Email;
        customer.Phone = string.IsNullOrWhiteSpace(request.Phone) ? null : request.Phone;
        customer.BranchId = await ResolveBranchIdForUpdateAsync(
            context, context.FirmId!.Value, customer.BranchId, request.BranchId);

        _customerRepository.Update(customer);
        await _customerRepository.SaveChangesAsync();

        var branchName = await GetBranchNameAsync(customer.BranchId);

        return MapToResponse(customer, branchName);
    }

    public async Task DeleteAsync(int currentUserId, int customerId)
    {
        var context = await GetCallerContextAsync(currentUserId);
        var customer = await GetOwnedCustomerAsync(context, customerId);

        var hasInvoices = await _invoiceRepository.Query().AnyAsync(i => i.CustomerId == customerId);

        if (hasInvoices)
        {
            throw new BusinessRuleException(ErrorCodes.CustomerHasInvoicesCannotDelete);
        }

        _customerRepository.Remove(customer);
        await _customerRepository.SaveChangesAsync();
    }

    public async Task<CustomerResponse> GetByIdAsync(int currentUserId, int customerId)
    {
        var context = await GetCallerContextAsync(currentUserId);
        var customer = await GetOwnedCustomerAsync(context, customerId);
        return MapToResponse(customer, customer.Branch?.Name);
    }

    public async Task<PagedResult<CustomerResponse>> GetPagedAsync(int currentUserId, PagedRequest request)
    {
        var context = await GetCallerContextAsync(currentUserId);
        var query = _customerRepository.Query()
            .Include(c => c.Branch)
            .Where(c => c.FirmId == context.FirmId);

        if (!context.CanAccessAllBranches)
        {
            query = query.Where(c => c.BranchId == context.BranchId);
        }

        if (!string.IsNullOrWhiteSpace(request.SearchTerm))
        {
            query = query.Where(c =>
                c.Title.Contains(request.SearchTerm) ||
                c.TaxNumber.Contains(request.SearchTerm));
        }

        query = request.SortBy?.ToLower() switch
        {
            "title" => request.SortDirection == SortDirection.Descending
                ? query.OrderByDescending(c => c.Title)
                : query.OrderBy(c => c.Title),
            "updateddate" => request.SortDirection == SortDirection.Descending
                ? query.OrderByDescending(c => c.UpdatedDate)
                : query.OrderBy(c => c.UpdatedDate),
            "branchname" => request.SortDirection == SortDirection.Descending
                ? query.OrderByDescending(c => c.Branch!.Name)
                : query.OrderBy(c => c.Branch!.Name),
            _ => request.SortDirection == SortDirection.Descending
                ? query.OrderByDescending(c => c.CreatedDate)
                : query.OrderBy(c => c.CreatedDate)
        };

        var pagedCustomers = await query.ToPagedResultAsync(request.Page, request.PageSize);

        return new PagedResult<CustomerResponse>
        {
            Items = pagedCustomers.Items.Select(c => MapToResponse(c, c.Branch?.Name)).ToList(),
            TotalCount = pagedCustomers.TotalCount,
            Page = pagedCustomers.Page,
            PageSize = pagedCustomers.PageSize
        };
    }

    private async Task<UserPermissionContext> GetCallerContextAsync(int currentUserId)
    {
        var context = await _permissionService.GetUserContextAsync(currentUserId);

        if (context.FirmId is null)
        {
            throw new BusinessRuleException(ErrorCodes.UserHasNoFirm);
        }

        return context;
    }

    private async Task<int?> ResolveBranchIdForCreateAsync(
        UserPermissionContext context, int currentFirmId, int? requestedBranchId)
    {
        if (!context.CanAccessAllBranches)
        {
            return context.BranchId;
        }

        if (requestedBranchId is null)
        {
            return null;
        }

        var branchExists = await _branchRepository.Query()
            .AnyAsync(b => b.BranchId == requestedBranchId && b.FirmId == currentFirmId);

        if (!branchExists)
        {
            throw new NotFoundException(
                ErrorCodes.BranchNotFound,
                new Dictionary<string, string> { ["branchId"] = requestedBranchId.Value.ToString() });
        }

        return requestedBranchId;
    }

    private async Task<int?> ResolveBranchIdForUpdateAsync(
        UserPermissionContext context, int currentFirmId, int? currentBranchId, int? requestedBranchId)
    {
        if (!context.CanAccessAllBranches)
        {
            return currentBranchId;
        }

        if (requestedBranchId is null)
        {
            return currentBranchId;
        }

        var branchExists = await _branchRepository.Query()
            .AnyAsync(b => b.BranchId == requestedBranchId && b.FirmId == currentFirmId);

        if (!branchExists)
        {
            throw new NotFoundException(
                ErrorCodes.BranchNotFound,
                new Dictionary<string, string> { ["branchId"] = requestedBranchId.Value.ToString() });
        }

        return requestedBranchId;
    }

    private async Task<string?> GetBranchNameAsync(int? branchId)
    {
        if (branchId is null)
        {
            return null;
        }

        return await _branchRepository.Query()
            .Where(b => b.BranchId == branchId)
            .Select(b => b.Name)
            .FirstOrDefaultAsync();
    }

    private async Task<Customer> GetOwnedCustomerAsync(UserPermissionContext context, int customerId)
    {
        var query = _customerRepository.Query()
            .Include(c => c.Branch)
            .Where(c => c.CustomerId == customerId && c.FirmId == context.FirmId);

        if (!context.CanAccessAllBranches)
        {
            query = query.Where(c => c.BranchId == context.BranchId);
        }

        var customer = await query.FirstOrDefaultAsync();

        return customer ?? throw new NotFoundException(
            ErrorCodes.CustomerNotFound,
            new Dictionary<string, string> { ["customerId"] = customerId.ToString() });
    }

    private static CustomerResponse MapToResponse(Customer customer, string? branchName)
    {
        return new CustomerResponse
        {
            CustomerId = customer.CustomerId,
            TaxNumber = customer.TaxNumber,
            Title = customer.Title,
            Address = customer.Address,
            Email = customer.Email,
            Phone = customer.Phone,
            BranchId = customer.BranchId,
            BranchName = branchName,
            CreatedDate = customer.CreatedDate,
            UpdatedDate = customer.UpdatedDate
        };
    }
}
