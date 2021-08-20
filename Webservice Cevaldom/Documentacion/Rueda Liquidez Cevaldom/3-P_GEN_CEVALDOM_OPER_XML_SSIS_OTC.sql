USE [SIOPEL_INTERFACE_DB]
GO
	--- Z:\TomasJimenez\XML_CEVALDOM_PATH_DEV\prueba.xml
	--- E:\Production\Cevaldom_xml_produccion\Prueba.txt
	SET NOCOUNT ON;
	
	DECLARE @cmd1 nvarchar(4000);
	DECLARE @cmd2 nvarchar(4000);
	DECLARE @sql nvarchar(max);
	DECLARE @year nvarchar(4);
	DECLARE @month nvarchar(4);
	DECLARE @day nvarchar(4);
	DECLARE @hour nvarchar(4);
	DECLARE @minute nvarchar(4);
	DECLARE @second nvarchar(4);
	DECLARE @millisecond nvarchar(4);
	DECLARE @FILENAME nvarchar(100);
	
	SET @year=DATEPART(year, GETDATE());
	SET @month=DATEPART(month,GETDATE());
	SET @day =DATEPART(day,GETDATE());
	--DATEPART(week,GETDATE())
	SET @hour =DATEPART(hour,GETDATE());
	SET @minute =DATEPART(minute,GETDATE());
	SET @second =DATEPART(second,GETDATE());
	SET @millisecond =DATEPART(millisecond,GETDATE());
	SET @FILENAME = 'CEVALDOM'+@year+@month+@day+@hour+@minute+@second+'_MDIN.XML';
	
--Production13	

SET		@cmd1 = 'bcp "SELECT ''<?xml version=""1.0"" encoding=""utf-8""?><SolOperaciones>'' +(SELECT NUMERO_OPERACION AS NUMERO_SOLICITUD,FECHA_TRANSACCION AS FECHA_PACTADA, FECHA_LIQUIDACION ,INDICADOR_OPERACION AS TIPO_SOLICITUD  ,ID_DEPOSITANTE_COMPRADOR  AS DEPOSITANTE_COMPRADOR ,ID_DEPOSITANTE_VENDEDOR AS DEPOSITANTE_VENDEDOR										  ,CODIGO_ISIN  ,CANTIDAD_TITULOS ,PRECIO_PRIMA, IMPORTE_BRUTO,DIAS_PLAZO,	IMPORTE_PLAZO,	PRECIO_PLAZO, OBSERVACIONES FROM SIOPEL_INTERFACE_DB.dbo.vGen_XML_CEVALDOM_FORMAT_1_OTC WHERE DIA=DAY(GETDATE()) AND MES=MONTH(GETDATE()) AND ANIO=YEAR(GETDATE()) AND HORA >=8 AND HORA <15 FOR XML PATH(''SOLOPER''))+''</SolOperaciones>''" queryout "C:\Production\Cevaldom_xml_produccion\'+'FORMATO_1_'+@FILENAME+'" -c -S .\SQL_REPORT_01 -T -c -t,'--'" -T -c -t,'
SET		@cmd2 = 'bcp "SELECT ''<?xml version=""1.0"" encoding=""utf-8""?><SolOperaciones>'' +(SELECT NUMERO_OPERACION AS NUMERO_SOLICITUD,FECHA_TRANSACCION AS FECHA_PACTADA, FECHA_LIQUIDACION ,INDICADOR_OPERACION AS TIPO_SOLICITUD  ,ID_DEPOSITANTE_COMPRADOR  AS DEPOSITANTE_COMPRADOR, ID_DEPOSITANTE_VENDEDOR AS DEPOSITANTE_VENDEDOR, CUENTA_COMPRADOR   ,CUENTA_VENDEDOR   ,CODIGO_ISIN  ,CANTIDAD_TITULOS ,PRECIO_PRIMA, IMPORTE_BRUTO,DIAS_PLAZO,	IMPORTE_PLAZO,	PRECIO_PLAZO, OBSERVACIONES FROM SIOPEL_INTERFACE_DB.dbo.vGen_XML_CEVALDOM_FORMAT_2_OTC WHERE DIA=DAY(GETDATE()) AND MES=MONTH(GETDATE()) AND ANIO=YEAR(GETDATE()) AND HORA >=8 AND HORA <15 FOR XML PATH(''SOLOPER''))+''</SolOperaciones>''" queryout "C:\Production\Cevaldom_xml_produccion\'+'FORMATO_2_'+@FILENAME+'" -c -S .\SQL_REPORT_01 -T -c -t,'-- '" -T -c -t,'

 
-- SELECT * FROM SIOPEL_INTERFACE_DB.dbo.vGen_XML_CEVALDOM_FORMAT_1_OTC

--UNITTesting
EXEC xp_cmdshell @cmd1;
EXEC xp_cmdshell @cmd2;

GO


