
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
