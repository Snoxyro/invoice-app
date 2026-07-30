using InvoiceApp.Common.Dtos.Branches;
using InvoiceApp.Common.Entities;
using InvoiceApp.Common.Exceptions;
using InvoiceApp.Common.Paging;
using InvoiceApp.Repository;
using InvoiceApp.Repository.Extensions;
using InvoiceApp.Service.Permissions;
using Microsoft.EntityFrameworkCore;

namespace InvoiceApp.Service.Branches;

public class BranchService : IBranchService
{
    private readonly IRepository<Branch> _branchRepository;
    private readonly IRepository<User> _userRepository;
    private readonly IRepository<Customer> _customerRepository;
    private readonly IRepository<Invoice> _invoiceRepository;
    private readonly IPermissionService _permissionService;

    public BranchService(
        IRepository<Branch> branchRepository,
        IRepository<User> userRepository,
        IRepository<Customer> customerRepository,
        IRepository<Invoice> invoiceRepository,
        IPermissionService permissionService)
    {
        _branchRepository = branchRepository;
        _userRepository = userRepository;
        _customerRepository = customerRepository;
        _invoiceRepository = invoiceRepository;
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
}
