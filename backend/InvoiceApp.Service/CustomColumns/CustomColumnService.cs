using InvoiceApp.Common.Dtos.CustomColumns;
using InvoiceApp.Common.Entities;
using InvoiceApp.Common.Exceptions;
using InvoiceApp.Repository;
using InvoiceApp.Service.Permissions;
using Microsoft.EntityFrameworkCore;

namespace InvoiceApp.Service.CustomColumns;

public class CustomColumnService : ICustomColumnService
{
    private readonly IRepository<InvoiceLineCustomColumnDefinition> _customColumnRepository;
    private readonly IRepository<InvoiceLineCustomValue> _customValueRepository;
    private readonly IPermissionService _permissionService;

    public CustomColumnService(
        IRepository<InvoiceLineCustomColumnDefinition> customColumnRepository,
        IRepository<InvoiceLineCustomValue> customValueRepository,
        IPermissionService permissionService)
    {
        _customColumnRepository = customColumnRepository;
        _customValueRepository = customValueRepository;
        _permissionService = permissionService;
    }

    public async Task<List<CustomColumnResponse>> GetAllAsync(int currentUserId)
    {
        var currentFirmId = await GetCurrentFirmIdAsync(currentUserId);

        var columns = await _customColumnRepository.Query()
            .Where(c => c.FirmId == currentFirmId)
            .OrderBy(c => c.DisplayOrder)
            .ToListAsync();

        var columnIds = columns.Select(c => c.InvoiceLineCustomColumnDefinitionId).ToList();

        var usedColumnIds = await _customValueRepository.Query()
            .Where(cv => columnIds.Contains(cv.ColumnDefinitionId))
            .Select(cv => cv.ColumnDefinitionId)
            .Distinct()
            .ToListAsync();

        var usedSet = usedColumnIds.ToHashSet();

        return columns.Select(c => MapToResponse(c, usedSet.Contains(c.InvoiceLineCustomColumnDefinitionId))).ToList();
    }

    public async Task<CustomColumnResponse> CreateAsync(int currentUserId, CustomColumnCreateRequest request)
    {
        var currentFirmId = await GetCurrentFirmIdAsync(currentUserId);

        await EnsureLabelNotInUseAsync(currentFirmId, request.Label, excludeId: null);

        var column = new InvoiceLineCustomColumnDefinition
        {
            FirmId = currentFirmId,
            Label = request.Label,
            DisplayOrder = request.DisplayOrder,
            IsActive = true
        };

        await _customColumnRepository.AddAsync(column);
        await _customColumnRepository.SaveChangesAsync();

        return MapToResponse(column, isUsed: false);
    }

    public async Task<CustomColumnResponse> UpdateAsync(int currentUserId, int id, CustomColumnUpdateRequest request)
    {
        var currentFirmId = await GetCurrentFirmIdAsync(currentUserId);
        var column = await GetOwnedColumnAsync(currentFirmId, id);

        if (request.IsActive)
        {
            await EnsureLabelNotInUseAsync(currentFirmId, request.Label, excludeId: id);
        }

        column.Label = request.Label;
        column.DisplayOrder = request.DisplayOrder;
        column.IsActive = request.IsActive;

        _customColumnRepository.Update(column);
        await _customColumnRepository.SaveChangesAsync();

        var isUsed = await _customValueRepository.Query().AnyAsync(cv => cv.ColumnDefinitionId == id);

        return MapToResponse(column, isUsed);
    }

    public async Task DeleteAsync(int currentUserId, int id)
    {
        var currentFirmId = await GetCurrentFirmIdAsync(currentUserId);
        var column = await GetOwnedColumnAsync(currentFirmId, id);

        var isUsed = await _customValueRepository.Query().AnyAsync(cv => cv.ColumnDefinitionId == id);

        if (isUsed)
        {
            throw new BusinessRuleException(ErrorCodes.CustomColumnInUseCannotDelete);
        }

        _customColumnRepository.Remove(column);
        await _customColumnRepository.SaveChangesAsync();
    }

    private async Task<int> GetCurrentFirmIdAsync(int currentUserId)
    {
        var context = await _permissionService.GetUserContextAsync(currentUserId);
        return context.FirmId ?? throw new BusinessRuleException(ErrorCodes.UserHasNoFirm);
    }

    private async Task<InvoiceLineCustomColumnDefinition> GetOwnedColumnAsync(int firmId, int id)
    {
        var column = await _customColumnRepository.Query()
            .FirstOrDefaultAsync(c => c.InvoiceLineCustomColumnDefinitionId == id && c.FirmId == firmId);

        return column ?? throw new NotFoundException(
            ErrorCodes.CustomColumnNotFound,
            new Dictionary<string, string> { ["customColumnId"] = id.ToString() });
    }

    private async Task EnsureLabelNotInUseAsync(int firmId, string label, int? excludeId)
    {
        var query = _customColumnRepository.Query()
            .Where(c => c.FirmId == firmId && c.IsActive && c.Label == label);

        if (excludeId.HasValue)
        {
            query = query.Where(c => c.InvoiceLineCustomColumnDefinitionId != excludeId.Value);
        }

        var labelInUse = await query.AnyAsync();

        if (labelInUse)
        {
            throw new BusinessRuleException(
                ErrorCodes.CustomColumnLabelAlreadyExists,
                new Dictionary<string, string> { ["label"] = label });
        }
    }

    private static CustomColumnResponse MapToResponse(InvoiceLineCustomColumnDefinition column, bool isUsed)
    {
        return new CustomColumnResponse
        {
            InvoiceLineCustomColumnDefinitionId = column.InvoiceLineCustomColumnDefinitionId,
            Label = column.Label,
            DisplayOrder = column.DisplayOrder,
            IsActive = column.IsActive,
            IsUsed = isUsed,
            CreatedDate = column.CreatedDate,
            UpdatedDate = column.UpdatedDate
        };
    }
}
