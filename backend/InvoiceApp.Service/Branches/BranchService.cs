using InvoiceApp.Common.Dtos.Branches;
using InvoiceApp.Common.Dtos.InvoiceSeries;
using InvoiceApp.Common.Entities;
using InvoiceApp.Common.Exceptions;
using InvoiceApp.Common.Paging;
using InvoiceApp.Repository;
using InvoiceApp.Repository.Extensions;
using InvoiceApp.Service.Permissions;
using InvoiceApp.Service.Shared;
using Microsoft.EntityFrameworkCore;

namespace InvoiceApp.Service.Branches;

public class BranchService : IBranchService
{
    private readonly IRepository<Branch> _branchRepository;
    private readonly IRepository<User> _userRepository;
    private readonly IRepository<Customer> _customerRepository;
    private readonly IRepository<Invoice> _invoiceRepository;
    private readonly IRepository<InvoiceSeries> _invoiceSeriesRepository;
    private readonly IPermissionService _permissionService;

    public BranchService(
        IRepository<Branch> branchRepository,
        IRepository<User> userRepository,
        IRepository<Customer> customerRepository,
        IRepository<Invoice> invoiceRepository,
        IRepository<InvoiceSeries> invoiceSeriesRepository,
        IPermissionService permissionService)
    {
        _branchRepository = branchRepository;
        _userRepository = userRepository;
        _customerRepository = customerRepository;
        _invoiceRepository = invoiceRepository;
        _invoiceSeriesRepository = invoiceSeriesRepository;
        _permissionService = permissionService;
    }

    public async Task<BranchResponse> CreateAsync(int currentUserId, BranchCreateRequest request)
    {
        var currentFirmId = await GetCurrentFirmIdAsync(currentUserId);

        var nameExists = await _branchRepository.Query()
            .AnyAsync(b => b.FirmId == currentFirmId && b.Name == request.Name);

        if (nameExists)
        {
            throw new BusinessRuleException(
                ErrorCodes.BranchNameAlreadyExists,
                new Dictionary<string, string> { ["name"] = request.Name });
        }

        var branch = new Branch
        {
            FirmId = currentFirmId,
            Name = request.Name,
            IsHeadquarters = false,
            Address = request.Address,
            City = request.City,
            TaxOffice = request.TaxOffice,
            Phone = request.Phone,
            Fax = request.Fax,
            Email = request.Email,
            Website = request.Website
        };

        var seriesPrefix = await GenerateUniqueSeriesPrefixAsync(currentFirmId, request.Name);

        branch.InvoiceSeries.Add(new InvoiceSeries
        {
            Branch = branch,
            Prefix = seriesPrefix,
            LastUsedYear = DateTime.UtcNow.Year,
            NextNumber = 1,
            IsActive = true
        });

        await _branchRepository.AddAsync(branch);
        await _branchRepository.SaveChangesAsync();

        return MapToResponse(branch);
    }

    public async Task<BranchResponse> UpdateAsync(int currentUserId, int branchId, BranchUpdateRequest request)
    {
        var currentFirmId = await GetCurrentFirmIdAsync(currentUserId);
        var branch = await GetOwnedBranchAsync(currentFirmId, branchId);

        var nameExists = await _branchRepository.Query()
            .AnyAsync(b => b.FirmId == currentFirmId && b.Name == request.Name && b.BranchId != branchId);

        if (nameExists)
        {
            throw new BusinessRuleException(
                ErrorCodes.BranchNameAlreadyExists,
                new Dictionary<string, string> { ["name"] = request.Name });
        }

        branch.Name = request.Name;
        branch.Address = request.Address;
        branch.City = request.City;
        branch.TaxOffice = request.TaxOffice;
        branch.Phone = request.Phone;
        branch.Fax = request.Fax;
        branch.Email = request.Email;
        branch.Website = request.Website;

        _branchRepository.Update(branch);
        await _branchRepository.SaveChangesAsync();

        return MapToResponse(branch);
    }

    public async Task DeleteAsync(int currentUserId, int branchId)
    {
        var currentFirmId = await GetCurrentFirmIdAsync(currentUserId);
        var branch = await GetOwnedBranchAsync(currentFirmId, branchId);

        var hasUsers = await _userRepository.Query().AnyAsync(u => u.BranchId == branchId);
        var hasCustomers = await _customerRepository.Query().AnyAsync(c => c.BranchId == branchId);
        var hasInvoices = await _invoiceRepository.Query().AnyAsync(i => i.BranchId == branchId);

        if (branch.IsHeadquarters || hasUsers || hasCustomers || hasInvoices)
        {
            throw new BusinessRuleException(ErrorCodes.BranchHasRecordsCannotDelete);
        }

        _branchRepository.Remove(branch);
        await _branchRepository.SaveChangesAsync();
    }

    public async Task<BranchResponse> GetByIdAsync(int currentUserId, int branchId)
    {
        var currentFirmId = await GetCurrentFirmIdAsync(currentUserId);
        var branch = await GetOwnedBranchAsync(currentFirmId, branchId);
        return MapToResponse(branch);
    }

    public async Task<PagedResult<BranchResponse>> GetPagedAsync(int currentUserId, PagedRequest request)
    {
        var currentFirmId = await GetCurrentFirmIdAsync(currentUserId);
        var query = _branchRepository.Query().Where(b => b.FirmId == currentFirmId);

        if (!string.IsNullOrWhiteSpace(request.SearchTerm))
        {
            query = query.Where(b => b.Name.Contains(request.SearchTerm));
        }

        query = request.SortBy?.ToLower() switch
        {
            "name" => request.SortDirection == SortDirection.Descending
                ? query.OrderByDescending(b => b.Name)
                : query.OrderBy(b => b.Name),
            _ => request.SortDirection == SortDirection.Descending
                ? query.OrderByDescending(b => b.CreatedDate)
                : query.OrderBy(b => b.CreatedDate)
        };

        var pagedBranches = await query.ToPagedResultAsync(request.Page, request.PageSize);

        return new PagedResult<BranchResponse>
        {
            Items = pagedBranches.Items.Select(MapToResponse).ToList(),
            TotalCount = pagedBranches.TotalCount,
            Page = pagedBranches.Page,
            PageSize = pagedBranches.PageSize
        };
    }

    public async Task<List<InvoiceSeriesResponse>> GetSeriesAsync(int currentUserId, int branchId)
    {
        var currentFirmId = await GetCurrentFirmIdAsync(currentUserId);
        await GetOwnedBranchAsync(currentFirmId, branchId);

        var series = await _invoiceSeriesRepository.Query()
            .Where(s => s.BranchId == branchId)
            .OrderBy(s => s.Prefix)
            .ToListAsync();

        return series.Select(MapSeriesToResponse).ToList();
    }

    public async Task<InvoiceSeriesResponse> CreateSeriesAsync(
        int currentUserId, int branchId, InvoiceSeriesCreateRequest request)
    {
        var currentFirmId = await GetCurrentFirmIdAsync(currentUserId);
        await GetOwnedBranchAsync(currentFirmId, branchId);

        var normalizedPrefix = request.Prefix.Trim().ToUpperInvariant();

        if (!SeriesPrefixGenerator.IsValidFormat(normalizedPrefix))
        {
            throw new BusinessRuleException(ErrorCodes.SeriesPrefixInvalidFormat);
        }

        var prefixExists = await _invoiceSeriesRepository.Query()
            .AnyAsync(s => s.Branch.FirmId == currentFirmId && s.Prefix == normalizedPrefix);

        if (prefixExists)
        {
            throw new BusinessRuleException(
                ErrorCodes.SeriesPrefixAlreadyExists,
                new Dictionary<string, string> { ["prefix"] = normalizedPrefix });
        }

        var series = new InvoiceSeries
        {
            BranchId = branchId,
            Prefix = normalizedPrefix,
            LastUsedYear = DateTime.UtcNow.Year,
            NextNumber = 1,
            IsActive = true
        };

        await _invoiceSeriesRepository.AddAsync(series);
        await _invoiceSeriesRepository.SaveChangesAsync();

        return MapSeriesToResponse(series);
    }

    public async Task<InvoiceSeriesResponse> UpdateSeriesAsync(
        int currentUserId, int branchId, int seriesId, InvoiceSeriesUpdateRequest request)
    {
        var currentFirmId = await GetCurrentFirmIdAsync(currentUserId);
        await GetOwnedBranchAsync(currentFirmId, branchId);

        var series = await _invoiceSeriesRepository.Query()
            .FirstOrDefaultAsync(s => s.InvoiceSeriesId == seriesId && s.BranchId == branchId);

        if (series is null)
        {
            throw new NotFoundException(
                ErrorCodes.SeriesNotFound,
                new Dictionary<string, string> { ["invoiceSeriesId"] = seriesId.ToString() });
        }

        if (!request.IsActive && series.IsActive)
        {
            var otherActiveSeriesExists = await _invoiceSeriesRepository.Query()
                .AnyAsync(s => s.BranchId == branchId && s.InvoiceSeriesId != seriesId && s.IsActive);

            if (!otherActiveSeriesExists)
            {
                throw new BusinessRuleException(ErrorCodes.SeriesLastActiveCannotDeactivate);
            }
        }

        series.IsActive = request.IsActive;

        _invoiceSeriesRepository.Update(series);
        await _invoiceSeriesRepository.SaveChangesAsync();

        return MapSeriesToResponse(series);
    }

    private async Task<int> GetCurrentFirmIdAsync(int currentUserId)
    {
        var context = await _permissionService.GetUserContextAsync(currentUserId);
        return context.FirmId ?? throw new BusinessRuleException(ErrorCodes.UserHasNoFirm);
    }

    private async Task<Branch> GetOwnedBranchAsync(int currentFirmId, int branchId)
    {
        var branch = await _branchRepository.Query()
            .FirstOrDefaultAsync(b => b.BranchId == branchId && b.FirmId == currentFirmId);

        return branch ?? throw new NotFoundException(
            ErrorCodes.BranchNotFound,
            new Dictionary<string, string> { ["branchId"] = branchId.ToString() });
    }

    private async Task<string> GenerateUniqueSeriesPrefixAsync(int firmId, string branchName)
    {
        var basePrefix = SeriesPrefixGenerator.Derive(branchName);

        var existingPrefixes = await _invoiceSeriesRepository.Query()
            .Where(s => s.Branch.FirmId == firmId)
            .Select(s => s.Prefix)
            .ToListAsync();

        if (!existingPrefixes.Contains(basePrefix))
        {
            return basePrefix;
        }

        const string candidateChars = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";

        foreach (var candidateChar in candidateChars)
        {
            var candidate = basePrefix[..2] + candidateChar;

            if (!existingPrefixes.Contains(candidate))
            {
                return candidate;
            }
        }

        throw new BusinessRuleException(
            ErrorCodes.SeriesPrefixAlreadyExists,
            new Dictionary<string, string> { ["prefix"] = basePrefix });
    }

    private static BranchResponse MapToResponse(Branch branch)
    {
        return new BranchResponse
        {
            BranchId = branch.BranchId,
            Name = branch.Name,
            IsHeadquarters = branch.IsHeadquarters,
            Address = branch.Address,
            City = branch.City,
            TaxOffice = branch.TaxOffice,
            Phone = branch.Phone,
            Fax = branch.Fax,
            Email = branch.Email,
            Website = branch.Website,
            CreatedDate = branch.CreatedDate,
            UpdatedDate = branch.UpdatedDate
        };
    }

    private static InvoiceSeriesResponse MapSeriesToResponse(InvoiceSeries series)
    {
        return new InvoiceSeriesResponse
        {
            InvoiceSeriesId = series.InvoiceSeriesId,
            BranchId = series.BranchId,
            Prefix = series.Prefix,
            LastUsedYear = series.LastUsedYear,
            NextNumber = series.NextNumber,
            IsActive = series.IsActive
        };
    }
}
