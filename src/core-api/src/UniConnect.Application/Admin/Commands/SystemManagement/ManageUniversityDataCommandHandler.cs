using AutoMapper;
using MediatR;
using Microsoft.Extensions.Logging;
using UniConnect.Application.Universities.DTOs;
using UniConnect.Domain.Entities;
using UniConnect.Domain.Repositories;
using UniConnect.Domain.Exceptions;

namespace UniConnect.Application.Admin.Commands.SystemManagement;

public class ManageUniversityDataCommandHandler : IRequestHandler<ManageUniversityDataCommand, UniversityDto>
{
    private readonly IRepository<University> _universityRepository;
    private readonly IMapper _mapper;
    private readonly ILogger<ManageUniversityDataCommandHandler> _logger;

    public ManageUniversityDataCommandHandler(
        IRepository<University> universityRepository,
        IMapper mapper,
        ILogger<ManageUniversityDataCommandHandler> logger)
    {
        _universityRepository = universityRepository;
        _mapper = mapper;
        _logger = logger;
    }

    public async Task<UniversityDto> Handle(ManageUniversityDataCommand request, CancellationToken cancellationToken)
    {
        _logger.LogInformation("Admin {AdminId} managing university data with operation {Operation}",
            request.AdminId, request.Operation);

        var university = await ProcessOperation(request, cancellationToken);
        return _mapper.Map<UniversityDto>(university);
    }

    private async Task<University> ProcessOperation(ManageUniversityDataCommand request, CancellationToken cancellationToken)
    {
        return request.Operation switch
        {
            UniversityDataOperation.Create => await CreateUniversity(request, cancellationToken),
            UniversityDataOperation.Update => await UpdateUniversity(request, cancellationToken),
            UniversityDataOperation.Delete => await DeleteUniversity(request, cancellationToken),
            UniversityDataOperation.Activate => await SetUniversityStatus(request, cancellationToken, true),
            UniversityDataOperation.Deactivate => await SetUniversityStatus(request, cancellationToken, false),
            _ => throw new ArgumentException($"Unknown operation: {request.Operation}")
        };
    }

    private async Task<University> CreateUniversity(ManageUniversityDataCommand request, CancellationToken cancellationToken)
    {
        if (string.IsNullOrWhiteSpace(request.UniversityName))
        {
            throw new ArgumentException("UniversityName cannot be null or whitespace.", nameof(request.UniversityName));
        }

        if (string.IsNullOrWhiteSpace(request.UniversityCode))
        {
            throw new ArgumentException("UniversityCode cannot be null or whitespace.", nameof(request.UniversityCode));
        }

        if (string.IsNullOrWhiteSpace(request.Country))
        {
            // Using string literal for paramName as request.Country is a property of the request object
            throw new ArgumentException("Country ID must be provided and cannot be empty.", "Country");
        }

        var university = new University
        {
            Name = request.UniversityName,
            Code = request.UniversityCode,
            CountryId = Guid.Parse(request.Country), // Assign parsed Guid to CountryId
            Website = request.Website,
            LogoUrl = request.LogoUrl,
            IsActive = request.IsActive ?? true
        };

        var createdUniversity = await _universityRepository.AddAsync(university, cancellationToken);
        await _universityRepository.SaveChangesAsync(cancellationToken);

        _logger.LogInformation("Created new university: {UniversityName}", request.UniversityName);
        return createdUniversity;
    }

    private async Task<University> UpdateUniversity(ManageUniversityDataCommand request, CancellationToken cancellationToken)
    {
        var university = await GetUniversityById(request.UniversityId, "update", cancellationToken);

        if (!string.IsNullOrWhiteSpace(request.UniversityName))
            university.Name = request.UniversityName;
        if (!string.IsNullOrWhiteSpace(request.UniversityCode))
            university.Code = request.UniversityCode;
        if (!string.IsNullOrWhiteSpace(request.Country))
            university.CountryId = Guid.Parse(request.Country); // Assign parsed Guid to CountryId
        // if (!string.IsNullOrWhiteSpace(request.State))
        //     university.State = request.State; // Removed: University entity does not have a direct State property
        // if (!string.IsNullOrWhiteSpace(request.City))
        //     university.City = request.City;   // Removed: University entity does not have a direct City property
        if (!string.IsNullOrWhiteSpace(request.Website))
            university.Website = request.Website;
        if (!string.IsNullOrWhiteSpace(request.LogoUrl))
            university.LogoUrl = request.LogoUrl;
        if (request.IsActive.HasValue)
            university.IsActive = request.IsActive.Value;

        await _universityRepository.UpdateAsync(university, cancellationToken);
        await _universityRepository.SaveChangesAsync(cancellationToken);

        _logger.LogInformation("Updated university: {UniversityId}", request.UniversityId);
        return university;
    }

    private async Task<University> DeleteUniversity(ManageUniversityDataCommand request, CancellationToken cancellationToken)
    {
        var university = await GetUniversityById(request.UniversityId, "delete", cancellationToken);
        await _universityRepository.DeleteAsync(university, cancellationToken);
        await _universityRepository.SaveChangesAsync(cancellationToken);
        _logger.LogInformation("Deleted university: {UniversityId}", request.UniversityId);
        return university;
    }

    private async Task<University> SetUniversityStatus(ManageUniversityDataCommand request, CancellationToken cancellationToken, bool isActive)
    {
        var operation = isActive ? "activate" : "deactivate";
        var university = await GetUniversityById(request.UniversityId, operation, cancellationToken);
        university.IsActive = isActive;
        await _universityRepository.UpdateAsync(university, cancellationToken);
        await _universityRepository.SaveChangesAsync(cancellationToken);
        _logger.LogInformation("{Operation}d university: {UniversityId}", operation, request.UniversityId);
        return university;
    }

    private async Task<University> GetUniversityById(Guid? universityId, string operation, CancellationToken cancellationToken)
    {
        if (!universityId.HasValue)
            throw new ArgumentException($"UniversityId is required for {operation} operation");

        var university = await _universityRepository.GetByIdAsync(universityId.Value, cancellationToken);
        if (university == null)
            throw new NotFoundException($"University with ID {universityId} not found");

        return university;
    }
}
