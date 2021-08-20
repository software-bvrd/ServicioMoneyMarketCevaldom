USE [DBRD_DB]
GO

TRUNCATE TABLE [siopel_owner].[swoper]
GO 

--- inserto en la tabla [siopel_owner].swoper desde psiopel DBRD_DB.[siopel_owner].swoper

INSERT INTO DBRD_DB[siopel_owner].[swoper]

( clave, CODIGODERE, FECHA, HORA, NUMEROSECU, codigodeti, cupon, numerocupo, plazoopera, moneda, tipo, codigoagen, codigoage2, CANTIDADOP, PRECIOOPER, PRECIOREFE, TOPEBASE, FLOTACION, operaciono, 
  operaciond, PRECIOCIER, rueda, opeorigen, INTERES, estado, TASAOPER, VALORIZACI, modo, memotec, VALORIZAD, ambiente, mercado, nroordenc, codcomic, nroordenv, codcomiv, ofertav, ofertac, tipogiro, dia, mes, anio, hh, 
  mm, ss, VIGENCIAT, INDICADORC, plazovta, atributo, precioidas, agenmm, age2mm, brokeragem, realocada, secopreori, secopre, propia, operador, siespegtia, sicantgtia, siprtagtia, sipteqgtia, nefechemis, nefechvto, neperioint, 
  nemodinter, neperiorei, nemodreinv, netasafaci, nepremio, tasaequinf, nroordeinf, fechaliq, fechaliq2, valorizac2, valodolar2, pata, referencia, descabrev, especieori, cuentacli, NomContInt, NomCustInt, SECOPORVTA, 
  SECOPORCPA, PorcGarant, PorComiLic, TipComiLic, EnteLiq, TextoCpa, TextoVta, MemoTecGen, TituloBCRA, CtaBCRA, CtaBCRA2, ESPECIEGEN, ESPECIE, DIASTRANS, FEPROPACUP, DIPROPACUP, DIASVTOTIT, FEULTCUPON, 
  FECHA2, TIPOLIQ, TipoOrdenC, TipoOrdenV, TipoMerca, CANTOFECPA, CANTOFEVTA, PCIOOFVTA, PCIOOFCPRA, TasaPiso, TasaTecho, 
  --MERCEXTCPA, MERCEXTVTA, NRORDMECPA, NRORDMEVTA, CORREDOR, NECODEMI,ARANCOD1, ARANIMP1, ARANCOD2, ARANIMP2, ARANCOD3, ARANIMP3, CUOTAFONDC, SECOPNOV,
  BoletaEnviada
)

SELECT  clave, CODIGODERE, FECHA, HORA, NUMEROSECU, codigodeti, cupon, numerocupo, plazoopera, moneda, tipo, codigoagen, codigoage2, CANTIDADOP, PRECIOOPER, PRECIOREFE, TOPEBASE, FLOTACION, operaciono, 
                         operaciond, PRECIOCIER, rueda, opeorigen, INTERES, estado, TASAOPER, VALORIZACI, modo, memotec, VALORIZAD, ambiente, mercado, nroordenc, codcomic, nroordenv, codcomiv, ofertav, ofertac, tipogiro, dia, mes, anio, hh, 
                         mm, ss, VIGENCIAT, INDICADORC, plazovta, atributo, precioidas, agenmm, age2mm, brokeragem, realocada, secopreori, secopre, propia, operador, siespegtia, sicantgtia, siprtagtia, sipteqgtia, nefechemis, nefechvto, neperioint, 
                         nemodinter, neperiorei, nemodreinv, netasafaci, nepremio, tasaequinf, nroordeinf, fechaliq, fechaliq2, valorizac2, valodolar2, pata, referencia, descabrev, especieori, cuentacli, NomContInt, NomCustInt, SECOPORVTA, 
                         SECOPORCPA, PorcGarant, PorComiLic, TipComiLic, EnteLiq, TextoCpa, TextoVta, MemoTecGen, TituloBCRA, CtaBCRA, CtaBCRA2, ESPECIEGEN, ESPECIE, DIASTRANS, FEPROPACUP, DIPROPACUP, DIASVTOTIT, FEULTCUPON, 
                         FECHA2, TIPOLIQ, TipoOrdenC, TipoOrdenV, TipoMerca, CANTOFECPA, CANTOFEVTA, PCIOOFVTA, PCIOOFCPRA, TasaPiso, TasaTecho, 
						 -- MERCEXTCPA, MERCEXTVTA, NRORDMECPA, NRORDMEVTA, CORREDOR, NECODEMI, ARANCOD1, ARANIMP1, ARANCOD2, ARANIMP2, ARANCOD3, ARANIMP3, CUOTAFONDC, SECOPNOV ,
						 0 AS  BoletaEnviada
	--  INTO [siopel_owner].[swoper_10022020]
  FROM [LKPSIOPEL2].[DBRD_DB].[siopel_owner].[swoper]


  --------------
  --- inserto en la tabla [siopel_owner].swoper_sync desde psiopel [siopel_owner].swoper

  INSERT INTO [siopel_owner].swoper_sync (clave, CODIGODERE, FECHA, HORA, NUMEROSECU, codigodeti, cupon, numerocupo, plazoopera, moneda, tipo, codigoagen, codigoage2, CANTIDADOP, PRECIOOPER, PRECIOREFE, TOPEBASE, FLOTACION, operaciono,
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
	  FROM [LKPSIOPEL2].[DBRD_DB].[siopel_owner].[swoper]
WHERE FECHA = 200210 AND RUEDA = 'MDIN'
