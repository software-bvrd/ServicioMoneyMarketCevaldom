 USE SIOPEL_INTERFACE_DB
 GO
				   
ALTER  VIEW [dbo].[vGen_XML_CEVALDOM_MONEYMARKET]
AS

SELECT
	REPLACE(
	(SUBSTRING(oper.clave, 1, 1) + '' +
	SUBSTRING(oper.clave, 2, 6) + '' +
	SUBSTRING(oper.clave, 12, 5)), 'D', '') NUMERO_OPERACION
   ,oper.NUMEROSECU AS ID_CONSECUTIVO_OPERACION
   ,(oper.DIA +'/'+ oper.MES +'/'+ oper.ANIO) AS FECHA_TRANSACCION
   ,dbo.format_date(oper.fechaliq, 'DD/MM/YYYY') AS FECHA_LIQUIDACION
   ,CAST(
	CASE
		WHEN oper.RUEDA = 'REVA' THEN '37'
		WHEN oper.RUEDA = 'LICI' AND
			SUBSTRING(oper.especieori, 15, 1) IN ('1', '2', '3', '4', '5', '6', '7', '8') THEN '23'
		WHEN oper.RUEDA = 'LICI' AND
			SUBSTRING(oper.especieori, 15, 1) IN ('a', 'b') THEN '36'
		ELSE '15'
	END AS VARCHAR(3)) AS INDICADOR_OPERACION
   --,oper.codigoagen AS ID_DEPOSITANTE_COMPRADOR
   --,oper.codigoage2 AS ID_DEPOSITANTE_VENDEDOR
   ,T.corta  COLLATE DATABASE_DEFAULT AS ID_DEPOSITANTE_COMPRADOR   
   ,R.corta  COLLATE DATABASE_DEFAULT AS ID_DEPOSITANTE_VENDEDOR 
   ,CAST(oper.codcomic AS VARCHAR(8)) AS CUENTA_COMPRADOR
   ,CAST(oper.codcomiv AS VARCHAR(8)) AS CUENTA_VENDEDOR
   ,CAST(
	CASE
		WHEN oper.moneda = '$' THEN 'DOP'
		WHEN oper.moneda = 'D' THEN 'USD'
		ELSE oper.moneda
	END AS VARCHAR(3)) AS ID_MONEDA_EMISION
   ,CASE ES.IndiceConversionLiquidacion
		WHEN 0 THEN CAST(
			CASE
				WHEN oper.moneda = '$' THEN 'DOP'
				WHEN oper.moneda = 'D' THEN 'USD'
				ELSE oper.moneda
			END AS VARCHAR(3))
		ELSE 'USD'
	END AS ID_MONEDA_LIQUIDACION
   ,CAST(es.CodigoISIN AS VARCHAR(12)) CODIGO_ISIN
   ,CAST(
	CASE
		WHEN oper.RUEDA = 'LIQ' THEN oper.sicantgtia / tit.divisibilidad --Formula					
		WHEN oper.RUEDA = 'PRES' THEN oper.sicantgtia / tit.divisibilidad --Formula				
		WHEN oper.RUEDA = 'REVA' THEN oper.CANTIDADOP
		ELSE oper.CANTIDADOP / tit.divisibilidad
	END AS DECIMAL(12)) AS CANTIDAD_TITULOS
   , --Verificar con el MAE., poner 1 para desarrollo
	CAST(oper.PRECIOOPER AS DECIMAL(18, 6)) PRECIO_PRIMA
   ,'1' TIPO_CAMBIO
   , --Confirmar con CEVALDOM, tiene un 1 Fijo
	--CAST( oper.VALORIZACI AS DECIMAL(18, 2) )  IMPORTE_BRUTO,
	CASE ES.IndiceConversionLiquidacion
		WHEN 0 THEN oper.VALORIZACI
		ELSE CAST(oper.VALORIZACI / (SELECT TOP 1
					dbo.fn_CalcularTasaCalculoEmsionDolares(ES.IndiceConversionLiquidacion, CAST(GETDATE() AS DATE)) AS Tasa)
			AS DECIMAL(36, 2))
	END AS IMPORTE_BRUTO
   ,oper.RUEDA RUEDA
   , -- Este campo no se visualiza en el archivo XML pero se usa para filtra cual Rueda y tipo de negociacion No aplican.
	oper.tipo TIPONEGOACION
   ,  --Tipo de Negociacion		  
	CAST(oper.DIA + '-' + oper.MES + '-' + oper.ANIO AS DATETIME) AS FECHA_FILTRO
   ,
	--oper.dia + '-' + oper.mes + '-' + oper.anio AS FECHA_FILTRO,		  	
	CAST(CASE
		WHEN LEN(oper.DIA) = 1 THEN '0' + oper.DIA
		ELSE oper.DIA
	END AS VARCHAR(2)) AS DIA
   ,CAST(CASE
		WHEN LEN(oper.MES) = 1 THEN '0' + oper.MES
		ELSE oper.MES
	END AS VARCHAR(2)) AS MES
   ,oper.ANIO ANIO
   ,oper.hh HORA
   ,oper.mm MINUTO
   ,oper.ss SEGUNDO
   ,oper.estado
   ,CAST(CASE
		WHEN oper.TIPOLIQ = '6' AND
			oper.RUEDA = 'LICI' THEN '1'
		ELSE '2'
	END AS VARCHAR(1)) AS TIPO_LIQUIDACION,
	'BVRD' AS MECANISMO,
	'1'  AS MODALIDAD,
	'1' AS ESQUEMA,
	'1' AS TIPO,
	'CONTADO' as OBSERVACIONES,
	oper.ENVIADO   
FROM SIOPEL_INTERFACE_DB.siopel_owner.swoper_sync oper
INNER JOIN DBRD_DB.siopel_owner.titulos tit 
	ON SUBSTRING(oper.especieori, 2, 5) COLLATE SQL_Latin1_General_CP1_CI_AS = tit.codigo
INNER JOIN  [SGO].[dbo].[EmisionSerie] es
	ON es.CodigoISIN = tit.CODIGO_ISIN  COLLATE SQL_Latin1_General_CP1_CI_AS
INNER JOIN 
DBRD_DB.siopel_owner.agentes R 
 ON SUBSTRING (oper.codigoagen ,2 , 3 ) COLLATE SQL_Latin1_General_CP1_CI_AS =  R.agente   
INNER JOIN 
DBRD_DB.siopel_owner.agentes T 
 ON SUBSTRING (oper.codigoage2 ,2 , 3 ) COLLATE SQL_Latin1_General_CP1_CI_AS =  T.agente   
WHERE 
-- (oper.RUEDA != 'LICI' OR oper.TIPOLIQ != '6');
-- AND rueda NOT IN ('TRD', 'DMAT','LICI')
oper.ENVIADO = 0 
AND oper.estado NOT IN ('B') --B = es igual a Operaciones Anuladas.
GO


 

SELECT * FROM vGen_XML_CEVALDOM_MONEYMARKET
