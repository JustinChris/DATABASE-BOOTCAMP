use doto

select *
from Equipments
where EquipmentPrice between 12 and 300
-- = < > <= >= and or

select *
from Users
where not UserName like '%a%'
-- kalo %a akhirannya harus a
-- kalo a% awalannya harus a
-- harus pake like buat nyari kalo misalnya UserName = '%a%' bakal nanggep literally