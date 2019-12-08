--	-------------------------------------------------------------------------------------------------
--	
--		2019/12/08, DDM
--	
--		DATAMART OF CLIENTS
--		
--	
CREATE VIEW [dm].[CLIENTS]
AS
WITH CTE AS
	(
		SELECT	1	AS RN
		UNION ALL
		SELECT	RN+1	AS	RN
		FROM	CTE
		WHERE	RN < 100
	)
SELECT	V1.CLIENTID																	AS	CLIENTID,				--	PK
		V1.INN																		AS	INN,
		'Name - ' + CAST(V1.CLIENTID AS VARCHAR(100))								AS	NAME,
		'Surname - ' + CAST(V1.CLIENTID AS VARCHAR(100))							AS	SURNAME,
		'Patronymic - ' + CAST(V1.CLIENTID AS VARCHAR(100))							AS	PATRONYMIC,
		CAST(CAST(CAST(LEFT(V1.INN,5) AS INT)-1 AS DATETIME) AS DATE)				AS	BIRTHDATE
FROM	(
			SELECT	ROW_NUMBER() OVER(ORDER BY T1.RN)						AS	CLIENTID,
					CAST(
							CAST(CAST('19500101' AS DATETIME) AS BIGINT) +
								ABS(CHECKSUM(NEWID()) % 18628) AS VARCHAR(5)
						)	+
						RIGHT('00000'+CAST(
								ABS(CHECKSUM(NEWID()) % 99999) AS VARCHAR(5)
							),5)											AS	INN
			FROM	CTE T1
			CROSS JOIN CTE T2
		) V1;
