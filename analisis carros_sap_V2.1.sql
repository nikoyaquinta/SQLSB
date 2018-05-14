Declare @fechaDesde smalldatetime
Declare @fechaHasta smalldatetime

Set @fechaDesde = '20180223'
Set @fechaHasta = '20180330'
/*
Almacenes
1			DLA FARMACIA CENTRAL
200			AGT FARMACIA CENTRAL
300			ZBL FARMACIA CENTRAL
400			CENTRAL PUEYRREDON
500			CENTRAL CHARCAS
700			ADS FARMACIA CENTRAL
800			OLV FARMACIA CENTRAL
19001792	VACUNATORIO CENTRAL
*/

Select distinct --top 10000  
	mov_almacen_lin.paciente_pk as 'Codigo_Cliente'
	,hc.nhc
	,clientes.apellido1 + ' ' + ISNULL(clientes.apellido2,'') + ', ' + clientes.nombre	 as 'NombreApellido' 
	,mov_almacen_lin.cod_art_mc_pk
	,alm_articulos_mc.cod_bar_mc_pr 
	,mov_almacen_lin.mov_art_deno
	,alm_almacenes.almacen_pk
	,alm_almacenes.almacen_deno
	,mov_almacen_lin.mov_cab_pk
	,mov_almacen_lin.mov_alma_linpk
	,convert(varchar,mov_almacen_lin.mov_cab_pk) + '-' + CONVERT(varchar,mov_almacen_lin.mov_alma_linpk)  as 'HIS_ItemID'
	,convert(varchar,far_prep_carros.far_ddesde,103) + ' ' + convert(varchar,far_prep_carros.far_hdesde,108) as 'FechaDesdeCarro'
	,convert(varchar,far_prep_carros.far_dhasta,103) + ' ' + convert(varchar,far_prep_carros.far_hhasta,108) as 'FechaHastaCarro'
	,mov_almacen_lin.mov_cantidad as 'CantidadSAP'

	--,convert(varchar,far_det_pac_car.far_detmed_dia,103) + ' ' + convert(varchar,far_det_pac_car.far_detmed_hora,108) as 'FechaOrden'
	--,case when far_det_pac_car.far_detmed_tipo=1 then FORMAT(far_det_pac_car.far_detpaccar_cant, 'N', 'de-de') end as 'Cantidad Carro'
	--,case when far_detmed_tipo=2 then FORMAT(far_det_pac_car.far_detpaccar_cant, 'N', 'de-de') end as 'Cantidad Devuelta'

	,mov_almacen_lin.ref_externa
	,far_detalles_ord.linea_orden_pk
	,far_det_pac_car.far_prep_car_pk
	,far_prep_carros.far_situa
	,mov_tipo_mov.mot_tipo_pk
	,mov_tipo_mov.mot_tipo_deno
	, far_det_pac_car.far_detmed_tipo 
Into #Temp1
from  mov_almacen_cab 
	inner Join mov_almacen_lin  On mov_almacen_cab.mov_cab_pk = mov_almacen_lin.mov_cab_pk
	inner Join far_det_pac_car  On far_det_pac_car.mov_alma_linpk = mov_almacen_lin.mov_alma_linpk 
	left join far_prep_carros on far_prep_carros.far_prep_car_pk=far_det_pac_car.far_prep_car_pk
	left  join far_detalles_ord on far_det_pac_car.linea_orden_pk=far_detalles_ord.linea_orden_pk -- los de carro no tienen linea_orden_pk
	inner join hc hc on mov_almacen_lin.paciente_pk = hc.codigo_cliente
	inner join clientes on clientes.codigo_cliente = hc.codigo_cliente
	inner join mov_tipo_mov on mov_tipo_mov.mot_tipo_pk = mov_almacen_cab.mot_tipo_pk
	inner join alm_almacenes on alm_almacenes.almacen_pk=mov_almacen_cab.almacen_pk
	inner join alm_articulos_mc on alm_articulos_mc.cod_art_mc_pk = mov_almacen_lin.cod_art_mc_pk
Where-- hc.nhc = 2186  and 
--far_det_pac_car.far_detmed_dia between '20180224' and '20180225' 
--mov_almacen_lin.ref_externa = '0000000078496031'  and
--and far_detmed_tipo=2 
--and mov_almacen_cab.mov_cab_pk='56513433'
--and alm_articulos_mc.cod_bar_mc_pr = '1202042'
--and far_prep_carros.far_situa <>1
alm_almacenes.almacen_pk in (1,200,300,400,500,700,800,19001792)
and far_prep_carros.far_ddesde >= @fechaDesde
and far_prep_carros.far_ddesde <= @fechaHasta
and convert(varchar,far_prep_carros.far_ddesde,103) is not null
and hc.activa_sn = 1
--and far_det_pac_car.codigo_cliente=151872
--and far_detalles_ord.linea_orden_pk = 54579736
--and far_det_pac_car.far_prep_car_pk = 54586436

--and mov_almacen_lin.mov_cab_pk = 56330387	
--and mov_almacen_lin.mov_alma_linpk = 56330388
--and mov_almacen_lin.ref_externa like '%77297536'


order by ref_externa




--Query Devuelve las ordenes medicas del paciente, asociado a las tomas que saldran del carro
Select distinct --top 10000  
	mov_almacen_lin.mov_cab_pk
	,mov_almacen_lin.mov_alma_linpk
	,case when far_det_pac_car.far_detmed_tipo=1 then SUM(CEILING(far_det_pac_car.far_detpaccar_cant)) end as 'CantidadCarro'
	,case when far_detmed_tipo=2 then SUM(CEILING(far_det_pac_car.far_detpaccar_cant)) end as 'CantidadDevuelta'
	,mov_almacen_lin.ref_externa
Into #Temp2
from  mov_almacen_cab 
	inner Join mov_almacen_lin  On mov_almacen_cab.mov_cab_pk = mov_almacen_lin.mov_cab_pk
	inner Join far_det_pac_car  On far_det_pac_car.mov_alma_linpk = mov_almacen_lin.mov_alma_linpk 
	left join far_prep_carros on far_prep_carros.far_prep_car_pk=far_det_pac_car.far_prep_car_pk
	left  join far_detalles_ord on far_det_pac_car.linea_orden_pk=far_detalles_ord.linea_orden_pk -- los de carro no tienen linea_orden_pk
	inner join hc hc on mov_almacen_lin.paciente_pk = hc.codigo_cliente
	inner join clientes on clientes.codigo_cliente = hc.codigo_cliente
	inner join mov_tipo_mov on mov_tipo_mov.mot_tipo_pk = mov_almacen_cab.mot_tipo_pk
	inner join alm_almacenes on alm_almacenes.almacen_pk=mov_almacen_cab.almacen_pk
	inner join alm_articulos_mc on alm_articulos_mc.cod_art_mc_pk = mov_almacen_lin.cod_art_mc_pk
Where-- hc.nhc = 2186  and 
--far_det_pac_car.far_detmed_dia between '20180224' and '20180225' 
--mov_almacen_lin.ref_externa = '0000000078496031'  and
--and far_detmed_tipo=2 
--and mov_almacen_cab.mov_cab_pk='56513433'
--and alm_articulos_mc.cod_bar_mc_pr = '1202042'
--and far_prep_carros.far_situa <>1
alm_almacenes.almacen_pk in (1,200,300,400,500,700,800,19001792)
and far_prep_carros.far_ddesde >= @fechaDesde
and far_prep_carros.far_ddesde <= @fechaHasta
and convert(varchar,far_prep_carros.far_ddesde,103) is not null
and hc.activa_sn = 1
--and far_detalles_ord.linea_orden_pk = 54579736
--and far_det_pac_car.far_prep_car_pk = 54586436

--and mov_almacen_lin.mov_cab_pk = 56330387	
--and mov_almacen_lin.mov_alma_linpk = 56330388
--and far_det_pac_car.codigo_cliente=151872
--and mov_almacen_lin.ref_externa like '%77297536'

Group By mov_almacen_lin.mov_cab_pk
	,mov_almacen_lin.mov_alma_linpk
	,mov_almacen_lin.ref_externa
	,far_det_pac_car.far_detmed_tipo
order by ref_externa



Select distinct
	T1.Codigo_Cliente
	,T1.nhc
	,T1.NombreApellido
	,T1.cod_art_mc_pk
	,T1.cod_bar_mc_pr
	,T1.mov_art_deno
	,T1.almacen_pk
	,T1.almacen_deno
	,T1.mov_cab_pk
	,T1.mov_alma_linpk
	,T1.HIS_ItemID
	,T1.FechaDesdeCarro
	,T1.FechaHastaCarro
	--,T1.CantidadSAP
	,Case When T1.far_detmed_tipo = 2 Then Format(CEILING((Convert(int,T1.CantidadSAP) * -1)), 'N', 'de-de')
		Else Format(CEILING(T1.CantidadSAP), 'N', 'de-de') End CantidadSAP
	,Format(CEILING((ISNULL(T2.CantidadCarro,0) - ISNULL(T2.CantidadDevuelta,0))), 'N', 'de-de') as CantidadCarro
	,T2.CantidadCarro
	,T2.CantidadDevuelta
	,T1.ref_externa
	,T1.linea_orden_pk
	,T1.far_prep_car_pk
	,T1.far_situa
	,T1.mot_tipo_pk
	,T1.mot_tipo_deno
	,T1.far_detmed_tipo
	,T1.mov_cab_pk
	,T1.mov_alma_linpk
	
From #temp1 T1
Inner Join #temp2 T2 On T1.mov_cab_pk = T2.mov_cab_pk and T1.mov_alma_linpk = T2.mov_alma_linpk
--Where T1.mov_cab_pk = 57949085
--	And T1.mov_alma_linpk = 57949086


Drop Table #temp1, #temp2

-- Cuando far_detalles_ord.linea_orden_pk is null son dispensaciones manuales
-- Devoluciones no tienen linea_orden_pk a menos que tengan el check O.M en dispensacion medica
/*
--Validar mensaje de Viaduct
Select top 100 * From viaduct_smg..viaduct_log_hist
where /*TimeStamp between '20180307 00:00' and '20180307 23:59'
	and*/ RESPONSEDEST like '%idoc:%0000000078496031%'
 Order By TimeStamp desc


 Select top 100 * From viaduct_smg..VIADUCT_INBOX
 Where MESSAGE like '%VIGUERA%'

 */


