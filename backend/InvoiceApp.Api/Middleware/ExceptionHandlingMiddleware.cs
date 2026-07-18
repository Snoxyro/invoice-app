using InvoiceApp.Common.Exceptions;

namespace InvoiceApp.Api.Middleware;

public class ExceptionHandlingMiddleware
{
    private readonly RequestDelegate _next;

    public ExceptionHandlingMiddleware(RequestDelegate next)
    {
        _next = next;
    }

    public async Task InvokeAsync(HttpContext context)
    {
        try
        {
            await _next(context);
        }
        catch (NotFoundException ex)
        {
            context.Response.StatusCode = StatusCodes.Status404NotFound;
            await context.Response.WriteAsJsonAsync(new { errorCode = ex.ErrorCode, parameters = ex.Params });
        }
        catch (BusinessRuleException ex)
        {
            context.Response.StatusCode = StatusCodes.Status400BadRequest;
            await context.Response.WriteAsJsonAsync(new { errorCode = ex.ErrorCode, parameters = ex.Params });
        }
        catch (Exception)
        {
            context.Response.StatusCode = StatusCodes.Status500InternalServerError;
            await context.Response.WriteAsJsonAsync(new
            {
                errorCode = ErrorCodes.UnexpectedError,
                parameters = new Dictionary<string, string>()
            });
        }
    }
}