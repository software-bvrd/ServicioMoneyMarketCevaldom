USE [SIOPEL_INTERFACE_DB]
GO
 

ALTER Procedure [dbo].[P_SUBE_ArchivoEstadoOperacionesMM]
 @archivo nvarchar(max) 
 AS
 BEGIN

Declare @PROCESO numeric(18, 0)=  0
--DECLARE @archivo  nVarchar(MAX) = 'c:\prueba.xml'
IF OBJECT_ID('tempdb.dbo.##DATAFINAL', 'U')  IS NOT NULL  DROP TABLE ##DATAFINAL

SELECT @archivo = '(SELECT  BulkColumn INTO ##DATAFINAL FROM OPENROWSET(BULK N''' + @archivo + ''',SINGLE_BLOB) AS xData) '
exec sp_executesql   @archivo

Declare @XmlData XML
SET  @XmlData = CONVERT(XML, (SELECT * FROM ##DATAFINAL) , 1);


/* VALIDACION DEL PROCESO A CARGAR PARA NO CARGARLO VARIAS VECES*/

SET @PROCESO  = (SELECT xData.value('PROCESO[1]', 'numeric(18, 0)') PROCESO  FROM @XmlData.nodes('/Respuesta/Cuerpo/SolOperaciones/Encabezado') AS x (xData))

SELECT 'PROCESO: '+ CAST(@PROCESO AS VARCHAR)

/* CARGA SUBIR EN EL ENCABEZADO DEL ARCHIVO*/
--IF NOT EXISTS(SELECT PROCESO FROM EstadoOperacionesOTC_Maestro WHERE PROCESO =@PROCESO)
BEGIN
INSERT INTO [dbo].[EstadoOperacionesOTC_Maestro] ([PROCESO]
, [PARTICIPANTE]
, [MECANISMO]
, [ARCHIVO]
, [CARGA]
, [REGISTROS]
, [ACEPTADOS]
, [RECHAZADOS])
	SELECT
		xData.value('PROCESO[1]', 'numeric(18, 0)') PROCESO
	   ,        -- 'xData' is our xml content alias
		xData.value('PARTICIPANTE[1]', 'varchar(20)') PARTICIPANTE
	   ,xData.value('MECANISMO[1]', 'varchar(8)') MECANISMO
	   ,xData.value('ARCHIVO[1]', 'varchar(50)') ARCHIVO
	   ,        -- 'xData' is our xml content alias
		xData.value('CARGA[1]', 'varchar(50)') CARGA
	   ,xData.value('REGISTROS[1]', 'numeric(18, 0)') REGISTROS
	   ,xData.value('ACEPTADOS[1]', 'numeric(18, 0)') ACEPTADOS
	   ,        -- 'xData' is our xml content alias
		xData.value('RECHAZADOS[1]', 'numeric(18, 0)') RECHAZADOS
	FROM @XmlData.nodes('/Respuesta/Cuerpo/SolOperaciones/Encabezado') AS
	x (xData)
-- confirm we loaded the data!


-- SELECT	* FROM EstadoOperacionesOTC_Maestro

/* CARGA SUBIR EN EL DETALLE DEL ARCHIVO Aceptados */
INSERT INTO [dbo].[EstadoOperacionesOTC_Detalle] (
  [PROCESO]
, [REFERENCIA]
, [FECHA]
, [OPERACION]
, [ISIN]
, [LINEA]
, [CAMPO]
, [DESCRIPCION]
, [ESTADO])
	SELECT 
		@PROCESO
	   ,xData.value('REFERENCIA[1]', 'varchar(30)') REFERENCIA
	   ,xData.value('FECHA[1]', 'varchar(50)') FECHA
	   ,xData.value('OPERACION[1]', 'numeric(18, 0)') OPERACION
	   ,xData.value('ISIN[1]', 'varchar(12)') ISIN
	   ,xData.value('LINEA[1]', 'numeric(18, 0)') LINEA
	   ,xData.value('CAMPO[1]', 'varchar(30)') CAMPO
	   ,xData.value('DESCRIPCION[1]', 'varchar(150)') DESCRIPCION
	   ,'A' ESTADO

	FROM @XmlData.nodes('/Respuesta/Cuerpo/SolOperaciones/Detalle/Aceptados/Operacion') AS
	x (xData) 
	-- WHERE xData.value('PROCESO[1]', 'numeric(18, 0)') NOT IN (SELECT PROCESO FROM EstadoOperacionesOTC_Maestro)
 
/* CARGA SUBIR EN EL DETALLE DEL ARCHIVO Rechazados */
INSERT INTO [dbo].[EstadoOperacionesOTC_Detalle] (
  [PROCESO]
, [REFERENCIA]
, [FECHA]
, [OPERACION]
, [ISIN]
, [LINEA]
, [CAMPO]
, [DESCRIPCION]
, [ESTADO])
	SELECT
	    @PROCESO
	   ,xData.value('REFERENCIA[1]', 'varchar(30)') REFERENCIA
	   ,xData.value('FECHA[1]', 'varchar(50)') FECHA
	   ,xData.value('OPERACION[1]', 'numeric(18, 0)') OPERACION
	   ,xData.value('ISIN[1]', 'varchar(12)') ISIN
	   ,xData.value('LINEA[1]', 'numeric(18, 0)') LINEA
	   ,xData.value('CAMPO[1]', 'varchar(30)') CAMPO
	   ,xData.value('DESCRIPCION[1]', 'varchar(150)') DESCRIPCION
	   ,'R' ESTADO

	FROM @XmlData.nodes('/Respuesta/Cuerpo/SolOperaciones/Detalle/Rechazados/RECOPER') AS
	x (xData) 
	-- WHERE xData.value('PROCESO[1]', 'numeric(18, 0)') NOT IN (SELECT PROCESO FROM EstadoOperacionesOTC_Maestro)

 -- SELECT * FROM EstadoOperacionesOTC_Detalle
END

--if (@PROCESO  > 0) 
--BEGIN
 select CONTADOR = 1, * from V_OPERACIONES_ESTADO_OTC where proceso = @PROCESO
--end 
-- else
--  SELECT CONTADOR = 0 
----SELECT @PROCESO 
END

GO
 



P_SUBE_ArchivoEstadoOperacionesMM '\\sep\archivos\file3.xml'

SELECT * FROM EstadoOperacionesOTC_Maestro WHERE PROCESO = 52322

SELECT * FROM EstadoOperacionesOTC_Detalle WHERE PROCESO = 52322
