USE [SIOPEL_INTERFACE_DB]
GO
 
 
ALTER   VIEW [dbo].[vGen_XML_CEVALDOM_MONEYMARKET]
AS

SELECT
	REPLACE(
	(SUBSTRING(oper.clave, 1, 1) + '' +
	SUBSTRING(oper.clave, 2, 6) + '' +
	SUBSTRING(oper.clave, 12, 5)), 'D', '') NUMERO_OPERACION
   ,oper.NUMEROSECU AS ID_CONSECUTIVO_OPERACION
   ,(oper.DIA + '/' + oper.MES + '/' + oper.ANIO) AS FECHA_TRANSACCION
   ,dbo.format_date(oper.fechaliq, 'DD/MM/YYYY') AS FECHA_LIQUIDACION
   ,CAST(
	CASE
		WHEN oper.Rueda = 'REVA' THEN '37'
		WHEN oper.Rueda = 'LICI' AND
			SUBSTRING(oper.especieori, 15, 1) IN ('1', '2', '3', '4', '5', '6', '7', '8') THEN '23'
		WHEN oper.Rueda = 'LICI' AND
			SUBSTRING(oper.especieori, 15, 1) IN ('a', 'b') THEN '36'
		ELSE '15'
	END AS VARCHAR(3)) AS INDICADOR_OPERACION
	--,oper.codigoagen AS ID_DEPOSITANTE_COMPRADOR
	--,oper.codigoage2 AS ID_DEPOSITANTE_VENDEDOR
   ,T.corta COLLATE DATABASE_DEFAULT AS ID_DEPOSITANTE_COMPRADOR
   ,R.corta COLLATE DATABASE_DEFAULT AS ID_DEPOSITANTE_VENDEDOR
   ,CAST(oper.codcomic AS VARCHAR(8)) AS CUENTA_COMPRADOR
   ,CAST(oper.codcomiv AS VARCHAR(8)) AS CUENTA_VENDEDOR
   ,CAST(
	CASE
		WHEN oper.Moneda = '$' THEN 'DOP'
		WHEN oper.Moneda = 'D' THEN 'USD'
		ELSE oper.Moneda
	END AS VARCHAR(3)) AS ID_MONEDA_EMISION
   ,CASE ES.IndiceConversionLiquidacion
		WHEN 0 THEN CAST(
			CASE
				WHEN oper.Moneda = '$' THEN 'DOP'
				WHEN oper.Moneda = 'D' THEN 'USD'
				ELSE oper.Moneda
			END AS VARCHAR(3))
		ELSE 'USD'
	END AS ID_MONEDA_LIQUIDACION
   ,CAST(es.CodigoIsin AS VARCHAR(12)) CODIGO_ISIN
   ,CAST(
	CASE
		WHEN oper.Rueda = 'LIQ' THEN oper.sicantgtia / tit.divisibilidad --Formula					
		WHEN oper.Rueda = 'PRES' THEN oper.sicantgtia / tit.divisibilidad --Formula				
		WHEN oper.Rueda = 'REVA' THEN oper.CANTIDADOP
		ELSE oper.CANTIDADOP / tit.divisibilidad
	END AS DECIMAL(12)) AS CANTIDAD_TITULOS
   , --Verificar con el MAE., poner 1 para desarrollo
	CAST(oper.PRECIOOPER AS DECIMAL(36, 6)) PRECIO_PRIMA
   ,'1' TIPO_CAMBIO
   , --Confirmar con CEVALDOM, tiene un 1 Fijo
	--CAST( oper.VALORIZACI AS DECIMAL(18, 2) )  IMPORTE_BRUTO,
	CASE ES.IndiceConversionLiquidacion
		WHEN 0 THEN oper.VALORIZACI
		ELSE CAST(oper.VALORIZACI / (SELECT TOP 1
					dbo.fn_CalcularTasaCalculoEmsionDolares(ES.IndiceConversionLiquidacion, CAST(GETDATE() AS DATE)) AS Tasa)
			AS DECIMAL(36, 2))
	END AS IMPORTE_BRUTO
   ,oper.Rueda Rueda
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
			oper.Rueda = 'LICI' THEN '1'
		ELSE '2'
	END AS VARCHAR(1)) AS TIPO_LIQUIDACION
   ,'BVRD' AS MECANISMO
	--,Case When  oper.TEXTOVTA = '' Then oper.TEXTOCPA Else oper.TEXTOVTA End  AS MODALIDAD
   ,CAST(CASE oper.tipo
		WHEN 'S' THEN 9  -- Simultanea
		WHEN '*' THEN 4  -- Repo
		WHEN '2' THEN 1  -- MAYO
		WHEN '3' THEN 1  -- MINO
		WHEN '4' THEN 2  -- REVA
		ELSE -1
	END AS VARCHAR) AS MODALIDAD
   ,'1' AS ESQUEMA
   ,'1' AS TIPO
   ,Ts.Descripcion AS OBSERVACIONES
   ,oper.ENVIADO
   ,CAST(
	CASE
		WHEN oper.codigoagen = oper.codigoage2 THEN 'CRUZADA'
		ELSE CASE
				WHEN oper.CODIGODERE = '105' THEN 'VENTA'
				WHEN oper.CODIGODERE = '205' THEN 'COMPRA'
				ELSE ''
			END
	END AS VARCHAR) AS ORIGEN

	--,oper.CODIGODERE as ORIGEN
	--105 VENTAS; 205 COMPRA
   ,CASE OPER.rueda
		WHEN 'ALIQ' THEN CAST(oper.SICANTGTIA AS DECIMAL(30, 2))
		ELSE CAST(OPER.CANTIDADOP AS DECIMAL(30, 2))
	END AS FACIAL
   ,CASE OPER.rueda
		WHEN 'ALIQ' THEN CAST(oper.siprtagtia AS DECIMAL(36, 6))
		ELSE CAST(OPER.PRECIOOPER AS DECIMAL(36, 6))
	END AS LIMPIO
   ,oper.VALORIZACI
   ,oper.SICANTGTIA
   ,CASE OPER.rueda
		WHEN 'ALIQ' THEN CAST((oper.VALORIZACI / oper.SICANTGTIA * 100) AS DECIMAL(36, 6))
		WHEN 'REVA' THEN CAST(OPER.PRECIOOPER AS DECIMAL(36, 6))
		ELSE CAST((OPER.VALORIZACI / OPER.CANTIDADOP * 100) AS DECIMAL(36, 6))
	END AS SUCIO
   ,CAST(oper.TASAEQUINF AS DECIMAL(30, 15)) AS RENDIMIENTO
	--,AOP.OPEVINC06,
	-- AOP.TIPOPATA06  AS TipoPata,
	-- AOP.VALORIZ06   AS ImportePlazo,
	-- AOP.PLAVUELT06  AS DiasPlazo,
	--	cast(
	--(((oper.valorizaci - ((( oper.sicantgtia * (tit.Tasaadicional/100))/tit.Baseanual) * (datediff(y,oper.feultcupon,oper.fechaliq))))/convert(float,oper.sicantgtia)) * 100) as decimal(36,6)
	--   ) AS PRECIO_PLAZO
	--,CAST(PATA2.PLAZOVTA AS NUMERIC) as DIAS_PLAZO
   ,CASE
		WHEN Ts.TipoCevaldom IN (1, 2) THEN '0'
		ELSE CAST(DATEDIFF(D, CAST((OPER.DIA + '/' + OPER.MES + '/' + OPER.ANIO) AS DATE), PATA2.fechaliq) AS VARCHAR)
	END AS DIAS_PLAZO
   ,CASE
		WHEN Ts.TipoCevaldom IN (1, 2) THEN '0'
		ELSE CAST(CAST(PATA2.siprtagtia AS DECIMAL(36, 6)) AS VARCHAR)
	END AS LIMPIO_PLAZO
   ,CASE
		WHEN Ts.TipoCevaldom IN (1, 2) THEN '0'
		ELSE CAST(CAST(PATA2.VALORIZACI / PATA2.SICANTGTIA * 100 AS DECIMAL(30, 2)) AS VARCHAR)
	END AS SUCIO_PLAZO
   ,CASE
		WHEN Ts.TipoCevaldom IN (1, 2) THEN '0'
		ELSE CAST(CAST(PATA2.TASAEQUINF AS DECIMAL(30, 15)) AS VARCHAR)
	END AS RENDIMIENTO_PLAZO
   ,CASE
		WHEN Ts.TipoCevaldom IN (1, 2) THEN '0'
		ELSE CAST(CAST(PATA2.VALORIZACI AS DECIMAL(30, 2)) AS VARCHAR)
	END AS IMPORTE_PLAZO

FROM SIOPEL_INTERFACE_DB.siopel_owner.swoper_sync oper
INNER JOIN DBRD_DB.siopel_owner.titulos tit
	ON SUBSTRING(oper.especieori, 2, 5) COLLATE SQL_Latin1_General_CP1_CI_AS = tit.codigo
INNER JOIN [SGO].[dbo].[EmisionSerie] es
	ON es.CodigoIsin = tit.CODIGO_ISIN COLLATE SQL_Latin1_General_CP1_CI_AS
INNER JOIN DBRD_DB.siopel_owner.agentes R
	ON SUBSTRING(oper.codigoagen, 2, 3) COLLATE SQL_Latin1_General_CP1_CI_AS = R.agente
INNER JOIN DBRD_DB.siopel_owner.agentes T
	ON SUBSTRING(oper.codigoage2, 2, 3) COLLATE SQL_Latin1_General_CP1_CI_AS = T.agente
--LEFT JOIN VAOP06AS400 AOP ON
---- AOP.OPEVINC06 = oper.OPEVINC06 and 
--	   oper.NUMEROSECU = CAST(AOP.NROSEC06 AS NUMERIC)  and 
--	   oper.FECHA = CAST(AOP.FECHA06 AS NUMERIC) 
--	    AND AOP.TIPOPATA06= 2
LEFT JOIN Vswoper_syncPata2 PATA2
	ON oper.referencia = CAST(PATA2.referencia AS NUMERIC)
		AND oper.FECHA = PATA2.FECHA
		AND oper.HORA = PATA2.HORA
LEFT JOIN SIOPEL_INTERFACE_DB.dbo.Tipo_Solicitudes_OTCCevaldom Ts
	ON
		--Case When  oper.TEXTOVTA = '' Then oper.TEXTOCPA Else oper.TEXTOVTA End   = cast(Ts.TipoCevaldom as varchar)
		CASE oper.tipo
			WHEN 'S' THEN 9  -- Simultanea
			WHEN '*' THEN 4  -- Repo
			WHEN '2' THEN 1  -- MAYO
			WHEN '3' THEN 1  -- MINO
			WHEN '4' THEN 2  -- REVA
			ELSE -1
		END = Ts.TipoCevaldom
WHERE
-- (oper.RUEDA != 'LICI' OR oper.TIPOLIQ != '6');
-- AND rueda NOT IN ('TRD', 'DMAT','LICI')
oper.ENVIADO = 0
AND oper.estado NOT IN ('B') --B = es igual a Operaciones Anuladas.
--AND OPER.rueda!='MDIN'
AND CAST((oper.DIA + '/' + oper.MES + '/' + oper.ANIO) AS DATE) = CAST(GETDATE() AS DATE)
AND oper.pata IN (0, 1)
AND (oper.RUEDA NOT IN ('LICI','ALIQ') OR oper.TIPOLIQ != '6');
GO


