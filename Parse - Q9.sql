

--------------------------------------------------------------------
--Q9 : تعیین لول افراد در جدول چارت سازمانی

Create table OrganizationalChart (
    Id int primary key,
    Name nvarchar(50),
    ManagerId int NULL,
    Manager nvarchar(100) NULL
)


Insert into OrganizationalChart (Id, Name, Manager, ManagerId)
Values
(1,'Ken', NULL, NULL),
(2,'Hugo', NULL, NULL),
(3,'James', 'Carol', 5),
(4,'Mark', 'Morgan', 13),
(5,'Carol', 'Alex', 12),
(6,'David', 'Rose', 21),
(7,'Michael', 'Markos', 11),
(8,'Brad', 'Alex', 12),
(9,'Rob', 'Matt', 15),
(10,'Dylan', 'Alex', 12),
(11,'Markos', 'Carol', 5),
(12,'Alex', 'Ken', 1),
(13,'Morgan', 'Matt', 15),
(14,'Jennifer', 'Morgan', 13),
(15,'Matt', 'Hugo', 2),
(16,'Tom', 'Brad', 8),
(17,'Oliver', 'Dylan', 10),
(18,'Daniel', 'Rob', 9),
(19,'Amanda', 'Markos', 11),
(20,'Ana', 'Dylan', 10),
(21,'Rose', 'Rob', 9),
(22,'Robert', 'Rob', 9),
(23,'Fill', 'Morgan', 13),
(24,'Antoan', 'David', 6) , 
(25,'Eddie', 'Mark', 4)



With cte_Levels as (
    -- سطح اول
    Select 
        ch.Id,
        ch.Name,
        ch.Manager,
        ch.ManagerId,
        1 as Level,
        ch.Name as TopManager
    From OrganizationalChart ch
    Where ManagerId IS NULL

    Union ALL

    -- سطوح بعدی
    Select 
        ch.Id,
        ch.Name,
        ch.Manager,
        ch.ManagerID,
        cte_Levels.Level + 1 as Level,
        cte_Levels.TopManager
    From OrganizationalChart ch
    JOIN  cte_Levels on ch.ManagerId = cte_Levels.id
)
Select *
From cte_Levels
Order by Level, Id ;


--------------------------------------------------------------------
