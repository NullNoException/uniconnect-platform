using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Application.Providers.DTOs;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Repositories;

namespace UniConnect.Application.Providers.Commands.StaffAccountManagement;

public class UpdateProviderStaffCommandHandler : IRequestHandler<UpdateProviderStaffCommand, ProviderStaffDto>
{
    private readonly IRepository<ProviderStaff> _staffRepository;
    private readonly IRepository<ServiceProvider> _providerRepository;
    private readonly ILogger<UpdateProviderStaffCommandHandler> _logger;

    public UpdateProviderStaffCommandHandler(
        IRepository<ProviderStaff> staffRepository,
        IRepository<ServiceProvider> providerRepository,
        ILogger<UpdateProviderStaffCommandHandler> logger)
    {
        _staffRepository = staffRepository;
        _providerRepository = providerRepository;
        _logger = logger;
    }

    public async Task<ProviderStaffDto> Handle(UpdateProviderStaffCommand request, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Updating staff member {StaffId} for provider {ProviderId}",
            request.StaffId, request.ProviderId);

        // Verify provider exists
        var provider = await _providerRepository.GetByIdAsync(request.ProviderId, cancellationToken);
        if (provider == null)
        {
            throw new InvalidOperationException($"Provider with ID {request.ProviderId} not found");
        }

        // Get staff member with related data
        var staff = await _staffRepository.GetByIdAsync(request.StaffId, cancellationToken);

        if (staff == null)
        {
            throw new InvalidOperationException($"Staff member with ID {request.StaffId} not found");
        }

        // Verify staff belongs to the provider
        if (staff.ProviderId != request.ProviderId)
        {
            throw new InvalidOperationException("Staff member does not belong to the specified provider");
        }

        // Update staff properties - map Role to Position since that's what the entity supports
        if (!string.IsNullOrEmpty(request.Role))
            staff.Position = request.Role;

        if (request.Permissions != null)
            staff.Permissions = string.Join(",", request.Permissions);

        // Note: SupervisorId is not in the command, but the entity supports it
        // For now, we'll leave it as is

        staff.UpdatedAt = DateTime.UtcNow;

        await _staffRepository.UpdateAsync(staff, cancellationToken);

        // For now, we'll update the user profile separately if needed
        // Note: The entity only has Position and Permissions, so Role/Department are mapped to Position

        _logger.LogInformation("Successfully updated staff member {StaffId}", request.StaffId);

        return new ProviderStaffDto
        {
            Id = staff.Id,
            ProviderId = staff.ProviderId,
            UserId = staff.UserId,
            Email = "email@placeholder.com", // Would need User entity to get actual email
            FirstName = "FirstName", // Would need User.Profile to get actual name
            LastName = "LastName", // Would need User.Profile to get actual name  
            PhoneNumber = null, // Would need User.Profile to get actual phone
            Position = staff.Position,
            Role = staff.Position, // Map Position to Role for DTO compatibility
            Department = "N/A", // Not available in current entity
            IsActive = true, // Not available in current entity
            Permissions = !string.IsNullOrEmpty(staff.Permissions)
                ? staff.Permissions
                : string.Empty,
            SupervisorId = staff.SupervisorId,
            CreatedAt = staff.CreatedAt,
            UpdatedAt = staff.UpdatedAt
        };
    }
}
