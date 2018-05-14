select * from descriptores where codigo_descriptor=11085

begin transaction
update descriptores set mascara = 16 where codigo_descriptor=11085
rollback
commit