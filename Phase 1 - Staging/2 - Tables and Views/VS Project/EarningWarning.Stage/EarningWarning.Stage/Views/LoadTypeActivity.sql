CREATE VIEW LoadTypeActivity
AS
SELECT DISTINCT
	CAST([Type] AS VARCHAR(32)) TypeAK,
	CAST(Activity AS VARCHAR(26)) Activity
FROM dbo.StageActivities