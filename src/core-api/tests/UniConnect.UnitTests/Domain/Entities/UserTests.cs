using Xunit;
using FluentAssertions;
using System.Text.RegularExpressions;

namespace UniConnect.UnitTests.Domain.Entities;

// This is a temporary implementation that would normally be imported from the Domain layer
public class User
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;

    public bool IsValidEmail()
    {
        // Simple email validation
        var regex = new Regex(@"^[^@\s]+@[^@\s]+\.[^@\s]+$");
        return regex.IsMatch(Email);
    }
}

public class UserTests
{
    [Fact]
    public void User_Properties_Should_Be_Set_And_Get_Correctly()
    {
        var user = new User
        {
            Id = 1,
            Name = "Test User",
            Email = "test@example.com"
        };

        Assert.Equal(1, user.Id);
        Assert.Equal("Test User", user.Name);
        Assert.Equal("test@example.com", user.Email);
    }

    [Fact]
    public void User_Should_Have_Valid_Email()
    {
        var user = new User
        {
            Email = "test@example.com"
        };

        Assert.True(user.IsValidEmail());
    }

    [Fact]
    public void User_Should_Have_Invalid_Email()
    {
        var user = new User
        {
            Email = "invalid-email"
        };

        Assert.False(user.IsValidEmail());
    }
}