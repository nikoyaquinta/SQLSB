/*
Select 	*
From ns_msg_in Msj 
	Inner Join ns_msg_in_det MsjDet On Msj.ns_msg_in_pk = MsjDet.ns_msg_in_pk
Where Msj.nsi_origen = 'GPC'
*/

Select 
	
	--CHARINDEX('|',nid_param1) AS Encuentro,
	--CHARINDEX('|',nid_param1,(CHARINDEX('|',nid_param1)+1)) As pkPaciente,
	--CHARINDEX('|',nid_param1,(CHARINDEX('|',nid_param1,(CHARINDEX('|',nid_param1)+1))+1)) as pkPrestacion,
	--(CHARINDEX('|',nid_param1,(CHARINDEX('|',nid_param1)+1))-CHARINDEX('|',nid_param1)) as largoPaciente,
	--(CHARINDEX('|',nid_param1,(CHARINDEX('|',nid_param1,(CHARINDEX('|',nid_param1)+1))+1)) - CHARINDEX('|',nid_param1,(CHARINDEX('|',nid_param1)+1))) as largoPrestacion, 
	Msj.ns_msg_in_pk,
	nsi_origen,
	(convert(varchar,nsi_fechareg,103) + ' ' + convert(varchar,nsi_horareg,108)) as FechaRegistracion,
	nsi_errorText,
	SUBSTRING(nid_param1,0,(CHARINDEX('|',nid_param1)))  as Encuentro,
	(Select nhc from hc where codigo_cliente = (SUBSTRING(nid_param1,((CHARINDEX('|',nid_param1))+1), ((CHARINDEX('|',nid_param1,(CHARINDEX('|',nid_param1)+1))-CHARINDEX('|',nid_param1))-1)))) as HC,
	(Select top 100 nombre + ', ' + Apellido1 from clientes where codigo_cliente = (SUBSTRING(nid_param1,((CHARINDEX('|',nid_param1))+1), ((CHARINDEX('|',nid_param1,(CHARINDEX('|',nid_param1)+1))-CHARINDEX('|',nid_param1))-1)))) as Paciente,
	(Select prest_item_desc from prest_item where prest_item_pk = (SUBSTRING(nid_param1,(CHARINDEX('|',nid_param1,(CHARINDEX('|',nid_param1)+1))+1),((CHARINDEX('|',nid_param1,(CHARINDEX('|',nid_param1,(CHARINDEX('|',nid_param1)+1))+1)) - CHARINDEX('|',nid_param1,(CHARINDEX('|',nid_param1)+1)))-1)))) as idPrestacion,
	nid_param1
From ns_msg_in Msj 
	Inner Join ns_msg_in_det MsjDet On Msj.ns_msg_in_pk = MsjDet.ns_msg_in_pk
Where Msj.nsi_origen = 'GPC'

/*
508|526||19000101000000||1008067-01|3|2|0
*/



--Select * from be_encuentro where epis_pk = 282
--Select * from be_encuentro where epis_pk = 282
--Select * from ingresos
--Select * from clientes where codigo_cliente = 293
--Select * from hc where codigo_cliente = 293
----282|293|17700||1|20160317102442|1265|1008056-02|2|0|4|1|1744|242||0

--Select 
--	SUBSTRING(nid_param1,0,(CHARINDEX('|',nid_param1)))
--	,SUBSTRING(nid_param1,(CHARINDEX('|',nid_param1)+1),(CHARINDEX('|',nid_param1)-1))
--	,MsjDet.*
--From ns_msg_in Msj 
--	Inner Join ns_msg_in_det MsjDet On Msj.ns_msg_in_pk = MsjDet.ns_msg_in_pk
--Where Msj.nsi_origen = 'GPC'



--Select nsi_tipo_op , nsi_origen From ns_msg_in Where ns_msg_in_pk =1861 
--Select nsi_tipo_op , nsi_fechareg , nsi_horareg , nsi_usuario , nsi_origen From ns_msg_in Where ns_msg_in_pk =1861 
--SELECT  ns_msg_in_det.ns_msg_in_pk ,           ns_msg_in_det.nid_orden ,           ns_msg_in_det.nid_param1 ,           ns_msg_in_det.nid_param2 ,           ns_msg_in_det.nid_param3 ,           ns_msg_in_det.nid_param4     FROM ns_msg_in_det      WHERE ( ns_msg_in_det.ns_msg_in_pk = 1861 )   
--Select apellido1 , apellido2 , nombre From clientes Where codigo_cliente =293 
--Select tipo_episodio_pk From episodios Where epis_pk =282 
--SELECT  prest_item.prest_item_cod ,           prest_item.prest_item_desc ,           prest_item.prest_item_pk     FROM prest_item      WHERE ( prest_item.prest_item_pk in (17700) )  
