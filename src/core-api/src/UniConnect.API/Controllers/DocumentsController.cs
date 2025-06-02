using MediatR;
using Microsoft.AspNetCore.Mvc;
using UniConnect.Application.Documents.Commands.UploadDocument;
using UniConnect.Application.Documents.DTOs;

namespace UniConnect.API.Controllers;

[ApiController]
[Route("api/[controller]")]
public class DocumentsController : ControllerBase
{
    private readonly IMediator _mediator;
    private readonly ILogger<DocumentsController> _logger;

    public DocumentsController(IMediator mediator, ILogger<DocumentsController> logger)
    {
        _mediator = mediator;
        _logger = logger;
    }

    [HttpPost("upload")]
    [ProducesResponseType(typeof(DocumentDto), StatusCodes.Status201Created)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    [ProducesResponseType(StatusCodes.Status500InternalServerError)]
    public async Task<IActionResult> UploadDocument([FromForm] UploadDocumentCommand command)
    {
        try
        {
            // For now, UserId can be hardcoded or passed via a claim if auth is set up.
            // Assuming UserId will be extracted from claims in a real scenario.
            // For testing, if command.UserId is Guid.Empty, assign a test UserId.
            if (command.UserId == Guid.Empty)
            {
                // Replace with a test Guid or a mechanism to get the current user's ID
                command.UserId = Guid.NewGuid(); // Placeholder for actual user ID retrieval
                _logger.LogInformation("UserId not provided, using a test UserId: {UserId}", command.UserId);
            }

            var result = await _mediator.Send(command);
            // Assuming the command handler returns the DocumentDto
            return CreatedAtAction(nameof(GetDocumentById), new { id = result.Id }, result);
        }
        catch (FluentValidation.ValidationException ex)
        {
            _logger.LogWarning("Validation failed for uploading document: {ValidationErrors}", ex.Errors);
            return BadRequest(ex.Errors);
        }
        catch (InvalidOperationException ex) // Catching specific exception from handler (e.g., malware)
        {
            _logger.LogWarning("Operation failed while uploading document: {ErrorMessage}", ex.Message);
            return BadRequest(new { message = ex.Message });
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "An unexpected error occurred while uploading document.");
            return StatusCode(StatusCodes.Status500InternalServerError, "An unexpected error occurred.");
        }
    }

    // Placeholder for GetDocumentById - to be implemented with View Document use case
    [HttpGet("{id}")]
    [ProducesResponseType(typeof(DocumentDto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status404NotFound)]
    public async Task<IActionResult> GetDocumentById(Guid id)
    {
        // This will be implemented as part of UC-5.1.3 View Document
        // var query = new GetDocumentQuery { Id = id };
        // var document = await _mediator.Send(query);
        // if (document == null) return NotFound();
        // return Ok(document);
        await Task.CompletedTask; // To make async warning go away
        return NotFound(new { message = "Endpoint not yet implemented." });
    }
}
