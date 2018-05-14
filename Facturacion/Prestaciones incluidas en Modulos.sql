
--PRESTACIONES INCLUIDAS EN MODULOS
select c.prest_item_pk,
		p.prest_item_cod, 
		c.prest_item_pk1,
		pi.prest_item_desc 

from co_conjunto c
	inner join prest_item p on c.prest_item_pk=p.prest_item_pk
	inner join prest_item pi on c.prest_item_pk1=pi.prest_item_pk
where p.prest_item_cod='q010'
