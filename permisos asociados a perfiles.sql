select sys_perfil_desc,sys_apli.cod_apli,sys_apli.descripcion, modulo, ventana from sys_perfil_apli
inner join sys_perfil on sys_perfil.sys_perfil_pk=sys_perfil_apli.sys_perfil_pk
inner join sys_apli on sys_apli.cod_apli=sys_perfil_apli.cod_apli
order by sys_perfil_desc
