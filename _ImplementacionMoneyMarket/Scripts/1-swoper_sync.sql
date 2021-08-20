USE [SIOPEL_INTERFACE_DB]
GO
 
CREATE TABLE [siopel_owner].[swoper_sync](
	[clave] [varchar](16) NOT NULL,
	[CODIGODERE] [int] NULL,
	[FECHA] [decimal](10, 0) NULL,
	[HORA] [decimal](10, 0) NULL,
	[NUMEROSECU] [decimal](10, 0) NULL,
	[codigodeti] [varchar](5) NULL,
	[cupon] [varchar](1) NULL,
	[numerocupo] [varchar](3) NULL,
	[plazoopera] [varchar](3) NULL,
	[moneda] [varchar](1) NULL,
	[tipo] [varchar](1) NULL,
	[codigoagen] [varchar](6) NULL,
	[codigoage2] [varchar](6) NULL,
	[CANTIDADOP] [decimal](18, 4) NULL,
	[PRECIOOPER] [decimal](18, 8) NULL,
	[PRECIOREFE] [decimal](18, 8) NULL,
	[TOPEBASE] [decimal](5, 2) NULL,
	[FLOTACION] [decimal](5, 2) NULL,
	[operaciono] [varchar](1) NULL,
	[operaciond] [varchar](1) NULL,
	[PRECIOCIER] [decimal](18, 8) NULL,
	[rueda] [varchar](4) NULL,
	[opeorigen] [varchar](4) NULL,
	[INTERES] [decimal](18, 2) NULL,
	[estado] [varchar](1) NULL,
	[TASAOPER] [decimal](18, 8) NULL,
	[VALORIZACI] [decimal](18, 2) NULL,
	[modo] [varchar](1) NULL,
	[memotec] [varchar](30) NULL,
	[VALORIZAD] [decimal](18, 2) NULL,
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
	[precioidas] [decimal](18, 8) NULL,
	[agenmm] [varchar](3) NULL,
	[age2mm] [varchar](3) NULL,
	[brokeragem] [char](1) NULL,
	[realocada] [bit] NULL,
	[secopreori] [varchar](11) NULL,
	[secopre] [varchar](11) NULL,
	[propia] [bit] NULL,
	[operador] [varchar](2) NULL,
	[siespegtia] [varchar](15) NULL,
	[sicantgtia] [decimal](18, 4) NULL,
	[siprtagtia] [decimal](18, 8) NULL,
	[sipteqgtia] [decimal](18, 8) NULL,
	[nefechemis] [datetime] NULL,
	[nefechvto] [datetime] NULL,
	[neperioint] [varchar](1) NULL,
	[nemodinter] [varchar](1) NULL,
	[neperiorei] [varchar](1) NULL,
	[nemodreinv] [varchar](1) NULL,
	[netasafaci] [decimal](18, 8) NULL,
	[nepremio] [decimal](18, 4) NULL,
	[tasaequinf] [decimal](18, 8) NULL,
	[nroordeinf] [varchar](13) NULL,
	[fechaliq] [datetime] NULL,
	[fechaliq2] [datetime] NULL,
	[valorizac2] [decimal](18, 2) NULL,
	[valodolar2] [decimal](18, 2) NULL,
	[pata] [char](1) NULL,
	[referencia] [varchar](5) NULL,
	[descabrev] [varchar](20) NULL,
	[especieori] [varchar](50) NULL,
	[cuentacli] [varchar](11) NULL,
	[NomContInt] [varchar](11) NULL,
	[NomCustInt] [varchar](11) NULL,
	[SECOPORVTA] [varchar](17) NULL,
	[SECOPORCPA] [varchar](17) NULL,
	[PorcGarant] [decimal](7, 4) NULL,
	[PorComiLic] [decimal](7, 4) NULL,
	[TipComiLic] [char](1) NULL,
	[EnteLiq] [char](1) NULL,
	[Pu] [decimal](18, 8) NULL,
	[ValVol] [decimal](18, 2) NULL,
	[ValVolD] [decimal](18, 2) NULL,
	[SumaVolOpe] [char](1) NULL,
	[TextoCpa] [varchar](100) NULL,
	[TextoVta] [varchar](100) NULL,
	[MemoTecGen] [varchar](30) NULL,
	[TituloBCRA] [varchar](5) NULL,
	[CtaBCRA] [varchar](5) NULL,
	[CtaBCRA2] [varchar](5) NULL,
	[ESPECIEGEN] [varchar](15) NULL,
	[ESPECIE] [varchar](15) NULL,
	[DIASTRANS] [decimal](10, 0) NULL,
	[FEPROPACUP] [datetime] NULL,
	[DIPROPACUP] [decimal](10, 0) NULL,
	[DIASVTOTIT] [decimal](10, 0) NULL,
	[FEULTCUPON] [datetime] NULL,
	[FECHA2] [datetime] NULL,
	[TIPOLIQ] [varchar](1) NULL,
	[TipoOrdenC] [varchar](1) NULL,
	[TipoOrdenV] [varchar](1) NULL,
	[TipoMerca] [varchar](1) NULL,
	[CANTOFECPA] [decimal](18, 4) NULL,
	[CANTOFEVTA] [decimal](18, 4) NULL,
	[PCIOOFVTA] [decimal](18, 8) NULL,
	[PCIOOFCPRA] [decimal](18, 8) NULL,
	[TasaPiso] [decimal](18, 8) NULL,
	[TasaTecho] [decimal](18, 8) NULL,
	[ENVIADO] [int] NULL,
 CONSTRAINT [pk_swoper1] PRIMARY KEY CLUSTERED 
(
	[clave] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [siopel_owner].[swoper_sync1] ADD  DEFAULT ((0)) FOR [ENVIADO]
GO

