
Select distinct
cagendas.n_solic,
case 
when fpersona.apellido2 is null then fpersona.nombre + ' ' + fpersona.apellido1 + '' 
when fpersona.apellido2 is not null then fpersona.nombre + ' ' + fpersona.apellido1 + ' ' + fpersona.apellido2
end as 'Prestador',
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
--case when count(cagendas_prest.cagprest_nsolic) > 1-- cagendasp.n_solic_padre is not null 
--	then 
--		STUFF(( Select Distinct ';' + Convert(varchar,cagendas_prest.prest_item_pk) 
--			   From cagendas_prest
--			   Inner Join cagendas On cagendas_prest.cagprest_nsolic = cagendas.n_solic

--			   where cagendas.codigo_cliente=138694
--			   group by cagprest_nsolic,cagendas_prest.prest_item_pk,cagendas.n_solic having cagendas_prest.cagprest_nsolic = cagendas.n_solic
		
--			   --Order By cagendas_prest.prest_item_pk
			   
--			   FOR XML PATH('')), 1, 1, '') 
--			   else 'Marito' 
--			end 
--	else STUFF(( Select Distinct ';' + Convert(varchar,cagendas_prest.prest_item_pk) 
--			   From cagendas_prest
--			   Inner Join cagendas On cagendas_prest.cagprest_nsolic = cagendas.n_solic
--			   where cagendas.codigo_cliente=138694 
--					And cagendasp.n_solic_padre not in (Select n_solic From cagendas Where cagendas.codigo_cliente=138694 )
--			   --Order By cagendas_prest.prest_item_pk
--			   FOR XML PATH('')), 1, 1, '') 
--	end as 'Prestacion',



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
where cagendas.codigo_cliente = 138694
group by fpersona.apellido2, fpersona.apellido1, fpersona.nombre,cagendas.fecha,cagendas.hora,cagendas.n_solic_padre,cagendas.n_solic,
cagendas.duracion,cagendasp.n_solic_padre,cagendasp.duracion,garantes.nombre_garante,cliente_pagadores.clipag_numpoliza,cex.cex_fecha_in,cex.con_cita_sn,
cex.codigo_cliente,cagendas.codigo_cliente,clientes.telefono1,cagendas.nota,prest_item_desc,cex.codigo_personal1, fmodelos.codigo_personal
,cagendas_prest.prest_item_pk,cagendas.consult_pk,servicios.serv_bas_pk,pagadores.codigo_garante_pk
order by n_solic


--select * from garantes

/*
Select top 10 dateadd(minute, 15,cagendas.hora) from cagendas

select sum(hora+duracion)  from cagendas where codigo_cliente = 138694

select * from fmodelos where cod_modelo=144

select * from fpersona where codigo_personal =18003
Select * from hc where codigo_cliente=138694 
Select top 12 * from cagendas_prest

SELECT DISTINCT 
  
  STUFF(
        (
            SELECT  tt.prde_desc_manual +CHAR(10)AS [text()] 
                FROM prde_presup_det AS tt
      WHERE ( TT.prca_pk = 69 )
                ORDER BY tt.prest_item_cod
            FOR XML PATH('')
        ), 1, 1, '') AS Valores
    FROM prde_presup_det 
  WHERE ( prde_presup_det.prca_pk = 69 ) 




Select top 100 c.n_solic,count(c.n_solic)
FRom cagendas c
Inner Join cagendas_prest cp On cp.cagprest_nsolic = c.n_solic 
Where codigo_cliente=138694 
	And c.n_solic_padre is null
Group By c.n_solic
--Having count(c.n_solic) > 1 
Order by c.n_solic


Select n_solic_padre,n_solic,cp.prest_item_pk,c.prest_item_pk as 'cagendas.prest_item_pk', cagprest_orden
FRom cagendas c
Inner Join cagendas_prest cp On cp.cagprest_nsolic = c.n_solic 
Where c.n_solic in (2947803)
	--or c.n_solic_padre = c.n_solic

Select Distinct ';' + Convert(varchar,cagendas_prest.prest_item_pk) 
From cagendas_prest
left Join cagendas On cagendas_prest.cagprest_nsolic = cagendas.n_solic_padre 
where
cagendas.n_solic_padre in (Select n_solic From cagendas Where cagendas.codigo_cliente=138694 )

Select Distinct n_solic_padre,n_solic,cagendas_prest.prest_item_pk,cagendas.prest_item_pk as 'cagendas.prest_item_pk', cagprest_orden--';' + Convert(varchar,cagendas_prest.prest_item_pk) 
From cagendas_prest
left Join cagendas On cagendas_prest.cagprest_nsolic = cagendas.n_solic
where
cagendas.n_solic in (Select n_solic From cagendas Where cagendas.codigo_cliente=138694 )
and cagendas_prest.prest_item_pk <> cagendas.prest_item_pk




					
					select distinct cagendas_prest.prest_item_pk from cagendas 
					inner join cagendas_prest on cagendas_prest.cagprest_nsolic=cagendas.n_solic
					where codigo_cliente = 138694 
					union
					select distinct cagendas_prest.prest_item_pk from cagendas 
					inner join cagendas_prest on cagendas_prest.cagprest_nsolic=cagendas.n_solic_padre
					where n_solic_padre = 2947803
					

					Select * From cagendas_prest where cagprest_nsolic = 2947796


2947803 5
2947803 6
2947803 7
2947796 6
2947796 7

Select cagprest_nsolic,
STUFF(( Select Distinct ';' + Convert(varchar,cagendas_prest.prest_item_pk) 
			   From cagendas_prest
			   Inner Join cagendas On cagendas_prest.cagprest_nsolic = cagendas.n_solic
			   where cagendas_prest
			   FOR XML PATH('')), 1, 1, '') 
into #tmp
from cagendas_prest where cagprest_nsolic is not null

Select * from #tmp

DROP TABLE #tmp

select * from cagendas where n_solic = 2947796

Select cagprest_nsolic,
STUFF(( Select Distinct ';' + Convert(varchar,cagendas_prest.prest_item_pk) 
			   From cagendas_prest
			   inner join cagendas on cagendas.n_solic=cagendas_prest.cagprest_nsolic
			   where cagprest_nsolic=cagprest_nsolic
			   FOR XML PATH('')), 1, 1, '') 
	from cagendas_prest --where cagprest_nsolic=cagprest_nsolic





	*/