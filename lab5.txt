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
