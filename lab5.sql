--1 Zarobki poniżej 3 tys należy zwiększyć o 20%, a zarobki powyżej 3 tys należy obniżyć o 10%
update Pracownicy
set PENSJA=
case
	when pensja>3000 then pensja*0.9
	when pensja>3000 then pensja*0.9
	else pensja
end
select * from Pracownicy

--2	Stwórz procedurę która wypisze najwcześniej zatrudnione osoby, w każdym departamencie. Identyfikator departamentu powinien być przekazanym jako argument procedur. 
--Natomiast data zatrudnienia przekazywana jest przez drugi argument, który jest zadeklarowany jako wyjściowy.
create proc zatrud_dept
(
	@dept int,
	@data_zatrud date output)
as
	select @data_zatrud=min(data_zatrud) from Pracownicy
	where KOD_dzialu =@dept

declare @wynik date
exec zatrud_dept 20, @wynik output
select @wynik

--zzdefiniuj procedure, ktora wyswietli nazwisko najgorzej zarabiajacej osoby w departamencie
create proc najgorszaPensja
(
	@dept int,
	@nazwisko varchar(20) output)
as
	select @nazwisko=NAZWISKO from Pracownicy
	where KOD_dzialu =@dept and pensja = (select min(PENSJA)from Pracownicy
											where KOD_dzialu =@dept)
declare @wynik varchar(20)
exec najgorszaPensja 10, @wynik output
select @wynik
select * from Pracownicy

--return
create proc return_exp as
declare @ile int
select @ile = count(identyfikator) --dokoczyc
