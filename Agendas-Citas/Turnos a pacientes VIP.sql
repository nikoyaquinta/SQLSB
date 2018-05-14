select 
	isnull(fpersona.apellido1,' ') + ' ' + isnull(fpersona.apellido2,' ') + fpersona.nombre as 'Profesional Prestador',
	clientes.apellido1 + ' ' + isnull(clientes.apellido2,' ') + clientes.nombre as 'Paciente',
	cagendas.hora as 'Hora Turno',
	cagendas.fecha as 'Fecha Turno',
	cagendas.cod_estado as 'Estado Turno'
from cagendas 
	inner join clientes on cagendas.codigo_cliente = clientes.codigo_cliente
	inner join fpersona on cagendas.codigo_personal = fpersona.codigo_personal
	where clientes.vip_sn=1

