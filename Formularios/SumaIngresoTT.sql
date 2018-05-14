SumaIngresoTT

select Distinct
       Case when {EXP_ID} =0 Then 0
       Else
             (Select Sum(hn.valor_campo)
             from hce_val_exp_num hn
                    inner join hce_exp_form hf on hf.exp_form_pk=hn.exp_form_pk
                    inner join hce_formulario hcf on hcf.formulario_pk=hf.formulario_pk
             where hn.campo_pk in (1002333,1002334,1002335,1002336,1002337,1002338,1002339) 
                    and hf.codigo_cliente = {COD_CLI}
                    and hcf.descripcion='Balance Hídrico.'
                    and hn.exp_form_pk = {EXP_ID} )
       End
from hce_val_exp_num hn
Where hn.exp_form_pk = {EXP_ID}


select Distinct
      Case when {EXP_ID} =0 Then 0
      Else
           convert(decimal(18,4),(Select Sum(hn.valor_campo)
            from hce_val_exp_num hn
                   inner join hce_exp_form hf on hf.exp_form_pk=hn.exp_form_pk
                   inner join hce_formulario hcf on hcf.formulario_pk=hf.formulario_pk
            where hn.campo_pk in (1002333,1002334,1002335,1002336,1002337,1002338,1002339)
                   and hf.codigo_cliente = {COD_CLI}
                   and hcf.descripcion='Balance Hídrico.'
                   and hn.exp_form_pk = {EXP_ID} ))
      End
from hce_val_exp_num hn
Where hn.exp_form_pk = {EXP_ID}