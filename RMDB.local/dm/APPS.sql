﻿--	-------------------------------------------------------------------------------------------------
--	
--		2019/12/07, DDM
--	
--		DATAMART OF APPLICATIONS
--		
--	
CREATE VIEW [dm].[APPS]
AS
WITH CTE AS
	(
		SELECT	1	AS RN
		UNION ALL
		SELECT	RN+1	AS	RN
		FROM	CTE
		WHERE	RN < 100
	)
SELECT	V1.APPID																	AS	APPID,				--	PK
		V1.APPDATE																	AS	APPDATETIME,
		CAST(V1.APPDATE AS DATE)													AS	APPDATE,
		V1.PRODUCTID																AS	PRODUCTID,
		V1.FIRSTBRNID																AS	FIRSTBRNID,
		CASE WHEN V1.FIRSTBRNID = 100 THEN ABS(CHECKSUM(NEWID())%99)+1
			ELSE V1.FIRSTBRNID
		END																			AS	BRNID,
		V1.AMOUNT																	AS	AMOUNT,
		V1.DECISION																	AS	DECESION,
		V1.APPDATE +
			ABS(CHECKSUM(NEWID())%3) + 
			CAST(1 AS FLOAT)/(ABS(CHECKSUM(NEWID()) % 100)+1)						AS	DECISIONDATETIME,
		V1.INN																		AS	INN,
		REPLICATE('A', 10) + ' ' +
			REPLICATE('B',10) + ' ' +
			REPLICATE('C',10)														AS	CLIENTNAME,
		CAST(CAST(CAST(LEFT(V1.INN,5) AS INT)-1 AS DATETIME) AS DATE)				AS	BIRTHDATE,
		CASE WHEN CAST(SUBSTRING(V1.INN,7,1) AS TINYINT) IN (1,3,5,7,9)	THEN 'M'
			ELSE 'F'
		END																			AS	SEX,
		CASE WHEN V1.DECISION < 0 THEN ABS(V1.REJECTIONID)
			ELSE NULL
		END																			AS	REJECTIONID
FROM	(
			SELECT	ROW_NUMBER() OVER(ORDER BY T1.RN)						AS	APPID,
					CAST('20190101 12:00:00.000' AS DATETIME) + 
						ABS(CHECKSUM(NEWID()) % 200) + 
						CAST(1 AS FLOAT)/(ABS(CHECKSUM(NEWID()) % 100)+1)	AS	APPDATE,
					ABS(CHECKSUM(NEWID())%10)+1								AS	PRODUCTID,
					ABS(CHECKSUM(NEWID())%100)+1							AS	FIRSTBRNID,
					CAST((ABS(CHECKSUM(NEWID())%10)+1)*10000 AS MONEY)		AS	AMOUNT,
					(CHECKSUM(NEWID())%2)									AS	DECISION,
					CAST(
							CAST(CAST('19500101' AS DATETIME) AS BIGINT) +
								ABS(CHECKSUM(NEWID()) % 18628) AS VARCHAR(5)
						)	+
						RIGHT('00000'+CAST(
								ABS(CHECKSUM(NEWID()) % 99999) AS VARCHAR(5)
							),5)											AS	INN,
					ABS(CHECKSUM(NEWID()) % 50)									AS	REJECTIONID

			FROM	CTE T1
			CROSS JOIN CTE T2
		) V1;