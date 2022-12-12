--	Stwórz tabele Pracownik={Imie, Nazwisko, Pesel, Plec}. Zaprogramuj wyzwalacz, który dla nowowprowadzonych pracowników będzie uzupełniał kolumnę Plec na podstawie numeru pesel.
create table Pracownik(
	id_pracownik int identity(1,1) primary key,
	Imie varchar(25),
	Nazwisko varchar(25),
	Pesel varchar(11),
	Płeć varchar(1)
)

alter trigger plec on Pracownik
after insert
as
begin
	 update Pracownik set Płeć=
	case
	when ((select substring(inserted.Pesel,10,1) from inserted)in ('0','2','4','6','8'))
	then 'K'
	else 'M'
	end
	from inserted inner join Pracownik on inserted.id_pracownik=Pracownik.id_pracownik
end

insert into Pracownik(imie,nazwisko,pesel) values ('fr','fdhga','12344567865')
select * from Pracownik

--Kierownik może zarządzać maksymalnie 5 pracownikami. Opracuj rozwiązanie, które w przypadku przekroczenia ilości pracowników będzie wyświetlała wiadomość o obciążeniu kierownika.

select * from Pracownicy

alter trigger maks on Pracownicy
after insert,update
as
begin
	if((select count(kierownik) from Pracownicy  where kierownik=(select kierownik from inserted))>5)
	begin
		print('Kierownik obciążony')
		rollback
	end
end

insert into Pracownicy(kierownik) values (4)
select * from Pracownicy

update Pracownicy set KIEROWNIK=4 where identyfikator = 4

--Stwórz wyzwalacz, który w tabeli LOG_ZMIAN będzie raportował jaka operacja (update, insert czy deleted) przez jakiego użytkownika,
-- z jakiego komputera i której godzinie została wykonana na tabeli pracownicy.

create table log_zmian(
	ID int identity(1,1) primary key,
	operacja varchar(2),
	uzytkownik varchar(15),
	host varchar(15),
	kiedy datetime
)

create trigger zmiana on Pracownicy
after insert,update,delete
as
begin
	insert into log_zmian values(
		(case
			when exists(select *from deleted) and exists(select *from inserted)
			then 'u'
			when exists(select *from deleted)
			then 'd'
			when exists(select *from inserted)
			then 'i'
		end),SUSER_SNAME(),HOST_NAME(),CURRENT_TIMESTAMP)
end

insert into Pracownicy (nazwisko,imie) values ('jan', 'kowalski')

select * from log_zmian
select * from Pracownicy
