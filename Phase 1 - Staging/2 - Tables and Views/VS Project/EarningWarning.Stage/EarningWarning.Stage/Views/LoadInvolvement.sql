CREATE VIEW  LoadInvolvement
AS
SELECT	DISTINCT
	CAST(involvementcode AS VARCHAR(5)) InvolvementCodeAK,
	CAST(involvement AS VARCHAR(20)) Involvement
FROM dbo.StageIncident