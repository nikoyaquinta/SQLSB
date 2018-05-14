select
(select valor_campo
from hce_val_exp_num hn 
inner join hce_exp_form hf on hf.exp_form_pk=hn.exp_form_pk
where campo_pk=1003464 and hf.codigo_cliente=2337 and formulario_pk=1001321 and val_exp_num_pk = (select max(val_exp_num_pk) from hce_val_exp_num where campo_pk=1003464)and hf.exp_form_pk =(select max(exp_form_pk) from hce_exp_form where codigo_cliente=2337) 

+

(select valor_campo
from hce_val_exp_num hn 
inner join hce_exp_form hf on hf.exp_form_pk=hn.exp_form_pk
where campo_pk=1004573 and hf.codigo_cliente=2337  and formulario_pk=1001321 and val_exp_num_pk= (select max(val_exp_num_pk) from hce_val_exp_num where campo_pk=1004573) and hf.exp_form_pk =(select max(exp_form_pk) from hce_exp_form where codigo_cliente=2337 ) 




1001319
select * from hce_formulario  where formulario_pk=1001319
select * from clientes where apellido1 like '%pruebasb4%'
select * from hce_val_exp_num where campo_pk=1003464
select * from hce_exp_form where codigo_cliente=2139

select valor_campo
from hce_val_exp_num hn 
inner join hce_exp_form hf on hf.exp_form_pk=hn.exp_form_pk
where campo_pk=1003462 and hf.codigo_cliente={COD_CLI} and formulario_pk=1001319 and val_exp_num_pk= (select max(val_exp_num_pk) from hce_val_exp_num) 