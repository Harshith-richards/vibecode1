namespace Domain.Entities;

public abstract class AuditableEntity
{
    public Guid Id { get; set; } = Guid.NewGuid();
    public DateTime CreatedAtUtc { get; set; } = DateTime.UtcNow;
    public string CreatedBy { get; set; } = "system";
    public DateTime? UpdatedAtUtc { get; set; }
    public string? UpdatedBy { get; set; }
    public bool IsDeleted { get; set; }
}

public class Organization : AuditableEntity
{
    public string Name { get; set; } = string.Empty;
    public string Code { get; set; } = string.Empty;
    public ICollection<Project> Projects { get; set; } = new List<Project>();
}

public class Project : AuditableEntity
{
    public string Name { get; set; } = string.Empty;
    public Guid OrganizationId { get; set; }
    public Organization? Organization { get; set; }
    public decimal Budget { get; set; }
}

public class EngineeringDocument : AuditableEntity
{
    public Guid ProjectId { get; set; }
    public string Title { get; set; } = string.Empty;
    public string BlobPath { get; set; } = string.Empty;
    public int Revision { get; set; }
}

public class WorkTask : AuditableEntity
{
    public Guid ProjectId { get; set; }
    public string Summary { get; set; } = string.Empty;
    public string Status { get; set; } = "Open";
}

public class Vendor : AuditableEntity
{
    public Guid OrganizationId { get; set; }
    public string Name { get; set; } = string.Empty;
    public string Trade { get; set; } = string.Empty;
}

public class Attendance : AuditableEntity
{
    public Guid ProjectId { get; set; }
    public string EmployeeCode { get; set; } = string.Empty;
    public DateOnly WorkDate { get; set; }
    public decimal Hours { get; set; }
}

public class AppNotification : AuditableEntity
{
    public string UserId { get; set; } = string.Empty;
    public string Message { get; set; } = string.Empty;
    public bool IsRead { get; set; }
}

public class RefreshToken : AuditableEntity
{
    public string UserId { get; set; } = string.Empty;
    public string Token { get; set; } = string.Empty;
    public DateTime ExpiresAtUtc { get; set; }
}
