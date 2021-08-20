INSERT INTO DBRD_DB.siopel_owner.agentes (agente, mercado, corta, deno, resp, dir, loc, cp, tel, fax, tipo, estado, ambienteshab, ambiente, condicioniva, cuit, ch, estadoxcuenta, estadootc, puestos, monedalimites, apellido, posicionpropia, posicionterceros, username,
operacionescruzadas, tipodedocumento, nrodocumento, digitoverificador, limitespordemanda, posicioncarteras, eliminarOfersPosPropia, CuentaBCRA-- ,AmbientesNego, Grupo, PosicionEnTiempoReal, RecibeNovaciones
)
	SELECT
		agente
	   ,mercado
	   ,corta
	   ,deno
	   ,resp
	   ,dir
	   ,loc
	   ,cp
	   ,tel
	   ,fax
	   ,tipo
	   ,estado
	   ,ambienteshab
	   ,ambiente
	   ,condicioniva
	   ,cuit
	   ,ch
	   ,estadoxcuenta
	   ,estadootc
	   ,puestos
	   ,monedalimites
	   ,apellido
	   ,posicionpropia
	   ,posicionterceros
	   ,username
	   ,operacionescruzadas
	   ,tipodedocumento
	   ,nrodocumento
	   ,digitoverificador
	   ,limitespordemanda
	   ,posicioncarteras
	   ,eliminarOfersPosPropia
	   ,CuentaBCRA--, AmbientesNego, Grupo, PosicionEnTiempoReal, RecibeNovaciones
	FROM LKPSIOPEL2.[DBRD_DB].[siopel_owner].[agentes]
	WHERE agente NOT IN (SELECT
			agente
		FROM DBRD_DB.siopel_owner.agentes)
	ORDER BY agente
