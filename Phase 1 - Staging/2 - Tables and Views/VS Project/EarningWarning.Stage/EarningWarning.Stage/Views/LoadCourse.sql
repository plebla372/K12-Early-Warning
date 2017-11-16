CREATE VIEW LoadCourse
AS
SELECT 
	DISTINCT
		CAST(mstuniq AS BIGINT) CourseAK,
		CAST(CourseCode AS VARCHAR(15)) CourseCode,
		CAST(CourseName AS VARCHAR(40)) CourseName
FROM dbo.StageClassAttendance

