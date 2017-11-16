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