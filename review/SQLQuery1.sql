Create database review
use review
-- CRUD -> create, read, Update, Delete

Create table Customers (
	--customer_id char(5) Primary Key
	--check(customer_id like 'CS[0-9][0-9][0-9]'),

	--Columns
	customer_id char(5),
	customer_favourite_number int identity(1, 1), -- buat bikin id identity -> mulai dari 1 tambah terus sebanyak 1
	customer_name varchar(30) unique,
	customer_age int not null,
	customer_location varchar(30) default 'Jakarta',

	-- keys
	constraint PK_customers primary key (customer_id),

	-- Constraint
	constraint customerCheckID
		check (customer_id like 'CS[0-9][0-9][0-9]')
)

insert into
	customers
values
	('CS002','Bima',25, 'Bandung')

select * from Customers

drop table Customers

create table transactionDetails(
	--Columns
	transactionDetails_id char(5),
	transactionDetails_name varchar(30),
	transactionDetails_price int,

	-- Keys
	constraint PK_transactionDetails
		primary key(transactionDetails_id),

	-- Constraints
	constraint transactionsDetailsCheckID
		check(transactionDetails_id like 'TD[0-9][0-9][0-9]')
)

create table transactions(
	-- Columns
	customer_id char(5),
	transactionsDetails_id char(5),

	-- Composite Key
	constraint CK_transactions
		primary key(customer_id, transactionsDetails_id)

	-- Foreign Keys
	constraint FK_customer_id
		foreign key (customer_id)
		references customers(customer_id)
		on update cascade
		on delete cascade

	Constraint FK_transactionsDetails_id
		foreign key (transactionsDetails_id)
		references transactionsDetails(transactionsDetails_id)
)