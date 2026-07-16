using InvoiceApp.Common.Entities;

namespace InvoiceApp.Common.Security;

public interface ITokenService
{
    TokenResult GenerateToken(User user);
}