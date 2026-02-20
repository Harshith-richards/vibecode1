using Domain.Entities;
using MediatR;

namespace Application.Abstractions;

public interface IAppDbContext
{
    IQueryable<Organization> Organizations { get; }
    IQueryable<Project> Projects { get; }
    IQueryable<EngineeringDocument> Documents { get; }
    IQueryable<WorkTask> Tasks { get; }
    IQueryable<Vendor> Vendors { get; }
    IQueryable<Attendance> Attendances { get; }
    IQueryable<AppNotification> Notifications { get; }
    Task AddAsync<T>(T entity, CancellationToken ct) where T : AuditableEntity;
    Task<int> SaveChangesAsync(CancellationToken ct);
}

public record CreateProjectCommand(Guid OrganizationId, string Name, decimal Budget) : IRequest<Guid>;
public record CreateProjectResult(Guid Id, string Name);

public class CreateProjectHandler(IAppDbContext db) : IRequestHandler<CreateProjectCommand, Guid>
{
    public async Task<Guid> Handle(CreateProjectCommand request, CancellationToken cancellationToken)
    {
        var entity = new Project { OrganizationId = request.OrganizationId, Name = request.Name, Budget = request.Budget };
        await db.AddAsync(entity, cancellationToken);
        await db.SaveChangesAsync(cancellationToken);
        return entity.Id;
    }
}

public class CreateProjectValidator : FluentValidation.AbstractValidator<CreateProjectCommand>
{
    public CreateProjectValidator()
    {
        RuleFor(x => x.Name).NotEmpty().MaximumLength(200);
        RuleFor(x => x.Budget).GreaterThanOrEqualTo(0);
    }
}
