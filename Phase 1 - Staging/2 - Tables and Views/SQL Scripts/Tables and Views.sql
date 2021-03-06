
CREATE TABLE [dbo].[StageClassAttendance](
	[StudentName] [varchar](50) NULL,
	[StudentID] [varchar](50) NULL,
	[SchoolCode] [varchar](50) NULL,
	[SchoolName] [varchar](50) NULL,
	[Grade] [varchar](50) NULL,
	[Advisor] [varchar](50) NULL,
	[Counselor] [varchar](50) NULL,
	[Period] [varchar](50) NULL,
	[CourseCode] [varchar](50) NULL,
	[CourseName] [varchar](50) NULL,
	[mstuniq] [varchar](50) NULL,
	[AttendType] [varchar](50) NULL,
	[AttendCode] [varchar](50) NULL,
	[TeacherName] [varchar](50) NULL,
	[AttendanceDate] [varchar](50) NULL,
	[StateID] [varchar](50) NULL,
	[AgeYearMonth] [varchar](50) NULL,
	[EnrollStatus] [varchar](50) NULL
)
GO

CREATE VIEW [dbo].[LoadCourse]
AS
SELECT 
	DISTINCT
		CAST(mstuniq AS BIGINT) CourseAK,
		CAST(CourseCode AS VARCHAR(15)) CourseCode,
		CAST(CourseName AS VARCHAR(40)) CourseName
FROM dbo.StageClassAttendance

GO

Create View [dbo].[LoadAttendanceType]
AS
SELECT DISTINCT
	CAST(IIF(AttendCode='.', 'Pr', AttendCode) AS VARCHAR(5)) AttendCodeAK,
	CAST(AttendType AS VARCHAR(40)) AttendType
FROM dbo.StageClassAttendance

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

CREATE TABLE [dbo].[StageActivities](
	[suniq] [varchar](50) NULL,
	[begdate] [varchar](50) NULL,
	[enddate] [varchar](50) NULL,
	[Type] [varchar](50) NULL,
	[Activity] [varchar](50) NULL,
	[gradelvc] [varchar](50) NULL
)
GO

CREATE VIEW [dbo].[LoadTypeActivity]
AS
SELECT DISTINCT
	CAST([Type] AS VARCHAR(32)) TypeAK,
	CAST(Activity AS VARCHAR(26)) Activity
FROM dbo.StageActivities
GO

CREATE TABLE [dbo].[StageDemographics](
	[StudentName] [varchar](50) NULL,
	[StudentID] [varchar](50) NULL,
	[GenderCode] [varchar](50) NULL,
	[FederalRaceRptCategoryCode] [varchar](50) NULL,
	[FederalRaceRptCategory] [varchar](50) NULL,
	[PrimaryLanguage] [varchar](50) NULL,
	[LanguageProficiency] [varchar](50) NULL,
	[MembershipCode] [varchar](50) NULL,
	[Membership] [varchar](50) NULL,
	[SchoolName] [varchar](50) NULL,
	[Grade] [varchar](50) NULL
)
GO

CREATE VIEW [dbo].[LoadStudent]
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
CREATE VIEW [dbo].[LoadActivities]
AS
SELECT        CAST(suniq AS BIGINT) StudentAK, CAST(CONVERT(varchar(8), CAST(begdate AS DATE), 112) AS INT) BeginningDateAK, CAST(CONVERT(varchar(8), CAST(IIF(enddate = 'NULL', '', enddate) AS DATE), 112) AS INT) EndingDateAK, 
                         CAST([Type] AS VARCHAR(32)) TypeAK
FROM            dbo.StageActivities
GO

CREATE TABLE [dbo].[StageDailyAttendance](
	[SchoolCode] [varchar](50) NULL,
	[SchoolName] [varchar](50) NULL,
	[AttendanceDate] [varchar](50) NULL,
	[StudentID] [varchar](50) NULL,
	[NumofPossiblePeriods] [varchar](50) NULL,
	[NumofTardies] [varchar](50) NULL,
	[NumofUnexecusedAbsent] [varchar](50) NULL,
	[NumofExecusedAbsent] [varchar](50) NULL,
	[termc] [varchar](50) NULL
)
GO

CREATE VIEW [dbo].[LoadSchool]
AS
SELECT 
	DISTINCT
		CAST(SchoolCode AS INT) SchoolAK,
		CAST(SchoolName AS VARCHAR(40)) SchoolName
FROM dbo.StageDailyAttendance
GO

CREATE VIEW [dbo].[LoadDailyAttendance]
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

CREATE TABLE [dbo].[StageIncident](
	[StudentName] [varchar](50) NULL,
	[StudentID] [varchar](50) NULL,
	[SchoolCode] [varchar](50) NULL,
	[SchoolName] [varchar](50) NULL,
	[Grade] [varchar](50) NULL,
	[IncidentCode] [varchar](50) NULL,
	[Incident] [varchar](50) NULL,
	[InvolvementCode] [varchar](50) NULL,
	[Involvement] [varchar](50) NULL,
	[ReportedBy] [varchar](50) NULL,
	[IncidentDate] [varchar](50) NULL,
	[Location] [varchar](50) NULL,
	[IncidentTime] [varchar](50) NULL,
	[RefInfo] [varchar](50) NULL,
	[ActionCode] [varchar](50) NULL,
	[Action] [varchar](50) NULL,
	[Alert] [varchar](50) NULL,
	[Points] [varchar](50) NULL,
	[ReferredTo] [varchar](50) NULL,
	[Advisor] [varchar](50) NULL,
	[Counselor] [varchar](50) NULL,
	[Notes] [varchar](300) NULL,
	[Column 22] [varchar](50) NULL
)
GO

CREATE VIEW [dbo].[LoadIncident]
AS
SELECT DISTINCT
	CAST(incidentcode AS VARCHAR(5)) IncidentCodeAK,
	CAST(incident AS VARCHAR(40)) Incident
FROM dbo.StageIncident
GO

CREATE VIEW  [dbo].[LoadInvolvement]
AS
SELECT	DISTINCT
	CAST(involvementcode AS VARCHAR(5)) InvolvementCodeAK,
	CAST(involvement AS VARCHAR(20)) Involvement
FROM dbo.StageIncident
GO

CREATE VIEW [dbo].[LoadAction]
AS
SELECT DISTINCT CAST(ActionCode AS VARCHAR(5)) AS ActionCodeAK, CAST(Action AS VARCHAR(40)) AS Action
FROM            dbo.StageIncident
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

CREATE TABLE [dbo].[StageWarningSystem](
	[SchoolName] [varchar](50) NULL,
	[StudentID] [varchar](50) NULL,
	[StudentName] [varchar](50) NULL,
	[CumulativeGPA] [varchar](50) NULL,
	[WeightedGPA] [varchar](50) NULL,
	[NumofAbsentDays] [varchar](50) NULL,
	[NumofReferrals] [varchar](50) NULL,
	[NumofSuspensions] [varchar](50) NULL,
	[NumofCurMarkD] [varchar](50) NULL,
	[NumofCurMarkF] [varchar](50) NULL,
	[WarningAbsent] [varchar](50) NULL,
	[WarningGPA] [varchar](50) NULL,
	[WarningReferrals] [varchar](50) NULL,
	[WarningSuspension] [varchar](50) NULL,
	[WarningMarkD] [varchar](50) NULL,
	[WarningMarkF] [varchar](50) NULL
)
GO

CREATE VIEW [dbo].[LoadWarningSystem]
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
