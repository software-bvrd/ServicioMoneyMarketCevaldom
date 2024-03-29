/****** Script for SelectTopNRows command from SSMS  ******/

SET DATEFORMAT DMY
GO
SELECT
	*
FROM [SIOPEL_INTERFACE_DB].[dbo].[vGen_XML_CEVALDOM_FORMAT_MONEYMARKET1]
WHERE FECHA_TRANSACCION = '20/02/2020' --AND  RUEDA = 'mdin' 
ORDER BY NUMERO_OPERACION DESC

SELECT
	*
FROM siopel_owner.swoper_sync
WHERE --rueda = 'MDIN' AND 
FECHA = '200220'

sp_helptext 'vGen_XML_CEVALDOM_FORMAT_MONEYMARKET1'

SELECT
	plazovta
   ,*
FROM SIOPEL_INTERFACE_DB.siopel_owner.swoper_sync oper
WHERE rueda = 'mdin'
AND plazovta = '005'



SELECT
	ID_DEPOSITANTE_VENDEDOR
   ,ID_DEPOSITANTE_COMPRADOR
   ,MECANISMO
   ,MODALIDAD
   ,NUMERO_OPERACION REFERENCIA
   ,FECHA_TRANSACCION AS PACTADA
   ,OBSERVACIONES
   ,ESQUEMA
   ,tipo
   ,FECHA_LIQUIDACION
   ,codigo_isin
   ,ID_MONEDA_LIQUIDACION
   ,CANTIDAD_TITULOS titulos
   ,PRECIO_PRIMA AS PRECIO
   ,IMPORTE_BRUTO AS PRECIO
   ,VERIFICADOR
   ,CADENA
FROM [SIOPEL_INTERFACE_DB].[dbo].[vGen_XML_CEVALDOM_FORMAT_MONEYMARKET1]
WHERE FECHA_TRANSACCION = '11/02/2020'
-- AND RUEDA= 'mdin'
ORDER BY FECHA_TRANSACCION DESC



  SP_HELPTEXT 'vGen_XML_CEVALDOM_MONEYMARKET'


SELECT
	*
FROM DBRD_DB.siopel_owner.titulos

SELECT
	*
FROM siopel_owner.swoper_sync
WHERE rueda = 'MDIN'
AND FECHA = '200211'

SELECT
	*
FROM siopel_owner.swoper oper
WHERE SUBSTRING(oper.clave, 2, LEN(clave)) = '20021021339'
SELECT
	*
FROM SIOPEL_INTERFACE_DB.siopel_owner.swoper_sync
WHERE NUMEROSECU = 33962

SELECT
	*
FROM siopel_owner.swoper oper
WHERE SUBSTRING(oper.clave, 2, LEN(clave)) = '20021021339'


SELECT
	*
FROM SIOPEL_INTERFACE_DB.siopel_owner.swoper_sync
WHERE NUMEROSECU = 33964

SELECT
	*
FROM SIOPEL_INTERFACE_DB.siopel_owner.swoper_sync
WHERE NUMEROSECU IN (33957, 33955, 33958, 33956, 33959)



SELECT
	*
FROM SIOPEL_INTERFACE_DB.siopel_owner.swoper_sync
WHERE FECHA = 200210
AND rueda = 'MDIN'

SELECT
	*
FROM DBRD_DB.siopel_owner.swoper
WHERE FECHA = 200210
AND rueda = 'MDIN'

SELECT
	*
FROM SIOPEL_INTERFACE_DB.siopel_owner.swoper_sync
WHERE FECHA = 200210
AND rueda = 'MDIN'

UPDATE SIOPEL_INTERFACE_DB.siopel_owner.swoper_sync SET dia = 21 ,FECHA = 200221 ,ENVIADO = 1 WHERE FECHA = 200221
AND rueda = 'MDIN'

EXEC P_GEN_CEVALDOM_OPER_CUENTA_MM 

select * from siopel_owner.swoper_sync

EXEC P_GEN_CEVALDOM_OPER_CUENTA_MM 

select fecha,* from SIOPEL_INTERFACE_DB.siopel_owner.swoper_sync
SELECT
	*
FROM SIOPEL_INTERFACE_DB.siopel_owner.swoper_sync
WHERE FECHA = 200211
AND rueda = 'MDIN'

----------------------------------

  SELECT SUBSTRING(especieori, 2, 5) , especieori,*   FROM SIOPEL_INTERFACE_DB.siopel_owner.swoper_sync WHERE FECHA = 200213 AND rueda = 'MDIN'
  and SUBSTRING(oper.especieori, 2, 5)   = 
-- DO1005205112
  WHERE codigo_isin
  sp_helptext 'vGen_XML_CEVALDOM_MONEYMARKET'
--00509
SELECT
	codigo
   ,codigo_isin
   ,*
FROM DBRD_DB.siopel_owner.titulos
WHERE codigo_isin = 'DO1002216112'

SELECT
	especieori
   ,*
FROM SIOPEL_INTERFACE_DB.siopel_owner.swoper_sync
WHERE NUMEROSECU IN (15362, 15361, 15360, 15359)

UPDATE SIOPEL_INTERFACE_DB.siopel_owner.swoper_sync
SET especieori = 'S00509 009000$3'
WHERE NUMEROSECU IN (15362, 15361, 15360, 15359)

SELECT
	fechaliq
   ,plazovta
   ,*
FROM siopel_owner.swoper_sync
WHERE FECHA = 200214
AND rueda = 'mdin'
AND plazovta = '004'

SET DATEFORMAT YMD

UPDATE siopel_owner.swoper_sync SET plazovta = '005'    ,fechaliq = '2020-02-19 00:00:00.000' WHERE FECHA = 200214
AND rueda = 'mdin'

UPDATE SIOPEL_INTERFACE_DB.siopel_owner.swoper_sync
SET plazovta = '003'
WHERE rueda = 'mdin'
AND plazovta = '005'

AND plazovta = '004'
 sp_helptext 'vGen_XML_CEVALDOM_FORMAT_MONEYMARKET1'
 sp_helptext 'vGen_XML_CEVALDOM_MONEYMARKET'
 EXEC P_GEN_CEVALDOM_OPER_CUENTA_MM 

 --------------------------------------

 
SELECT
	*
FROM EstadoOperacionesOTC_Maestro
ORDER BY FECHACREACION DESC
SELECT
	*
FROM dbo.EstadoOperacionesOTC_Detalle
ORDER BY FECHACREACION DESC
SELECT
	*
FROM siopel_owner.swoper_sync
WHERE FECHA = '200224'
SELECT
	*
FROM V_OPERACIONES_ESTADO
WHERE REFERENCIA IN ('20022415598', '20022415597')
SELECT
	*
FROM V_OPERACIONES_ESTADO
WHERE REFERENCIA IN ('20022415601', '20022415602', '20022415593', '20022415594')
SELECT
	*
FROM SIOPEL_INTERFACE_DB.siopel_owner.swoper_sync
WHERE FECHA = '200224'
AND REFERENCIA NOT IN (15597, 15598)
AND SUBSTRING(REFERENCIA, 2, 100) IN ('20022415601', '20022415602', '20022415593', '20022415594')

UPDATE SIOPEL_INTERFACE_DB.siopel_owner.swoper_sync
SET ENVIADO = 0
WHERE FECHA = '200224'
AND REFERENCIA NOT IN (15597, 15598)

SELECT
	*
FROM V_OPERACIONES_ESTADO
ORDER BY CARGA DESC

------------------

UPDATE SIOPEL_INTERFACE_DB.siopel_owner.swoper_sync
SET ENVIADO = 0
WHERE FECHA = '200224'

EXEC P_GEN_CEVALDOM_OPER_CUENTA_MM 