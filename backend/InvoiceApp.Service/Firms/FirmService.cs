using InvoiceApp.Common.Dtos.Firms;
using InvoiceApp.Common.Entities;
using InvoiceApp.Common.Exceptions;
using InvoiceApp.Common.Paging;
using InvoiceApp.Common.Security;
using InvoiceApp.Repository;
using InvoiceApp.Repository.Extensions;
using InvoiceApp.Service.EInvoice;
using InvoiceApp.Service.Permissions;
using InvoiceApp.Service.Shared;
using Microsoft.EntityFrameworkCore;
using System.Globalization;
using System.Text.RegularExpressions;

namespace InvoiceApp.Service.Firms;

public class FirmService : IFirmService
{
    private const string SystemAdminProfileName = "admin";
    private const string HeadquartersBranchName = "Merkez";
    private const string SampleCustomerTitle = "ÖRNEK MÜŞTERİ A.Ş.";
    private const string SampleCustomerTaxNumber = "1234567890";
    private const string SampleCustomerAddress = "Örnek Mahallesi, Örnek Caddesi No:1, İstanbul";
    private const string SampleLineItemName = "Örnek Ürün / Hizmet";
    private const string SampleCustomValueText = "Örnek Değer";
    private const int MinPixelDimension = 1;
    private const int MaxPixelDimension = 255;

    private static readonly string[] AllowedFontFamilies =
    {
        "Inter", "Arial", "Times New Roman", "Georgia", "Roboto"
    };

    private readonly IRepository<Firm> _firmRepository;
    private readonly IRepository<Profile> _profileRepository;
    private readonly IRepository<User> _userRepository;
    private readonly IRepository<Permission> _permissionRepository;
    private readonly IRepository<VatRate> _vatRateRepository;
    private readonly IRepository<Customer> _customerRepository;
    private readonly IRepository<Invoice> _invoiceRepository;
    private readonly IRepository<Branch> _branchRepository;
    private readonly IRepository<InvoiceLineCustomColumnDefinition> _customColumnRepository;
    private readonly IPasswordHasher _passwordHasher;
    private readonly IPermissionService _permissionService;
    private readonly IEInvoiceTransformer _eInvoiceTransformer;

    public FirmService(
        IRepository<Firm> firmRepository,
        IRepository<Profile> profileRepository,
        IRepository<User> userRepository,
        IRepository<Permission> permissionRepository,
        IRepository<VatRate> vatRateRepository,
        IRepository<Customer> customerRepository,
        IRepository<Invoice> invoiceRepository,
        IRepository<Branch> branchRepository,
        IRepository<InvoiceLineCustomColumnDefinition> customColumnRepository,
        IPasswordHasher passwordHasher,
        IPermissionService permissionService,
        IEInvoiceTransformer eInvoiceTransformer)
    {
        _firmRepository = firmRepository;
        _profileRepository = profileRepository;
        _userRepository = userRepository;
        _permissionRepository = permissionRepository;
        _vatRateRepository = vatRateRepository;
        _customerRepository = customerRepository;
        _invoiceRepository = invoiceRepository;
        _branchRepository = branchRepository;
        _customColumnRepository = customColumnRepository;
        _passwordHasher = passwordHasher;
        _permissionService = permissionService;
        _eInvoiceTransformer = eInvoiceTransformer;
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

        ValidateVkn(request.Vkn);

        var allPermissions = await _permissionRepository.Query().ToListAsync();
        var allVatRates = await _vatRateRepository.Query().ToListAsync();

        var firm = new Firm { Name = request.FirmName, Vkn = request.Vkn };

        var headquarters = new Branch
        {
            Firm = firm,
            Name = HeadquartersBranchName,
            IsHeadquarters = true
        };

        headquarters.InvoiceSeries.Add(new InvoiceSeries
        {
            Branch = headquarters,
            Prefix = SeriesPrefixGenerator.Derive(HeadquartersBranchName),
            LastUsedYear = DateTime.UtcNow.Year,
            NextNumber = 1,
            IsActive = true
        });

        var adminProfile = new Profile
        {
            Firm = firm,
            Name = SystemAdminProfileName,
            IsSystem = true,
            CanAccessAllBranches = true
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
            Branch = headquarters,
            UserName = request.FirstUserName,
            PasswordHash = _passwordHasher.HashPassword(request.FirstUserPassword),
            Role = UserRole.FirmUser
        };

        await _firmRepository.AddAsync(firm);
        await _branchRepository.AddAsync(headquarters);
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

        ValidateVkn(request.Vkn);

        firm.Name = request.Name;
        firm.Vkn = request.Vkn;

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

        var firmBranches = await _branchRepository.Query().Where(b => b.FirmId == firmId).ToListAsync();

        foreach (var branch in firmBranches)
        {
            _branchRepository.Remove(branch);
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

    public async Task<FirmBrandingResponse> GetBrandingAsync(int currentUserId)
    {
        var firm = await GetOwnFirmAsync(currentUserId);
        return MapToBrandingResponse(firm);
    }

    public async Task<FirmBrandingResponse> UpdateBrandingAsync(int currentUserId, FirmBrandingUpdateRequest request)
    {
        ValidateBranding(request);

        var firm = await GetOwnFirmAsync(currentUserId);

        firm.LogoBase64 = request.LogoBase64;
        firm.StampBase64 = request.StampBase64;
        firm.AccentColorHex = request.AccentColorHex;
        firm.FontFamily = request.FontFamily;
        firm.LogoWidthPx = request.LogoWidthPx;
        firm.LogoHeightPx = request.LogoHeightPx;
        firm.StampWidthPx = request.StampWidthPx;
        firm.StampHeightPx = request.StampHeightPx;

        _firmRepository.Update(firm);
        await _firmRepository.SaveChangesAsync();

        return MapToBrandingResponse(firm);
    }

    public async Task<string> GetBrandingPreviewAsync(int currentUserId, FirmBrandingUpdateRequest request)
    {
        ValidateBranding(request);

        var context = await _permissionService.GetUserContextAsync(currentUserId);
        var firmId = context.FirmId ?? throw new BusinessRuleException(ErrorCodes.UserHasNoFirm);

        var firm = await _firmRepository.Query()
            .Include(f => f.BankAccounts)
            .FirstOrDefaultAsync(f => f.FirmId == firmId)
            ?? throw new NotFoundException(
                ErrorCodes.FirmNotFound,
                new Dictionary<string, string> { ["firmId"] = firmId.ToString() });

        var activeColumns = await _customColumnRepository.Query()
            .Where(c => c.FirmId == firmId && c.IsActive)
            .OrderBy(c => c.DisplayOrder)
            .ToListAsync();

        var headquarters = await _branchRepository.Query()
            .Where(b => b.FirmId == firmId)
            .OrderByDescending(b => b.IsHeadquarters)
            .FirstOrDefaultAsync();

        var previewFirm = new Firm
        {
            FirmId = firm.FirmId,
            Name = firm.Name,
            Vkn = firm.Vkn,
            LogoBase64 = request.LogoBase64,
            StampBase64 = request.StampBase64,
            AccentColorHex = request.AccentColorHex,
            FontFamily = request.FontFamily,
            LogoWidthPx = request.LogoWidthPx,
            LogoHeightPx = request.LogoHeightPx,
            StampWidthPx = request.StampWidthPx,
            StampHeightPx = request.StampHeightPx,
            BankAccounts = firm.BankAccounts
        };

        var now = DateTime.UtcNow;

        var sampleCustomer = new Customer
        {
            TaxNumber = SampleCustomerTaxNumber,
            Title = SampleCustomerTitle,
            Address = SampleCustomerAddress,
            Email = string.Empty
        };

        var sampleLine = new InvoiceLine
        {
            ItemName = SampleLineItemName,
            Quantity = 1,
            Price = 1000m,
            VatRatePercentage = 20m,
            CreatedDate = now,
            CustomValues = activeColumns.Select(c => new InvoiceLineCustomValue
            {
                ColumnDefinitionId = c.InvoiceLineCustomColumnDefinitionId,
                ColumnLabel = c.Label,
                Value = SampleCustomValueText
            }).ToList()
        };

        var previewInvoice = new Invoice
        {
            InvoiceDate = now,
            CreatedDate = now,
            Status = InvoiceStatus.Draft,
            InvoiceTypeCode = InvoiceTypeCode.Satis,
            Firm = previewFirm,
            Branch = headquarters,
            Customer = sampleCustomer,
            InvoiceLines = new List<InvoiceLine> { sampleLine }
        };

        ApplyPreviewTotals(previewInvoice);

        var xmlBytes = EInvoiceXmlBuilder.Build(previewInvoice);

        return _eInvoiceTransformer.TransformToHtml(xmlBytes);
    }

    private static void ApplyPreviewTotals(Invoice invoice)
    {
        decimal subtotal = 0;
        decimal vatTotal = 0;

        foreach (var line in invoice.InvoiceLines)
        {
            var lineSubtotal = Math.Round(line.Quantity * line.Price, 2);
            var lineVat = Math.Round(lineSubtotal * line.VatRatePercentage / 100, 2);

            subtotal += lineSubtotal;
            vatTotal += lineVat;
        }

        invoice.Subtotal = subtotal;
        invoice.VatTotal = vatTotal;
        invoice.GrandTotal = subtotal + vatTotal;
    }

    private async Task<Firm> GetOwnFirmAsync(int currentUserId)
    {
        var context = await _permissionService.GetUserContextAsync(currentUserId);
        var firmId = context.FirmId ?? throw new BusinessRuleException(ErrorCodes.UserHasNoFirm);

        return await _firmRepository.GetByIdAsync(firmId)
            ?? throw new NotFoundException(
                ErrorCodes.FirmNotFound,
                new Dictionary<string, string> { ["firmId"] = firmId.ToString() });
    }

    private static void ValidateBranding(FirmBrandingUpdateRequest request)
    {
        if (!string.IsNullOrWhiteSpace(request.FontFamily) && !AllowedFontFamilies.Contains(request.FontFamily))
        {
            throw new BusinessRuleException(ErrorCodes.InvalidFontFamily);
        }

        if (!string.IsNullOrWhiteSpace(request.AccentColorHex) &&
            !Regex.IsMatch(request.AccentColorHex, "^#[0-9A-Fa-f]{6}$"))
        {
            throw new BusinessRuleException(ErrorCodes.InvalidAccentColorFormat);
        }

        ValidatePixelDimension(request.LogoWidthPx, ErrorCodes.InvalidLogoDimension);
        ValidatePixelDimension(request.LogoHeightPx, ErrorCodes.InvalidLogoDimension);
        ValidatePixelDimension(request.StampWidthPx, ErrorCodes.InvalidStampDimension);
        ValidatePixelDimension(request.StampHeightPx, ErrorCodes.InvalidStampDimension);
    }

    private static void ValidatePixelDimension(int? value, string errorCode)
    {
        if (value is not null && (value < MinPixelDimension || value > MaxPixelDimension))
        {
            throw new BusinessRuleException(
                errorCode,
                new Dictionary<string, string>
                {
                    ["min"] = MinPixelDimension.ToString(CultureInfo.InvariantCulture),
                    ["max"] = MaxPixelDimension.ToString(CultureInfo.InvariantCulture)
                });
        }
    }

    private static void ValidateVkn(string? vkn)
    {
        if (!string.IsNullOrWhiteSpace(vkn) && !Regex.IsMatch(vkn, "^[0-9]{1,10}$"))
        {
            throw new BusinessRuleException(ErrorCodes.InvalidTaxNumberFormat);
        }
    }

    private static FirmResponse MapToResponse(Firm firm)
    {
        return new FirmResponse
        {
            FirmId = firm.FirmId,
            Name = firm.Name,
            Vkn = firm.Vkn,
            CreatedDate = firm.CreatedDate,
            UpdatedDate = firm.UpdatedDate
        };
    }

    private static FirmBrandingResponse MapToBrandingResponse(Firm firm)
    {
        return new FirmBrandingResponse
        {
            LogoBase64 = firm.LogoBase64,
            StampBase64 = firm.StampBase64,
            AccentColorHex = firm.AccentColorHex,
            FontFamily = firm.FontFamily,
            LogoWidthPx = firm.LogoWidthPx,
            LogoHeightPx = firm.LogoHeightPx,
            StampWidthPx = firm.StampWidthPx,
            StampHeightPx = firm.StampHeightPx
        };
    }
}
