using MediatR;
using Microsoft.AspNetCore.Http;
using UniConnect.Application.Documents.DTOs;
using UniConnect.Domain.Enums;

namespace UniConnect.Application.Documents.Commands.UploadDocument;

public class UploadDocumentCommand : IRequest<DocumentDto>
{
    public IFormFile File { get; set; } = null!;
    public DocumentType DocumentType { get; set; }
    public Guid UserId { get; set; } // Assuming the user's ID is passed from the controller/context
}
