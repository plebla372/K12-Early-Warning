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

