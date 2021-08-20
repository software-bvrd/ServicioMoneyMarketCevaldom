USE [SIOPEL_INTERFACE_DB]
GO

 
ALTER   view [dbo].[Vswoper_syncPata2]
as
SELECT
	*
FROM SIOPEL_INTERFACE_DB.siopel_owner.swoper_sync
WHERE pata = 2
AND rueda = 'ALIQ'
GO


