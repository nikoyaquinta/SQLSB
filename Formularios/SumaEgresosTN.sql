SumaEgresosTN

select Distinct
       Case when {EXP_ID} =0 Then 0
       Else
             (Select Sum(hn.valor_campo)
             from hce_val_exp_num hn
                    inner join hce_exp_form hf on hf.exp_form_pk=hn.exp_form_pk
                    inner join hce_formulario hcf on hcf.formulario_pk=hf.formulario_pk
             where hn.campo_pk in (1002365,1002366,1002367,1002368,1002369,1002370,1002371,1002372,1002373,1002374)
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
            where hn.campo_pk in (1002365,1002366,1002367,1002368,1002369,1002370,1002371,1002372,1002373,1002374)
                   and hf.codigo_cliente = {COD_CLI}
                   and hcf.descripcion='Balance Hídrico.'
                   and hn.exp_form_pk = {EXP_ID} ))
      End
from hce_val_exp_num hn
Where hn.exp_form_pk = {EXP_ID}