SELECT clin_grupos.clin_grp_pk,clin_grupos.clin_grp_desc,  prest_item.prest_item_pk ,           prest_item.prest_item_desc ,           prest_item.prest_item_actsn ,           prest_item.prest_item_orden ,           prest_item.clin_sgrp_pk ,           tipo_item.tipo_actividad_pk ,           clin_grupos.clin_grp_orden ,           clin_subgrupos.clin_sgrp_orden ,           clin_grupos.clin_grp_activo_sn ,           clin_subgrupos.clin_sgrp_act_sn     FROM prest_item ,           tipo_item ,           clin_grupos ,           clin_subgrupos     WHERE ( clin_subgrupos.clin_sgrp_pk = prest_item.clin_sgrp_pk ) and          ( tipo_item.tipo_item_pk = prest_item.tipo_item_pk ) and          ( clin_subgrupos.clin_grp_pk = clin_grupos.clin_grp_pk )
order by clin_grupos.clin_grp_desc desc


