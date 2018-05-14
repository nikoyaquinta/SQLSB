
--select servicios.servicio,
--servicio_basico.serv_bas_desc
-- from servicios
-- inner join servicio_basico on servicio_basico.serv_bas_pk=servicios.serv_bas_pk


--CECO
select ceco_codigo,
ceco_descripcion
 from centro_coste

--CECO asociado a grupo de prestacion
Select prest_grupo_desc,
	 ceco_descripcion,
	 ceco_codigo
from prest_grupo_ceco 
inner join prest_grupo on prest_grupo.prest_grupo_pk=prest_grupo_ceco.prest_grupo_pk
inner join centro_coste on centro_coste.ceco_pk=prest_grupo_ceco.ceco_pk

--CECO asociado a servicios
select servicio,
 ceco_descripcion,
 ceco_codigo
from servicios_ceco 
inner join servicios on servicios.codigo_servicio=servicios_ceco.codigo_servicio
inner join centro_coste on centro_coste.ceco_pk=servicios_ceco.ceco_pk

-----------------------------------------------------------------------------------------

--CEBE
select cebe_desc,
cebe_cod 
from centro_beneficio

--CEBE asociado a grupo de prestacion
select prest_grupo_desc,
		cebe_desc,
		cebe_cod,
		nombre_centro 
	 from prest_grupo_cebe
inner join prest_grupo on prest_grupo.prest_grupo_pk=prest_grupo_cebe.prest_grupo_pk
inner join centro_beneficio on centro_beneficio.cebe_pk=prest_grupo_cebe.cebe_pk
inner join centros on centros.cod_centro=prest_grupo_cebe.cod_centro   

--CEBE asociado a servicios
select servicio,
		cebe_desc,
		cebe_cod
 from servicios_cebe
inner join servicios on servicios.codigo_servicio=servicios_cebe.codigo_servicio
inner join centro_beneficio on centro_beneficio.cebe_pk=servicios_cebe.cebe_pk