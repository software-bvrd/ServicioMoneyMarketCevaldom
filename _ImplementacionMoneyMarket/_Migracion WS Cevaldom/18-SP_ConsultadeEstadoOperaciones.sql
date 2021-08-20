USE [SIOPEL_INTERFACE_DB]
GO

 
CREATE PROCEDURE [dbo].[SP_ConsultadeEstadoOperaciones]
      @SqlWhere AS VARCHAR(MAX)
as
DECLARE @SQL VARCHAR(MAX);
SELECT
	@SQL = ' SELECT * FROM V_OPERACIONES_ESTADO  '
SELECT
	@SQL = @SQL + ' WHERE ' + @SqlWhere;
SELECT
	@SQL = @SQL + ' ORDER BY FechaCreacion DESC';
EXECUTE (@SQL);

GO


