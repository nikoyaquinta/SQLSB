select Distinct 
       Case when hn.exp_form_pk =0 Then 0
       Else
             (Select  convert(decimal(18,4), Sum(hn.valor_campo))
             from hce_val_exp_num hn
                    inner join hce_exp_form hf on hf.exp_form_pk=hn.exp_form_pk
                    inner join hce_formulario hcf on hcf.formulario_pk=hf.formulario_pk
             where hn.campo_pk in (1003462,1003463,1004578)-- Agregar los campos a sumar
                    and hf.codigo_cliente = {COD_CLI}
                    and hcf.descripcion='Prueba Hoja Balance'-- Nombre del formulario
                    and hn.exp_form_pk = {EXP_ID} ) 
/
(Select count(*)
             from hce_val_exp_num hn
                    inner join hce_exp_form hf on hf.exp_form_pk=hn.exp_form_pk
                    inner join hce_formulario hcf on hcf.formulario_pk=hf.formulario_pk
             where hn.campo_pk in (1003462,1003463,1004578)-- Agregar los campos a sumar
                    and hf.codigo_cliente = {COD_CLI}
                    and hcf.descripcion='Prueba Hoja Balance'-- Nombre del formulario
                    and hn.exp_form_pk = {EXP_ID} )
       End
from hce_val_exp_num hn
Where hn.exp_form_pk = {EXP_ID}

