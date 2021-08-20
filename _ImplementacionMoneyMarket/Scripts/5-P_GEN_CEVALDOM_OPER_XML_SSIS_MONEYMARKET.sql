USE SIOPEL_INTERFACE_DB
GO

--ALTER  PROCEDURE P_GEN_CEVALDOM_OPER_XML_SSIS_MONEYMARKET
--AS
--BEGIN
DECLARE @cmd1 nvarchar(4000)
DECLARE @FILENAME nvarchar(100) = 'MONEYMARKET.XML'
DECLARE @CANT_REGISTROS AS NUMERIC(36)
DECLARE @message as varchar(2000)

SET @CANT_REGISTROS = (SELECT COUNT(*) FROM SIOPEL_INTERFACE_DB.dbo.vGen_XML_CEVALDOM_FORMAT_MONEYMARKET /* WHERE DIA=DAY(GETDATE()) AND MES=MONTH(GETDATE()) AND ANIO=YEAR(GETDATE())*/ )

SELECT @CANT_REGISTROS

IF (@CANT_REGISTROS >0)
	BEGIN
	-- GENERO EL XML DE LAS OPERACIONES MONEY MARKET
	-- CAMBIAR CUANDO SE PASE A PRODUCCION E:\PRODUCTION\CEVALDOM_XML_PRODUCCION\
	--SET @CMD1 = 'BCP "SELECT ''<?XML VERSION=""1.0"" ENCODING=""UTF-8""?><FILE>'' +(SELECT NUMERO_OPERACION,ID_CONSECUTIVO_OPERACION ,FECHA_TRANSACCION ,FECHA_LIQUIDACION ,INDICADOR_OPERACION  ,ID_DEPOSITANTE_COMPRADOR  ,ID_DEPOSITANTE_VENDEDOR ,ID_MONEDA_EMISION   ,ID_MONEDA_LIQUIDACION ,CODIGO_ISIN,CANTIDAD_TITULOS ,PRECIO_PRIMA ,TIPO_CAMBIO  ,IMPORTE_BRUTO FROM SIOPEL_INTERFACE_DB.DBO.VGEN_XML_CEVALDOM_FORMAT_MONEYMARKET WHERE DIA=DAY(GETDATE()) AND MES=MONTH(GETDATE()) AND ANIO=YEAR(GETDATE()) FOR XML PATH(''OPERBVRD''))+''</FILE>''" QUERYOUT "C:\PRODUCTION\CEVALDOM_XML_PRODUCCION\' + 'FORMATO_1_' + @FILENAME + '" -T -C -T,'
	SET @CMD1 = 'BCP "SELECT ''<?XML VERSION=""1.0"" ENCODING=""UTF-8""?><FILE>'' +(SELECT NUMERO_OPERACION,ID_CONSECUTIVO_OPERACION ,FECHA_TRANSACCION ,FECHA_LIQUIDACION ,INDICADOR_OPERACION  ,ID_DEPOSITANTE_COMPRADOR  ,ID_DEPOSITANTE_VENDEDOR ,ID_MONEDA_EMISION   ,ID_MONEDA_LIQUIDACION ,CODIGO_ISIN,CANTIDAD_TITULOS ,PRECIO_PRIMA ,TIPO_CAMBIO  ,IMPORTE_BRUTO FROM SIOPEL_INTERFACE_DB.DBO.VGEN_XML_CEVALDOM_FORMAT_MONEYMARKET /*WHERE DIA=DAY(GETDATE()) AND MES=MONTH(GETDATE()) AND ANIO=YEAR(GETDATE())*/ FOR XML PATH(''OPERBVRD''))+''</FILE>''" QUERYOUT "C:\PRODUCTION\CEVALDOM_XML_PRODUCCION\' + 'FORMATO_1_' + @FILENAME +'" -c -S .\SQL_REPORT_01 -T -c -t,'
	
	EXEC XP_CMDSHELL @CMD1;

	-- ENVIO UN CORREO A OPERACIONES PARA QUE SEPAN QUE EXISTE UN ARCHIVO NUEVO PARA SUBIR A CEVALDOM
		SET @message = ' <h2>A continuación la consolidación de las operaciones del día de MONEY MARKET.</h2></br>
		<p>Los datos en la siguiente tabla corresponden al total de las operaciones del día hasta el momento.</p>		
		<style>
		table.GeneratedTable {
		  width: 100%;
		  background-color: #ffffff;
		  border-collapse: collapse;
		  border-width: 2px;
		  border-color: #5189e6;
		  border-style: solid;
		  color: #000000;
		}

		table.GeneratedTable td, table.GeneratedTable th {
		  border-width: 2px;
		  border-color: #5189e6;
		  border-style: solid;
		  padding: 3px;
		}

		table.GeneratedTable thead {
		  background-color: #5189e6;
		}
		</style>
		<table class="GeneratedTable">
		  <thead>
			<tr>
			  <th>Operaciones MONEY MARKET</th> 
			</tr>
		  </thead>
		  <tbody>
			<tr>
			  <td>' + CONVERT(VARCHAR, @CANT_REGISTROS) + '</td> 
			</tr>   
		  </tbody>
		</table>';

		EXEC msdb.dbo.sp_send_dbmail @profile_name = 'Notifications'
									--,@recipients = 'consolidacionop@bvrd.com.do'
									,@recipients = 'mcastillo@bvrd.com.do'									
									,@subject = 'Operaciones MONEY MARKET'
									,@body = @message
									,@body_format = 'html';
		UPDATE siopel_owner.swoper_sync SET ENVIADO =1 WHERE ENVIADO =0
	END
--END

GO

-- UPDATE siopel_owner.swoper_sync SET ENVIADO = 0
SELECT *  FROM SIOPEL_INTERFACE_DB.dbo.vGen_XML_CEVALDOM_FORMAT_MONEYMARKET