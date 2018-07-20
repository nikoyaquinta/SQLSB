
Select distinct top 10
cagendas.n_solic,
isnull (fpersona.nombre,' ') + ' ' +  isnull(fpersona.apellido1,' ') + ' ' +  isnull(fpersona.apellido2,' ') as 'Prestador',
CONVERT (date, SYSDATETIME())   as 'Dia',
convert(varchar,cagendas.fecha,102) as 'Fecha desde',
convert(varchar,cagendas.hora,114) as 'Hora desde',

case when cagendasp.n_solic_padre is not null 
	then convert(varchar,sum (cagendasp.duracion)+cagendas.duracion,114) 
	else convert(varchar,cagendas.duracion,114)
	end as 'Duracion',

case when cagendasp.n_solic_padre is not null 
	then convert(varchar,dateadd(minute, (sum (cagendasp.duracion)+cagendas.duracion),cagendas.hora),114) 
	else convert(varchar,dateadd(minute, cagendas.duracion,cagendas.hora),114) 
	end as 'Hora Hasta',

count (cagendasp.n_solic_padre)+ 1  as 'Cantidad',
case when pagadores.codigo_garante_pk = 2 then 'S' else 'E' end as 'Afiliado',
pagadores.codigo_garante_pk as 'Prepaga',
cliente_pagadores.clipag_numpoliza as 'Credencial',
case when cex.codigo_cliente=cagendas.codigo_cliente and cex.codigo_personal1 <> fmodelos.codigo_personal or cex.codigo_personal1 is null then 'Si' else 'No' end as 'Primera Vez',
clientes.telefono1 as 'Telefono',
cagendas.nota as 'Observaciones',
cagendas.consult_pk as 'Consultorio',
servicios.serv_bas_pk as 'Especialidad',
cagendas_prest.prest_item_pk as 'Prestacion'

from cagendas
inner join clientes on clientes.codigo_cliente=cagendas.codigo_cliente
inner join fmodelos on fmodelos.cod_modelo=cagendas.cod_modelo
inner join fageprog on fageprog.cod_modelo=fmodelos.cod_modelo
inner join fpersona on fpersona.codigo_personal=fmodelos.codigo_personal and fmodelos.cod_modelo=cagendas.cod_modelo
left join cagendas cagendasp on cagendasp.n_solic_padre=cagendas.n_solic
left join pagadores on pagadores.cod_pagador_pk=cagendas.cod_pagador_pk
left join garantes on garantes.codigo_garante_pk=pagadores.codigo_garante_pk
left join cliente_pagadores on cliente_pagadores.codigo_cliente=cagendas.codigo_cliente and cliente_pagadores.cod_pagador_pk=cagendas.cod_pagador_pk and clipag_activo_sn = 1
left join cex on cex.codigo_cliente=cagendas.codigo_cliente
--left join tconsultorio on tconsultorio.consult_pk=cagendas.consult_pk
inner join servicios on servicios.codigo_servicio =cagendas.codigo_servicio
--inner join servicio_basico on servicio_basico.serv_bas_pk=servicios.serv_bas_pk
inner join cagendas_prest on cagendas_prest.cagprest_nsolic=cagendas.n_solic
inner join prest_item on prest_item.prest_item_pk=cagendas_prest.prest_item_pk
where cliente_pagadores.clipag_numpoliza= '8000060567449011003' or clientes.codigo1='39462302'
group by fpersona.apellido2, fpersona.apellido1, fpersona.nombre,cagendas.fecha,cagendas.hora,cagendas.n_solic_padre,cagendas.n_solic,
cagendas.duracion,cagendasp.n_solic_padre,cagendasp.duracion,garantes.nombre_garante,cliente_pagadores.clipag_numpoliza,cex.cex_fecha_in,cex.con_cita_sn,
cex.codigo_cliente,cagendas.codigo_cliente,clientes.telefono1,cagendas.nota,prest_item_desc,cex.codigo_personal1, fmodelos.codigo_personal
,cagendas_prest.prest_item_pk,cagendas.consult_pk,servicios.serv_bas_pk,pagadores.codigo_garante_pk
order by n_solic




