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



