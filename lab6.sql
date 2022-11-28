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


