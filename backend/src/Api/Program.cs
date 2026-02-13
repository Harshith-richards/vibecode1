using Application.Abstractions;
using Hangfire;
using Infrastructure.Persistence;
using MediatR;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using Serilog;
using Microsoft.EntityFrameworkCore;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

builder.Host.UseSerilog((ctx, lc) => lc.WriteTo.Console().ReadFrom.Configuration(ctx.Configuration));
builder.Services.AddInfrastructure(builder.Configuration);
builder.Services.AddMediatR(c => c.RegisterServicesFromAssembly(typeof(CreateProjectCommand).Assembly));
builder.Services.AddSignalR();
builder.Services.AddHangfire(c => c.UseSqlServerStorage(builder.Configuration.GetConnectionString("SqlServer")));
builder.Services.AddHangfireServer();
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateLifetime = true,
            ValidateIssuerSigningKey = true,
            ValidIssuer = builder.Configuration["Jwt:Issuer"],
            ValidAudience = builder.Configuration["Jwt:Audience"],
            IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(builder.Configuration["Jwt:Key"]!))
        };
    });
builder.Services.AddAuthorization();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

app.UseSwagger();
app.UseSwaggerUI();
app.UseAuthentication();
app.UseAuthorization();

app.MapPost("/api/auth/login", () => Results.Ok(new { token = "dev-token", refreshToken = Guid.NewGuid() }));
app.MapPost("/api/projects", async (CreateProjectCommand cmd, IMediator mediator) => Results.Ok(await mediator.Send(cmd))).RequireAuthorization();
app.MapGet("/api/organizations", async (IAppDbContext db) => Results.Ok(await db.Organizations.ToListAsync()));
app.MapGet("/api/documents", async (IAppDbContext db) => Results.Ok(await db.Documents.ToListAsync())).RequireAuthorization();
app.MapGet("/api/tasks", async (IAppDbContext db) => Results.Ok(await db.Tasks.ToListAsync())).RequireAuthorization();
app.MapGet("/api/vendors", async (IAppDbContext db) => Results.Ok(await db.Vendors.ToListAsync())).RequireAuthorization();
app.MapGet("/api/attendance", async (IAppDbContext db) => Results.Ok(await db.Attendances.ToListAsync())).RequireAuthorization();
app.MapGet("/api/notifications", async (IAppDbContext db) => Results.Ok(await db.Notifications.ToListAsync())).RequireAuthorization();
app.MapHub<NotificationHub>("/hubs/notifications");
app.MapHangfireDashboard();

app.Run();

public class NotificationHub : Microsoft.AspNetCore.SignalR.Hub { }
