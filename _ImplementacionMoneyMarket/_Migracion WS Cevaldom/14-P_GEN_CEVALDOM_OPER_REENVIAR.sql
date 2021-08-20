USE [SIOPEL_INTERFACE_DB]
GO
 
CREATE procedure [dbo].[P_GEN_CEVALDOM_OPER_REENVIAR]
@NoOperacion numeric
AS
UPDATE SIOPEL_INTERFACE_DB.siopel_owner.swoper_sync
SET enviado = 0
WHERE CAST(SUBSTRING(clave, 2, 6) + '' + SUBSTRING(clave, 12, 8) AS NUMERIC) = @NoOperacion
AND enviado = 1
--select CAST(substring(clave,2,5)+''+substring(clave,11,8) AS numeric) as clave1,*  from SIOPEL_INTERFACE_DB.siopel_owner.swoper_sync where FECHA =200309 
--clave = clave order by fecha desc
GO


