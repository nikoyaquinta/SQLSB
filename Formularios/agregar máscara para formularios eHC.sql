-- Tabla para verificar las máscaras
select * from hce_mascara 


-- Ejecutar el insert con el valor que indica el usuario
insert into hce_mascara values (69, '####,#', 1);

--Seguidamente se actualizara el contador asociado a la tabla.
update descriptores set contador = (select max(mascara_pk) from hce_mascara) where descriptor ='hce_mascara';