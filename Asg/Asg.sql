CREATE DATABASE Assignment_Study_Network

use Assignment_Study_Network

CREATE TABLE Users(
	userID char(12) PRIMARY KEY,
	FirstName varchar(255),
	LastName varchar(255),
	School varchar(255),
	userAddress varchar(255),
	Email varchar(255),
	PhoneNum varchar(255),
	userLocation varchar(255),
	DOB varchar(255),
	Gender varchar(255)
)

CREATE TABLE Posts(
	postID char(12) PRIMARY KEY,
	userID char(12) FOREIGN KEY REFERENCES Users(userID),
	postData varchar(255),
	postContent varchar(255)
)

CREATE TABLE Friends (
	FriendID char(12),
	userID char (12) FOREIGN KEY REFERENCES Users(userID)
)

CREATE TABLE Page_Likes(
	userID char(12) FOREIGN KEY REFERENCES Users(userID),
	PageID char(12) PRIMARY KEY
)

CREATE TABLE Pages(
	PageID char(12) FOREIGN KEY REFERENCES Page_Likes(PageID),
	PageName varchar(255),
	PageContent varchar(255)
)

CREATE TABLE Post_Likes(
	postID char(12) FOREIGN KEY REFERENCES Posts(postID),
	userID char(12) FOREIGN KEY REFERENCES Users(userID)
)

CREATE TABLE Photos(
	ImageContent varchar(255),
	photoID char(12) PRIMARY KEY,
	postID char(12) FOREIGN KEY REFERENCES Posts(postID)
)

CREATE TABLE Shares(
	postID char(12) FOREIGN KEY REFERENCES Posts(postID),
	userID char(12) FOREIGN KEY REFERENCES Users(userID)
)

CREATE TABLE Comments(
	CommentDate varchar(255),
	postID char(12) FOREIGN KEY REFERENCES Posts(postID),
	commentID char(12) PRIMARY KEY,
	userID char(12) FOREIGN KEY REFERENCES Users(userID),
	CommentContent varchar(255)
)

CREATE TABLE Comment_Likes(
	commentID char(12) FOREIGN KEY REFERENCES Comments(commentID),
	userID char(12) FOREIGN KEY REFERENCES Users(userID)
)