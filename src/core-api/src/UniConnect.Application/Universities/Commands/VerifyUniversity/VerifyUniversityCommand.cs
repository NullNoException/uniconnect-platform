using MediatR;
using UniConnect.Application.Universities.DTOs;

namespace UniConnect.Application.Universities.Commands.VerifyUniversity;

public record VerifyUniversityCommand(UniversityVerificationRequest Request) : IRequest<UniversityDto>;
