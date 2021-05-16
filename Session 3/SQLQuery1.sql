USE doto

-- aggregate: MAX, MIN, AVG, COUNT, SUM
SELECT MAX(EquipmentName) AS [Max of equipment name] --Lexicographically
FROM Equipments

SELECT *
FROM Equipments

SELECT MAX(EquipmentName) AS [Max of equipment name],
		MIN(EquipmentName) AS [Min of equipment name]
FROM Equipments

SELECT EquipmentRarity, SUM (EquipmentPrice) AS [total equipment price]
FROM Equipments
GROUP BY EquipmentRarity
ORDER BY EquipmentRarity

SELECT HeroId, EquipmentRarity, SUM(EquipmentPrice) as [total equipment price]
FROM Equipments
GROUP BY HeroId, EquipmentRarity



SELECT HeroId, SUM(EquipmentPrice) as [total equipment price]
FROM Equipments
GROUP BY HeroId
HAVING SUM(EquipmentPrice) < 300


SELECT LEFT('BUDI',2)
SELECT SUBSTRING ('BUDI', 2, 2)
SELECT CHARINDEX('ud', 'hasbdkajsdnajkbudi',3)
SELECT STUFF('BUDI',2,2, 'DIPAS')
SELECT REPLACE('ANNAN','N','X')

SELECT CAST(15 AS VARCHAR) + '$'
SELECT CONVERT (VARCHAR,15) + '$'

SELECT GETDATE()

SELECT DATENAME(DAY, '2001-2-2')
SELECT DATENAME(WEEKDAY, '2001-2-2')
SELECT DATENAME(WEEKDAY,GETDATE())

SELECT DATEDIFF(DAY, '2001-2-1','2004-9-1')

SELECT YEAR('2001-9-1')
SELECT DAY('2001-9-1')
SELECT MONTH('2001-9-1')