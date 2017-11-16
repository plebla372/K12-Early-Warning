CREATE VIEW LoadSchool
AS
SELECT 
	DISTINCT
		CAST(SchoolCode AS INT) SchoolAK,
		CAST(SchoolName AS VARCHAR(40)) SchoolName
FROM dbo.StageDailyAttendance