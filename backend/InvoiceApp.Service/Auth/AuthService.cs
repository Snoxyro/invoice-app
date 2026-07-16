using InvoiceApp.Common.Dtos.Auth;
using InvoiceApp.Common.Entities;
using InvoiceApp.Common.Exceptions;
using InvoiceApp.Common.Security;
using InvoiceApp.Repository;
using Microsoft.EntityFrameworkCore;

namespace InvoiceApp.Service.Auth;

public class AuthService : IAuthService
{
    private readonly IRepository<User> _userRepository;
    private readonly IPasswordHasher _passwordHasher;
    private readonly ITokenService _tokenService;

    public AuthService(IRepository<User> userRepository, IPasswordHasher passwordHasher, ITokenService tokenService)
    {
        _userRepository = userRepository;
        _passwordHasher = passwordHasher;
        _tokenService = tokenService;
    }

    public async Task<LoginResponse> LoginAsync(LoginRequest request)
    {
        var user = await _userRepository.Query()
            .FirstOrDefaultAsync(u => u.UserName == request.UserName);

        if (user is null || !_passwordHasher.VerifyPassword(request.Password, user.PasswordHash))
        {
            throw new BusinessRuleException("Kullanıcı adı veya şifre hatalı.");
        }

        var tokenResult = _tokenService.GenerateToken(user);

        return new LoginResponse
        {
            Token = tokenResult.Token,
            ExpiresAt = tokenResult.ExpiresAt,
            UserName = user.UserName,
            Role = user.Role
        };
    }
}