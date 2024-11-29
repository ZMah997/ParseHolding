--Q2

select [Top2CustomerID], totalamount
from (
    select 
        sa.CustomerID as [Top2CustomerID],
        sum((sd.orderqty * sd.unitprice) - sd.unitpricediscount) as totalamount,
        row_number() over (order by sum((sd.orderqty * sd.unitprice) - sd.unitpricediscount) desc) as rank
    from [adventureworks2022].[sales].[salesorderheader] sa
    inner join sales.salesorderdetail sd on sd.salesorderid = sa.salesorderid
    where sa.onlineorderflag = 1 
    group by sa.customerid
) as rankedcustomers
where rank = 2
