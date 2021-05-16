CREATE DATABASE bakMovie
Go

USE bakMovie



CREATE TABLE Users(
	UserId CHAR(6),
	Nickname VARCHAR(255) not null,
	Fullname VARCHAR(255) not null,
	Email VARCHAR(255) not null,
	City VARCHAR(255) not null,
	[Description] VARCHAR(255) not null,

	CONSTRAINT User_pk PRIMARY KEY(UserId),

	CONSTRAINT nickname_len_check CHECK(LEN(Nickname) > 5),
	CONSTRAINT email_check CHECK(Email like '%@%'),
	CONSTRAINT userId_check CHECK(UserId like 'USR[0-9][0-9][0-9]')
)

CREATE TABLE Director(
	DirectorId CHAR(6),
	[Name] VARCHAR(255) not null,
	Email VARCHAR(255) not null,
	City VARCHAR(255) not null,
	[Address] VARCHAR(255) not null,
	Phone VARCHAR(255) not null,

	CONSTRAINT Director_pk PRIMARY KEY (DirectorId),

	CONSTRAINT director_email_check CHECK(Email like '%@%'),
	CONSTRAINT director_phone_check CHECK(ISNUMERIC(Phone) = 1)
)