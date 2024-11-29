--Q1

use AdventureWorks2022

SELECT 
cr.Name ,
sum((sd.OrderQty*sd.UnitPrice)-sd.UnitPriceDiscount )

  FROM [AdventureWorks2022].[Sales].[SalesOrderHeader] sa
	 inner join sales.SalesOrderDetail sd on sd.SalesOrderID = sa.SalesOrderID
	 inner join Sales.Customer c on c.CustomerID = sa.CustomerID
	 inner join Person.Person p on p.BusinessEntityID = c.PersonID
	 inner join Person.BusinessEntityAddress bad on bad.BusinessEntityID = p.BusinessEntityID
	 inner join Person.Address ad on ad.AddressID = bad.AddressID
	 inner join Person.StateProvince sp on sp.StateProvinceID = ad.StateProvinceID
	 inner join Person.CountryRegion cr on cr.CountryRegionCode = sp.CountryRegionCode

where sa.OnlineOrderFlag = 1

Group by cr.Name

order by 2 desc , 1