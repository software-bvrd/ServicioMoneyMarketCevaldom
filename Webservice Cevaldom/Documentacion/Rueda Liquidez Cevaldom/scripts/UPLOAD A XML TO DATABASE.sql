
ALTER Procedure [dbo].[P_SUBE_XML_RESPUESTA_OPERACIONESMM_CEVALDOM]
 @archivo nvarchar(max) 
AS
BEGIN
Declare @PROCESO numeric(18, 0)=  0
--DECLARE @archivo  nVarchar(MAX) = 'c:\prueba.xml'
IF OBJECT_ID('tempdb.dbo.##DATAFINAL', 'U')  IS NOT NULL DROP TABLE ##DATAFINAL

SELECT 	@archivo = '(SELECT  BulkColumn INTO ##DATAFINAL FROM OPENROWSET(BULK N''' + @archivo + ''',SINGLE_BLOB) AS xData) '
EXEC sp_executesql @archivo

DECLARE @XmlData XML
SET @XmlData = CONVERT(XML, (SELECT	* FROM ##DATAFINAL), 1);

/* VALIDACION DEL PROCESO A CARGAR PARA NO CARGARLO VARIAS VECES*/
SET @PROCESO = (SELECT xData.value('PROCESO[1]', 'numeric(18, 0)') PROCESO FROM @XmlData.nodes('/Respuesta/Cuerpo/SolOperaciones/Encabezado') AS X (xData))

SELECT 'PROCESO: ' + CAST(@PROCESO AS VARCHAR)

/* CARGA SUBIR EN EL ENCABEZADO DEL ARCHIVO*/
--IF NOT EXISTS(SELECT PROCESO FROM EstadoOperacionesOTC_Maestro WHERE PROCESO =@PROCESO)
BEGIN
/*INSERT INTO [dbo].[EstadoOperacionesOTC_Maestro] ([PROCESO]
, [PARTICIPANTE]
, [MECANISMO]
, [ARCHIVO]
, [CARGA]
, [REGISTROS]
, [ACEPTADOS]
, [RECHAZADOS])
*/
	SELECT
		xData.value('PROCESO[1]', 'numeric(18, 0)')		PROCESO
	   ,xData.value('PARTICIPANTE[1]', 'varchar(20)')	PARTICIPANTE
	   ,xData.value('MECANISMO[1]', 'varchar(8)')		MECANISMO
	   ,xData.value('ARCHIVO[1]', 'varchar(50)')		ARCHIVO
	   ,xData.value('CARGA[1]', 'varchar(50)')			CARGA
	   ,xData.value('REGISTROS[1]', 'numeric(18, 0)')	REGISTROS
	   ,xData.value('ACEPTADOS[1]', 'numeric(18, 0)')	ACEPTADOS
	   ,xData.value('RECHAZADOS[1]', 'numeric(18, 0)')	RECHAZADOS
	FROM @XmlData.nodes('/Respuesta/Cuerpo/SolOperaciones/Encabezado') AS X (xData)
						 
-- SELECT	* FROM EstadoOperacionesOTC_Maestro
/* CARGA SUBIR EN EL DETALLE DEL ARCHIVO Aceptados */
/*
INSERT INTO [dbo].[EstadoOperacionesOTC_Detalle] ([PROCESO]
, [REFERENCIA]
, [FECHA]
, [OPERACION]
, [ISIN]
, [LINEA]
, [CAMPO]
, [DESCRIPCION]
, [ESTADO]
, [VENDEDOR]
, [COMPRADOR]
, [MECANISMO]
, [MODALIDAD]
, [VERIFICADOR]
, [SOLICITUD]
)*/
	SELECT
		@PROCESO
	   ,xData.value('REFERENCIA[1]', 'varchar(30)')		REFERENCIA
	   ,xData.value('FECHA[1]', 'varchar(50)')			FECHA
	   ,xData.value('OPERACION[1]', 'numeric(18, 0)')	OPERACION
	   ,xData.value('ISIN[1]', 'varchar(12)')			ISIN
	   ,xData.value('LINEA[1]', 'numeric(18, 0)')		LINEA
	   ,xData.value('CAMPO[1]', 'varchar(30)')			CAMPO
	   ,xData.value('DESCRIPCION[1]', 'varchar(150)')	DESCRIPCION
	   ,xData.value('VENDEDOR[1]', 'varchar(150)')		VENDEDOR
	   ,xData.value('COMPRADOR[1]', 'varchar(150)')		COMPRADOR
	   ,xData.value('MECANISMO[1]', 'varchar(20)')		MECANISMO
	   ,xData.value('MODALIDAD[1]', 'varchar(5)')		MODALIDAD
	   ,xData.value('VERIFICADOR[1]', 'NUMERIC(18)')	VERIFICADOR
	   ,xData.value('SOLICITUD[1]', 'NUMERIC(18)')		SOLICITUD
	   ,'A' ESTADO

	FROM @XmlData.nodes('/Respuesta/Cuerpo/SolOperaciones/Detalle/Aceptados/SOLOPER') AS X (xData)
-- WHERE xData.value('PROCESO[1]', 'numeric(18, 0)') NOT IN (SELECT PROCESO FROM EstadoOperacionesOTC_Maestro)

/* CARGA SUBIR EN EL DETALLE DEL ARCHIVO Rechazados */
/*
INSERT INTO [dbo].[EstadoOperacionesOTC_Detalle] ([PROCESO]
, [REFERENCIA]
, [FECHA]
, [OPERACION]
, [ISIN]
, [LINEA]
, [CAMPO]
, [DESCRIPCION]
, [ESTADO],
, [VENDEDOR]
, [COMPRADOR]
, [MECANISMO]
, [MODALIDAD]
, [PACTADA])
*/
	SELECT
		@PROCESO										PROCESO
	   ,xData.value('REFERENCIA[1]', 'varchar(30)')		REFERENCIA
	   ,xData.value('FECHA[1]', 'varchar(50)')			FECHA
	   ,xData.value('OPERACION[1]', 'numeric(18, 0)')	OPERACION
	   ,xData.value('ISIN[1]', 'varchar(12)')			ISIN
	   ,xData.value('LINEA[1]', 'numeric(18, 0)')		LINEA
	   ,xData.value('CAMPO[1]', 'varchar(30)')			CAMPO
	   ,xData.value('DESCRIPCION[1]', 'varchar(150)')	DESCRIPCION
	   ,xData.value('VENDEDOR[1]', 'varchar(150)')		VENDEDOR
	   ,xData.value('COMPRADOR[1]', 'varchar(150)')		COMPRADOR
	   ,xData.value('MECANISMO[1]', 'varchar(20)')		MECANISMO
	   ,xData.value('MODALIDAD[1]', 'varchar(5)')		MODALIDAD
	   ,xData.value('PACTADA[1]', 'varchar(10)')		PACTADA
	   ,'R' ESTADO 
	FROM @XmlData.nodes('/Respuesta/Cuerpo/SolOperaciones/Detalle/Rechazados/RECOPER') AS X (xData)
-- WHERE xData.value('PROCESO[1]', 'numeric(18, 0)') NOT IN (SELECT PROCESO FROM EstadoOperacionesOTC_Maestro)
-- SELECT * FROM EstadoOperacionesOTC_Detalle
END

--if (@PROCESO  > 0) 
--BEGIN
SELECT CONTADOR = 1 ,* FROM V_OPERACIONES_ESTADO_OTC WHERE PROCESO = @PROCESO
--end 
-- else
--  SELECT CONTADOR = 0 
----SELECT @PROCESO 
END

GO
-- P_SUBE_XML_RESPUESTA_OPERACIONESMM_CEVALDOM '\\ARP01\xml\NotificacionCevaldom_12022020041916.xml'

-- P_SUBE_XML_RESPUESTA_OPERACIONESMM_CEVALDOM '\\ARP01\xml\ACEPTADOS.xml'

P_SUBE_XML_RESPUESTA_OPERACIONESMM_CEVALDOM '\\ARP01\xml\RECHAZADOS.xml'

-- FECHA	OPERACION	ISIN	LINEA 