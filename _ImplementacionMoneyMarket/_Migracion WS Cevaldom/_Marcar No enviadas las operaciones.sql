 --** marca como no enviadas las operaciones **//
 SELECT COUNT(*) FROM  SIOPEL_INTERFACE_DB.[dbo].[EstadoOperacionesCevaldom]
SET DATEFORMAT DMY
--select S.ENVIADO,op.estadocvd, OP.*
 UPDATE S SET S.ENVIADO = 1
 FROM SIOPEL_INTERFACE_DB.siopel_owner.swoper_sync s
	 ,sgo.dbo.operacionescsv op
 WHERE op.num_oper = SUBSTRING(s.clave, 2, 6) + '' + SUBSTRING(s.clave, 12, 8)
 AND CAST(op.fecha_oper AS DATE) = CAST(s.fecha2 AS DATE)
 AND CAST(op.fecha_oper AS DATE) = CAST(GETDATE() AS DATE)
 AND ISNULL(op.estadocvd, '') = ''
 --and op.num_oper=  '2010015937856'


UPDATE SIOPEL_INTERFACE_DB.siopel_owner.swoper_sync
SET ENVIADO = 0
WHERE REPLACE(
	(SUBSTRING(clave, 1, 1) + '' +
	SUBSTRING(clave, 2, 6) + '' +
	SUBSTRING(clave, 12, 5)), 'D', '') = 20092345161

SELECT ENVIADO, REPLACE(
	(SUBSTRING(clave, 1, 1) + '' +
	SUBSTRING(clave, 2, 6) + '' +
	SUBSTRING(clave, 12, 5)), 'D', '') , * FROM SIOPEL_INTERFACE_DB.siopel_owner.swoper_sync
-- UPDATE SIOPEL_INTERFACE_DB.siopel_owner.swoper_sync SET ENVIADO =0
WHERE FECHA = 200925
AND REPLACE(
	(SUBSTRING(clave, 1, 1) + '' +
	SUBSTRING(clave, 2, 6) + '' +
	SUBSTRING(clave, 12, 5)), 'D', '') NOT IN (2009255837738,
20092519377,
20092519377,
2009252937742,
2009251737739,
2009254837740,
2009252637741,
2009252937742)

-- update set enviado = 0 siopel_owner.swoper_sync where fecha = '200930'


select   * from  SIOPEL_INTERFACE_DB.siopel_owner.swoper_sync  s
where --fecha = '201001' and
REPLACE(
	 (SUBSTRING(s.clave, 1, 1) + '' +
	 SUBSTRING(s.clave, 2, 6) + '' +
	 SUBSTRING(s.clave, 12, 5)), 'D', '') like '%2010010037869%'

select codrueda,* from sgo.dbo.operacionescsv where cast(fecha_oper as date)  = cast(getdate() as date) 
and codrueda != '1'
and num_oper like '%11378%'


SELECT
 
	   
	 SUBSTRING(s.clave, 2, 6) + '' +
	 SUBSTRING(s.clave, 12, 8)   op2,
 REPLACE(
	 (SUBSTRING(s.clave, 1, 1) + '' +
	 SUBSTRING(s.clave, 2, 6) + '' +
	 SUBSTRING(s.clave, 12, 5)), 'D', '') as op, 
	*
FROM SIOPEL_INTERFACE_DB.siopel_owner.swoper_sync s where s.fecha = '201001'
201001-1137851
201001-1137851
D20100109011137851