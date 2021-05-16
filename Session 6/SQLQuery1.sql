use OOVEO_Salon
-- Soal Aggregate
-- 1
SELECT 
	MAX(Price) as [Maximum Price],
	Min(Price) as [Minimum Price],
	CAST(ROUND(AVG(Price),0) as decimal(18, 2))
	as [Average Price]
FROM MsTreatment

-- 2
SELECT 
	StaffPosition,
	LEFT(StaffGender,1) as [Gender],
	'Rp. ' + CAST(CAST(AVG (StaffSalary) as decimal(18,2)) as varchar)as [Average Salary]
FROM MsStaff
GROUP BY StaffPosition, StaffGender

-- 3
SELECT 
	CONVERT(varchar, TransactionDate, 107) -- 107 dapet dari dokumentasi with century
	as [Transaction Date],
	COUNT(TransactionId) as [Total Transaction per Day]
FROM HeaderSalonServices
GROUP BY TransactionDate

-- 4
SELECT
	UPPER(CustomerGender) as [CustomerGender],
	COUNT(hss.TransactionId) as [Total Transaction]
FROM MsCustomer as mc
JOIN HeaderSalonServices as hss on mc.CustomerId = hss.CustomerId
GROUP BY CustomerGender

-- 5
SELECT 
	mtt.TreatmentTypeName,
	COUNT(dss.TransactionId) as [Total Transaction]
FROM DetailSalonServices as dss
JOIN MsTreatment as mt on dss.TreatmentId = mt.TreatmentId
JOIN MsTreatmentType as mtt on mt.TreatmentTypeId = mtt.TreatmentTypeId
GROUP BY TreatmentTypeName
ORDER BY [Total Transaction] DESC

-- 6
SELECT *
FROM HeaderSalonServices

----------------------------------------
-- soal 05_view
USE OOVEO_Salon
GO
-- 1
CREATE VIEW ViewBonus
AS
SELECT
	STUFF(CustomerId, 1, 2, 'BN') as BinusId,
	CustomerName
FROM MsCustomer
WHERE LEN(CustomerName) > 10
GO

SELECT *
FROM ViewBonus

-- 2
CREATE VIEW ViewCustomerData
AS
SELECT
	SUBSTRING(CustomerName, 1, CHARINDEX(' ', Customername) - 1) as [Name],
	CustomerAddress as [Address],
	CustomerPhone as [Phone]
FROM MsCustomer
WHERE CustomerName like '% %'
GO

-- 3
CREATE VIEW ViewTreatment
AS
SELECT
	mt.TreatmentName,
	mtt.TreatmentTypeName,
	'Rp. ' + CAST(mt.Price as varchar) as [Price]
FROM MsTreatment as mt
JOIN MsTreatmentType as mtt on mt.TreatmentTypeId = mtt.TreatmentTypeId
WHERE mtt.TreatmentTypeName = 'Hair Treatment' and mt.Price BETWEEN 450000 AND 800000
GO

-- 4
CREATE VIEW ViewTransaction
AS
SELECT s.StaffName, c.CustomerName, CONVERT(VARCHAR, hss.TransactionDate, 106) as [TransactionDate], hss.PaymentType
FROM HeaderSalonServices as hss 
JOIN MsCustomer as c on hss.CustomerId = c.CustomerId
JOIN MsStaff as s on hss.StaffId = s.StaffId
WHERE hss.PaymentType = 'Credit' AND DAY(hss.TransactionDate) BETWEEN 21 AND 25
GO

-- 5
CREATE VIEW ViewBonusCustomer
AS
SELECT
	REPLACE(c.CustomerId, 'CU', 'BN') as [BonusId],
	LOWER(REVERSE(SUBSTRING(REVERSE(c.CustomerName), 1,CHARINDEX(' ', REVERSE(c.CustomerName))- 1))) as [Name],
	DATENAME(WEEKDAY,hss.TransactionDate) as [Day],
	CONVERT(VARCHAR, hss.TransactionDate, 101) as [TransactionDate]
FROM MsCustomer as c
JOIN HeaderSalonServices as hss on hss.CustomerId = c.CustomerId
WHERE CustomerName like '% %a%'
GO

-- 6
SELECT 
	hss.TransactionId,
	CONVERT(VARCHAR, hss.TransactionDate, 107) as [Date],
	t.TreatmentName
FROM MsStaff as s
JOIN HeaderSalonServices as hss on s.StaffId = hss.StaffId
JOIN DetailSalonServices as dss on hss.TransactionId = dss.TransactionId
JOIN MsTreatment as t on dss.TreatmentId = t.TreatmentId
WHERE DAY(hss.TransactionDate) = 21 AND s.StaffName like 'Livia Ashianti'

-- 8
CREATE VIEW ViewCustomer
AS
SELECT CustomerId, CustomerName, CustomerGender
FROM MsCustomer
GO

BEGIN TRAN
GO
INSERT INTO ViewCustomer
VALUES ('CU006', 'Christian', 'Male')
GO
SELECT *
FROM MsCustomer
GO
ROLLBACK
GO
-- 9

-- 10
DROP VIEW ViewCustomerData

-- CONTOH DELETE DARI VIEW
BEGIN TRAN
GO
DELETE FROM ViewCustomer
WHERE CustomerId = 'CU005'
GO
SELECT *
FROM MsCustomer
GO
ROLLBACK
GO

-- GRANT AND REVOKE
-- CURSORS
DECLARE
	@name varchar(max),
	@phone varchar(20)

DECLARE customerCursor CURSOR

-- Procedure

CREATE PROCEDURE GetTransactionByTotal(
	@total int

)
AS
SELECT hss.TransactionId, COUNT (*) as [Total Treatment]
FROM HeaderSalonServices as hss
JOIN DetailSalonServices as dss on hss.TransactionId = dss.TransactionId
GROUP BY hss.TransactionId
HAVING COUNT (*) = @total
GO

EXEC GetTransactionByTotal 4

-- DROP STORED PROCEDURE
DROP PROCEDURE GetTransactionByTotal

-- TRIGGERS
-- STORED PROCEDURE that is automatically executed when an event occurs

-- CREATE TRIGGER SYNTAX

GO
CREATE TRIGGER  InsteadOfDeleteCustomer
ON MsCustomer
INSTEAD OF DELETE
AS
	SELECT *
	FROM MsCustomer
GO

DELETE FROM MsCustomer
WHERE CustomerGender = 'Male'


-- FUNCTION
CREATE FUNCTION testFunction(@string VARCHAR(max))
RETURNS VARCHAR(max)
AS
	BEGIN
	RETURN @string + '....'
	END

SELECT dbo.testFunction(CustomerName)
FROM MsCustomer