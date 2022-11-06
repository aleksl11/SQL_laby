--1
select CategoryID, avg(UnitPrice) as average from Products
where CategoryID != (select CategoryID=(select CategoryID from Categories where CategoryName='Seafood'))
group by CategoryID;

--2
select CategoryID, avg([Order Details].UnitPrice-([Order Details].UnitPrice*Discount))as average  from [Order Details]
inner join Products on Products.ProductID=[Order Details].ProductID
group by CategoryID

--3
Select Categoryname, AVG(UnitPrice)as averagePrice from Products
inner join Categories on Products.CategoryID=Categories.CategoryID
group by CategoryName having AVG(UnitPrice)>10

--4
select min(HireDate)as hireDate, Title from Employees
group by Title

--5
select LastName, year(GETDATE())-year(BirthDate) as age from Employees 

--6
select LastName, len(LastName)as nameLength from Employees

--7
select count(*) as ilosc from Employees e1
where city in (select city from Employees e2
				where e1.EmployeeID!=e2.EmployeeID)

--8
select ContactName, fax from Customers
where fax is null

