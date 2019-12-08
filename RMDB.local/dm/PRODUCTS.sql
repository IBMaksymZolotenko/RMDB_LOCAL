--	-------------------------------------------------------------------------------------------------
--	
--		2019/12/08, DDM
--	
--		DATAMART OF PRODUCTS
--		
--	
CREATE VIEW [dm].[PRODUCTS]
AS
WITH CTE AS
	(
		SELECT	1	AS RN
		UNION ALL
		SELECT	RN+1	AS	RN
		FROM	CTE
		WHERE	RN < 10
	)
SELECT	V1.PRODUCTID																AS	PRODUCTID,				--	PK
		V1.NAME + CAST(V1.PRODUCTID AS VARCHAR(10))									AS	NAME,
		V1.FL_CROSS,
		V1.FL_RESTR,
		V1.FL_CARD,
		V1.FL_SME,
		V1.CLIENTCODE
FROM	(
			SELECT	ROW_NUMBER() OVER(ORDER BY T1.RN)						AS	PRODUCTID,
					'PRODUCT - '											AS	NAME,
					0														AS	FL_CROSS,
					0														AS	FL_RESTR,
					0														AS	FL_CARD,
					0														AS	FL_SME,
					'CLI'													AS	CLIENTCODE
			FROM	CTE T1
		) V1;
