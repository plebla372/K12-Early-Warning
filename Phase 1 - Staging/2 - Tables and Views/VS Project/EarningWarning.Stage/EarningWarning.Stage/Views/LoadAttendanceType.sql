Create View [LoadAttendanceType]
AS
SELECT DISTINCT
	CAST(IIF(AttendCode='.', 'Pr', AttendCode) AS VARCHAR(5)) AttendCodeAK,
	CAST(AttendType AS VARCHAR(40)) AttendType
FROM dbo.StageClassAttendance

