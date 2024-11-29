use adventureworks2022;

with rankedcategories as (
    select 
        pc.name as categoryname,
        sum((sd.orderqty * sd.unitprice) - sd.unitpricediscount) as totalsales,
        rank() over (order by sum((sd.orderqty * sd.unitprice) - sd.unitpricediscount) desc) as rank_category
    from [adventureworks2022].[sales].[salesorderheader] sa
    inner join sales.salesorderdetail sd on sd.salesorderid = sa.salesorderid
    inner join production.product p on p.productid = sd.productid
    inner join production.productsubcategory ps on ps.productsubcategoryid = p.productsubcategoryid
    inner join production.productcategory pc on pc.productcategoryid = ps.productcategoryid
    where sa.onlineorderflag = 1
    group by pc.name
),
rankedsubcategories as (
    select 
        pc.name as categoryname,
        ps.name as subcategoryname,
        sum((sd.orderqty * sd.unitprice) - sd.unitpricediscount) as totalsales,
        rank() over (partition by pc.name order by sum((sd.orderqty * sd.unitprice) - sd.unitpricediscount) desc) as rank_subcategory
    from [adventureworks2022].[sales].[salesorderheader] sa
    inner join sales.salesorderdetail sd on sd.salesorderid = sa.salesorderid
    inner join production.product p on p.productid = sd.productid
    inner join production.productsubcategory ps on ps.productsubcategoryid = p.productsubcategoryid
    inner join production.productcategory pc on pc.productcategoryid = ps.productcategoryid
    where sa.onlineorderflag = 1
    group by pc.name, ps.name
)
select 
    rs.categoryname,
    rs.rank_subcategory,
    rs.subcategoryname,
    rs.totalsales
from rankedsubcategories rs
inner join rankedcategories rc on rs.categoryname = rc.categoryname
order by rc.rank_category, rs.rank_subcategory;
