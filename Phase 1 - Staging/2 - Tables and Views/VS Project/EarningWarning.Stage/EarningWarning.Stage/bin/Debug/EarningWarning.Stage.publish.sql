﻿/*
Deployment script for EarlyWarningStaging

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "EarlyWarningStaging"
:setvar DefaultFilePrefix "EarlyWarningStaging"
:setvar DefaultDataPath ""
:setvar DefaultLogPath ""

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
IF EXISTS (SELECT 1
           FROM   [sys].[databases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [sys].[databases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
PRINT N'Creating [dbo].[StageActivities]...';


GO
CREATE TABLE [dbo].[StageActivities] (
    [suniq]    VARCHAR (50) NULL,
    [begdate]  VARCHAR (50) NULL,
    [enddate]  VARCHAR (50) NULL,
    [Type]     VARCHAR (50) NULL,
    [Activity] VARCHAR (50) NULL,
    [gradelvc] VARCHAR (50) NULL
);


GO
PRINT N'Creating [dbo].[StageClassAttendance]...';


GO
CREATE TABLE [dbo].[StageClassAttendance] (
    [StudentName]    VARCHAR (50) NULL,
    [StudentID]      VARCHAR (50) NULL,
    [SchoolCode]     VARCHAR (50) NULL,
    [SchoolName]     VARCHAR (50) NULL,
    [Grade]          VARCHAR (50) NULL,
    [Advisor]        VARCHAR (50) NULL,
    [Counselor]      VARCHAR (50) NULL,
    [Period]         VARCHAR (50) NULL,
    [CourseCode]     VARCHAR (50) NULL,
    [CourseName]     VARCHAR (50) NULL,
    [mstuniq]        VARCHAR (50) NULL,
    [AttendType]     VARCHAR (50) NULL,
    [AttendCode]     VARCHAR (50) NULL,
    [TeacherName]    VARCHAR (50) NULL,
    [AttendanceDate] VARCHAR (50) NULL,
    [StateID]        VARCHAR (50) NULL,
    [AgeYearMonth]   VARCHAR (50) NULL,
    [EnrollStatus]   VARCHAR (50) NULL
);


GO
PRINT N'Creating [dbo].[StageDailyAttendance]...';


GO
CREATE TABLE [dbo].[StageDailyAttendance] (
    [SchoolCode]            VARCHAR (50) NULL,
    [SchoolName]            VARCHAR (50) NULL,
    [AttendanceDate]        VARCHAR (50) NULL,
    [StudentID]             VARCHAR (50) NULL,
    [NumofPossiblePeriods]  VARCHAR (50) NULL,
    [NumofTardies]          VARCHAR (50) NULL,
    [NumofUnexecusedAbsent] VARCHAR (50) NULL,
    [NumofExecusedAbsent]   VARCHAR (50) NULL,
    [termc]                 VARCHAR (50) NULL
);


GO
PRINT N'Creating [dbo].[StageDemographics]...';


GO
CREATE TABLE [dbo].[StageDemographics] (
    [StudentName]                VARCHAR (50) NULL,
    [StudentID]                  VARCHAR (50) NULL,
    [GenderCode]                 VARCHAR (50) NULL,
    [FederalRaceRptCategoryCode] VARCHAR (50) NULL,
    [FederalRaceRptCategory]     VARCHAR (50) NULL,
    [PrimaryLanguage]            VARCHAR (50) NULL,
    [LanguageProficiency]        VARCHAR (50) NULL,
    [MembershipCode]             VARCHAR (50) NULL,
    [Membership]                 VARCHAR (50) NULL,
    [SchoolName]                 VARCHAR (50) NULL,
    [Grade]                      VARCHAR (50) NULL
);


GO
PRINT N'Creating [dbo].[StageIncident]...';


GO
CREATE TABLE [dbo].[StageIncident] (
    [StudentName]     VARCHAR (50)  NULL,
    [StudentID]       VARCHAR (50)  NULL,
    [SchoolCode]      VARCHAR (50)  NULL,
    [SchoolName]      VARCHAR (50)  NULL,
    [Grade]           VARCHAR (50)  NULL,
    [IncidentCode]    VARCHAR (50)  NULL,
    [Incident]        VARCHAR (50)  NULL,
    [InvolvementCode] VARCHAR (50)  NULL,
    [Involvement]     VARCHAR (50)  NULL,
    [ReportedBy]      VARCHAR (50)  NULL,
    [IncidentDate]    VARCHAR (50)  NULL,
    [Location]        VARCHAR (50)  NULL,
    [IncidentTime]    VARCHAR (50)  NULL,
    [RefInfo]         VARCHAR (50)  NULL,
    [ActionCode]      VARCHAR (50)  NULL,
    [Action]          VARCHAR (50)  NULL,
    [Alert]           VARCHAR (50)  NULL,
    [Points]          VARCHAR (50)  NULL,
    [ReferredTo]      VARCHAR (50)  NULL,
    [Advisor]         VARCHAR (50)  NULL,
    [Counselor]       VARCHAR (50)  NULL,
    [Notes]           VARCHAR (300) NULL,
    [Column 22]       VARCHAR (50)  NULL
);


GO
PRINT N'Creating [dbo].[StageWarningSystem]...';


GO
CREATE TABLE [dbo].[StageWarningSystem] (
    [SchoolName]        VARCHAR (50) NULL,
    [StudentID]         VARCHAR (50) NULL,
    [StudentName]       VARCHAR (50) NULL,
    [CumulativeGPA]     VARCHAR (50) NULL,
    [WeightedGPA]       VARCHAR (50) NULL,
    [NumofAbsentDays]   VARCHAR (50) NULL,
    [NumofReferrals]    VARCHAR (50) NULL,
    [NumofSuspensions]  VARCHAR (50) NULL,
    [NumofCurMarkD]     VARCHAR (50) NULL,
    [NumofCurMarkF]     VARCHAR (50) NULL,
    [WarningAbsent]     VARCHAR (50) NULL,
    [WarningGPA]        VARCHAR (50) NULL,
    [WarningReferrals]  VARCHAR (50) NULL,
    [WarningSuspension] VARCHAR (50) NULL,
    [WarningMarkD]      VARCHAR (50) NULL,
    [WarningMarkF]      VARCHAR (50) NULL
);


GO
PRINT N'Creating [dbo].[LoadAction]...';


GO
CREATE VIEW dbo.LoadAction
AS
SELECT DISTINCT CAST(ActionCode AS VARCHAR(5)) AS ActionCodeAK, CAST(Action AS VARCHAR(40)) AS Action
FROM            dbo.StageIncident
GO
PRINT N'Creating [dbo].[LoadActivities]...';


GO
CREATE VIEW dbo.LoadActivities
AS
SELECT        CAST(suniq AS BIGINT) StudentAK, CAST(CONVERT(varchar(8), CAST(begdate AS DATE), 112) AS INT) BeginningDateAK, CAST(CONVERT(varchar(8), CAST(IIF(enddate = 'NULL', '', enddate) AS DATE), 112) AS INT) EndingDateAK, 
                         CAST([Type] AS VARCHAR(32)) TypeAK
FROM            dbo.StageActivities
GO
PRINT N'Creating [dbo].[LoadAttendanceType]...';


GO
Create View [LoadAttendanceType]
AS
SELECT DISTINCT
	CAST(IIF(AttendCode='.', 'Pr', AttendCode) AS VARCHAR(5)) AttendCodeAK,
	CAST(AttendType AS VARCHAR(40)) AttendType
FROM dbo.StageClassAttendance
GO
PRINT N'Creating [dbo].[LoadClassAttendance]...';


GO

CREATE VIEW [dbo].[LoadClassAttendance]
AS
SELECT
	CAST(StudentID AS BIGINT) StudentAK,
	CAST(SchoolCode AS INT) SchoolCodeAK,
	CAST(IIF(AttendCode = '.', 'Pr', AttendCode) AS VARCHAR(5)) AttendCodeAK,
	CAST(mstuniq AS BIGINT) CourseAK,
	CAST(CONVERT(VARCHAR(8), CAST(AttendanceDate AS DATE), 112) AS INT) AttendanceDateAK,
	Cast([Period] AS INT) ClassPeriod,
	Advisor,
	Counselor,
	TeacherName Teacher,
	CAST(EnrollStatus AS VARCHAR(15)) EnrollStatus
FROM StageClassAttendance
GO
PRINT N'Creating [dbo].[LoadCourse]...';


GO
CREATE VIEW LoadCourse
AS
SELECT 
	DISTINCT
		CAST(mstuniq AS BIGINT) CourseAK,
		CAST(CourseCode AS VARCHAR(15)) CourseCode,
		CAST(CourseName AS VARCHAR(40)) CourseName
FROM dbo.StageClassAttendance
GO
PRINT N'Creating [dbo].[LoadDailyAttendance]...';


GO
CREATE VIEW LoadDailyAttendance
AS
SELECT 
	CAST(SchoolCode AS INT) SchoolAK,
	CAST(CONVERT(varchar(8), CAST(AttendanceDate AS DATE), 112) AS INT) AttendanceDataAK,
	CAST(StudentID AS BIGINT) StudentAK,
	CAST(NumofPossiblePeriods AS INT) PossiblePeriods,
	CAST(NumofTardies AS INT) Tardies,
	CAST(NumofUnexecusedAbsent AS INT) UnexcusedAbsent,
	CAST(NumofExecusedAbsent AS INT) ExcusedAbsent
FROM dbo.StageDailyAttendance
GO
PRINT N'Creating [dbo].[LoadDailyIncident]...';


GO

CREATE VIEW [dbo].[LoadDailyIncident]
AS
SELECT 
	CAST(StudentID AS BIGINT) StudentAK,
	CAST(SchoolCode AS INT) SchoolCodeAK,
	CAST(IncidentCode AS VARCHAR(5)) IncidentCodeAK,
	CAST(InvolvementCode AS VARCHAR(5)) InvolvementCodeAK,
	CAST(ActionCode AS VARCHAR(5)) ActionCodeAK,
	CAST(CONVERT(VARCHAR(8), CAST(IncidentDate AS DATE), 112) AS INT) IncidentDateAK,
	IncidentTime,
	IIF([Location]='', '<No Entry>', [Location]) [Location],
	ReportedBy,
	ReferredTo,
	Advisor,
	Counselor,
	Notes,
	CAST(Alert AS INT) Alert,
	CAST(Points AS INT) Points
FROM dbo.StageIncident
GO
PRINT N'Creating [dbo].[LoadIncident]...';


GO
CREATE VIEW dbo.LoadIncident
AS
SELECT DISTINCT
	CAST(incidentcode AS VARCHAR(5)) IncidentCodeAK,
	CAST(incident AS VARCHAR(40)) Incident
FROM dbo.StageIncident
GO
PRINT N'Creating [dbo].[LoadInvolvement]...';


GO
CREATE VIEW  LoadInvolvement
AS
SELECT	DISTINCT
	CAST(involvementcode AS VARCHAR(5)) InvolvementCodeAK,
	CAST(involvement AS VARCHAR(20)) Involvement
FROM dbo.StageIncident
GO
PRINT N'Creating [dbo].[LoadSchool]...';


GO
CREATE VIEW LoadSchool
AS
SELECT 
	DISTINCT
		CAST(SchoolCode AS INT) SchoolAK,
		CAST(SchoolName AS VARCHAR(40)) SchoolName
FROM dbo.StageDailyAttendance
GO
PRINT N'Creating [dbo].[LoadStudent]...';


GO
CREATE VIEW LoadStudent
AS
SELECT 
	CAST(StudentID AS BIGINT) StudentAK,
	CAST(StudentName AS VARCHAR(50)) StudentName,
	IIF(GenderCode = 'F', 'Female', 'Male') Gender,
	CAST(FederalRaceRptCategory AS VARCHAR(50)) FederalRaceCategory,
	CAST(PrimaryLanguage AS VARCHAR(25)) PrimaryLanguage,
	CAST(Membership AS VARCHAR(15)) Membership,
	CAST(Grade as int) GradeNum,
	CASE 
		WHEN Grade = '1' THEN 'First'
		WHEN Grade = '2' THEN 'Second'
		WHEN Grade = '3' THEN 'Third'
		WHEN Grade = '4' THEN 'Fourth'
		WHEN Grade = '5' THEN 'Fifth'
		WHEN Grade = '6' THEN 'Sixth'
		WHEN Grade = '7' THEN 'Seventh'
		WHEN Grade = '8' THEN 'Eighth'
		WHEN Grade = '9' THEN 'Ninth'
		WHEN Grade = '10' THEN 'Tenth'
		WHEN Grade = '11' THEN 'Eleventh'
		WHEN Grade = '12' THEN 'Thwelfth'
	ELSE 'PreK'
	END Grade
FROM dbo.StageDemographics
GO
PRINT N'Creating [dbo].[LoadTypeActivity]...';


GO
CREATE VIEW LoadTypeActivity
AS
SELECT DISTINCT
	CAST([Type] AS VARCHAR(32)) TypeAK,
	CAST(Activity AS VARCHAR(26)) Activity
FROM dbo.StageActivities
GO
PRINT N'Creating [dbo].[LoadWarningSystem]...';


GO
CREATE VIEW LoadWarningSystem
AS
SELECT 
	CAST(StudentID AS BIGINT) StudentAK,
	CAST(CASE 
		WHEN SchoolName = 'Doherty High School' THEN 351
		WHEN SchoolName = 'North Middle School' THEN 245
		WHEN SchoolName = 'Wilson Elementary School' THEN 138
	END AS INT) SchoolCodeAK,
	CAST(CumulativeGPA AS DECIMAL (6,3)) CumulativeGPA ,
	CAST(WeightedGPA AS DECIMAL (6,3)) WeightedGPA,
	CAST(NumofAbsentDays AS INT) NumofAbsentDays,
	CAST(NumofReferrals AS INT) NumofReferrals,
	CAST(NumofSuspensions AS INT) NumofSuspensions,
	CAST(NumofCurMarkD AS INT) NumofCurMarkD,
	CAST(NumofCurMarkF AS INT) NumofCurMarkF,
	CAST(WarningAbsent AS INT) WarningAbsent,
	CAST(WarningGPA AS DECIMAL (6,3)) WarningGPA,
	CAST(WarningReferrals AS INT) WarningReferrals,
	CAST(WarningSuspension AS INT) WarningSuspension,
	CAST(WarningMarkD AS INT) WarningMarkD,
	CAST(WarningMarkF AS INT) WarningMarkF
FROM dbo.StageWarningSystem
GO
PRINT N'Creating [dbo].[LoadAction].[MS_DiagramPane1]...';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "StageIncident (dbo)"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 221
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'LoadAction';


GO
PRINT N'Creating [dbo].[LoadAction].[MS_DiagramPaneCount]...';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'LoadAction';


GO
PRINT N'Creating [dbo].[LoadActivities].[MS_DiagramPane1]...';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'LoadActivities';


GO
PRINT N'Creating [dbo].[LoadActivities].[MS_DiagramPaneCount]...';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'LoadActivities';


GO
PRINT N'Update complete.';


GO
