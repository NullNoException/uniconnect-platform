namespace UniConnect.Application.Common.Interfaces;

public interface IJwtTokenGenerator
{
    string GenerateToken(string userId, string email, IEnumerable<string> roles);
}
