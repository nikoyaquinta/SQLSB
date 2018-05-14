/*	Profesionales Activos en el sistema		*/
Select 
	fpersona.codigo_Personal	
	,nombre	
	,apellido1	
	,apellido2
	,nombre_Corto	
	,fpers_doc	
	,codigo_colegiado	
	,cuenta_contable as Legajo
From fpersona
where fpersona.activo_sn <> 0

/*	Profesional-Servicio-Categoria	*/
Select 
	fpersona.codigo_Personal	
	,nombre	
	,apellido1	
	,apellido2
	,nombre_Corto	
	,fpers_doc	
	,codigo_colegiado
	,fpersona.cuenta_contable as Legajo	
	,tcategor.codigo_categoria	
	,nom_categ	
	,Servicios.codigo_servicio	
	,Servicio
From fpersona
	Inner Join tcategor On fpersona.codigo_categoria = tcategor.codigo_categoria
	Inner Join fpersona_servicio On fpersona.codigo_Personal = fpersona_servicio.codigo_Personal
	Inner Join Servicios On fpersona_servicio.codigo_servicio =  Servicios.codigo_servicio
where fpersona.activo_sn <> 0

/*	Profesional-Categoria	*/
Select 
	fpersona.codigo_Personal	
	,nombre	
	,apellido1	
	,apellido2
	,nombre_Corto	
	,fpers_doc	
	,codigo_colegiado
	,cuenta_contable as Legajo	
	,tcategor.codigo_categoria	
	,nom_categ	
From fpersona
	Inner Join tcategor On fpersona.codigo_categoria = tcategor.codigo_categoria
where fpersona.activo_sn <> 0

/*	Profesional-Servicio	*/
Select 
	fpersona.codigo_Personal	
	,nombre	
	,apellido1	
	,apellido2
	,nombre_Corto	
	,fpers_doc	
	,codigo_colegiado	
	,fpersona.cuenta_contable as Legajo
	,Servicios.codigo_servicio	
	,Servicio
From fpersona
	Inner Join fpersona_servicio On fpersona.codigo_Personal = fpersona_servicio.codigo_Personal
	Inner Join Servicios On fpersona_servicio.codigo_servicio =  Servicios.codigo_servicio
where fpersona.activo_sn <> 0

/*	Usuario xHis	*/
Select 
	sysLogin	
	,sys_usu.codigo_personal	
	,nombre	
	,apellido1	
	,apellido2	
	,fpers_doc
	,fpersona.cuenta_contable as Legajo
From sys_usu
	Inner Join fpersona On sys_usu.codigo_personal = fpersona.codigo_personal
where fpersona.activo_sn <> 0

/*	Usuarios - Permisos		*/
Select 
	sys_perfil_usu_pk
	,sys_perfil_usu.sys_perfil_pk
	,sys_perfil.sys_perfil_desc
	,sys_perfil_usu.SYSLOGIN
	,fpersona.codigo_personal	
	,nombre	
	,apellido1	
	,apellido2	
	,fpers_doc
	,fpersona.cuenta_contable as Legajo
From sys_perfil_usu
	Inner Join sys_perfil On sys_perfil.sys_perfil_pk = sys_perfil_usu.sys_perfil_pk
	Inner Join sys_usu  On sys_usu.sysLogin = sys_perfil_usu.sysLogin
	Inner Join fpersona On sys_usu.codigo_personal = fpersona.codigo_personal
where fpersona.activo_sn <> 0

/*	Usuarios xFarma	*/
Select 
	usu_login	
	,nombre_usu	
	,nombreCorto	
	,fpersona.codigo_personal	
	,nombre	
	,apellido1	
	,apellido2	
	,fpers_doc
	,fpersona.cuenta_contable as Legajo
	,cla_usuarios.nivel_pk
	,cla_niveles.nivel_deno
From cla_usuarios
	Inner Join sys_usu  On sys_usu.sysLogin = cla_usuarios.usu_his
	Inner Join fpersona On sys_usu.codigo_personal = fpersona.codigo_personal
	Inner Join cla_niveles ON cla_niveles.nivel_pk = cla_usuarios.nivel_pk
Where usu_activo = 1



