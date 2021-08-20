USE [DBRD_DB]
GO

/****** Object:  Trigger [siopel_owner].[TR_INSERTA_SWOPER]    Script Date: 21/02/2020 09:24:34 a.m. ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

 

ALTER TRIGGER [siopel_owner].[TR_INSERTA_SWOPER]
ON [siopel_owner].[swoper]
AFTER INSERT
AS
  INSERT INTO ARP01.SIOPEL_INTERFACE_DB.siopel_owner.swoper_sync (clave, CODIGODERE, FECHA, HORA, NUMEROSECU, codigodeti, cupon, numerocupo, plazoopera, moneda, tipo, codigoagen, codigoage2, CANTIDADOP, PRECIOOPER, PRECIOREFE, TOPEBASE, FLOTACION, operaciono,
  operaciond, PRECIOCIER, rueda, opeorigen, INTERES, estado, TASAOPER, VALORIZACI, modo, memotec, VALORIZAD, ambiente, mercado, nroordenc, codcomic, nroordenv, codcomiv, ofertav, ofertac, tipogiro, dia, mes, anio, hh,
  mm, ss, VIGENCIAT, INDICADORC, plazovta, atributo, precioidas, agenmm, age2mm, brokeragem, realocada, secopreori, secopre, propia, operador, siespegtia, sicantgtia, siprtagtia, sipteqgtia, nefechemis, nefechvto, neperioint,
  nemodinter, neperiorei, nemodreinv, netasafaci, nepremio, tasaequinf, nroordeinf, fechaliq, fechaliq2, valorizac2, valodolar2, pata, referencia, descabrev, especieori, cuentacli, NomContInt, NomCustInt, SECOPORVTA,
  SECOPORCPA, PorcGarant, PorComiLic, TipComiLic, EnteLiq, TextoCpa, TextoVta, MemoTecGen, TituloBCRA, CtaBCRA, CtaBCRA2, ESPECIEGEN, ESPECIE, DIASTRANS, FEPROPACUP, DIPROPACUP, DIASVTOTIT, FEULTCUPON,
  FECHA2, TIPOLIQ, TipoOrdenC, TipoOrdenV, TipoMerca, CANTOFECPA, CANTOFEVTA, PCIOOFVTA, PCIOOFCPRA, TasaPiso, TasaTecho)

	  SELECT
clave, CODIGODERE, FECHA, HORA, NUMEROSECU, codigodeti, cupon, numerocupo, plazoopera, moneda, tipo, codigoagen, codigoage2, CANTIDADOP, PRECIOOPER, PRECIOREFE, TOPEBASE, FLOTACION, operaciono,
  operaciond, PRECIOCIER, rueda, opeorigen, INTERES, estado, TASAOPER, VALORIZACI, modo, memotec, VALORIZAD, ambiente, mercado, nroordenc, codcomic, nroordenv, codcomiv, ofertav, ofertac, tipogiro, dia, mes, anio, hh,
  mm, ss, VIGENCIAT, INDICADORC, plazovta, atributo, precioidas, agenmm, age2mm, brokeragem, realocada, secopreori, secopre, propia, operador, siespegtia, sicantgtia, siprtagtia, sipteqgtia, nefechemis, nefechvto, neperioint,
  nemodinter, neperiorei, nemodreinv, netasafaci, nepremio, tasaequinf, nroordeinf, fechaliq, fechaliq2, valorizac2, valodolar2, pata, referencia, descabrev, especieori, cuentacli, NomContInt, NomCustInt, SECOPORVTA,
  SECOPORCPA, PorcGarant, PorComiLic, TipComiLic, EnteLiq, TextoCpa, TextoVta, MemoTecGen, TituloBCRA, CtaBCRA, CtaBCRA2, ESPECIEGEN, ESPECIE, DIASTRANS, FEPROPACUP, DIPROPACUP, DIASVTOTIT, FEULTCUPON,
  FECHA2, TIPOLIQ, TipoOrdenC, TipoOrdenV, TipoMerca, CANTOFECPA, CANTOFEVTA, PCIOOFVTA, PCIOOFCPRA, TasaPiso, TasaTecho
	  --  INTO [siopel_owner].[swoper_10022020]
	  FROM INSERTED 
	  -- FROM [DBRD_DB].[siopel_owner].[swoper]
-- WHERE FECHA = 200210 AND RUEDA = 'MDIN'
GO


