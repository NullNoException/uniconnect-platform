using MediatR;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using UniConnect.Application.Common.Interfaces;
using UniConnect.Application.Providers.DTOs;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Repositories;

namespace UniConnect.Application.Providers.Queries.StaffAccountManagement;

public class GetProviderStaffQueryHandler : IRequestHandler<GetProviderStaffQuery, List<ProviderStaffDto>>
{
    private readonly IRepository<ProviderStaff> _staffRepository;
    private readonly IRepository<ServiceProvider> _providerRepository;
    private readonly ILogger<GetProviderStaffQueryHandler> _logger;

    public GetProviderStaffQueryHandler(
        IRepository<ProviderStaff> staffRepository,
        IRepository<ServiceProvider> providerRepository,
        ILogger<GetProviderStaffQueryHandler> logger)
    {
        _staffRepository = staffRepository;
        _providerRepository = providerRepository;
        _logger = logger;
    }

    public async Task<List<ProviderStaffDto>> Handle(GetProviderStaffQuery request, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Getting staff members for provider {ProviderId}", request.ProviderId);

        // Verify provider exists
        var provider = await _providerRepository.GetByIdAsync(request.ProviderId, cancellationToken);
        if (provider == null)
        {
            throw new InvalidOperationException($"Provider with ID {request.ProviderId} not found");
        }

        // Get staff members with filters
        var allStaff = await _staffRepository.GetAllAsync(cancellationToken);
        var staffMembers = allStaff.Where(s => s.ProviderId == request.ProviderId).ToList();

        var staffDtos = new List<ProviderStaffDto>();

        foreach (var staff in staffMembers)
        {
            staffDtos.Add(new ProviderStaffDto
            {
                Id = staff.Id,
                ProviderId = staff.ProviderId,
                UserId = staff.UserId,
                Email = staff.User?.Email ?? string.Empty,
                FirstName = staff.User?.Profile?.FirstName ?? string.Empty,
                LastName = staff.User?.Profile?.LastName ?? string.Empty,
                PhoneNumber = staff.User?.Profile?.PhoneNumber,
                Position = staff.Position,
                Role = string.Empty, // Will need to be added to entity
                Department = string.Empty, // Will need to be added to entity
                IsActive = true, // Will need to be added to entity
                Permissions = staff.Permissions ?? string.Empty,
                SupervisorId = staff.SupervisorId,
                CreatedAt = staff.CreatedAt,
                UpdatedAt = staff.UpdatedAt ?? staff.CreatedAt
            });
        }

        return staffDtos;
    }
}
