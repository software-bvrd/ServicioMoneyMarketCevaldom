USE [SIOPEL_INTERFACE_DB]
GO

 

CREATE TABLE [dbo].[Tipo_Solicitudes_OTCCevaldom](
	[TipoCevaldom] [numeric](18, 0) NOT NULL,
	[Descripcion] [varchar](100) NOT NULL,
	[TipoMercado] [varchar](5) NULL
) ON [PRIMARY]
GO


