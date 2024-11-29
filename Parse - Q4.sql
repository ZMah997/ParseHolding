Create or Alter Procedure  GetProductOrderCount
    @ProductID INT
AS
BEGIN
    select 
        sd.ProductID,
        count(sd.SalesOrderDetailID) as OrderCount
    from [adventureworks2022].[sales].[salesorderheader] sa
    inner join sales.salesorderdetail sd on sd.salesorderid = sa.salesorderid
    where sa.onlineorderflag = 1 
      and sd.ProductID = @ProductID
    group by sd.ProductID;

END;

EXEC GetProductOrderCount @ProductID = 879;
