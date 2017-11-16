CREATE VIEW dbo.LoadIncident
AS
SELECT DISTINCT
	CAST(incidentcode AS VARCHAR(5)) IncidentCodeAK,
	CAST(incident AS VARCHAR(40)) Incident
FROM dbo.StageIncident