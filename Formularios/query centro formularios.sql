select nombre_centro from centros
where cod_centro in (select cod_Centro from servicios where codigo_servicio = {SERV_USU})