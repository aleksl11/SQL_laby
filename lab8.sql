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
