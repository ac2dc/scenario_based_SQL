-- https://www.sqlshack.com/how-to-implement-error-handling-in-sql-server/

USE AdventureWorks2014
GO
-- Basic example of TRY...CATCH
 
BEGIN TRY
-- Generate a divide-by-zero error  
  SELECT
    1 / 0 AS Error;
END TRY
BEGIN CATCH
  SELECT
    ERROR_NUMBER() AS ErrorNumber,
    ERROR_STATE() AS ErrorState,
    ERROR_SEVERITY() AS ErrorSeverity,
    ERROR_PROCEDURE() AS ErrorProcedure,
    ERROR_LINE() AS ErrorLine,
    ERROR_MESSAGE() AS ErrorMessage;
END CATCH;
GO

-- Table to record errors
 
CREATE TABLE DB_Errors
         (ErrorID        INT IDENTITY(1, 1),
          UserName       VARCHAR(100),
          ErrorNumber    INT,
          ErrorState     INT,
          ErrorSeverity  INT,
          ErrorLine      INT,
          ErrorProcedure VARCHAR(MAX),
          ErrorMessage   VARCHAR(MAX),
          ErrorDateTime  DATETIME)
GO

-- Begining of procedure
CREATE OR ALTER PROC dbo.AddSale @employeeid INT,
                   @productid  INT,
                   @quantity   SMALLINT,
                   @saleid     UNIQUEIDENTIFIER OUTPUT
AS
SET @saleid = NEWID()
  BEGIN TRY
    INSERT INTO Sales.Sales
         SELECT
           @saleid,
           @productid,
           @employeeid,
           @quantity
  END TRY
  BEGIN CATCH
    INSERT INTO dbo.DB_Errors
    VALUES
  (SUSER_SNAME(),
   ERROR_NUMBER(),
   ERROR_STATE(),
   ERROR_SEVERITY(),
   ERROR_LINE(),
   ERROR_PROCEDURE(),
   ERROR_MESSAGE(),
   GETDATE());
  END CATCH
GO


