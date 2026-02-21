#Part 1: Individual Project Requirements
#1 
select concat(c.FirstName,'',c.LastName) as FullName ,o.OrderID,o.OrderDateID
from customers c
join orders o on
c.customerID = o.customerID;
#2
select concat(c.FirstName,'',c.LastName) as FullName,sum(od.UnitPrice * od.Quantity) as Total_Amount_Spent from
customers c
join orders o on
c.customerID = o.customerID 
join orderdetails od on
o.OrderID = od.OrderID
group by FullName
order by Total_Amount_Spent desc;
#3
select p.ProductName, sum(od.Quantity) as Quantity_Sold
from products p
join orderdetails od on 
p.ProductID = od.ProductID
group by p.ProductName 
order by Quantity_Sold desc
limit 5;
#4
select ProductName , StockQuantity 
from products
where StockQuantity < 10;
#5
select c.FirstName, c.LastName
from Customers c
left join Orders o on c.CustomerID = o.CustomerID
where o.OrderID is null;     
#6
select distinct c.FirstName, c.LastName
from Customers c
join Orders o on c.CustomerID = o.CustomerID
join OrderDetails od on o.OrderID = od.OrderID
where od.UnitPrice > (select AVG(Price) from Products);
#7
select cal.year, cal.month, sum(o.TotalAmount) as MonthlySales
from Orders o
join Calendar cal on o.OrderDateID = cal.DateID
group by cal.year, cal.month
having MonthlySales > 10000;
#8
select ProductName, Price 
from Products 
where Price > (select AVG(Price) from Products);
#9
select c.FirstName, c.LastName, sum(o.TotalAmount) AS TotalSpent
from Customers c
join Orders o on c.CustomerID = o.CustomerID
group by c.CustomerID
having TotalSpent > 5000;
#10#####(could be solved using not in )
select p.ProductName
from Products p
left join OrderDetails od
on p.ProductID = od.ProductID
where od.ProductID is null;
#11
select AVG(TotalAmount) as AOV from Orders;    ####SUM(TotalAmount) / COUNT(OrderID) = AOV
#12
select a.City, count(o.OrderID) as Number_Of_Orders
from orders o
join customers c on o.CustomerID = c.CustomerID
join address a on c.AddressID = a.AddressID
group by a.City
order by Number_Of_Orders desc;
#13
select ProductName, Price 
from Products 
where Price between 50 and 200
order by Price desc;
#14
select c.CategoryName, sum(od.Quantity) as Total_Quantity_Sold
from categories c
join Products p on c.CategoryID = p.CategoryID
join orderdetails od on p.ProductID = od.ProductID
group by c.CategoryName
order by Total_Quantity_Sold desc
limit 1;
#15
select p.ProductID, p.ProductName, sum(od.Quantity * od.UnitPrice) as Total_Sales
from products p
join orderdetails od on p.ProductID = od.ProductID
group by p.ProductID, p.ProductName
order by Total_Sales desc;
############(PART-2)############
#task1
select concat(FirstName,'',LastName) as FullName, RegistrationDateID,
case 
when RegistrationDateID <'2024-1-1' then 'Old Customer'
else 'New Customer'
end as Customer_Status 
 from customers;
 #task2
select concat(c.FirstName,'',c.LastName) as FullName, c.CustomerID, count(o.OrderID) as Number_of_Orders
 from customers c
 join orders o on 
 c.CustomerID = o.CustomerID
 group by  FullName, c.CustomerID
 having count(o.OrderID) = 1;
 #task3
select p.ProductName, p.ProductID , sum(od.Quantity * od.UnitPrice) as Total_Revenue
from products p  
join orderdetails od on 
p.ProductID = od.ProductID
group by p.ProductName, p.ProductID 
order by Total_Revenue desc;
#task4
select MIN(TotalAmount) as Minimun_Order_value,
MAX(TotalAmount) as Maximum_Order_value, 
AVG(TotalAmount) as Average_Order_value
from orders;
#task5
#(categories-with-HIGHEST-number of products)
select c.CategoryName, c.CategoryID, count(p.ProductID) as  Number_Of_Products
 from categories c
 join products p on
 c.CategoryID = p.CategoryID
 group by c.CategoryName, c.CategoryID
 order by  Number_Of_Products desc
limit 1;
#(categories-with-LOWEST-number of products)
select c.CategoryName, c.CategoryID, count(p.ProductID) as  Number_Of_Products
 from categories c 
 join products p on
 c.CategoryID = p.CategoryID
 group by c.CategoryName, c.CategoryID
 order by  Number_Of_Products asc
limit 1;

############(PART-3-problem-solving)############
#1#
insert into Customers (FirstName, LastName, Email, AddressID, RegistrationDateID)
values ('Mohamed','Ahmed','mohamed@example.com',1, (select DateID from Calendar where date = '2024-01-01'));  #successfully affected 
select*from Customers   #to verify the addition of a new customer (1)
where Email = 'mohamed@example.com';
update Customers   #updated the phone---instead of a null its not provided 
set Phone = 'not_provided'
where Email = 'mohamed@example.com';
select*from Customers   #the update check (2)
where Email = 'mohamed@example.com';

#2#
insert into Products (ProductName, Price, StockQuantity, CategoryID)
values ('Laptop X200', 1500, 10, (select CategoryID from Categories where CategoryName = 'Electronics'));
select*from products    #the update check
where ProductName = 'Laptop X200';

update Products         #Updated the stock
set StockQuantity = 50
where StockQuantity = 0;
select*from Products    #successfully checked for zero stock 
where StockQuantity = 0;

#3#
select * from Address 
where City = 'Cairo ';  #detect the problem precence (didnt find the problem, output's null)
select distinct City from Address;                  #(checked by the filter if cairo is there originally, its not!)
update Address                                      #(the update query was prepared as a preventive measure)
set City = 'Cairo'
where City = 'Cairo ';