Select distinct
	det.va_det_pk,
	cli.apellido1 as 'Apellido1',
	cli.apellido2 as 'Apellido2',
	cli.nombre as 'Nombre',
	epis_pk as 'Encuentro',
	nhc as 'NHC',
	det.va_det_des_manual as 'Prestacion',
	gar.nombre_garante as 'Financiador',
	copa.plan_desc as 'Plan',
	det.va_det_total_fin as 'Precio Financiador',
	det.va_det_total_pac as 'Precio Privado',
	prest.prest_item_cod as 'Codigo Prestacion',
	det.va_det_fapunte as 'Fecha Prestacion',
	det.va_det_hora_Apunte as 'Hora Apunte',
	det.va_det_cantidad as 'Cantidad',
	Case 
		when det.va_det_estado=0 and det.va_det_fact_cob=0 and det.va_det_fact2_cob=0  then 'Anulado'
		when det.va_det_estado=1 and det.va_det_fact_cob=0 and det.va_det_fact2_cob=0  then 'Pendiente' 
		when det.va_det_estado=3 and det.va_det_fact_cob=0 and det.va_det_fact2_cob=0  then 'No Facturable'
		when det.va_det_estado=0 and det.va_det_fact_cob=1 or det.va_det_fact2_cob=1 and det.mot_anul_vale_pk=1  then 'Nota de Credito (Anulado)'
		when det.va_det_estado=1 and det.va_det_fact_cob=0 and det.va_det_fact2_cob=1  then 'Facturado Financiador'
		when det.va_det_estado=1 and det.va_det_fact_cob=1 and det.va_det_fact2_cob=0  then 'Facturado Privado'
	end as Estado,
	Case
		when det.va_det_revisado is null or det.va_det_revisado='0'  then 'No' else 'Si'
	end as Revisado,
	rec.reca_fec_emis as 'Fecha Facturacion',
	CONVERT(varchar(12),rec.reca_gpo_pto_rec,101) + '-' + CONVERT(varchar(12),rec.reca_gpo_nro_rec,101) as 'Numero Factura',
	detp.va_det_des_manual as 'Incluido en',
	detp.va_det_fapunte as 'Fecha Modulo',
	Case
		when det.actividad_pk is null then 'SI' else 'NO'
	end as 'Insercion Manual/Dispensacion Manual',
	Case
		when det.actividad_pk is null then fper.nombre_corto end as 'Usuario Inserta',
	mot.mot_anul_vale_desc as 'Motivo Anulacion',
	Case
		when det.fecha_anul is not null then fpe.nombre_corto end as 'Usuario Anula',
	det.modulo_anul_vale as 'Modulo Anula',
	det.fecha_anul as 'Fecha Anulacion',
	fpenf.nombre_corto as 'Usuario NoFact',
	nofa.vanof_fecha as 'Fecha NoFact',
	nofa.vanof_hora as 'Hora NoFact'
	,det.nro_equipo as 'Caja'
	--,det.va_det_padre
from vale_asis_cab cab
	Inner join vale_asis_det det on det.va_pk=cab.va_pk
	Left join  vale_asis_det detp on det.va_det_padre=detp.va_det_pk
	Inner join clientes cli on cli.codigo_cliente=cab.codigo_cliente
	Inner join prest_item prest on prest.prest_item_pk=det.prest_item_pk
	Left Join mot_anul_vale mot on mot.mot_anul_vale_pk=det.mot_anul_vale_pk
	Left join fpersona fpe on fpe.codigo_personal=det.cod_personal_anul
	Left join fpersona fper on det.cod_perso_registra=fper.codigo_personal
	Inner join hc on cli.codigo_cliente=hc.codigo_cliente
	Left Join vadet_motnofact nofa on nofa.va_det_pk=det.va_det_pk
	Left join fpersona fpenf on nofa.codigo_personal=fpenf.codigo_personal
	left join recibos_det red on red.va_det_pk = det.va_det_pk
	left join recibos_cab rec on rec.reca_pk=red.reca_pk
	inner join co_planes copa on cab.plan_pk=copa.plan_pk
	inner join garantes gar on copa.codigo_garante_pk=gar.codigo_garante_pk
	inner join episodios epis on epis.referencia_id=det.va_det_referencia and epis.tipo_episodio_pk=det.tipo_episodio_pk
	where
       hc.nhc= 90334

	 

	--Anulaci�n de Actividad ( Llamada desde nvuo_actividad_det.uof_anular_apunte_en_va )+ modulo confcita = SE ANULO LA CITA ASOCIADA A ESTA PRESTACION
	  
	--Anulaci�n de Actividad ( Llamada desde nvuo_actividad_det.uof_anular_apunte_en_va )+ modulo bloque_quirurgico = SE ANULO ESTA PRESTACION DESDE LA FICHA

	--Anulaci�n de Actividad ( Llamada desde nvuo_actividad_det.uof_anular_apunte_en_va ) + modulo ingresos = SE HACE UN CAMBIO DE PAGADOR DEL ENCUENTRO Y SE PASAN LOS CARGOS AL NUEVO FINANCIADOR

	--Cambio de Pagador de Vales Pendientes ( llamada desde nvuo_encuentro.uof_cambiar_pagador_vale, que a su vez se llama desde uo_control_facturas de Facturaci�n o desde uo_prest_pago de Caja Convenios  ( consultar campo modulo_anul_vale )  ) + modulo facturacion = SE REALIZO CAMBIO DE PAGADOR DE LA PRESTACION