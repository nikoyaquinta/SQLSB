select 
	cli.apellido1,
	cli.apellido2,
	cli.nombre,
	case when vdp.EMBARAZO  =(1) then 'Si' else 'No'  end as 'Embarazo',
	case when vdp.PUERPERA  =(1) then 'Si' else 'No'  end as 'Puerpera',
	aam.art_mc_nom,
	vdp.dosis,
	vdp.fecha1 'Fecha Dosis',
	vdp.fecha_inicio,
	ved.nombre_estado_dosis 'Estado'
	,cen.nombre_centro
	,alm.almacen_deno
	,lote.lotecab_num,
	lote.lotecab_f_cad,
	case when vdp.ADMINISTRACION_EXTERNA  =(1) then 'Si' else 'No'  end as 'Administracion Externa',
	vmo.nom_motivo,
	vld.nombre_loc_dosis
from vacc_dosis_pac vdp
	inner join clientes cli on vdp.codigo_cliente=cli.codigo_cliente
	inner join vacc_estados_dosis ved on ved.estado_dosis_pk=vdp.estado
	left join centros cen on cen.cod_centro=vdp.cod_centro
	left join alm_almacenes alm on alm.almacen_pk=vdp.ALMACEN_PK
	left join alm_lote_cab lote on lote.lotecab_pk=vdp.LOTECAB_PK
	left join alm_articulos_mc aam on aam.cod_art_mc_pk=vdp.COD_ART_MC_PK
	left join vacc_motivos vmo on vmo.cod_motivo=vdp.cod_mot_inclusion
	left join vacc_localizacion_dosis  vld on vld.loc_dosis_pk=vdp.localizacion

	--where cli.apellido1 = 'noto'
	--order by apellido1	