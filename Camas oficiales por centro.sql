select 
	count(cod_cama) as 'Camas Oficiales',
	nombre_centro as 'Centro'
  from camas
	inner join unidadesenfermeria on camas.cod_uenf_pk=unidadesenfermeria.cod_uenf_pk
	inner join co_ubicaciones on co_ubicaciones.ubicac_pk=unidadesenfermeria.ubicac_pk
	inner join area_fisica on area_fisica.areafis_pk=co_ubicaciones.areafis_pk
	inner join centros on centros.cod_centro=area_fisica.cod_centro
  where oficial_sn = 1 and tipo_cama_pk = 2
  group by nombre_centro