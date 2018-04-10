

USE master
Go
-- Drop database
IF DB_ID ('SQL2016Demo') IS NOT NULL
    DROP DATABASE SQL2016Demo;
GO
CREATE DATABASE SQL2016Demo;

USE SQL2016Demo;
GO
CREATE TABLE dbo.SalesPerson
(
SalesPersonId     Int IDENTITY,
SalesPersonName   Varchar (50),
SalesRegion       Varchar (50),
RowStartDate      date NOT NULL Default GetDate (),
RowEndDate        date NOT NULL Default '2079-12-31',
Constraint PK_SalesPerson_SalesPersonId Primary Key(SalesPersonId)
);
GO
CREATE TABLE dbo.SalesPersonHistory
(
SalesPersonId     Int NOT NULL,
SalesPersonName   Varchar (50),
SalesRegion       Varchar (50),
RowStartDate      date NOT NULL,
RowEndDate        date NOT NULL
);
GO
--Populate the dbo.SalesPerson Table with some initial data.
INSERT dbo.SalesPerson(SalesPersonName , SalesRegion , RowStartDate)
Values ('John Smith' , 'Hertfordshire' , '2015-05-01') ,
       ('Anthony Webster' , 'South West London', '2015-05-01'),
       ('Matt Williams' , 'Kingston upon Thames', '2015-05-01'),
       ('James Jenkinson' , 'Croydon', '2015-05-01'),
       ('Tom Bailey' , 'Slough', '2015-05-01')
GO


--step 3
USE SQL2016Demo;
GO
Create Procedure dbo.usp_UpdateSalesPersonRegion(@SalesPersonid INT, @SalesRegion Varchar(50))
As
Begin
SET NOCOUNT ON;
    UPDATE dbo.SalesPerson SET SalesRegion = @SalesRegion ,
                    RowStartDate = GetDate()
    OUTPUT    inserted.SalesPersonId,
inserted.SalesPersonName,
deleted.SalesRegion,
deleted.RowStartDate,
GetDate()-1 as RowEndDate
INTO dbo.SalesPersonHistory(
SalesPersonId,
SalesPersonName,
SalesRegion,
RowStartDate,
RowEndDate)
Where
SalesPerson.SalesPersonId = @SalesPersonid;SET NOCOUNT OFF;
END
GO
EXEC dbo.usp_UpdateSalesPersonRegion @SalesPersonid = 1,
@SalesRegion = 'North West London'
GO
EXEC dbo.usp_UpdateSalesPersonRegion @SalesPersonid = 2,
@SalesRegion = 'Hertfordshire'
USE SQL2016Demo;
GO
CREATE TABLE dbo.SalesPerson
(
SalesPersonId     Int IDENTITY,
SalesPersonName   Varchar (50),
SalesRegion       Varchar (50),
RowStartDate      date NOT NULL Default GetDate (),
RowEndDate        date NOT NULL Default '2079-12-31',
Constraint PK_SalesPerson_SalesPersonId Primary Key(SalesPersonId)
);
GO
CREATE TABLE dbo.SalesPersonHistory
(
SalesPersonId     Int NOT NULL,
SalesPersonName   Varchar (50),
SalesRegion       Varchar (50),
RowStartDate      date NOT NULL,
RowEndDate        date NOT NULL
);
GO
--Populate the dbo.SalesPerson Table with some initial data.
INSERT dbo.SalesPerson(SalesPersonName , SalesRegion , RowStartDate)
Values ('John Smith' , 'Hertfordshire' , '2015-05-01') ,
       ('Anthony Webster' , 'South West London', '2015-05-01'),
       ('Matt Williams' , 'Kingston upon Thames', '2015-05-01'),
       ('James Jenkinson' , 'Croydon', '2015-05-01'),
       ('Tom Bailey' , 'Slough', '2015-05-01')
GO


--step 3
USE SQL2016Demo;
GO
Create Procedure dbo.usp_UpdateSalesPersonRegion(@SalesPersonid INT, @SalesRegion Varchar(50))
As
Begin
SET NOCOUNT ON;
    UPDATE dbo.SalesPerson SET SalesRegion = @SalesRegion ,
                    RowStartDate = GetDate()
    OUTPUT    inserted.SalesPersonId,
inserted.SalesPersonName,
deleted.SalesRegion,
deleted.RowStartDate,
GetDate()-1 as RowEndDate
INTO dbo.SalesPersonHistory(
SalesPersonId,
SalesPersonName,
SalesRegion,
RowStartDate,
RowEndDate)
Where
SalesPerson.SalesPersonId = @SalesPersonid;SET NOCOUNT OFF;
END
GO
EXEC dbo.usp_UpdateSalesPersonRegion @SalesPersonid = 1,
@SalesRegion = 'North West London'
GO
EXEC dbo.usp_UpdateSalesPersonRegion @SalesPersonid = 2,
@SalesRegion = 'Hertfordshire'

--check hàng
select * from dbo.SalesPerson
EXCEPT
select * from dbo.SalesPersonHistory