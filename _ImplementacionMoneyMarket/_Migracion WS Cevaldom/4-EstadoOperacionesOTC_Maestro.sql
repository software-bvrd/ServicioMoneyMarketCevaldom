USE [SIOPEL_INTERFACE_DB]
GO

CREATE TABLE [dbo].[EstadoOperacionesOTC_Maestro](
	[PROCESO] [numeric](18, 0) NULL,
	[PARTICIPANTE] [varchar](20) NULL,
	[MECANISMO] [varchar](8) NULL,
	[ARCHIVO] [varchar](50) NULL,
	[CARGA] [varchar](50) NULL,
	[REGISTROS] [numeric](18, 0) NULL,
	[ACEPTADOS] [numeric](18, 0) NULL,
	[RECHAZADOS] [numeric](18, 0) NULL,
	[FECHACREACION] [datetime] NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[EstadoOperacionesOTC_Maestro] ADD  CONSTRAINT [DF_EstadoOperacionesOTC_Maestro_FechaCreacion]  DEFAULT (getdate()) FOR [FECHACREACION]
GO


