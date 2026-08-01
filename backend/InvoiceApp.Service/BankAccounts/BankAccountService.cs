using System.Text.RegularExpressions;
using InvoiceApp.Common.Dtos.BankAccounts;
using InvoiceApp.Common.Entities;
using InvoiceApp.Common.Exceptions;
using InvoiceApp.Repository;
using InvoiceApp.Service.Permissions;
using Microsoft.EntityFrameworkCore;

namespace InvoiceApp.Service.BankAccounts;

public class BankAccountService : IBankAccountService
{
    private readonly IRepository<BankAccount> _bankAccountRepository;
    private readonly IPermissionService _permissionService;

    public BankAccountService(IRepository<BankAccount> bankAccountRepository, IPermissionService permissionService)
    {
        _bankAccountRepository = bankAccountRepository;
        _permissionService = permissionService;
    }

    public async Task<List<BankAccountResponse>> GetAllAsync(int currentUserId)
    {
        var currentFirmId = await GetCurrentFirmIdAsync(currentUserId);

        var bankAccounts = await _bankAccountRepository.Query()
            .Where(b => b.FirmId == currentFirmId)
            .OrderBy(b => b.BankName)
            .ToListAsync();

        return bankAccounts.Select(MapToResponse).ToList();
    }

    public async Task<BankAccountResponse> CreateAsync(int currentUserId, BankAccountCreateRequest request)
    {
        var currentFirmId = await GetCurrentFirmIdAsync(currentUserId);

        var bankAccount = new BankAccount
        {
            FirmId = currentFirmId,
            BankName = request.BankName,
            Currency = NormalizeCurrency(request.Currency),
            Iban = NormalizeIban(request.Iban)
        };

        await _bankAccountRepository.AddAsync(bankAccount);
        await _bankAccountRepository.SaveChangesAsync();

        return MapToResponse(bankAccount);
    }

    public async Task<BankAccountResponse> UpdateAsync(
        int currentUserId, int bankAccountId, BankAccountUpdateRequest request)
    {
        var currentFirmId = await GetCurrentFirmIdAsync(currentUserId);
        var bankAccount = await GetOwnedBankAccountAsync(currentFirmId, bankAccountId);

        bankAccount.BankName = request.BankName;
        bankAccount.Currency = NormalizeCurrency(request.Currency);
        bankAccount.Iban = NormalizeIban(request.Iban);

        _bankAccountRepository.Update(bankAccount);
        await _bankAccountRepository.SaveChangesAsync();

        return MapToResponse(bankAccount);
    }

    public async Task DeleteAsync(int currentUserId, int bankAccountId)
    {
        var currentFirmId = await GetCurrentFirmIdAsync(currentUserId);
        var bankAccount = await GetOwnedBankAccountAsync(currentFirmId, bankAccountId);

        _bankAccountRepository.Remove(bankAccount);
        await _bankAccountRepository.SaveChangesAsync();
    }

    private async Task<int> GetCurrentFirmIdAsync(int currentUserId)
    {
        var context = await _permissionService.GetUserContextAsync(currentUserId);
        return context.FirmId ?? throw new BusinessRuleException(ErrorCodes.UserHasNoFirm);
    }

    private async Task<BankAccount> GetOwnedBankAccountAsync(int firmId, int bankAccountId)
    {
        var bankAccount = await _bankAccountRepository.Query()
            .FirstOrDefaultAsync(b => b.BankAccountId == bankAccountId && b.FirmId == firmId);

        return bankAccount ?? throw new NotFoundException(
            ErrorCodes.BankAccountNotFound,
            new Dictionary<string, string> { ["bankAccountId"] = bankAccountId.ToString() });
    }

    private static string NormalizeCurrency(string currency)
    {
        var normalized = currency.Trim().ToUpperInvariant();

        if (!Regex.IsMatch(normalized, "^[A-Z]{3}$"))
        {
            throw new BusinessRuleException(ErrorCodes.InvalidCurrencyFormat);
        }

        return normalized;
    }

    private static string NormalizeIban(string iban)
    {
        var normalized = iban.Replace(" ", string.Empty).ToUpperInvariant();

        if (!Regex.IsMatch(normalized, "^[A-Z]{2}[0-9]{2}[A-Z0-9]{11,30}$"))
        {
            throw new BusinessRuleException(ErrorCodes.InvalidIbanFormat);
        }

        return normalized;
    }

    private static BankAccountResponse MapToResponse(BankAccount bankAccount)
    {
        return new BankAccountResponse
        {
            BankAccountId = bankAccount.BankAccountId,
            BankName = bankAccount.BankName,
            Currency = bankAccount.Currency,
            Iban = bankAccount.Iban,
            CreatedDate = bankAccount.CreatedDate,
            UpdatedDate = bankAccount.UpdatedDate
        };
    }
}
