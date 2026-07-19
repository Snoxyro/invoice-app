using InvoiceApp.Common.Dtos.Firms;
using InvoiceApp.Common.Entities;
using InvoiceApp.Common.Exceptions;
using InvoiceApp.Common.Paging;
using InvoiceApp.Common.Security;
using InvoiceApp.Repository;
using InvoiceApp.Repository.Extensions;
using Microsoft.EntityFrameworkCore;

namespace InvoiceApp.Service.Firms;

public class FirmService : IFirmService
{
    private const string SystemAdminProfileName = "admin";

    private readonly IRepository<Firm> _firmRepository;
    private readonly IRepository<Profile> _profileRepository;
    private readonly IRepository<User> _userRepository;
    private readonly IRepository<Permission> _permissionRepository;
    private readonly IRepository<VatRate> _vatRateRepository;
    private readonly IRepository<Customer> _customerRepository;
    private readonly IRepository<Invoice> _invoiceRepository;
    private readonly IPasswordHasher _passwordHasher;

    public FirmService(
        IRepository<Firm> firmRepository,
        IRepository<Profile> profileRepository,
        IRepository<User> userRepository,
        IRepository<Permission> permissionRepository,
        IRepository<VatRate> vatRateRepository,
        IRepository<Customer> customerRepository,
        IRepository<Invoice> invoiceRepository,
        IPasswordHasher passwordHasher)
    {
        _firmRepository = firmRepository;
        _profileRepository = profileRepository;
        _userRepository = userRepository;
        _permissionRepository = permissionRepository;
        _vatRateRepository = vatRateRepository;
        _customerRepository = customerRepository;
        _invoiceRepository = invoiceRepository;
        _passwordHasher = passwordHasher;
    }

    public async Task<FirmResponse> CreateAsync(FirmCreateRequest request)
    {
        var firmNameExists = await _firmRepository.Query().AnyAsync(f => f.Name == request.FirmName);

        if (firmNameExists)
        {
            throw new BusinessRuleException(
                ErrorCodes.FirmNameAlreadyExists,
                new Dictionary<string, string> { ["firmName"] = request.FirmName });
        }

        var userNameExists = await _userRepository.Query().AnyAsync(u => u.UserName == request.FirstUserName);

        if (userNameExists)
        {
            throw new BusinessRuleException(
                ErrorCodes.UsernameAlreadyExists,
                new Dictionary<string, string> { ["userName"] = request.FirstUserName });
        }

        var allPermissions = await _permissionRepository.Query().ToListAsync();
        var allVatRates = await _vatRateRepository.Query().ToListAsync();

        var firm = new Firm { Name = request.FirmName };

        var adminProfile = new Profile
        {
            Firm = firm,
            Name = SystemAdminProfileName,
            IsSystem = true
        };

        foreach (var permission in allPermissions)
        {
            adminProfile.ProfilePermissions.Add(new ProfilePermission { Permission = permission });
        }

        foreach (var vatRate in allVatRates)
        {
            adminProfile.ProfileVatRates.Add(new ProfileVatRate { VatRate = vatRate });
        }

        var firstUser = new User
        {
            Firm = firm,
            Profile = adminProfile,
            UserName = request.FirstUserName,
            PasswordHash = _passwordHasher.HashPassword(request.FirstUserPassword),
            Role = UserRole.FirmUser
        };

        await _firmRepository.AddAsync(firm);
        await _profileRepository.AddAsync(adminProfile);
        await _userRepository.AddAsync(firstUser);

        await _firmRepository.SaveChangesAsync();

        return MapToResponse(firm);
    }

    public async Task<FirmResponse> UpdateAsync(int firmId, FirmUpdateRequest request)
    {
        var firm = await _firmRepository.GetByIdAsync(firmId)
            ?? throw new NotFoundException(
                ErrorCodes.FirmNotFound,
                new Dictionary<string, string> { ["firmId"] = firmId.ToString() });

        var nameExists = await _firmRepository.Query()
            .AnyAsync(f => f.Name == request.Name && f.FirmId != firmId);

        if (nameExists)
        {
            throw new BusinessRuleException(
                ErrorCodes.FirmNameAlreadyExists,
                new Dictionary<string, string> { ["firmName"] = request.Name });
        }

        firm.Name = request.Name;

        _firmRepository.Update(firm);
        await _firmRepository.SaveChangesAsync();

        return MapToResponse(firm);
    }

    public async Task DeleteAsync(int firmId)
    {
        var firm = await _firmRepository.GetByIdAsync(firmId)
            ?? throw new NotFoundException(
                ErrorCodes.FirmNotFound,
                new Dictionary<string, string> { ["firmId"] = firmId.ToString() });

        var hasCustomers = await _customerRepository.Query().AnyAsync(c => c.FirmId == firmId);
        var hasInvoices = await _invoiceRepository.Query().AnyAsync(i => i.FirmId == firmId);

        if (hasCustomers || hasInvoices)
        {
            throw new BusinessRuleException(ErrorCodes.FirmHasRecordsCannotDelete);
        }

        var firmUsers = await _userRepository.Query().Where(u => u.FirmId == firmId).ToListAsync();

        foreach (var user in firmUsers)
        {
            _userRepository.Remove(user);
        }

        var firmProfiles = await _profileRepository.Query().Where(p => p.FirmId == firmId).ToListAsync();

        foreach (var profile in firmProfiles)
        {
            _profileRepository.Remove(profile);
        }

        _firmRepository.Remove(firm);
        await _firmRepository.SaveChangesAsync();
    }

    public async Task<FirmResponse> GetByIdAsync(int firmId)
    {
        var firm = await _firmRepository.GetByIdAsync(firmId)
            ?? throw new NotFoundException(
                ErrorCodes.FirmNotFound,
                new Dictionary<string, string> { ["firmId"] = firmId.ToString() });

        return MapToResponse(firm);
    }

    public async Task<PagedResult<FirmResponse>> GetPagedAsync(PagedRequest request)
    {
        var query = _firmRepository.Query();

        if (!string.IsNullOrWhiteSpace(request.SearchTerm))
        {
            query = query.Where(f => f.Name.Contains(request.SearchTerm));
        }

        query = request.SortBy?.ToLower() switch
        {
            "name" => request.SortDirection == SortDirection.Descending
                ? query.OrderByDescending(f => f.Name)
                : query.OrderBy(f => f.Name),
            _ => request.SortDirection == SortDirection.Descending
                ? query.OrderByDescending(f => f.CreatedDate)
                : query.OrderBy(f => f.CreatedDate)
        };

        var pagedFirms = await query.ToPagedResultAsync(request.Page, request.PageSize);

        return new PagedResult<FirmResponse>
        {
            Items = pagedFirms.Items.Select(MapToResponse).ToList(),
            TotalCount = pagedFirms.TotalCount,
            Page = pagedFirms.Page,
            PageSize = pagedFirms.PageSize
        };
    }

    private static FirmResponse MapToResponse(Firm firm)
    {
        return new FirmResponse
        {
            FirmId = firm.FirmId,
            Name = firm.Name,
            CreatedDate = firm.CreatedDate,
            UpdatedDate = firm.UpdatedDate
        };
    }
}