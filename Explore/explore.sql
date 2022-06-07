use explore;

--DROP TABLE Rental_Transaction;
--DROP TABLE Branch;
--DROP TABLE Branch_Phone;
--DROP TABLE [Type];
--DROP TABLE Car;
--DROP TABLE Customer;
--DROP TABLE Customer_Phone;
--DROP TABLE Employee;
--DROP TABLE Employee_Phone;

CREATE TABLE Branch (
	BID NCHAR(4) PRIMARY KEY,
	Address_1 NCHAR(50)NOT NULL,
	Address_2 NCHAR(50) NULL,
	City NCHAR(20) NOT NULL,
	Province NCHAR(2) NOT NULL,
	Postal_Code NCHAR(6) NOT NULL
);

CREATE TABLE Branch_Phone (
	BID NCHAR(4) FOREIGN KEY REFERENCES Branch(BID) NOT NULL,
	Phone_Number NCHAR(10) NOT NULL,
	PRIMARY KEY (BID, Phone_Number)
);

CREATE TABLE [Type] (
	Type_ID NCHAR(2) PRIMARY KEY,
	Type_Name NCHAR(20) NOT NULL,
	Price_Per_Day NUMERIC(5,0) NOT NULL,
	Price_Per_Week NUMERIC(5,0) NOT NULL,
	Price_Per_Month NUMERIC(5,0) NOT NULL,
	Change_Branch_Fee NUMERIC(5,0) NOT NULL,
	Late_Fee NUMERIC(5,0) NOT NULL
);


CREATE TABLE Car (
	Car_ID NCHAR(7) PRIMARY KEY,
	BID NCHAR(4) FOREIGN KEY REFERENCES Branch(BID) NOT NULL,
	Type_ID NCHAR(2) FOREIGN KEY REFERENCES [Type](Type_ID) NOT NULL,
	Year NUMERIC(4) NOT NULL,
	Brand NCHAR(10) NOT NULL,
	Model NCHAR(10) NOT NULL,
	Mileage NUMERIC(7) NOT NULL
);

CREATE TABLE Customer (
	CID NCHAR(7) PRIMARY KEY,
	First_Name NCHAR(20) NOT NULL,
	Last_Name NCHAR(20) NOT NULL,
	Driver_License NUMERIC(9,0) NOT NULL,
	Gender NCHAR(1) NOT NULL,
	DOB NUMERIC(8,0) NOT NULL,
	Membership NUMERIC(1) NOT NULL,
	Address_1 NCHAR(50) NOT NULL,
	Address_2 NCHAR(50) NULL,
	City NCHAR(20) NOT NULL,
	Province NCHAR(2) NOT NULL,
	Postal_Code NCHAR(6) NOT NULL,
	Email NCHAR(50) NOT NULL,
);

CREATE TABLE Customer_Phone (
	CID NCHAR(7) FOREIGN KEY REFERENCES Customer(CID),
	Phone_Number NCHAR(10),
	PRIMARY KEY (CID, Phone_Number)
);

CREATE TABLE Employee (
	EID NCHAR(5) PRIMARY KEY,
	BID NCHAR(4) FOREIGN KEY REFERENCES Branch(BID) NOT NULL,
	First_Name NCHAR(20) NOT NULL,
	Last_Name NCHAR(20) NOT NULL,
	Address_1 NCHAR(50) NOT NULL,
	Address_2 NCHAR(50) NULL,
	City NCHAR(20) NOT NULL,
	Province NCHAR(2) NOT NULL,
	Postal_Code NCHAR(6) NOT NULL,
	Work_Email NCHAR(50) NOT NULL,
	Personal_Email NCHAR(50) NOT NULL,
);

CREATE TABLE Employee_Phone (
	EID NCHAR(5) FOREIGN KEY REFERENCES Employee(EID),
	Phone_Number NCHAR(10),
	PRIMARY KEY (EID, Phone_Number)
);

CREATE TABLE Rental_Transaction (
	TID NCHAR(10) PRIMARY KEY,
	Type_Requested NCHAR(2)  FOREIGN KEY REFERENCES [Type](Type_ID) NOT NULL,
	Car_Received_ID NCHAR(7) FOREIGN KEY REFERENCES Car(Car_ID) NOT NULL,
	CID NCHAR(7) FOREIGN KEY REFERENCES Customer(CID) NOT NULL,
	Pickup_Branch_ID NCHAR(4) FOREIGN KEY REFERENCES Branch(BID) NOT NULL,
	Return_Branch_ID NCHAR(4) FOREIGN KEY REFERENCES Branch(BID) NULL,
	EID_Pickup NCHAR(5) FOREIGN KEY REFERENCES Employee(EID) NOT NULL,
	[Start_Date] NUMERIC(8,0) NOT NULL,
	[End_Date] NUMERIC(8,0) NOT NULL,
	Reservation_Price NUMERIC(5,2) NOT NULL,
	Return_Date NUMERIC(8,0) NULL,
	Total_Price NUMERIC(5,2) NULL
);