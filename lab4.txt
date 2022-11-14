--WYŚWIETL DANE O WYPOŻYCZENIA: TYTUŁ KSIĄŻKI, NAZWISKO NAJWAŻNIEJSZEGO AUTORA, NAZWISKO CZYTELNIKA, DATA WYPOŻYCZENIA 
--W FORMACIE STOSOWANYM W USA ORAZ DATA ZWROTU W FORMACIE STOSOWANYM W POLSCE (CONVERT).

select tytul,autor.nazwisko as 'nazwisko autora',czytelnik.nazwisko as 'nazwisko czytelnika', convert(varchar, data_wypozyczenia, 110), convert(varchar, data_zwrotu, 105) from wypozyczenie
inner join egzemplarz on wypozyczenie.id_egzemplarz=egzemplarz.id_egzemplarz
inner join ksiazka on ksiazka.id_ksiazka=egzemplarz.id_ksiazka
inner join autor_ksiazki on ksiazka.id_ksiazka=autor_ksiazki.id_ksiazka
inner join autor on autor_ksiazki.id_autor=autor.id_autor
inner join czytelnik on wypozyczenie.id_czytelnik=czytelnik.id_czytelnik

--	WYŚWIETLIĆ NAZWISKO, IMIĘ CZYTELNIKA ORAZ ŚREDNI CZAS POMIĘDZY DATĄ ZWROTU, A DATĄ WYPOŻYCZENIA (DATEDIFF, 
--DLA KSIĄŻEK, KTÓRE ZOSTAŁY ZWRÓCONE).


select imie, nazwisko, (select avg(datediff(day, data_wypozyczenia, data_zwrotu))
						from wypozyczenie w2 where w1.id_czytelnik=w2.id_czytelnik) from czytelnik
inner join wypozyczenie w1 on w1.id_czytelnik=czytelnik.id_czytelnik
where data_zwrotu is not null

-- WYŚWIETL NAZWISKA CZYTELNIKÓW KTÓRZY NIC NIE WYPOŻYCZALI (2 SPOSOBY)
select nazwisko from czytelnik 
where id_czytelnik not in(select id_czytelnik from wypozyczenie)

--WYŚWIETLIĆ NAZWISKO, IMIĘ CZYTELNIKA, NAZWĘ KSIĄŻKI ORAZ KARĘ (20 GR ZA KAŻDY DZIEŃ) 
--DLA CZYTELNIKÓW PRZETRZYMUJĄCYCH KSIĄŻKI (JEŻELI MINĘŁO WIĘCEJ NIŻ TRZY MIESIĄCE OD DATY WYPOŻYCZENIA).
select imie, nazwisko, tytul,
case
	when  data_zwrotu is not null and datediff(MONTH, data_wypozyczenia, data_zwrotu)>3 then  0.2*(datediff(day, data_wypozyczenia, data_zwrotu)-90)
	when data_zwrotu is null and datediff(MONTH, data_wypozyczenia, GETDATE())>3 then 0.2*(datediff(day, data_wypozyczenia, getdate())-90)
end
  as kara from czytelnik
inner join wypozyczenie w1 on w1.id_czytelnik=czytelnik.id_czytelnik
inner join egzemplarz on w1.id_egzemplarz=egzemplarz.id_egzemplarz
inner join ksiazka on ksiazka.id_ksiazka=egzemplarz.id_ksiazka



select 0.2*(datediff(day, data_wypozyczenia, data_zwrotu)-90) from wypozyczenie
where data_zwrotu is not null and datediff(MONTH, data_wypozyczenia, data_zwrotu)>3

select 0.2*(datediff(day, data_wypozyczenia, getdate())-90) from wypozyczenie
where data_zwrotu is null and datediff(MONTH, data_wypozyczenia, GETDATE())>3
