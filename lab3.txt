--z1 najdluzsze zamowienie
SELECT orderid from Orders
where  datediff(day, ORDERDATE, SHIPPEDDATE)=(select max(datediff(day, ORDERDATE, SHIPPEDDATE)) from orders)

SELECT orderid, datediff(day, ORDERDATE, SHIPPEDDATE) from Orders
order by 2 desc

--z2 przerwa w zamowieniach
select customerid from customers
where customerid in (select CustomerID from orders o1
						where datediff(day, orderdate,(select top 1 orderdate from orders o2 
														where o1.CustomerID=o2.CustomerID and o2.orderid>o1.OrderID)) >62)

select datediff(day, orderdate,(select top 1 orderdate from orders o2 where o1.CustomerID=o2.CustomerID and o2.orderid>o1.OrderID)), CustomerID from orders o1
where datediff(day, orderdate,(select top 1 orderdate from orders o2 where o1.CustomerID=o2.CustomerID and o2.orderid>o1.OrderID)) >62
order by CustomerID

--z3 3.	Wypisać identyfikatory tych pracowników, którzy realizowali więcej zamówień niż liczba zamówień zrealizowanych przez pracowników z tego samego kraju co spedytorzy.
select count(orderid), EmployeeID from Orders
group by EmployeeID
having count(OrderID)>all(select count(*)from orders inner join Employees
							on Employees.EmployeeID=Orders.EmployeeID
							where Employees.Country=ShipCountry
							group by orders.EmployeeID)

--4	W firmie używającej bazy Northwind pracownicy (tabela Employees) posiadają adresy emial’owe. Załóżmy, że standardowo nazwa konta (część przed znakiem @)
-- zbudowana jest z pierwszej litery imienia (firstname), inicjału środkowego (pole middlinitial) oraz pierwszych ośmiu znaków nazwiska (lastname). 
--Utwórz zapytanie, które wygeneruje te nazwy email’owe. W tym zadaniu należy użyć funkcji łańcuchowych LOWER i SUBSTRING.

select LOWER(SUBSTRING(firstname,1,1)+SUBSTRING(lastname,1,8))+'@wsiz.edu.pl' AS 'e-mail' from Employees 

SELECT FirstName, LastName FROM Employees

--5.Podaj dzień w którym było najwięcej zamówień
select datename(weekday, orderdate)as 'day' from orders
group by datename(weekday,orderdate)
having count(OrderID)>= all(select count(OrderID) from orders group by datename(weekday,OrderDate))

select count(OrderID)as 'number', datename(weekday,OrderDate)as 'day' from orders
group by datename(weekday,OrderDate)
order by 1 desc

select DATENAME(WEEKDAY, orderid) from Orders

select OrderID, OrderDate from orders
order by OrderDate

--6.	Wypisz nazwę i adres najczęściej zamawiającego klienta
select companyname, address from Customers
where companyname=(select companyname from customers
inner join orders on orders.CustomerID=Customers.CustomerID
group by CompanyName
having count(orderID)>=all(select count(orderID) from orders
group by CustomerID))

select count(orderID) from orders
group by CustomerID
order by 1 desc
