--Q6
create View Top3to5Product 
as
select rank , [3to5Product], totalamount
from (
    select 
        sd.ProductID as [3to5Product],
        sum((sd.orderqty * sd.unitprice) - sd.unitpricediscount) as totalamount,
        row_number() over (order by sum((sd.orderqty * sd.unitprice) - sd.unitpricediscount) desc) as rank
    from [adventureworks2022].[sales].[salesorderheader] sa
    inner join sales.salesorderdetail sd on sd.salesorderid = sa.salesorderid
    where sa.onlineorderflag = 1 
    group by sd.ProductID
) as rankedcustomers
where rank between 3 and 5 


select * from Top3to5Product