select sys_usap.syslogin,sys_usap.cod_apli,sys_apli.modulo,sys_apli.descripcion from sys_usap 
inner join sys_perfil_usu on sys_usap.syslogin=sys_perfil_usu.syslogin
inner join sys_apli on sys_apli.cod_apli=sys_usap.cod_apli 
where sys_usap.permiso =1
union
select sys_perfil_usu.SYSLOGIN,sys_perfil_apli.cod_apli,sys_apli.modulo,sys_apli.ventana from sys_perfil_usu
inner join sys_perfil_apli on sys_perfil_apli.sys_perfil_pk=sys_perfil_usu.sys_perfil_pk 
inner join sys_apli on sys_apli.cod_apli=sys_perfil_apli.Cod_Apli 

--Perfil asociado a usuario
select sys_perfil_usu.SYSLOGIN,sys_perfil.sys_perfil_desc from sys_perfil_usu 
inner join sys_perfil on sys_perfil.sys_perfil_pk=sys_perfil_usu.sys_perfil_pk