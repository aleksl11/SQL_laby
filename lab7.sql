--7.Korzystając z tabeli produkty stwórz transakcję, która przeniesie wszystkie produkty z magazynu nr 1 do magazynu nr 2. 
--Maksymalna pojemność magazynu nr 2 wynosi 500. Jeżeli powyższa operacja spowoduje przepełnienie magazynu należy ją wycofać i przenieść produkty do magazynu nr 3.

create table Produkty(
	id_produkt int identity(1,1) primary key,
	ilosc decimal(7,2),
	nr_magazynu int
)

insert into Produkty values(300,1)
insert into Produkty values(300,2)
insert into Produkty values(300,3)
select * from Produkty

begin transaction zmiana
save transaction z1
update Produkty set nr_magazynu=2 where nr_magazynu=1
if(select sum(ilosc) from Produkty where nr_magazynu=2)>500
begin 
	rollback transaction z1
	update Produkty set nr_magazynu=3 where nr_magazynu=1
end
commit transaction

-- kursor wyswietlajacy nazwiska pracownikow

declare @n varchar(20)
declare @i int=0

declare k1 cursor
for select nazwisko from Pracownicy
open k1
fetch next from k1 into @n
while @@FETCH_STATUS=0
begin
	set @i +=1
	print @n+' - to jest nazwisko z wiersza numer '+cast(@i as varchar(3))
	fetch next from k1 into @n
end
close k1
deallocate k1 

--pula 1000zl rozdzielic miedzy pracownikow +5% od tych najmniej zarabiajacych

declare @zarobki money
declare @podwyzka money
declare @pula money 
set @pula = 1000

declare k2 cursor
for select pensja from Pracownicy order by PENSJA

open k2
fetch next from k2 into @zarobki 
while @@FETCH_STATUS=0
begin
	set @podwyzka=0.05*@zarobki
	if @pula-@podwyzka<0 break; 
	set @pula-=@podwyzka
	print cast(@podwyzka as varchar(6))+' w puli: '+cast(@pula as varchar(6))
	update Pracownicy set PENSJA +=@podwyzka where current of k2
	fetch next from k2 into @zarobki 
end
if @pula>0
begin
	print cast(@pula as varchar(6))+' w puli: 0'
	update Pracownicy set PENSJA +=@pula where current of k2
end
close k2
deallocate k2


--trigger

select * from log


create trigger usuwanie 
on Pracownicy
for delete 
as 
begin
	declare @kto varchar(30)
	set @kto=SUSER_NAME()
	declare @kogo varchar(10)
	declare kursor cursor
	for select nazwisko from deleted
	open kursor
		fetch next from kursor into @kogo
		while @@FETCH_STATUS=0
		begin
			insert into log values (@kto,@kogo,CURRENT_TIMESTAMP)
			fetch next from kursor into @kogo
		end
	close kursor
	deallocate kursor
end

select * from Pracownicy
delete  from Pracownicy where IDENTYFIKATOR in (13,15) 
