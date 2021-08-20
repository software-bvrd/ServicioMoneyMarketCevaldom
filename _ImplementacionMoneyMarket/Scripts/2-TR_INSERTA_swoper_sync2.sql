INSERT INTO SIOPEL_INTERFACE_DB.siopel_owner.swoper_sync (clave
, CODIGODERE
, FECHA
, HORA
, NUMEROSECU
, codigodeti
, cupon
, numerocupo
, plazoopera
, moneda
, tipo
, codigoagen
, codigoage2
, CANTIDADOP
, PRECIOOPER
, PRECIOREFE
, TOPEBASE
, FLOTACION
, operaciono
, operaciond
, PRECIOCIER
, rueda
, opeorigen
, INTERES
, estado
, TASAOPER
, VALORIZACI
, modo
, memotec
, VALORIZAD
, ambiente
, mercado
, nroordenc
, codcomic
, nroordenv
, codcomiv
, ofertav
, ofertac
, tipogiro
, dia
, mes
, anio
, hh
, mm
, ss
, VIGENCIAT
, INDICADORC
, plazovta
, atributo
, precioidas
, agenmm
, age2mm
, brokeragem
, realocada
, secopreori
, secopre
, propia
, operador
, siespegtia
, sicantgtia
, siprtagtia
, sipteqgtia
, nefechemis
, nefechvto
, neperioint
, nemodinter
, neperiorei
, nemodreinv
, netasafaci
, nepremio
, tasaequinf
, nroordeinf
, fechaliq
, fechaliq2
, valorizac2
, valodolar2
, pata
, referencia
, descabrev
, especieori
, cuentacli
, NomContInt
, NomCustInt
, SECOPORVTA
, SECOPORCPA
, PorcGarant
, PorComiLic
, TipComiLic
, EnteLiq
, Pu
, ValVol
, ValVolD
, SumaVolOpe
, TextoCpa
, TextoVta
, MemoTecGen
, TituloBCRA
, CtaBCRA
, CtaBCRA2
, ESPECIEGEN
, ESPECIE
, DIASTRANS
, FEPROPACUP
, DIPROPACUP
, DIASVTOTIT
, FEULTCUPON
, FECHA2
, TIPOLIQ
, TipoOrdenC
, TipoOrdenV
, TipoMerca
, CANTOFECPA
, CANTOFEVTA
, PCIOOFVTA
, PCIOOFCPRA
, TasaPiso
, TasaTecho)

	SELECT
		clave
	   ,CODIGODERE
	   ,FECHA
	   ,HORA
	   ,NUMEROSECU
	   ,codigodeti
	   ,cupon
	   ,numerocupo
	   ,plazoopera
	   ,moneda
	   ,tipo
	   ,codigoagen
	   ,codigoage2
	   ,CANTIDADOP
	   ,PRECIOOPER
	   ,PRECIOREFE
	   ,TOPEBASE
	   ,FLOTACION
	   ,operaciono
	   ,operaciond
	   ,PRECIOCIER
	   ,rueda
	   ,opeorigen
	   ,INTERES
	   ,estado
	   ,TASAOPER
	   ,VALORIZACI
	   ,modo
	   ,memotec
	   ,VALORIZAD
	   ,ambiente
	   ,mercado
	   ,nroordenc
	   ,codcomic
	   ,nroordenv
	   ,codcomiv
	   ,ofertav
	   ,ofertac
	   ,tipogiro
	   ,dia
	   ,mes
	   ,anio
	   ,hh
	   ,mm
	   ,ss
	   ,VIGENCIAT
	   ,INDICADORC
	   ,plazovta
	   ,atributo
	   ,precioidas
	   ,agenmm
	   ,age2mm
	   ,brokeragem
	   ,realocada
	   ,secopreori
	   ,secopre
	   ,propia
	   ,operador
	   ,siespegtia
	   ,sicantgtia
	   ,siprtagtia
	   ,sipteqgtia
	   ,nefechemis
	   ,nefechvto
	   ,neperioint
	   ,nemodinter
	   ,neperiorei
	   ,nemodreinv
	   ,netasafaci
	   ,nepremio
	   ,tasaequinf
	   ,nroordeinf
	   ,fechaliq
	   ,fechaliq2
	   ,valorizac2
	   ,valodolar2
	   ,pata
	   ,referencia
	   ,descabrev
	   ,especieori
	   ,cuentacli
	   ,NomContInt
	   ,NomCustInt
	   ,SECOPORVTA
	   ,SECOPORCPA
	   ,PorcGarant
	   ,PorComiLic
	   ,TipComiLic
	   ,EnteLiq
	   ,Pu
	   ,ValVol
	   ,ValVolD
	   ,SumaVolOpe
	   ,TextoCpa
	   ,TextoVta
	   ,MemoTecGen
	   ,TituloBCRA
	   ,CtaBCRA
	   ,CtaBCRA2
	   ,ESPECIEGEN
	   ,ESPECIE
	   ,DIASTRANS
	   ,FEPROPACUP
	   ,DIPROPACUP
	   ,DIASVTOTIT
	   ,FEULTCUPON
	   ,FECHA2
	   ,TIPOLIQ
	   ,TipoOrdenC
	   ,TipoOrdenV
	   ,TipoMerca
	   ,CANTOFECPA
	   ,CANTOFEVTA
	   ,PCIOOFVTA
	   ,PCIOOFCPRA
	   ,TasaPiso
	   ,TasaTecho
	FROM [ADB03].DBRD_DB.siopel_owner.swoper
	WHERE FECHA = '200207'
	ORDER BY FECHA DESC


-----------------------------------------
INSERT INTO SIOPEL_INTERFACE_DB.siopel_owner.swoper (clave, CODIGODERE, FECHA, HORA, NUMEROSECU, codigodeti, cupon, numerocupo, plazoopera, moneda, tipo, codigoagen, codigoage2, CANTIDADOP, PRECIOOPER, PRECIOREFE, TOPEBASE, FLOTACION, operaciono,
operaciond, PRECIOCIER, rueda, opeorigen, INTERES, estado, TASAOPER, VALORIZACI, modo, memotec, VALORIZAD, ambiente, mercado, nroordenc, codcomic, nroordenv, codcomiv, ofertav, ofertac, tipogiro, dia, mes, anio, hh,
mm, ss, VIGENCIAT, INDICADORC, plazovta, atributo, precioidas, agenmm, age2mm, brokeragem, realocada, secopreori, secopre, propia, operador, siespegtia, sicantgtia, siprtagtia, sipteqgtia, nefechemis, nefechvto, neperioint,
nemodinter, neperiorei, nemodreinv, netasafaci, nepremio, tasaequinf, nroordeinf, fechaliq, fechaliq2, valorizac2, valodolar2, pata, referencia, descabrev, especieori, cuentacli, NomContInt, NomCustInt, SECOPORVTA,
SECOPORCPA, PorcGarant, PorComiLic, TipComiLic, EnteLiq, TextoCpa, TextoVta, MemoTecGen, TituloBCRA, CtaBCRA, CtaBCRA2, ESPECIEGEN, ESPECIE, DIASTRANS, FEPROPACUP, DIPROPACUP, DIASVTOTIT, FEULTCUPON,
FECHA2, TIPOLIQ, TipoOrdenC, TipoOrdenV, TipoMerca, CANTOFECPA, CANTOFEVTA, PCIOOFVTA, PCIOOFCPRA, TasaPiso, TasaTecho, 
-- MERCEXTCPA, MERCEXTVTA, NRORDMECPA, NRORDMEVTA, CORREDOR, NECODEMI,ARANCOD1, ARANIMP1, ARANCOD2, ARANIMP2, ARANCOD3, ARANIMP3, CUOTAFONDC, SECOPNOV, 
Pu, ValVol, ValVolD, SumaVolOpe, NROSEC06, INDACC06, BAJA06, OPEVINC06, FECOFV06, HORAOFV06, FECOFC06,
HORAOFC06, PUCALCU06, FEOPORI06, AGREDVC06, AGREDIDO06, HORA06, FECHA06, HORAMINUTO, MNEMOTE06)

SELECT
clave, CODIGODERE, FECHA, HORA, NUMEROSECU, codigodeti, cupon, numerocupo, plazoopera, moneda, tipo, codigoagen, codigoage2, CANTIDADOP, PRECIOOPER, PRECIOREFE, TOPEBASE, FLOTACION, operaciono,
operaciond, PRECIOCIER, rueda, opeorigen, INTERES, estado, TASAOPER, VALORIZACI, modo, memotec, VALORIZAD, ambiente, mercado, nroordenc, codcomic, nroordenv, codcomiv, ofertav, ofertac, tipogiro, dia, mes, anio, hh,
mm, ss, VIGENCIAT, INDICADORC, plazovta, atributo, precioidas, agenmm, age2mm, brokeragem, realocada, secopreori, secopre, propia, operador, siespegtia, sicantgtia, siprtagtia, sipteqgtia, nefechemis, nefechvto, neperioint,
nemodinter, neperiorei, nemodreinv, netasafaci, nepremio, tasaequinf, nroordeinf, fechaliq, fechaliq2, valorizac2, valodolar2, pata, referencia, descabrev, especieori, cuentacli, NomContInt, NomCustInt, SECOPORVTA,
SECOPORCPA, PorcGarant, PorComiLic, TipComiLic, EnteLiq, TextoCpa, TextoVta, MemoTecGen, TituloBCRA, CtaBCRA, CtaBCRA2, ESPECIEGEN, ESPECIE, DIASTRANS, FEPROPACUP, DIPROPACUP, DIASVTOTIT, FEULTCUPON,
FECHA2, TIPOLIQ, TipoOrdenC, TipoOrdenV, TipoMerca, CANTOFECPA, CANTOFEVTA, PCIOOFVTA, PCIOOFCPRA, TasaPiso, TasaTecho, 
MERCEXTCPA, MERCEXTVTA, NRORDMECPA, NRORDMEVTA, CORREDOR, NECODEMI, ARANCOD1, ARANIMP1, ARANCOD2, ARANIMP2, ARANCOD3, ARANIMP3, CUOTAFONDC, SECOPNOV, 
Pu, ValVol, ValVolD, SumaVolOpe, NROSEC06, INDACC06, BAJA06, OPEVINC06, FECOFV06, HORAOFV06, FECOFC06,
HORAOFC06, PUCALCU06, FEOPORI06, AGREDVC06, AGREDIDO06, HORA06, FECHA06, HORAMINUTO, MNEMOTE06
into DBRD_DB.siopel_owner.swoper 
FROM [ADB03].DBRD_DB.siopel_owner.swoper 
WHERE FECHA >'190328'
