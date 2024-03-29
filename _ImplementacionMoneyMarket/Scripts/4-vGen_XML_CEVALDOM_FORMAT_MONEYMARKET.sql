USE SIOPEL_INTERFACE_DB
GO


ALTER VIEW [dbo].[vGen_XML_CEVALDOM_FORMAT_MONEYMARKET]
AS
SELECT

	dia
   ,mes
   ,anio
   ,HORA
   ,MINUTO
   ,SEGUNDO
   ,rueda
   ,TIPONEGOACION
   ,NUMERO_OPERACION
   ,ID_CONSECUTIVO_OPERACION
   ,FECHA_TRANSACCION
   ,FECHA_LIQUIDACION
   ,INDICADOR_OPERACION
   ,T.corta ID_DEPOSITANTE_COMPRADOR
   ,R.corta ID_DEPOSITANTE_VENDEDOR
   ,ID_MONEDA_EMISION
   ,ID_MONEDA_LIQUIDACION
   ,codigo_isin
   ,CANTIDAD_TITULOS
   ,PRECIO_PRIMA
   ,TIPO_CAMBIO
   ,IMPORTE_BRUTO
FROM SIOPEL_INTERFACE_DB.dbo.vGen_XML_CEVALDOM_MONEYMARKET n
INNER JOIN DBRD_DB.siopel_owner.agentes R
	ON SUBSTRING(n.ID_DEPOSITANTE_COMPRADOR, 2, 3) COLLATE  Latin1_General_CS_AI = R.agente
INNER JOIN DBRD_DB.siopel_owner.agentes T
	ON SUBSTRING(n.ID_DEPOSITANTE_VENDEDOR, 2, 3) COLLATE  Latin1_General_CS_AI  = T.agente
--WHERE rueda NOT IN ('TRD', 'DMAT')





GO

 






