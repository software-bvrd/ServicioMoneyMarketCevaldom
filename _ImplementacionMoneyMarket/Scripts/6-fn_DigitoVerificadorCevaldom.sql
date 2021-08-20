USE [SIOPEL_INTERFACE_DB]
GO
 
ALTER  FUNCTION [dbo].[fn_DigitoVerificadorCevaldom]
(@cadena VARCHAR(8000))
RETURNS NUMERIC
BEGIN

DECLARE @resultado NUMERIC=0
DECLARE @CONTEO INT=1
 
WHILE ( @CONTEO  <= LEN(@cadena) ) -- @CONTEO  
BEGIN
SET @resultado = @resultado + (ASCII(SUBSTRING(@cadena, @CONTEO, 1)) * 13)
SET @CONTEO	   = @CONTEO + 1
END

RETURN    @resultado 
END
GO


 select dbo.fn_DigitoVerificadorCevaldom('CCIBPDBVRD11905212917921/05/201921/05/2019DO8015600125DOP999.999999999.99000')
--  SELECT 	 dbo.fn_DigitoVerificadorCevaldom('ABC')

 -- , * from  ATI01



