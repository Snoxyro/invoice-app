using InvoiceApp.Common.Dtos.Customers;
using InvoiceApp.Common.Entities;
using InvoiceApp.Common.Exceptions;
using InvoiceApp.Common.Paging;
using InvoiceApp.Repository;
using InvoiceApp.Repository.Extensions;
using Microsoft.EntityFrameworkCore;
using System.Text.RegularExpressions;

namespace InvoiceApp.Service.Customers;

public class CustomerService : ICustomerService
{
    private readonly IRepository<Customer> _customerRepository;
    private readonly IRepository<Invoice> _invoiceRepository;

    public CustomerService(IRepository<Customer> customerRepository, IRepository<Invoice> invoiceRepository)
    {
        _customerRepository = customerRepository;
        _invoiceRepository = invoiceRepository;
    }

    public async Task<CustomerResponse> CreateAsync(int currentUserId, CustomerCreateRequest request)
    {
        if (!Regex.IsMatch(request.TaxNumber, "^[0-9]+$"))
        {
            throw new BusinessRuleException(ErrorCodes.InvalidTaxNumberFormat);
        }

        var taxNumberExists = await _customerRepository.Query()
            .AnyAsync(c => c.UserId == currentUserId && c.TaxNumber == request.TaxNumber);

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
            UserId = currentUserId
        };

        await _customerRepository.AddAsync(customer);
        await _customerRepository.SaveChangesAsync();

        return MapToResponse(customer);
    }

    public async Task<CustomerResponse> UpdateAsync(int currentUserId, int customerId, CustomerUpdateRequest request)
    {
        var customer = await GetOwnedCustomerAsync(currentUserId, customerId);

        if (!Regex.IsMatch(request.TaxNumber, "^[0-9]+$"))
        {
            throw new BusinessRuleException(ErrorCodes.InvalidTaxNumberFormat);
        }

        var taxNumberExists = await _customerRepository.Query()
            .AnyAsync(c =>
                c.UserId == currentUserId &&
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
        var customer = await GetOwnedCustomerAsync(currentUserId, customerId);

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
        var customer = await GetOwnedCustomerAsync(currentUserId, customerId);
        return MapToResponse(customer);
    }

    public async Task<PagedResult<CustomerResponse>> GetPagedAsync(int currentUserId, PagedRequest request)
    {
        var query = _customerRepository.Query().Where(c => c.UserId == currentUserId);

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

    private async Task<Customer> GetOwnedCustomerAsync(int currentUserId, int customerId)
    {
        var customer = await _customerRepository.Query()
            .FirstOrDefaultAsync(c => c.CustomerId == customerId && c.UserId == currentUserId);

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