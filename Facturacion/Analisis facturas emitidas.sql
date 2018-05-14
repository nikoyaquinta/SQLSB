--select top 10000 * from recibos_cab where reca_pk_anulado = 74054 --nc asociadas a esa factura

--74054
--reca_gpo_pto_rec ='1702A' and reca_gpo_nro_rec = '814'

--select * from recibos_cab where reca_pk = 74054 and rcbd_reint_sn is null

--Numero de Factura sin 0000
Declare @nfact1 varchar(15)
set @nfact1 ='1702A'
Declare @nfact2 varchar(15)
set @nfact2 ='814'
Declare @nfact3 varchar (20)
set @nfact3 = (select reca_pk from recibos_cab where reca_gpo_pto_rec =@nfact1 and reca_gpo_nro_rec = @nfact2 )


-- Cabecera de la factura
select 
recibos_cab.reca_pk,
CONVERT(varchar(12),recibos_cab.reca_gpo_pto_rec,101) + '-' + CONVERT(varchar(12),recibos_cab.reca_gpo_nro_rec,101) as 'Nro Factura',
recibos_cab.reca_fec_emis as 'Fecha Emision',
recibos_cab.reca_cliente as 'Cliente',
recibos_cab.reca_importe_tot as 'Importe Total Factura',
recibos_cab.reca_abonoporc as 'Porcentaje Abonado (Nota Credito)',
recibos_cab.reca_conta_prefact as 'Nro de Pre-Factura SAP',
fpersona.apellido1 + ' ' + isnull(fpersona.apellido2,'') + ' ' + fpersona.nombre as 'Usuario Emite'
	from recibos_cab
	inner join fpersona on fpersona.codigo_personal=recibos_cab.codigo_personal
	where reca_gpo_pto_rec =@nfact1 and reca_gpo_nro_rec = @nfact2


-- Detalle de la Factura
select distinct 
	recibos_det.va_det_pk,
	prest_item.prest_item_desc as 'Prestacion',
	vale_asis_det.va_det_fapunte as 'Fecha Apunte', 
	prest_grupo.prest_grupo_desc as 'Grupo Administrativo',
	recibos_det.rcbd_total as 'Monto',
	recibos_det.rcbd_cantidad as 'Cantidad',
	clientes.apellido1 + ' ' + isnull(clientes.apellido2,'') + ' ' + clientes.nombre as 'Paciente',
	case
		when recibos_det.rcbd_abonoporc is null then 'No' else 'Si' end as 'Abonado',
	isnull(recibos_det.rcbd_abonoporc,'00.00') as 'Porcentaje Abonado'
	from recibos_det
	inner join clientes on clientes.codigo_cliente=recibos_det.codigo_cliente
	inner join prest_item on prest_item.prest_item_cod=recibos_det.rcbd_codprest_dicc
	inner join prest_grupo on prest_grupo.prest_grupo_pk=recibos_det.prest_grupo_pk
	inner join vale_asis_det on vale_asis_det.va_det_pk=recibos_det.va_det_pk
	where recibos_det.reca_pk=@nfact3


-- Notas de Credito
select 
recibos_cab.reca_pk,
CONVERT(varchar(12),recibos_cab.reca_gpo_pto_rec,101) + '-' + CONVERT(varchar(12),recibos_cab.reca_gpo_nro_rec,101) as 'Nro NC',
recibos_cab.reca_fec_emis as 'Fecha Emision',
recibos_cab.reca_cliente as 'Cliente',
recibos_cab.reca_importe_tot as 'Importe NC',
recibos_cab.reca_conta_prefact as 'Nro de Pre-Factura SAP',
fpersona.apellido1 + ' ' + isnull(fpersona.apellido2,'') + ' ' + fpersona.nombre as 'Usuario Emite'
	from recibos_cab
	inner join fpersona on fpersona.codigo_personal=recibos_cab.codigo_personal
	where reca_pk_anulado = @nfact3


