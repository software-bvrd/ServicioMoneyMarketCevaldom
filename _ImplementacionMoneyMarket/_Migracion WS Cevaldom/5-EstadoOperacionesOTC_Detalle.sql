USE [SIOPEL_INTERFACE_DB]
GO

 
CREATE TABLE [dbo].[EstadoOperacionesOTC_Detalle](
	[PROCESO] [numeric](18, 0) NULL,
	[REFERENCIA] [varchar](30) NULL,
	[FECHA] [varchar](50) NULL,
	[OPERACION] [numeric](18, 0) NULL,
	[ISIN] [varchar](12) NULL,
	[LINEA] [numeric](18, 0) NULL,
	[CAMPO] [varchar](30) NULL,
	[DESCRIPCION] [varchar](150) NULL,
	[FECHACREACION] [datetime] NULL,
	[ESTADO] [varchar](5) NULL,
	[VENDEDOR] [varchar](150) NULL,
	[COMPRADOR] [varchar](150) NULL,
	[MECANISMO] [varchar](20) NULL,
	[MODALIDAD] [varchar](5) NULL,
	[PACTADA] [varchar](10) NULL,
	[VERIFICADOR] [numeric](18, 0) NULL,
	[SOLICITUD] [numeric](18, 0) NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[EstadoOperacionesOTC_Detalle] ADD  CONSTRAINT [DF_EstadoOperacionesOTC_Detalle_FechaCreacion]  DEFAULT (getdate()) FOR [FECHACREACION]
GO


