-- Q7
use AdventureWorks2022


-- KPI 1 : میانگین ارزش هر سفارش اینترنتی  (Average Order Value - AOV)

select 
    sum((sd.orderqty * sd.unitprice) - sd.unitpricediscount) / count(distinct sa.salesorderid) as averageordervalue
from sales.salesorderheader sa
inner join sales.salesorderdetail sd on sa.salesorderid = sd.salesorderid
where sa.onlineorderflag = 1



--KPI 2 : نرخ بازگشت مشتریان  (Repeat Customer Rate - RCR)

with customerordercount as (
    select 
        sa.customerid,
        count(distinct sa.salesorderid) as OrderCount
    from sales.salesorderheader sa
    where sa.onlineorderflag = 1
    group by sa.customerid
)
select 
    cast(sum(case when ordercount > 1 then 1 else 0 end) as float) / count(*) * 100 as repeatcustomerrate
from customerordercount 



--KPI 3 :میانگین تعداد کالا در هر سفارش (Average Items Per Order)

select 
    sum(sd.orderqty) / count(distinct sa.salesorderid) as [AverageItems/Order]
from sales.salesorderheader sa
inner join sales.salesorderdetail sd on sa.salesorderid = sd.salesorderid
where sa.onlineorderflag = 1
