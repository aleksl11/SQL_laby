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

