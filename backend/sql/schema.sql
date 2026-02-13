CREATE TABLE Organizations (
  Id UNIQUEIDENTIFIER PRIMARY KEY,
  Name NVARCHAR(200) NOT NULL,
  Code NVARCHAR(50) NOT NULL UNIQUE,
  CreatedAtUtc DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
  CreatedBy NVARCHAR(100) NOT NULL,
  UpdatedAtUtc DATETIME2 NULL,
  UpdatedBy NVARCHAR(100) NULL,
  IsDeleted BIT NOT NULL DEFAULT 0
);

CREATE TABLE Projects (
  Id UNIQUEIDENTIFIER PRIMARY KEY,
  OrganizationId UNIQUEIDENTIFIER NOT NULL,
  Name NVARCHAR(200) NOT NULL,
  Budget DECIMAL(18,2) NOT NULL,
  CreatedAtUtc DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
  CreatedBy NVARCHAR(100) NOT NULL,
  UpdatedAtUtc DATETIME2 NULL,
  UpdatedBy NVARCHAR(100) NULL,
  IsDeleted BIT NOT NULL DEFAULT 0,
  CONSTRAINT FK_Projects_Organizations FOREIGN KEY (OrganizationId) REFERENCES Organizations(Id)
);

CREATE TABLE EngineeringDocuments (
  Id UNIQUEIDENTIFIER PRIMARY KEY,
  ProjectId UNIQUEIDENTIFIER NOT NULL,
  Title NVARCHAR(300) NOT NULL,
  BlobPath NVARCHAR(500) NOT NULL,
  Revision INT NOT NULL,
  CreatedAtUtc DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
  CreatedBy NVARCHAR(100) NOT NULL,
  UpdatedAtUtc DATETIME2 NULL,
  UpdatedBy NVARCHAR(100) NULL,
  IsDeleted BIT NOT NULL DEFAULT 0,
  CONSTRAINT FK_EngineeringDocuments_Projects FOREIGN KEY (ProjectId) REFERENCES Projects(Id)
);

CREATE TABLE WorkTasks (
  Id UNIQUEIDENTIFIER PRIMARY KEY,
  ProjectId UNIQUEIDENTIFIER NOT NULL,
  Summary NVARCHAR(300) NOT NULL,
  Status NVARCHAR(50) NOT NULL,
  CreatedAtUtc DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
  CreatedBy NVARCHAR(100) NOT NULL,
  UpdatedAtUtc DATETIME2 NULL,
  UpdatedBy NVARCHAR(100) NULL,
  IsDeleted BIT NOT NULL DEFAULT 0,
  CONSTRAINT FK_WorkTasks_Projects FOREIGN KEY (ProjectId) REFERENCES Projects(Id)
);

CREATE TABLE Vendors (
  Id UNIQUEIDENTIFIER PRIMARY KEY,
  OrganizationId UNIQUEIDENTIFIER NOT NULL,
  Name NVARCHAR(200) NOT NULL,
  Trade NVARCHAR(100) NOT NULL,
  CreatedAtUtc DATETIME2 NOT NULL DEFAULT SYSUTCDATETIME(),
  CreatedBy NVARCHAR(100) NOT NULL,
  UpdatedAtUtc DATETIME2 NULL,
  UpdatedBy NVARCHAR(100) NULL,
  IsDeleted BIT NOT NULL DEFAULT 0,
  CONSTRAINT FK_Vendors_Organizations FOREIGN KEY (OrganizationId) REFERENCES Organizations(Id)
);

CREATE INDEX IX_Projects_OrganizationId_Name ON Projects (OrganizationId, Name);
CREATE INDEX IX_Documents_ProjectId_Revision ON EngineeringDocuments (ProjectId, Revision DESC);
CREATE INDEX IX_Tasks_ProjectId_Status ON WorkTasks (ProjectId, Status);

GO
CREATE PROCEDURE dbo.usp_ProjectFinancialSummary
  @OrganizationId UNIQUEIDENTIFIER
AS
BEGIN
  SELECT p.Id, p.Name, p.Budget, COUNT(d.Id) AS DocumentCount
  FROM Projects p
  LEFT JOIN EngineeringDocuments d ON d.ProjectId = p.Id AND d.IsDeleted = 0
  WHERE p.OrganizationId = @OrganizationId AND p.IsDeleted = 0
  GROUP BY p.Id, p.Name, p.Budget;
END
GO

INSERT INTO Organizations (Id, Name, Code, CreatedBy) VALUES (NEWID(), 'Global Engineering Group', 'GEG', 'seed');
