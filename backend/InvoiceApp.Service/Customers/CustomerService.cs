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
    private readonly IPermissionService _permissionService;

    public CustomerService(
        IRepository<Customer> customerRepository,
        IRepository<Invoice> invoiceRepository,
        IPermissionService permissionService)
    {
        _customerRepository = customerRepository;
        _invoiceRepository = invoiceRepository;
        _permissionService = permissionService;
    }

    public async Task<CustomerResponse> CreateAsync(int currentUserId, CustomerCreateRequest request)
    {
        var currentFirmId = await GetCurrentFirmIdAsync(currentUserId);

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

        var customer = new Customer
        {
            TaxNumber = request.TaxNumber,
            Title = request.Title,
            Address = request.Address,
            Email = request.Email,
            FirmId = currentFirmId
        };

        await _customerRepository.AddAsync(customer);
        await _customerRepository.SaveChangesAsync();

        return MapToResponse(customer);
    }

    public async Task<CustomerResponse> UpdateAsync(int currentUserId, int customerId, CustomerUpdateRequest request)
    {
        var currentFirmId = await GetCurrentFirmIdAsync(currentUserId);
        var customer = await GetOwnedCustomerAsync(currentFirmId, customerId);

        if (!Regex.IsMatch(request.TaxNumber, "^[0-9]+$"))
        {
            throw new BusinessRuleException(ErrorCodes.InvalidTaxNumberFormat);
        }

        var taxNumberExists = await _customerRepository.Query()
            .AnyAsync(c =>
                c.FirmId == currentFirmId &&
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

        _customerRepository.Update(customer);
        await _customerRepository.SaveChangesAsync();

        return MapToResponse(customer);
    }

    public async Task DeleteAsync(int currentUserId, int customerId)
    {
        var currentFirmId = await GetCurrentFirmIdAsync(currentUserId);
        var customer = await GetOwnedCustomerAsync(currentFirmId, customerId);

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
        var currentFirmId = await GetCurrentFirmIdAsync(currentUserId);
        var customer = await GetOwnedCustomerAsync(currentFirmId, customerId);
        return MapToResponse(customer);
    }

    public async Task<PagedResult<CustomerResponse>> GetPagedAsync(int currentUserId, PagedRequest request)
    {
        var currentFirmId = await GetCurrentFirmIdAsync(currentUserId);
        var query = _customerRepository.Query().Where(c => c.FirmId == currentFirmId);

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
            _ => request.SortDirection == SortDirection.Descending
                ? query.OrderByDescending(c => c.CreatedDate)
                : query.OrderBy(c => c.CreatedDate)
        };

        var pagedCustomers = await query.ToPagedResultAsync(request.Page, request.PageSize);

        return new PagedResult<CustomerResponse>
        {
            Items = pagedCustomers.Items.Select(MapToResponse).ToList(),
            TotalCount = pagedCustomers.TotalCount,
            Page = pagedCustomers.Page,
            PageSize = pagedCustomers.PageSize
        };
    }

    private async Task<int> GetCurrentFirmIdAsync(int currentUserId)
    {
        var context = await _permissionService.GetUserContextAsync(currentUserId);
        return context.FirmId ?? throw new BusinessRuleException(ErrorCodes.UserHasNoFirm);
    }

    private async Task<Customer> GetOwnedCustomerAsync(int currentFirmId, int customerId)
    {
        var customer = await _customerRepository.Query()
            .FirstOrDefaultAsync(c => c.CustomerId == customerId && c.FirmId == currentFirmId);

        return customer ?? throw new NotFoundException(
            ErrorCodes.CustomerNotFound,
            new Dictionary<string, string> { ["customerId"] = customerId.ToString() });
    }

    private static CustomerResponse MapToResponse(Customer customer)
    {
        return new CustomerResponse
        {
            CustomerId = customer.CustomerId,
            TaxNumber = customer.TaxNumber,
            Title = customer.Title,
            Address = customer.Address,
            Email = customer.Email,
            CreatedDate = customer.CreatedDate,
            UpdatedDate = customer.UpdatedDate
        };
    }
}
