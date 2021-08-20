USE [SIOPEL_INTERFACE_DB]
GO

 
CREATE TABLE [siopel_owner].[swoper_sync](
	[clave] [varchar](18) NOT NULL,
	[CODIGODERE] [int] NULL,
	[FECHA] [numeric](10, 0) NULL,
	[HORA] [numeric](10, 0) NULL,
	[NUMEROSECU] [numeric](10, 0) NULL,
	[codigodeti] [varchar](5) NULL,
	[cupon] [varchar](1) NULL,
	[numerocupo] [varchar](3) NULL,
	[plazoopera] [varchar](3) NULL,
	[moneda] [varchar](1) NULL,
	[tipo] [varchar](1) NULL,
	[codigoagen] [varchar](6) NULL,
	[codigoage2] [varchar](6) NULL,
	[CANTIDADOP] [numeric](18, 4) NULL,
	[PRECIOOPER] [numeric](18, 8) NULL,
	[PRECIOREFE] [numeric](18, 8) NULL,
	[TOPEBASE] [numeric](5, 2) NULL,
	[FLOTACION] [numeric](5, 2) NULL,
	[operaciono] [varchar](1) NULL,
	[operaciond] [varchar](1) NULL,
	[PRECIOCIER] [numeric](18, 8) NULL,
	[rueda] [varchar](4) NULL,
	[opeorigen] [varchar](4) NULL,
	[INTERES] [numeric](18, 2) NULL,
	[estado] [varchar](1) NULL,
	[TASAOPER] [numeric](18, 8) NULL,
	[VALORIZACI] [numeric](18, 2) NULL,
	[modo] [varchar](1) NULL,
	[memotec] [varchar](30) NULL,
	[VALORIZAD] [numeric](18, 2) NULL,
	[ambiente] [varchar](2) NULL,
	[mercado] [varchar](1) NULL,
	[nroordenc] [varchar](13) NULL,
	[codcomic] [varchar](18) NULL,
	[nroordenv] [varchar](13) NULL,
	[codcomiv] [varchar](18) NULL,
	[ofertav] [varchar](5) NULL,
	[ofertac] [varchar](5) NULL,
	[tipogiro] [varchar](1) NULL,
	[dia] [varchar](2) NULL,
	[mes] [varchar](2) NULL,
	[anio] [varchar](4) NULL,
	[hh] [varchar](2) NULL,
	[mm] [varchar](2) NULL,
	[ss] [varchar](2) NULL,
	[VIGENCIAT] [int] NULL,
	[INDICADORC] [int] NULL,
	[plazovta] [varchar](3) NULL,
	[atributo] [char](1) NULL,
	[precioidas] [numeric](18, 8) NULL,
	[agenmm] [varchar](3) NULL,
	[age2mm] [varchar](3) NULL,
	[brokeragem] [char](1) NULL,
	[realocada] [bit] NULL,
	[secopreori] [varchar](17) NULL,
	[secopre] [varchar](17) NULL,
	[propia] [bit] NULL,
	[operador] [varchar](2) NULL,
	[siespegtia] [varchar](15) NULL,
	[sicantgtia] [numeric](18, 4) NULL,
	[siprtagtia] [numeric](18, 8) NULL,
	[sipteqgtia] [numeric](18, 8) NULL,
	[nefechemis] [datetime] NULL,
	[nefechvto] [datetime] NULL,
	[neperioint] [varchar](1) NULL,
	[nemodinter] [varchar](1) NULL,
	[neperiorei] [varchar](1) NULL,
	[nemodreinv] [varchar](1) NULL,
	[netasafaci] [numeric](18, 8) NULL,
	[nepremio] [numeric](18, 4) NULL,
	[tasaequinf] [numeric](18, 8) NULL,
	[nroordeinf] [varchar](13) NULL,
	[fechaliq] [datetime] NULL,
	[fechaliq2] [datetime] NULL,
	[valorizac2] [numeric](18, 2) NULL,
	[valodolar2] [numeric](18, 2) NULL,
	[pata] [char](1) NULL,
	[referencia] [varchar](5) NULL,
	[descabrev] [varchar](20) NULL,
	[especieori] [varchar](50) NULL,
	[cuentacli] [varchar](11) NULL,
	[NomContInt] [varchar](11) NULL,
	[NomCustInt] [varchar](11) NULL,
	[SECOPORVTA] [varchar](17) NULL,
	[SECOPORCPA] [varchar](17) NULL,
	[PorcGarant] [numeric](7, 4) NULL,
	[PorComiLic] [numeric](7, 4) NULL,
	[TipComiLic] [char](1) NULL,
	[EnteLiq] [char](1) NULL,
	[Pu] [numeric](18, 8) NULL,
	[ValVol] [numeric](18, 2) NULL,
	[ValVolD] [numeric](18, 2) NULL,
	[SumaVolOpe] [char](1) NULL,
	[TextoCpa] [varchar](100) NULL,
	[TextoVta] [varchar](100) NULL,
	[MemoTecGen] [varchar](30) NULL,
	[TituloBCRA] [varchar](5) NULL,
	[CtaBCRA] [varchar](5) NULL,
	[CtaBCRA2] [varchar](5) NULL,
	[ESPECIEGEN] [varchar](15) NULL,
	[ESPECIE] [varchar](15) NULL,
	[DIASTRANS] [numeric](10, 0) NULL,
	[FEPROPACUP] [datetime] NULL,
	[DIPROPACUP] [numeric](10, 0) NULL,
	[DIASVTOTIT] [numeric](10, 0) NULL,
	[FEULTCUPON] [datetime] NULL,
	[FECHA2] [datetime] NULL,
	[TIPOLIQ] [varchar](1) NULL,
	[TipoOrdenC] [varchar](1) NULL,
	[TipoOrdenV] [varchar](1) NULL,
	[TipoMerca] [varchar](1) NULL,
	[CANTOFECPA] [numeric](18, 4) NULL,
	[CANTOFEVTA] [numeric](18, 4) NULL,
	[PCIOOFVTA] [numeric](18, 8) NULL,
	[PCIOOFCPRA] [numeric](18, 8) NULL,
	[TasaPiso] [numeric](18, 8) NULL,
	[TasaTecho] [numeric](18, 8) NULL,
	[ENVIADO] [int] NULL
) ON [PRIMARY]
GO

ALTER TABLE [siopel_owner].[swoper_sync] ADD  CONSTRAINT [DF_swoper_sync_ENVIADO_1]  DEFAULT ((0)) FOR [ENVIADO]
GO

