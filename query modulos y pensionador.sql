DECLARE @nhc int
set @nhc=13045 --completar NHC del paciente

declare @fechaing varchar(20)
set @fechaing='20170523' --completar fecha de ingreso del paciente

--modulos y pensiones que debe apuntar el pensionador

select  thab.tipo_hab_desc,
ser.servicio,
pi.prest_item_desc
 from ingresos ing 
 inner join camas cam on ing.cod_cama=cam.cod_cama
 inner join habitaciones hab on hab.cod_habitacion_pk=cam.cod_habitacion_pk
 inner join tipo_habitacion thab on thab.tipo_hab_pk=hab.tipo_hab_pk
 inner join dias_est_prest dep on ing.codigo_servicio=dep.codigo_Servicio and dep.tipo_hab_pk= (select tipo_hab_pk from habitaciones where cod_habitacion_pk=(select cod_habitacion_pk from camas where cod_cama=(select cod_cama from ingresos where codigo_cliente=(select codigo_cliente from hc where nhc = @nhc) and fecha_ingreso=@fechaing)))
 inner join prest_item pi on pi.prest_item_pk=dep.prest_item_pk
 inner join servicios ser on ser.codigo_servicio=dep.codigo_servicio
 where ing.codigo_cliente=(select codigo_cliente from hc where nhc = @nhc) and ing.fecha_ingreso=@fechaing


--modulos y pensiones apuntados desde el dia de ingreso (modulos que tiene el paciente)
select distinct
det.va_det_des_manual,
det.va_det_fapunte,
det.actividad_pk,
det.va_det_estado
from vale_asis_cab cab
inner join vale_asis_det det on det.va_pk=cab.va_pk
inner join prest_item pi on pi.prest_item_pk=det.prest_item_pk
inner join ingresos ing on ing.codigo_cliente=cab.codigo_cliente
where cab.codigo_cliente = (select codigo_cliente from hc where nhc = @nhc) 
and pi.tipo_item_pk in (9,13) 
and det.va_det_estado <> 0
and det.va_det_fapunte >= @fechaing
and det.prest_item_pk in (select distinct prest_item_pk from dias_est_prest)
order by va_det_fapunte

-- si el paciente tuvo traslados y si el pensionador ya corrio para ese traslado

select distinct ser.servicio,
hab.tipo_hab_desc,
tra.trld_fecha_desde Fecha_Desde,
tra.trld_hora_desde Hora_Desde,
tra.trld_fecha_hasta Fecha_Hasta,
tra.trld_hora_hasta Hora_Hasta,
pi.prest_item_desc,
case when tra.trld_hora_hasta >('1900-01-01 00:59:00.000') and tra.trld_fecha_hasta<=(getdate()-1) then 'Si' else 'No' end as Pensionador
 from traslados tra
inner join servicios ser on ser.codigo_servicio=tra.codigo_servicio
inner join tipo_habitacion hab on hab.tipo_hab_pk=tra.tipo_hab_pk
inner join dias_est_prest dep on dep.codigo_Servicio=tra.codigo_Servicio and dep.tipo_hab_pk=tra.tipo_hab_pk
inner join prest_item pi on pi.prest_item_pk=dep.prest_item_pk
 where cod_ingreso_pk=((select cod_ingreso_pk from ingresos where codigo_cliente = (select codigo_cliente from hc where nhc = @nhc)and fecha_ingreso=@fechaing))