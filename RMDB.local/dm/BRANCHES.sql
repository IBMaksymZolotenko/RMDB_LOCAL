--	-------------------------------------------------------------------------------------------------
--	
--		2019/12/08, DDM
--	
--		DATAMART OF BRANCHES
--		
--	
CREATE VIEW [dm].[BRANCHES]
AS
WITH CTE AS
	(
		SELECT	1	AS RN
		UNION ALL
		SELECT	RN+1	AS	RN
		FROM	CTE
		WHERE	RN < 100
	)
SELECT	V1.BRANCHID																	AS	BRANCHID,				--	PK
		V1.NAME + CAST(V1.BRANCHID AS VARCHAR(10))									AS	NAME
FROM	(
			SELECT	ROW_NUMBER() OVER(ORDER BY T1.RN)						AS	BRANCHID,
					'BRN - '												AS	NAME
			FROM	CTE T1
		) V1;
