
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

