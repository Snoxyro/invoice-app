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
    private const string SimulatedGibStatusCode = "1300";
    private const string SimulatedGibStatusMessage = "Başarıyla Tamamlandı";

    private readonly IRepository<Invoice> _invoiceRepository;
    private readonly IRepository<Customer> _customerRepository;
    private readonly IRepository<VatRate> _vatRateRepository;
    private readonly IRepository<InvoiceSeries> _invoiceSeriesRepository;
    private readonly IPermissionService _permissionService;
    private readonly AppDbContext _dbContext;

    public InvoiceService(
        IRepository<Invoice> invoiceRepository,
        IRepository<Customer> customerRepository,
        IRepository<VatRate> vatRateRepository,
        IRepository<InvoiceSeries> invoiceSeriesRepository,
        IPermissionService permissionService,
        AppDbContext dbContext)
    {
        _invoiceRepository = invoiceRepository;
        _customerRepository = customerRepository;
        _vatRateRepository = vatRateRepository;
        _invoiceSeriesRepository = invoiceSeriesRepository;
        _permissionService = permissionService;
        _dbContext = dbContext;
    }

    public async Task<InvoiceResponse> CreateAsync(int currentUserId, InvoiceCreateRequest request)
    {
        var context = await _permissionService.GetUserContextAsync(currentUserId);
        var currentFirmId = context.FirmId ?? throw new BusinessRuleException(ErrorCodes.UserHasNoFirm);
        var currentBranchId = context.BranchId ?? throw new BusinessRuleException(ErrorCodes.UserHasNoBranch);

        var customer = await GetOwnedCustomerAsync(context, request.CustomerId);
        var series = await GetUsableSeriesAsync(context, request.InvoiceSeriesId);

        var vatRates = await GetVatRatesForLinesAsync(request.Lines);

        var invoice = new Invoice
        {
            CustomerId = request.CustomerId,
            InvoiceDate = request.InvoiceDate,
            FirmId = currentFirmId,
            BranchId = currentBranchId,
            InvoiceSeriesId = series.InvoiceSeriesId,
            Status = InvoiceStatus.Draft,
            CreatedByUserId = currentUserId,
            InvoiceLines = request.Lines.Select(l => new InvoiceLine
            {
                ItemName = l.ItemName,
                Quantity = l.Quantity,
                Price = l.Price,
                VatRateId = l.VatRateId,
                UserId = currentUserId
            }).ToList()
        };

        ApplyTotals(invoice, vatRates);

        await _invoiceRepository.AddAsync(invoice);
        await _invoiceRepository.SaveChangesAsync();

        return MapToResponse(invoice, customer.Title, vatRates);
    }

    public async Task<InvoiceResponse> UpdateAsync(int currentUserId, int invoiceId, InvoiceUpdateRequest request)
    {
        var context = await _permissionService.GetUserContextAsync(currentUserId);

        var invoice = await GetOwnedInvoiceAsync(context, invoiceId, includeLines: true);

        if (invoice.Status == InvoiceStatus.Sent)
        {
            throw new BusinessRuleException(ErrorCodes.InvoiceAlreadySentCannotModify);
        }

        var customer = await GetOwnedCustomerAsync(context, request.CustomerId);
        var series = await GetUsableSeriesAsync(context, request.InvoiceSeriesId);

        var vatRates = await GetVatRatesForLinesAsync(request.Lines);

        invoice.CustomerId = request.CustomerId;
        invoice.InvoiceDate = request.InvoiceDate;
        invoice.InvoiceSeriesId = series.InvoiceSeriesId;

        invoice.InvoiceLines.Clear();

        foreach (var line in request.Lines)
        {
            invoice.InvoiceLines.Add(new InvoiceLine
            {
                ItemName = line.ItemName,
                Quantity = line.Quantity,
                Price = line.Price,
                VatRateId = line.VatRateId,
                UserId = currentUserId
            });
        }

        ApplyTotals(invoice, vatRates);

        _invoiceRepository.Update(invoice);
        await _invoiceRepository.SaveChangesAsync();

        return MapToResponse(invoice, customer.Title, vatRates);
    }

    public async Task<InvoiceResponse> SendAsync(int currentUserId, int invoiceId)
    {
        var context = await _permissionService.GetUserContextAsync(currentUserId);
        var invoice = await GetOwnedInvoiceAsync(context, invoiceId, includeLines: true, includeCustomer: true);

        if (invoice.Status == InvoiceStatus.Sent)
        {
            throw new BusinessRuleException(ErrorCodes.InvoiceAlreadySentCannotModify);
        }

        if (invoice.InvoiceLines.Count == 0)
        {
            throw new BusinessRuleException(ErrorCodes.InvoiceRequiresAtLeastOneLine);
        }

        var lineRequests = invoice.InvoiceLines
            .Select(l => new InvoiceLineRequest
            {
                ItemName = l.ItemName,
                Quantity = l.Quantity,
                Price = l.Price,
                VatRateId = l.VatRateId
            })
            .ToList();

        var vatRates = await GetAllowedVatRatesAsync(lineRequests, context);

        ApplyTotals(invoice, vatRates);

        ValidateInvoiceAmountWithinLimit(invoice.GrandTotal, context);

        var executionStrategy = _dbContext.Database.CreateExecutionStrategy();

        await executionStrategy.ExecuteAsync(async () =>
        {
            await using var transaction = await _dbContext.Database.BeginTransactionAsync();

            try
            {
                invoice.InvoiceNumber = await AllocateInvoiceNumberAsync(invoice.InvoiceSeriesId);
                invoice.Status = InvoiceStatus.Sent;
                invoice.GibStatusCode = SimulatedGibStatusCode;
                invoice.GibStatusMessage = SimulatedGibStatusMessage;
                invoice.SentDate = DateTime.UtcNow;

                _invoiceRepository.Update(invoice);
                await _invoiceRepository.SaveChangesAsync();

                await transaction.CommitAsync();
            }
            catch
            {
                await transaction.RollbackAsync();
                throw;
            }
        });

        return MapToResponse(invoice, invoice.Customer.Title, vatRates);
    }

    public async Task DeleteAsync(int currentUserId, int invoiceId)
    {
        var context = await _permissionService.GetUserContextAsync(currentUserId);
        var invoice = await GetOwnedInvoiceAsync(context, invoiceId);

        invoice.IsDeleted = true;
        invoice.DeletedDate = DateTime.UtcNow;

        _invoiceRepository.Update(invoice);
        await _invoiceRepository.SaveChangesAsync();
    }

    public async Task<InvoiceResponse> GetByIdAsync(int currentUserId, int invoiceId)
    {
        var context = await _permissionService.GetUserContextAsync(currentUserId);
        var invoice = await GetOwnedInvoiceAsync(context, invoiceId, includeLines: true, includeCustomer: true);

        var vatRateIds = invoice.InvoiceLines.Select(l => l.VatRateId).Distinct().ToList();
        var vatRates = await _vatRateRepository.Query()
            .Where(v => vatRateIds.Contains(v.VatRateId))
            .ToDictionaryAsync(v => v.VatRateId, v => v.Rate);

        return MapToResponse(invoice, invoice.Customer.Title, vatRates);
    }

    public async Task<PagedResult<InvoiceListItemResponse>> GetPagedAsync(int currentUserId, InvoiceListRequest request)
    {
        var context = await _permissionService.GetUserContextAsync(currentUserId);
        var currentFirmId = context.FirmId ?? throw new BusinessRuleException(ErrorCodes.UserHasNoFirm);

        var query = _invoiceRepository.Query()
            .Include(i => i.Customer)
            .Where(i => i.FirmId == currentFirmId);

        if (!context.CanAccessAllBranches)
        {
            query = query.Where(i => i.BranchId == context.BranchId);
        }

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
                (i.InvoiceNumber != null && i.InvoiceNumber.Contains(request.SearchTerm)) ||
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
                Subtotal = i.Subtotal,
                VatTotal = i.VatTotal,
                GrandTotal = i.GrandTotal,
                CustomerId = i.CustomerId,
                CustomerTitle = i.Customer.Title,
                BranchId = i.BranchId,
                Status = i.Status,
                CreatedDate = i.CreatedDate,
                UpdatedDate = i.UpdatedDate
            }).ToList(),
            TotalCount = pagedInvoices.TotalCount,
            Page = pagedInvoices.Page,
            PageSize = pagedInvoices.PageSize
        };
    }

    private async Task<Customer> GetOwnedCustomerAsync(UserPermissionContext context, int customerId)
    {
        var query = _customerRepository.Query()
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

    private async Task<InvoiceSeries> GetUsableSeriesAsync(UserPermissionContext context, int invoiceSeriesId)
    {
        var series = await _invoiceSeriesRepository.Query()
            .FirstOrDefaultAsync(s => s.InvoiceSeriesId == invoiceSeriesId && s.BranchId == context.BranchId);

        if (series is null)
        {
            throw new NotFoundException(
                ErrorCodes.SeriesNotFound,
                new Dictionary<string, string> { ["invoiceSeriesId"] = invoiceSeriesId.ToString() });
        }

        if (!series.IsActive)
        {
            throw new BusinessRuleException(
                ErrorCodes.SeriesNotActive,
                new Dictionary<string, string> { ["invoiceSeriesId"] = invoiceSeriesId.ToString() });
        }

        return series;
    }

    private async Task<Invoice> GetOwnedInvoiceAsync(
        UserPermissionContext context, int invoiceId, bool includeLines = false, bool includeCustomer = false)
    {
        var query = _invoiceRepository.Query()
            .Where(i => i.InvoiceId == invoiceId && i.FirmId == context.FirmId);

        if (includeLines)
        {
            query = query.Include(i => i.InvoiceLines);
        }

        if (includeCustomer)
        {
            query = query.Include(i => i.Customer);
        }

        if (!context.CanAccessAllBranches)
        {
            query = query.Where(i => i.BranchId == context.BranchId);
        }

        var invoice = await query.FirstOrDefaultAsync();

        return invoice ?? throw new NotFoundException(
            ErrorCodes.InvoiceNotFound,
            new Dictionary<string, string> { ["invoiceId"] = invoiceId.ToString() });
    }

    private async Task<Dictionary<int, decimal>> GetVatRatesForLinesAsync(List<InvoiceLineRequest> lines)
    {
        var requestedVatRateIds = lines.Select(l => l.VatRateId).Distinct().ToList();

        var vatRates = await _vatRateRepository.Query()
            .Where(v => requestedVatRateIds.Contains(v.VatRateId))
            .ToDictionaryAsync(v => v.VatRateId, v => v.Rate);

        if (vatRates.Count != requestedVatRateIds.Count)
        {
            throw new BusinessRuleException(ErrorCodes.InvalidVatRateSelection);
        }

        return vatRates;
    }

    private async Task<Dictionary<int, decimal>> GetAllowedVatRatesAsync(
        List<InvoiceLineRequest> lines, UserPermissionContext context)
    {
        var requestedVatRateIds = lines.Select(l => l.VatRateId).Distinct().ToList();

        var notAllowed = requestedVatRateIds.Where(id => !context.VatRateIds.Contains(id)).ToList();

        if (notAllowed.Count > 0)
        {
            throw new BusinessRuleException(
                ErrorCodes.VatRateNotAllowedForProfile,
                new Dictionary<string, string> { ["vatRateIds"] = string.Join(",", notAllowed) });
        }

        return await _vatRateRepository.Query()
            .Where(v => requestedVatRateIds.Contains(v.VatRateId))
            .ToDictionaryAsync(v => v.VatRateId, v => v.Rate);
    }

    private async Task<string> AllocateInvoiceNumberAsync(int invoiceSeriesId)
    {
        var series = await _dbContext.InvoiceSeries
            .FromSqlInterpolated($"SELECT * FROM InvoiceSeries WITH (UPDLOCK, ROWLOCK) WHERE InvoiceSeriesId = {invoiceSeriesId}")
            .SingleAsync();

        var currentYear = DateTime.UtcNow.Year;

        if (series.LastUsedYear != currentYear)
        {
            series.LastUsedYear = currentYear;
            series.NextNumber = 1;
        }

        var allocatedNumber = series.NextNumber;
        series.NextNumber++;

        return $"{series.Prefix}{currentYear}{allocatedNumber:D9}";
    }

    private static void ApplyTotals(Invoice invoice, Dictionary<int, decimal> vatRates)
    {
        decimal subtotal = 0;
        decimal vatTotal = 0;

        foreach (var line in invoice.InvoiceLines)
        {
            var lineSubtotal = Math.Round(line.Quantity * line.Price, 2);
            var lineVat = Math.Round(lineSubtotal * vatRates[line.VatRateId] / 100, 2);

            subtotal += lineSubtotal;
            vatTotal += lineVat;
        }

        invoice.Subtotal = subtotal;
        invoice.VatTotal = vatTotal;
        invoice.GrandTotal = subtotal + vatTotal;
    }

    private static void ValidateInvoiceAmountWithinLimit(decimal grandTotal, UserPermissionContext context)
    {
        if (context.MinInvoiceAmount is not null && grandTotal < context.MinInvoiceAmount)
        {
            throw new BusinessRuleException(
                ErrorCodes.InvoiceAmountBelowMinimum,
                new Dictionary<string, string> { ["minInvoiceAmount"] = context.MinInvoiceAmount.Value.ToString() });
        }

        if (context.MaxInvoiceAmount is not null && grandTotal > context.MaxInvoiceAmount)
        {
            throw new BusinessRuleException(
                ErrorCodes.InvoiceAmountAboveMaximum,
                new Dictionary<string, string> { ["maxInvoiceAmount"] = context.MaxInvoiceAmount.Value.ToString() });
        }
    }

    private static InvoiceResponse MapToResponse(Invoice invoice, string customerTitle, Dictionary<int, decimal> vatRates)
    {
        return new InvoiceResponse
        {
            InvoiceId = invoice.InvoiceId,
            InvoiceNumber = invoice.InvoiceNumber,
            InvoiceDate = invoice.InvoiceDate,
            Subtotal = invoice.Subtotal,
            VatTotal = invoice.VatTotal,
            GrandTotal = invoice.GrandTotal,
            CustomerId = invoice.CustomerId,
            CustomerTitle = customerTitle,
            BranchId = invoice.BranchId,
            InvoiceSeriesId = invoice.InvoiceSeriesId,
            Status = invoice.Status,
            GibStatusCode = invoice.GibStatusCode,
            GibStatusMessage = invoice.GibStatusMessage,
            SentDate = invoice.SentDate,
            CreatedDate = invoice.CreatedDate,
            UpdatedDate = invoice.UpdatedDate,
            Lines = invoice.InvoiceLines.Select(l => new InvoiceLineResponse
            {
                InvoiceLineId = l.InvoiceLineId,
                ItemName = l.ItemName,
                Quantity = l.Quantity,
                Price = l.Price,
                VatRateId = l.VatRateId,
                VatRatePercentage = vatRates[l.VatRateId]
            }).ToList()
        };
    }
}