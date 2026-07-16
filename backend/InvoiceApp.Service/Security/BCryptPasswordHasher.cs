using BC = BCrypt.Net.BCrypt;
using InvoiceApp.Common.Security;

namespace InvoiceApp.Service.Security;

public class BCryptPasswordHasher : IPasswordHasher
{
    public string HashPassword(string password)
    {
        return BC.HashPassword(password);
    }

    public bool VerifyPassword(string password, string passwordHash)
    {
        return BC.Verify(password, passwordHash);
    }
}