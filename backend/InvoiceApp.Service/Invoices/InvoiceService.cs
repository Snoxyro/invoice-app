using InvoiceApp.Common.Dtos.Invoices;
using InvoiceApp.Common.Entities;
using InvoiceApp.Common.Exceptions;
using InvoiceApp.Common.Paging;
using InvoiceApp.Repository;
using InvoiceApp.Repository.Extensions;
using InvoiceApp.Service.Permissions;
using Microsoft.EntityFrameworkCore;

namespace InvoiceApp.Service.Invoices;

public class InvoiceService : IInvoiceService
{
    private readonly IRepository<Invoice> _invoiceRepository;
    private readonly IRepository<Customer> _customerRepository;
    private readonly IPermissionService _permissionService;

    public InvoiceService(
        IRepository<Invoice> invoiceRepository,
        IRepository<Customer> customerRepository,
        IPermissionService permissionService)
    {
        _invoiceRepository = invoiceRepository;
        _customerRepository = customerRepository;
        _permissionService = permissionService;
    }

    public async Task<InvoiceResponse> CreateAsync(int currentUserId, InvoiceCreateRequest request)
    {
        var context = await _permissionService.GetUserContextAsync(currentUserId);
        var currentFirmId = context.FirmId ?? throw new BusinessRuleException(ErrorCodes.UserHasNoFirm);

        var invoiceNumberExists = await _invoiceRepository.Query()
            .AnyAsync(i => i.FirmId == currentFirmId && i.InvoiceNumber == request.InvoiceNumber);

        if (invoiceNumberExists)
        {
            throw new BusinessRuleException(
                ErrorCodes.InvoiceNumberAlreadyExists,
                new Dictionary<string, string> { ["invoiceNumber"] = request.InvoiceNumber });
        }

        var customer = await GetOwnedCustomerAsync(currentFirmId, request.CustomerId);

        if (request.Lines.Count == 0)
        {
            throw new BusinessRuleException(ErrorCodes.InvoiceRequiresAtLeastOneLine);
        }

        var invoice = new Invoice
        {
            CustomerId = request.CustomerId,
            InvoiceNumber = request.InvoiceNumber,
            InvoiceDate = request.InvoiceDate,
            FirmId = currentFirmId,
            CreatedByUserId = currentUserId,
            InvoiceLines = request.Lines.Select(l => new InvoiceLine
            {
                ItemName = l.ItemName,
                Quantity = l.Quantity,
                Price = l.Price,
                UserId = currentUserId
            }).ToList()
        };

        invoice.TotalAmount = invoice.InvoiceLines.Sum(l => l.Quantity * l.Price);

        ValidateInvoiceAmountWithinLimit(invoice.TotalAmount, context);

        await _invoiceRepository.AddAsync(invoice);
        await _invoiceRepository.SaveChangesAsync();

        return MapToResponse(invoice, customer.Title);
    }

    public async Task<InvoiceResponse> UpdateAsync(int currentUserId, int invoiceId, InvoiceUpdateRequest request)
    {
        var context = await _permissionService.GetUserContextAsync(currentUserId);
        var currentFirmId = context.FirmId ?? throw new BusinessRuleException(ErrorCodes.UserHasNoFirm);

        var invoice = await _invoiceRepository.Query()
            .Include(i => i.InvoiceLines)
            .FirstOrDefaultAsync(i => i.InvoiceId == invoiceId && i.FirmId == currentFirmId);

        if (invoice is null)
        {
            throw new NotFoundException(
                ErrorCodes.InvoiceNotFound,
                new Dictionary<string, string> { ["invoiceId"] = invoiceId.ToString() });
        }

        var invoiceNumberExists = await _invoiceRepository.Query()
            .AnyAsync(i =>
                i.FirmId == currentFirmId &&
                i.InvoiceNumber == request.InvoiceNumber &&
                i.InvoiceId != invoiceId);

        if (invoiceNumberExists)
        {
            throw new BusinessRuleException(
                ErrorCodes.InvoiceNumberAlreadyExists,
                new Dictionary<string, string> { ["invoiceNumber"] = request.InvoiceNumber });
        }

        var customer = await GetOwnedCustomerAsync(currentFirmId, request.CustomerId);

        if (request.Lines.Count == 0)
        {
            throw new BusinessRuleException(ErrorCodes.InvoiceRequiresAtLeastOneLine);
        }

        invoice.CustomerId = request.CustomerId;
        invoice.InvoiceNumber = request.InvoiceNumber;
        invoice.InvoiceDate = request.InvoiceDate;

        invoice.InvoiceLines.Clear();

        foreach (var line in request.Lines)
        {
            invoice.InvoiceLines.Add(new InvoiceLine
            {
                ItemName = line.ItemName,
                Quantity = line.Quantity,
                Price = line.Price,
                UserId = currentUserId
            });
        }

        invoice.TotalAmount = invoice.InvoiceLines.Sum(l => l.Quantity * l.Price);

        ValidateInvoiceAmountWithinLimit(invoice.TotalAmount, context);

        _invoiceRepository.Update(invoice);
        await _invoiceRepository.SaveChangesAsync();

        return MapToResponse(invoice, customer.Title);
    }

    public async Task DeleteAsync(int currentUserId, int invoiceId)
    {
        var context = await _permissionService.GetUserContextAsync(currentUserId);
        var currentFirmId = context.FirmId ?? throw new BusinessRuleException(ErrorCodes.UserHasNoFirm);

        var invoice = await _invoiceRepository.Query()
            .FirstOrDefaultAsync(i => i.InvoiceId == invoiceId && i.FirmId == currentFirmId);

        if (invoice is null)
        {
            throw new NotFoundException(
                ErrorCodes.InvoiceNotFound,
                new Dictionary<string, string> { ["invoiceId"] = invoiceId.ToString() });
        }

        invoice.IsDeleted = true;
        invoice.DeletedDate = DateTime.UtcNow;

        _invoiceRepository.Update(invoice);
        await _invoiceRepository.SaveChangesAsync();
    }

    public async Task<InvoiceResponse> GetByIdAsync(int currentUserId, int invoiceId)
    {
        var context = await _permissionService.GetUserContextAsync(currentUserId);
        var currentFirmId = context.FirmId ?? throw new BusinessRuleException(ErrorCodes.UserHasNoFirm);

        var invoice = await _invoiceRepository.Query()
            .Include(i => i.InvoiceLines)
            .Include(i => i.Customer)
            .FirstOrDefaultAsync(i => i.InvoiceId == invoiceId && i.FirmId == currentFirmId);

        if (invoice is null)
        {
            throw new NotFoundException(
                ErrorCodes.InvoiceNotFound,
                new Dictionary<string, string> { ["invoiceId"] = invoiceId.ToString() });
        }

        return MapToResponse(invoice, invoice.Customer.Title);
    }

    public async Task<PagedResult<InvoiceListItemResponse>> GetPagedAsync(int currentUserId, InvoiceListRequest request)
    {
        var context = await _permissionService.GetUserContextAsync(currentUserId);
        var currentFirmId = context.FirmId ?? throw new BusinessRuleException(ErrorCodes.UserHasNoFirm);

        var query = _invoiceRepository.Query()
            .Include(i => i.Customer)
            .Where(i => i.FirmId == currentFirmId);

        if (request.StartDate.HasValue)
        {
            query = query.Where(i => i.InvoiceDate >= request.StartDate.Value);
        }

        if (request.EndDate.HasValue)
        {
            query = query.Where(i => i.InvoiceDate <= request.EndDate.Value);
        }

        if (!string.IsNullOrWhiteSpace(request.SearchTerm))
        {
            query = query.Where(i =>
                i.InvoiceNumber.Contains(request.SearchTerm) ||
                i.Customer.Title.Contains(request.SearchTerm));
        }

        query = request.SortBy?.ToLower() switch
        {
            "customer" => request.SortDirection == SortDirection.Descending
                ? query.OrderByDescending(i => i.Customer.Title)
                : query.OrderBy(i => i.Customer.Title),
            "createddate" => request.SortDirection == SortDirection.Descending
                ? query.OrderByDescending(i => i.CreatedDate)
                : query.OrderBy(i => i.CreatedDate),
            "updateddate" => request.SortDirection == SortDirection.Descending
                ? query.OrderByDescending(i => i.UpdatedDate)
                : query.OrderBy(i => i.UpdatedDate),
            _ => request.SortDirection == SortDirection.Descending
                ? query.OrderByDescending(i => i.InvoiceDate)
                : query.OrderBy(i => i.InvoiceDate)
        };

        var pagedInvoices = await query.ToPagedResultAsync(request.Page, request.PageSize);

        return new PagedResult<InvoiceListItemResponse>
        {
            Items = pagedInvoices.Items.Select(i => new InvoiceListItemResponse
            {
                InvoiceId = i.InvoiceId,
                InvoiceNumber = i.InvoiceNumber,
                InvoiceDate = i.InvoiceDate,
                TotalAmount = i.TotalAmount,
                CustomerId = i.CustomerId,
                CustomerTitle = i.Customer.Title,
                CreatedDate = i.CreatedDate,
                UpdatedDate = i.UpdatedDate
            }).ToList(),
            TotalCount = pagedInvoices.TotalCount,
            Page = pagedInvoices.Page,
            PageSize = pagedInvoices.PageSize
        };
    }

    private async Task<Customer> GetOwnedCustomerAsync(int currentFirmId, int customerId)
    {
        var customer = await _customerRepository.Query()
            .FirstOrDefaultAsync(c => c.CustomerId == customerId && c.FirmId == currentFirmId);

        return customer ?? throw new NotFoundException(
            ErrorCodes.CustomerNotFound,
            new Dictionary<string, string> { ["customerId"] = customerId.ToString() });
    }

    private static void ValidateInvoiceAmountWithinLimit(decimal totalAmount, UserPermissionContext context)
    {
        if (context.MinInvoiceAmount is not null && totalAmount < context.MinInvoiceAmount)
        {
            throw new BusinessRuleException(
                ErrorCodes.InvoiceAmountBelowMinimum,
                new Dictionary<string, string> { ["minInvoiceAmount"] = context.MinInvoiceAmount.Value.ToString() });
        }

        if (context.MaxInvoiceAmount is not null && totalAmount > context.MaxInvoiceAmount)
        {
            throw new BusinessRuleException(
                ErrorCodes.InvoiceAmountAboveMaximum,
                new Dictionary<string, string> { ["maxInvoiceAmount"] = context.MaxInvoiceAmount.Value.ToString() });
        }
    }

    private static InvoiceResponse MapToResponse(Invoice invoice, string customerTitle)
    {
        return new InvoiceResponse
        {
            InvoiceId = invoice.InvoiceId,
            InvoiceNumber = invoice.InvoiceNumber,
            InvoiceDate = invoice.InvoiceDate,
            TotalAmount = invoice.TotalAmount,
            CustomerId = invoice.CustomerId,
            CustomerTitle = customerTitle,
            CreatedDate = invoice.CreatedDate,
            UpdatedDate = invoice.UpdatedDate,
            Lines = invoice.InvoiceLines.Select(l => new InvoiceLineResponse
            {
                InvoiceLineId = l.InvoiceLineId,
                ItemName = l.ItemName,
                Quantity = l.Quantity,
                Price = l.Price
            }).ToList()
        };
    }
}
