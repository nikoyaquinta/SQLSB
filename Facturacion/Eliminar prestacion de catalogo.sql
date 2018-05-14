declare @pipk int
set @pipk= --PREST_ITEM_PK de la prestacion a borrar

delete from icdprest WHERE prest_item_pk = @pipk

delete FROM prest_item WHERE prest_item_pk = @pipk

delete from fpersona_honorarios WHERE prest_item_pk = @pipk

delete from prest_precio WHERE prest_item_pk = @pipk

delete from co_cobert WHERE prest_item_pk = @pipk

delete from co_prest_contra WHERE prest_item_pk = @pipk

delete from actividad_det WHERE prest_item_pk = @pipk

delete from vale_asis_det WHERE prest_item_pk = @pipk

delete from act_det_precio where va_det_pk in (select va_det_pk from vale_asis_det WHERE prest_item_pk = @pipk)

delete from recibos_det where va_det_pk in (select va_det_pk from vale_asis_det WHERE prest_item_pk = @pipk) 

delete from co_unidnomen WHERE prest_item_pk = @pipk

delete from gpc_catalogo WHERE prest_item_pk = @pipk

delete from gpc_cat_local where catalogo_pk = (select catalogo_pk from gpc_catalogo where prest_item_pk =@pipk )

delete from gpc_cat_serv where catalogo_pk = (select catalogo_pk from gpc_catalogo where prest_item_pk =@pipk )