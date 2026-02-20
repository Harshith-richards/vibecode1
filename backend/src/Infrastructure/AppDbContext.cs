using Application.Abstractions;
using Domain.Entities;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;

namespace Infrastructure.Persistence;

public class AppDbContext(DbContextOptions<AppDbContext> options) : DbContext(options), IAppDbContext
{
    public DbSet<Organization> OrganizationSet => Set<Organization>();
    public DbSet<Project> ProjectSet => Set<Project>();
    public DbSet<EngineeringDocument> DocumentSet => Set<EngineeringDocument>();
    public DbSet<WorkTask> TaskSet => Set<WorkTask>();
    public DbSet<Vendor> VendorSet => Set<Vendor>();
    public DbSet<Attendance> AttendanceSet => Set<Attendance>();
    public DbSet<AppNotification> NotificationSet => Set<AppNotification>();
    public DbSet<RefreshToken> RefreshTokenSet => Set<RefreshToken>();

    public IQueryable<Organization> Organizations => OrganizationSet.AsNoTracking().Where(x => !x.IsDeleted);
    public IQueryable<Project> Projects => ProjectSet.AsNoTracking().Where(x => !x.IsDeleted);
    public IQueryable<EngineeringDocument> Documents => DocumentSet.AsNoTracking().Where(x => !x.IsDeleted);
    public IQueryable<WorkTask> Tasks => TaskSet.AsNoTracking().Where(x => !x.IsDeleted);
    public IQueryable<Vendor> Vendors => VendorSet.AsNoTracking().Where(x => !x.IsDeleted);
    public IQueryable<Attendance> Attendances => AttendanceSet.AsNoTracking().Where(x => !x.IsDeleted);
    public IQueryable<AppNotification> Notifications => NotificationSet.AsNoTracking().Where(x => !x.IsDeleted);

    public Task AddAsync<T>(T entity, CancellationToken ct) where T : AuditableEntity => Set<T>().AddAsync(entity, ct).AsTask();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Organization>().HasIndex(x => x.Code).IsUnique();
        modelBuilder.Entity<Project>().HasIndex(x => new { x.OrganizationId, x.Name });
        modelBuilder.Entity<EngineeringDocument>().HasIndex(x => new { x.ProjectId, x.Revision });
    }
}

public static class DependencyInjection
{
    public static IServiceCollection AddInfrastructure(this IServiceCollection services, IConfiguration cfg)
    {
        services.AddDbContext<AppDbContext>(o => o.UseSqlServer(cfg.GetConnectionString("SqlServer")));
        services.AddScoped<IAppDbContext>(sp => sp.GetRequiredService<AppDbContext>());
        services.AddStackExchangeRedisCache(o => o.Configuration = cfg.GetConnectionString("Redis"));
        return services;
    }
}
