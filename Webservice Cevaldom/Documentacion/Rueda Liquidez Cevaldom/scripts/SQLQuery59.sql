/****** Script for SelectTopNRows command from SSMS  ******/
SELECT *    FROM [SIOPEL_INTERFACE_DB].[dbo].[Tipo_Solicitudes_OTCCevaldom]

select * from SIOPEL_INTERFACE_DB.siopel_owner.swoper_sync where fecha= 200211 AND TIPO ='S'
 

SELECT
DISTINCT
	tipo
FROM SIOPEL_INTERFACE_DB.siopel_owner.swoper_sync

SELECT 
CASE WHEN TIPO in ('1','2','3') then 1 else --- Compra y Venta de RF Cotizacion, Mayorista y Minorista
CASE TIPO 
  WHEN '4' then 2   -- Compra y Venta de RV
  WHEN '*' then  4  -- Repo Estructurada 1 
  WHEN 'S' then  9  -- Simultanea 
  WHEN 'L' then  12 -- Licitaciones Precio
  END
END as prueba, *
FROM SIOPEL_INTERFACE_DB.siopel_owner.swoper_sync

SELECT * FROM SIOPEL_INTERFACE_DB.dbo.Tipo_Solicitudes_OTCCevaldom

SELECT * FROM LKPSIOPEL2.DBRD_DB.siopel_owner.swoper WHERE FECHA = 200210 AND rueda='MDIN'
