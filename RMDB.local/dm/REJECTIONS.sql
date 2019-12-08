--	-------------------------------------------------------------------------------------------------
--	
--		2019/12/08, DDM
--	
--		DATAMART OF REJECTIONS
--		
--	
CREATE VIEW [dm].[REJECTIONS]
AS
WITH CTE AS
	(
		SELECT	1	AS RN
		UNION ALL
		SELECT	RN+1	AS	RN
		FROM	CTE
		WHERE	RN < 50
	)
SELECT	V1.REJECTIONID																	AS	REJECTIONID,				--	PK
		V1.NAME + CAST(V1.REJECTIONID AS VARCHAR(10))									AS	NAME,
		V1.REJGROUP																		AS	REJGROUP
FROM	(
			SELECT	ROW_NUMBER() OVER(ORDER BY T1.RN)						AS	REJECTIONID,
					'REJECTION - '											AS	NAME,
					'REJGROUP'												AS	REJGROUP
			FROM	CTE T1
		) V1;
