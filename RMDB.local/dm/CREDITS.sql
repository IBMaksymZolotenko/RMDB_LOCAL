--	-------------------------------------------------------------------------------------------------
--	
--		2019/12/08, DDM
--	
--		DATAMART OF CREDITS
--		
--	
CREATE VIEW [dm].[CREDITS]
AS
WITH CTE AS
	(
		SELECT	1	AS RN
		UNION ALL
		SELECT	RN+1	AS	RN
		FROM	CTE
		WHERE	RN < 100
	)
SELECT	V1.CREDITID																	AS	CREDITID,				--	PK
		CAST(V1.BEGINATE AS DATE)													AS	BEGINDATE,
		V1.PRODUCTID																AS	PRODUCTID,
		V1.BRNID																	AS	BRNID,
		V1.AMOUNT																	AS	AMOUNT,
		V1.CREDITID																	AS	APPID,
		V1.FPD																		AS	FPD,
		V1.SPD																		AS	SPD,
		V1.TPD																		AS	TPD
FROM	(
			SELECT	ROW_NUMBER() OVER(ORDER BY T1.RN)						AS	CREDITID,
					CAST('20190101 12:00:00.000' AS DATETIME) + 
						ABS(CHECKSUM(NEWID()) % 200)						AS	BEGINATE,
					ABS(CHECKSUM(NEWID())%10)+1								AS	PRODUCTID,
					ABS(CHECKSUM(NEWID())%99)+1								AS	BRNID,
					CAST((ABS(CHECKSUM(NEWID())%10)+1)*10000 AS MONEY)		AS	AMOUNT,
					NULLIF(CHECKSUM(NEWID())%2,-1)							AS	FPD,
					NULLIF(CHECKSUM(NEWID())%2,-1)							AS	SPD,
					NULLIF(CHECKSUM(NEWID())%2,-1)							AS	TPD
			FROM	CTE T1
			CROSS JOIN CTE T2
		) V1;