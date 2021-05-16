USE OOVEO_Salon

SELECT *
FROM MsTreatmentType
WHERE TreatmentTypeId = 'TT002' OR TreatmentTypeId = 'TT003'

SELECT *
FROM MsTreatmentType
WHERE TreatmentTypeId in ('TT002', 'TT003') --Sama aja kayak yang diatas biar lebih dikit aja nulisnya

SELECT *
FROM MsTreatmentType
WHERE TreatmentTypeId in ('TT002', 'TT003') OR TreatmentTypeId in ('TT001') -- bisa pake or and juga dst.

-- IN gabisa regex
-- Kalo mau ada regex harus pake like


-- EXISTS

-- USED with subquery.

SELECT *
FROM MsCustomer as c
WHERE EXISTS (
	SELECT *
	FROM HeaderSalonServices as hss
	WHERE c.CustomerId = hss.CustomerId AND PaymentType = 'Credit'
)

-- In dengan subquery

SELECT *
FROM MsCustomer as c
WHERE c.CustomerId in (
	SELECT hss.CustomerId
	FROM HeaderSalonServices as hss
)

-- 1
SELECT TreatmentId, TreatmentName
FROM MsTreatment
WHERE TreatmentId in ('TM001', 'TM002')

-- 3
SELECT c.CustomerName, c.CustomerPhone, c.CustomerAddress
FROM MsCustomer as c
WHERE LEN(CustomerName) > 8 and c.CustomerId in(
	SELECT hss.CustomerId
	FROM HeaderSalonServices as hss
	WHERE DATENAME(WEEKDAY, TransactionDate) = 'Friday'
)

SELECT c.CustomerName, c.CustomerPhone, c.CustomerAddress
FROM MsCustomer as c
WHERE LEN(CustomerName) > 8 and EXISTS (
	SELECT hss.CustomerId
	FROM HeaderSalonServices as hss
	WHERE DATENAME(WEEKDAY, TransactionDate) = 'Friday' AND c.CustomerId = hss.CustomerId
)

-- ALL returns true if all value in the set meets the condition, can be used on SELECT
-- ANY return true if any value in the set meets the condition, Cannot be used on SELECT

SELECT *
FROM MsStaff
WHERE StaffSalary <= ALL (
	SELECT StaffSalary
	FROM MsStaff
)

SELECT *
FROM MsStaff
WHERE StaffSalary < ANY (
	SELECT StaffSalary
	FROM MsStaff
)
ORDER BY StaffSalary DESC

-- ORDER BY Tidak bisa dipakai di dalam subQuery

SELECT *
FROM MsStaff
WHERE StaffSalary <= ALL (
	SELECT StaffSalary
	FROM MsStaff
)
UNION
SELECT *
FROM MsStaff
WHERE StaffSalary >= ALL (
	SELECT StaffSalary
	FROM MsStaff
)

SELECT *
FROM MsCustomer
WHERE EXISTS (
	SELECT *
	FROM MsStaff
	WHERE EXISTS(
		SELECT *
		FROM HeaderSalonServices
	)
)

-- Maximal 32 Subquery -> Subquery didalam subquery

-- Kalo Subquery di dalam FROM maka dia adalah alias subquery
-- Harus dikasih nama di setiap kolomnya

SELECT SUM(tempStaff.staffCount)
FROM (
	SELECT COUNT(*) as staffCount
	FROM MsStaff
) as tempStaff



-- 8
SELECT tt.TreatmentTypeName, t.TreatmentName, t.Price
FROM MsTreatment as t
JOIN (
	SELECT AVG(Price) as average
	FROM MsTreatment
) as avgPrice on t.Price > avgPrice.average
JOIN MsTreatmentType as tt ON t.TreatmentTypeId = tt.TreatmentTypeId


-- 9

		--Select StaffName, StaffPosition, StaffSalary
		--FROM MsStaff
		--WHERE(
		--	SELECT MAX(StaffSalary) as SalaryTerbesar
		--	FROM MsStaff
		--) as MaxSalary on MsStaff.StaffSalary = MaxSalary.SalaryTerbesar
		--UNION
		--FROM MsStaff
		--WHERE (
		--	SELECT MIN(StaffSalary) as SalaryTerkecil
		--	FROM MsStaff
		--) as MinSalary on MsStaff.StaffSalary = MinSalary.SalaryTerkecil

SELECT s.staffName, s.StaffPosition, s.StaffSalary
FROM MsStaff as s
JOIN (
	SELECT MAX(StaffSalary) as [maxSalary], MIN (StaffSalary) as [minSalary]
	FROM MsStaff
) as salaries on s.StaffSalary = salaries.minSalary OR s.StaffSalary = salaries.maxSalary

-- 10
SELECT c.CustomerName, c.CustomerPhone, c.CustomerAddress, treatmentCounts.treatmentCount as [Count Treatment]
FROM HeaderSalonServices as hss
JOIN (
	SELECT COUNT(TreatmentId) as [treatmentCount], TransactionId
	FROM DetailSalonServices as dss
	GROUP BY TransactionId
) as treatmentCounts on hss.TransactionId = treatmentCounts.TransactionId
JOIN MsCustomer as c on hss.CustomerId = c.CustomerId
WHERE treatmentCounts.treatmentCount = (
	SELECT  MAX(treatmentCounts.treatmentCount)
	FROM (
		SELECT COUNT(TreatmentId) as [treatmentCount]
		FROM DetailSalonServices as dss
		GROUP BY TransactionId
	) as treatmentCounts
)