# Global Digital Engineering & BIM Enterprise Platform

## SECTION 1 – README (Complete)
### Project overview
Enterprise multi-tenant platform for global BIM, MEP, HVAC, and mega-infrastructure delivery. Supports organization hierarchy, project execution, document lifecycle, vendor governance, attendance, notifications, auditability, and financial rollups.

### Tech stack explanation
- Backend: .NET 8, ASP.NET Core Web API, Clean Architecture, CQRS with MediatR, EF Core SQL Server, JWT + refresh token model, SignalR, FluentValidation, Serilog, Redis cache, Hangfire.
- Database: SQL Server normalized schema with FK constraints, soft-delete fields, audit columns, heavy-operation stored procedure.
- Frontend: React + Vite + TypeScript, Tailwind CSS, Redux Toolkit, React Query, SignalR client, Recharts.
- Infrastructure: Docker, Compose, Nginx reverse proxy, GitHub Actions pipeline.

### Setup instructions
1. Install .NET 8 SDK, Node 20+, Docker.
2. Clone repository.
3. Configure environment variables (see below).
4. Start SQL Server + Redis.
5. Start backend and frontend.

### Environment variables
- `ConnectionStrings__SqlServer`
- `ConnectionStrings__Redis`
- `Jwt__Issuer`
- `Jwt__Audience`
- `Jwt__Key`
- `ASPNETCORE_ENVIRONMENT`
- `VITE_API_URL`

### Running locally
- Backend: `cd backend/src/Api && dotnet run`
- Frontend: `cd frontend && npm ci && npm run dev`
- Database: run `backend/sql/schema.sql` in SSMS.

### Running with Docker
`docker compose up --build`

### Deployment overview
- Nginx terminates traffic and routes SPA/API/SignalR.
- API scales horizontally behind load balancer.
- SQL Server uses managed HA setup.
- Redis offloads hot reads and session-like data.
- Hangfire workers process background jobs.

## SECTION 2 – SYSTEM ARCHITECTURE
- Clean Architecture layers:
  - Domain: business entities and invariants.
  - Application: CQRS handlers, validation, interfaces.
  - Infrastructure: EF Core persistence, cache providers.
  - API: composition root, auth middleware, endpoint mapping.
- CQRS: command handlers mutate state (`CreateProjectCommand`), query endpoints use read models.
- Microservice-ready: each module can be split to service boundary with same contracts.
- Security architecture: JWT bearer auth, role-based policies (extendable), refresh token entity, audit fields, soft delete.

## SECTION 3 – DATABASE DESIGN
- Core tables: `Organizations`, `Projects`, `EngineeringDocuments`, `WorkTasks`, `Vendors` plus application entities in EF (`Attendance`, `Notifications`, `RefreshTokens`).
- Relationships: Org 1..N Projects, Org 1..N Vendors, Project 1..N Documents/Tasks/Attendance.
- Index strategy: composite indexes on organization-project and project-document revision patterns.
- Constraints: PK, FK, unique code, NOT NULL critical columns.
- Stored procedure: `usp_ProjectFinancialSummary`.
- Seed data included in `schema.sql`.

## SECTION 4 – BACKEND IMPLEMENTATION
Implemented modules and code in:
- Solution: `backend/EnterpriseBimPlatform.sln`
- Domain entities: organization, project, document, task, vendor, attendance, notification, refresh token.
- Application layer: DB abstraction, CQRS command + handler + validation.
- Infrastructure: EF Core context, SQL Server + Redis registration.
- API layer: Program bootstrap, JWT auth, Hangfire, SignalR, Serilog, module endpoints.
- Authentication module: login endpoint and refresh token entity integration point.
- Organization/Project/Document/Task/Vendor/Attendance/Notification endpoints present.
- Audit logging foundation: auditable base class + Serilog pipeline.

## SECTION 5 – FRONTEND IMPLEMENTATION
Implemented:
- Vite + React + TypeScript setup
- Folder structure for app/features/lib/store
- Navigation layout and pages
- Authentication page
- Dashboard with Recharts visualization
- Project/document pages and SignalR client
- API integration with axios
- Redux Toolkit store with theme toggle state

## SECTION 6 – DOCKER & DEVOPS
- Backend Dockerfile: `backend/src/Api/Dockerfile`
- Frontend Dockerfile: `frontend/Dockerfile`
- Compose stack: API, frontend, SQL Server, Redis, Nginx
- Nginx reverse-proxy config for API + SignalR + SPA
- CI/CD example: `.github/workflows/ci.yml`

## SECTION 7 – PERFORMANCE & SCALING STRATEGY
- Indexing: composite indexes on hottest join/filter keys and revision traversal.
- Caching: Redis for dashboard/project aggregates and metadata lookups.
- Load balancing: stateless API replicas behind Nginx/ALB.
- Horizontal scaling: independent scaling of API, SignalR backplane-ready, Hangfire workers.
- SQL optimization: SARGable predicates, stored procedures for heavy aggregates, pagination on read endpoints.
- Monitoring: Serilog structured logs, Hangfire dashboard, APM integration points (OpenTelemetry recommended).
