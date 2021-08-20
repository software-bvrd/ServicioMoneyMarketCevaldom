USE [SIOPEL_INTERFACE_DB]
GO


CREATE VIEW [dbo].[V_OPERACIONES_ESTADO] 
AS

SELECT TOP 100 PERCENT
	M.PROCESO
   ,M.PARTICIPANTE
   ,M.MECANISMO
   ,M.ARCHIVO
   ,M.CARGA
   ,M.REGISTROS
   ,M.ACEPTADOS
   ,M.RECHAZADOS
   ,M.FECHACREACION
   ,D.referencia
   ,CAST(M.FECHACREACION AS DATE) AS FECHA
   ,D.OPERACION
   ,D.ISIN
   ,D.LINEA
   ,D.CAMPO
   ,D.Descripcion
   ,D.FECHACREACION AS DET_FECHACREACION
   ,CASE d.estado
		WHEN 'A' THEN 'ACEPTADO'
		WHEN 'R' THEN 'RECHAZADO'
	END AS estado
   ,CASE S.enviado
		WHEN 0 THEN 'PENDIENTE ENVIO'
		WHEN 1 THEN 'ENVIADO'
	END AS Enviado

FROM EstadoOperacionesOTC_Maestro AS M
INNER JOIN EstadoOperacionesOTC_Detalle AS D
	ON M.PROCESO = D.PROCESO
INNER JOIN siopel_owner.swoper_sync AS S
	ON CAST(SUBSTRING(s.clave, 2, 6) + '' + SUBSTRING(s.clave, 12, 8) AS NUMERIC) = D.REFERENCIA
ORDER BY d.estado


GO

