SumaEgresosTT

select Distinct
       Case when {EXP_ID} =0 Then 0
       Else
             (Select Sum(hn.valor_campo)
             from hce_val_exp_num hn
                    inner join hce_exp_form hf on hf.exp_form_pk=hn.exp_form_pk
                    inner join hce_formulario hcf on hcf.formulario_pk=hf.formulario_pk
             where hn.campo_pk in (1002358,1002359,1002360,1002361,1002362,1002363,1002364)
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
            where hn.campo_pk in (1002358,1002359,1002360,1002361,1002362,1002363,1002364)
                   and hf.codigo_cliente = {COD_CLI}
                   and hcf.descripcion='Balance Hídrico.'
                   and hn.exp_form_pk = {EXP_ID} ))
      End
from hce_val_exp_num hn
Where hn.exp_form_pk = {EXP_ID}