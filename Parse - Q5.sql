--Q5
create or alter procedure GetSalesGrowthByMonth
    @year int
as
begin
    ;with salesdata as (
        select 
            year(sa.modifieddate) as salesyear,
            month(sa.modifieddate) as salesmonth,
            sum((sd.orderqty * sd.unitprice) - sd.unitpricediscount) as totalamount
        from [adventureworks2022].[sales].[salesorderheader] sa
        inner join sales.salesorderdetail sd on sd.salesorderid = sa.salesorderid
        where sa.onlineorderflag = 1 
            and year(sa.modifieddate) = @year
        group by year(sa.modifieddate), month(sa.modifieddate)
    )
    select 
        salesyear,
        salesmonth,
        totalamount,
        previousmonthamount,
        case 
            when previousmonthamount is null then null
            else (totalamount - previousmonthamount) / nullif(previousmonthamount, 0) * 100
        end as salesgrowthpercentage
    from salesdata sd
    outer apply (
        select top 1 totalamount as previousmonthamount
        from salesdata
        where salesyear = sd.salesyear and salesmonth = sd.salesmonth - 1
        order by salesmonth desc
    ) as prevmonth
    order by salesmonth;
end;


Exec GetSalesGrowthByMonth @Year = 2013;
