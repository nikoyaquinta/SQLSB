--Las siguiente trae las pensiones que se imputaron al d�a de anterior. Lo de hy se factura ma�ana.
 
Select count(*) From vale_asis_det vad where va_det_des_manual like 'Pension%' and va_det_fapunte = Convert(varchar(10),dateadd(day,-1,getdate()),103)
 
--La siguiente te trae la cantidad de pacientes que se encuentran o encontraban internados al d�a anterior. Puede darse que la cantidad de pensiones sean Menor o Igual al n�mero de pacientes internados, dado que seg�n el horario de egreso del paciente no se le imputa  la estancia
 
Select count(*) from ingresos where (fecha_alta is null or fecha_alta = Convert(varchar(10),dateadd(day,-1,getdate()),103))
 