using MediatR;

public class AuthorizationBehavior<TRequest, TResponse> : IPipelineBehavior<TRequest, TResponse>
{
    // Inject authorization services as needed
    public AuthorizationBehavior() { }

    public async Task<TResponse> Handle(TRequest request, RequestHandlerDelegate<TResponse> next, CancellationToken cancellationToken)
    {
        // TODO: Implement authorization logic
        return await next();
    }
}
