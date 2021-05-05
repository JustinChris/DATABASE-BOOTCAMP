CREATE DATABASE session2

USE session2

CREATE TABLE Heroes(
	HeroId CHAR(5) PRIMARY KEY,
	HeroName VARCHAR(255),
	HeroType VARCHAR(10),
	HeroAttribute CHAR(3) 
		CHECK(HeroAttribute like 'int' or HeroAttribute like 'str' or HeroAttribute like 'agi')
)

CREATE TABLE Equipments (
	EquipmentId CHAR(5),
	HeroId CHAR(5), --FOREIGN KEY REFERENCES Heroes(HeroId)
	EquipmentName VARCHAR(255),
	EquipmentRarity VARCHAR(20),
	EquipmentPrice INT
	CONSTRAINT EquipmentsPK PRIMARY KEY(EquipmentId),
	CONSTRAINT EquipmentFK FOREIGN KEY (HeroId) REFERENCES Heroes(HeroId) 
		ON UPDATE CASCADE ON DELETE SET NULL
)

drop table Equipments

ALTER TABLE Equipments
ALTER COLUMN EquipmentName VARCHAR(200)

ALTER TABLE Heroes
ADD CONSTRAINT PKCheck CHECK(HeroId like 'HE[0-9][0-9][0-9]')

ALTER TABLE Heroes
DROP CONSTRAINT PKCheck

--DML
select * from Heroes

INSERT INTO Heroes (HeroId, HeroAttribute, HeroName, HeroType)
VALUES
('HE001', 'int', 'wukong', 'Melee')

INSERT INTO Heroes
VALUES
('HE002', 'test', 'Melee', 'agi')

INSERT INTO Heroes (HeroId,HeroAttribute)
VALUES
('HE004','str'),
('HE005','int')

select * FROM Heroes

DELETE FROM Heroes
WHERE HeroId like 'HE001'

UPDATE Heroes
SET HeroName = 'nautilus',
HeroType = 'Range'
WHERE HeroId like 'HE003'

select * from Heroes

BEGIN TRAN --Kayak Checkpoint
UPDATE Heroes
SET HeroName = Null
-- kalo udah commit gabisa rollback begitu juga sebaliknya
-- commit permanent
-- END Tran = ROLLBACK dan COMMIT
-- rollback balik
-- Commit simpan permanent
ROLLBACK 
COMMIT