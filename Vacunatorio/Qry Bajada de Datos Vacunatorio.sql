/*			BAJADA DE DATOS MAESTROS VACUNATORIO			*/

--	Select Column_name + ',' from information_schema.columns where table_name = 'vacc_motivos'
--	Select Table_name + ',' from information_schema.columns where column_name like '%calendar_vac%' order by 1


/*		GENERICOS		*/
Select catp_arti_nom, catp_articulos_pk from catp_articulos

/*		PRESTACIONES	*/
Select prest_item_desc,prest_item_pk From prest_item


/*		VACUNAS			*/
Select cod_vacuna,nom_vacuna,contraindicacion,cod_aux,activo_sn,lim_edad_inf,lim_edad_sup,dias_aviso_post,autorizacion,V.item_protocolo_sn,P.prest_item_desc, V.prest_item_pk, C.catp_arti_nom, V.CATP_ARTICULOS_PK
from vacc_vacunas v 
	Left Join catp_articulos C On V.catp_articulos_pk = C.catp_articulos_pk
	Left Join prest_item P On V.prest_item_pk = P.prest_item_pk
Order By 1

Select Top 1 * from prest_item

/*		Calendario de Vacunas		*/

Select * from vacc_calendarios

/*		Relación entre vacunas y calendarios		*/

Select CV.calendar_vac_pk,
		VC.nom_calendario,
		CV.cod_calendario,
		V.nom_vacuna,
		CV.cod_vacuna, CV.offset_inicio_dos1,
		case when unid_offset_inicio = 30 then 'Meses' else 'Años' End as 'unid_offset_inicio',
		CV.unid_offset_inicio,CV.offset_fin_dos1,
		case when unid_offset_fin = 30 then 'Meses' else 'Años' End as 'unid_offset_fin',
		CV.unid_offset_fin,CV.activo_sn,CV.orden,CV.aux
from vacc_calendar_vac CV
	Left join vacc_calendarios VC On CV.cod_calendario = VC.cod_calendario
	Left join vacc_vacunas v On CV.cod_vacuna = V.cod_vacuna
Order by 1

/*		Dosis de Vacunas			*/

Select VD.vacc_vacunas_dos_pk,
		V.nom_vacuna,
		VD.cod_vacuna,
		VD.id_dosis,
		VD.pauta,
		case when unidad_pauta = 30 then 'Meses' else 'Años' End as 'Unidad_Pauta',
		VD.unidad_pauta,
		VD.activo_sn,
		P.prest_item_desc,
		VD.prest_item_pk
from vacc_vacunas_dos VD
	Left join vacc_vacunas v On VD.cod_vacuna = V.cod_vacuna
	Left Join prest_item P On VD.prest_item_pk = P.prest_item_pk


/*		Motivos de vacunación			*/

Select cod_motivo,	nom_motivo,	ambito_dosis_sn,	ambito_paciente_sn,	inclusion_sn,	anulacion_sn,	reactivacion_sn,	activo_sn  from vacc_motivos
	

/*		Calendario Dosis		*/

Select calendar_dos_pk,
		calendar_vac,
		pauta,
		case when unidad_pauta = 30 then 'Meses' else 'Años' End as 'Unidad_Pauta',
		unidad_pauta,
		id_dosis,
		activo_sn
from vacc_calendar_dos


