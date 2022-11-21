select * from Customers
where city ='London'


--1
select *
from (select * from Customers where city ='London') mieszkancylondynu
where companyname like '[a-c]%'

--2

select orders.orderid, RegionDescription, OrderDate,(select avg(Quantity*UnitPrice)from [Order Details])
from Orders inner join Employees
on orders.EmployeeID=Employees.EmployeeID
inner join [Order Details]
on Orders.OrderID=[Order Details].OrderID
inner join EmployeeTerritories
on Employees.EmployeeID=EmployeeTerritories.EmployeeID
inner join Territories
on Territories.TerritoryID=EmployeeTerritories.TerritoryID
inner join Region
on Region.RegionID=EmployeeTerritories.EmployeeID
--
where RegionDescription='eastern' and OrderDate like '%1996%' and (Quantity*UnitPrice)>(select avg(Quantity*UnitPrice)from [Order Details])

--3
select * from Products
where UnitPrice=(select min(unitprice)from products)

--4 zapytanie skorelowane 
select productname, UnitPrice, CategoryID from Products p1
where UnitPrice in (select min(unitprice)
					from Products p2
					where p1.CategoryID=p2.CategoryID)

--5 
select count(*) ilosc from Employees e1
where city in (select city from Employees e2
				where e1.EmployeeID!=e2.EmployeeID)

select city, EmployeeID from Employees 

--6 
select ProductID from Products 
except  
select distinct ProductID from [Order Details]


select Products.ProductID, OrderID
from Products left join [Order Details]
on Products.ProductID=[Order Details].ProductID
where OrderID is null

--7

select Customers.CustomerID
from Customers left join Orders
on Customers.CustomerID=Orders.CustomerID
where OrderID is null
