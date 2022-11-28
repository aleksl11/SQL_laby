create trigger proba 
on Pracownicy
after insert, update, delete
as
	select * from inserted
	select * from deleted

select * from PRACOWNICY

INSERT INTO PRACOWNICY VALUES ('Lenart','Aleksandra','Prezes',NULL,'2002-01-01',7000.20,NULL,10);

update Pracownicy set pensja = 5000 where IDENTYFIKATOR=1

delete from Pracownicy where IDENTYFIKATOR=17

drop trigger proba

--4.Zdefiniuj wyzwalacz, który zabroni zmniejszania pensji pracownikom

create trigger zmiana 
on Pracownicy
after update
as
if update(pensja)
begin
	update Pracownicy
	set pensja= deleted.pensja
	from Pracownicy inner join deleted on Pracownicy.IDENTYFIKATOR=deleted.IDENTYFIKATOR
	where Pracownicy.pensja<deleted.pensja and Pracownicy.IDENTYFIKATOR=deleted.identyfikator
end

update Pracownicy set pensja =5000 where IDENTYFIKATOR=1

drop trigger zmiana

create trigger zmiana2
on Pracownicy
after update
as
if update(pensja)
begin
	declare @old decimal(10,2)
	declare @new decimal(10,2)
	select @old=pensja from deleted
	select @new=pensja from inserted
	if @old>@new
		rollback
end

update Pracownicy set pensja =5000 where IDENTYFIKATOR=1

--5.Dla relacji Pracownicy stwórz wyzwalacz, który w przypadku braku prowizji zamieni wartość NULL na 10.

create trigger prowizja
on pracownicy
after insert,update
as
	declare @new decimal(10,2)
	declare @id int
	select @new=prowizja from inserted
	select @id=identyfikator from inserted
	if @new is null
	begin
	update Pracownicy set prowizja=10
	where IDENTYFIKATOR=@id
	end

		
update Pracownicy set prowizja =120 where IDENTYFIKATOR =12
INSERT INTO PRACOWNICY VALUES ('Lenart','Aleksandra','Prezes',NULL,'2002-01-01',7000.20,NULL,10);

select * from PRACOWNICY

drop trigger prowizja

--6.Zapisz w tabeli LOG informacje o tym kto skasował którego klienta.

create table LOG(
	kto varchar(30),
	kogo varchar(20),
	kiedy date
)

create trigger rejestr on Pracownicy
after delete
as	
	declare @name varchar(20)
	select @name=nazwisko from deleted
	insert into LOG values(SUSER_NAME(),@name,GETDATE())

delete from pracownicy where IDENTYFIKATOR=18

select * from LOG

INSERT INTO PRACOWNICY VALUES ('Lenart','Aleksandra','Prezes',NULL,'2002-01-01',7000.20,NULL,10);
INSERT INTO PRACOWNICY VALUES ('Lenart','Aleksandra','Prezes',NULL,'2002-01-01',7000.20,NULL,10);

delete from pracownicy where IDENTYFIKATOR=19
delete from pracownicy where IDENTYFIKATOR=20



