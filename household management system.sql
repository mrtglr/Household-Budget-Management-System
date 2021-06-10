CREATE SCHEMA public AUTHORIZATION postgres;

COMMENT ON SCHEMA public IS 'standard public schema';

CREATE TABLE public.house (
	HouseNo SERIAL NOT NULL,
	HouseRent int4 NOT NULL,
	RoomNumber int4 NOT NULL,
	location varchar(50) NOT NULL,
	CONSTRAINT house_pk PRIMARY KEY (HouseNo)
);

CREATE TABLE public.family (
	Surname varchar(20) NOT NULL,
	MemberCount int4 NOT NULL,
	TotalIncome int4 NOT NULL,
	HouseNo int4 NOT NULL,
	CONSTRAINT family_pk PRIMARY KEY (Surname),
	CONSTRAINT family_fk FOREIGN KEY (HouseNo) REFERENCES house(HouseNo)
);

CREATE TABLE public.users (
	UserID SERIAL NOT NULL,
	Name varchar(25) NOT NULL,
	Surname varchar(25) NOT NULL,
	Age int4 NOT NULL,
	Gender varchar(10) NOT NULL,
	Birthday date NOT NULL,
	Job varchar(25),
	HasIncome boolean NOT NULL,
	CONSTRAINT user_pk PRIMARY KEY (UserID),
	CONSTRAINT user_fk FOREIGN KEY (Surname) REFERENCES family(Surname)
);

CREATE TABLE public.income (
	IncomeID SERIAL NOT NULL,
	TotalWorth int4 NOT NULL,
	UserID int4 NOT NULL,
	HasExtra boolean NOT NULL,
	CONSTRAINT income_pk PRIMARY KEY (IncomeID),
	CONSTRAINT income_fk FOREIGN KEY (UserID) REFERENCES users(UserID)
);

CREATE TABLE public.salary (
	SalaryNo SERIAL NOT NULL,
	Worth int4 NOT NULL,
	SalaryDate date NOT NULL,
	IncomeID int4 NOT NULL,
	CONSTRAINT salary_pk PRIMARY KEY (SalaryNo),
	CONSTRAINT salary_fk FOREIGN KEY (IncomeID) REFERENCES income(IncomeID)
);

CREATE TABLE public.extraincome (
	ExtID SERIAL NOT NULL,
	IncomeID int4 NOT NULL,
	ExtName varchar(25) NOT NULL,
	ExtWorth int4 NOT NULL,
	CONSTRAINT ExtID PRIMARY KEY (ExtID),
	CONSTRAINT extraincome_fk FOREIGN KEY (IncomeID) REFERENCES income(IncomeID)
);

CREATE TABLE public.balance (
	BalNo SERIAL NOT NULL,
	Total int4 NOT NULL,
	BalanceDate date NOT NULL,
	HouseNo int4 NOT NULL,
	CONSTRAINT balance_pk PRIMARY KEY (BalNo),
	CONSTRAINT balance_fk FOREIGN KEY (HouseNo) REFERENCES house(HouseNo)
);

CREATE TABLE public.expense (
	ExpID SERIAL NOT NULL,
	ExpName varchar(25) NOT NULL,
	ExpDate date NOT NULL,
	HouseNo int4 NOT NULL,
	CONSTRAINT expense_pk PRIMARY KEY (ExpID),
	CONSTRAINT expense_fk FOREIGN KEY (HouseNo) REFERENCES house(HouseNo)
);

CREATE TABLE public.bill (
	BillNo SERIAL NOT NULL,
	Cost int4 NOT NULL,
	BillName varchar(20) NOT NULL,
	BillDate date NOT NULL,
	ExpID int4 NOT NULL,
	CONSTRAINT bill_pk PRIMARY KEY (BillNo),
	CONSTRAINT bill_fk FOREIGN KEY (ExpID) REFERENCES expense(ExpID)
);

-- HOUSE 1

INSERT INTO public.house (HouseNo, HouseRent, RoomNumber, location)
VALUES (DEFAULT, 2000, 4, 'Cankaya Ankara');

INSERT INTO public.family (Surname, MemberCount, TotalIncome,HouseNo)
VALUES ('Keskin',3 , 15000 , 1);

INSERT INTO public.users (UserID, Name, Surname,Age,Gender,Birthday,Job,HasIncome)
VALUES (DEFAULT,'Alp Eren','Keskin', 22, 'Male','1999-12-24',NULL, false);

INSERT INTO public.users (UserID, Name, Surname,Age,Gender,Birthday,Job,HasIncome)
VALUES (DEFAULT,'Merve','Keskin', 40 , 'Female', '1980-05-01','Police', true);

INSERT INTO public.users (UserID, Name, Surname,Age,Gender,Birthday,Job,HasIncome)
VALUES (DEFAULT,'Ugur','Keskin', 45 , 'Female', '1975-11-20','Computer Engineer', true);

INSERT INTO public.income (IncomeID,TotalWorth, UserID,HasExtra)
VALUES (DEFAULT, 4500 , 2, false);

INSERT INTO public.income (IncomeID,TotalWorth, UserID,HasExtra)
VALUES (DEFAULT, 10500 , 3 , true);

INSERT INTO public.salary (SalaryNo, Worth, SalaryDate, IncomeID)
VALUES (DEFAULT, 4500, '2021-01-23', 1);

INSERT INTO public.salary (SalaryNo, Worth, SalaryDate, IncomeID)
VALUES (DEFAULT, 7500, '2021-05-15', 2);

INSERT INTO public.extraincome (ExtID, IncomeID, ExtName, ExtWorth)
VALUES (DEFAULT, 2, 'crypto trade', 3000);

INSERT INTO public.expense (ExpID, ExpName, ExpDate, HouseNo)
VALUES (DEFAULT, 'school expenses', '2021-01-20', 1);

INSERT INTO public.bill (BillNo, Cost, BillName, BillDate, ExpID)
VALUES (DEFAULT, 5000, 'schoolBill', '2021-01-20', 1);

INSERT INTO public.balance (BalNo, Total, BalanceDate, HouseNo)
VALUES (DEFAULT, 8000 , '2021-01-17', 1);

-- HOUSE 2

INSERT INTO public.house (HouseNo, HouseRent, RoomNumber, location)
VALUES (DEFAULT, 3000, 5, 'Umitkoy Ankara');

INSERT INTO public.family (Surname, MemberCount, TotalIncome,HouseNo)
VALUES ('Guler',1 , 7000 , 2);

INSERT INTO public.users (UserID, Name, Surname,Age,Gender,Birthday,Job,HasIncome)
VALUES (DEFAULT,'Halil Mert','Guler', 28 , 'Male', '1993-10-07','Program Developer', true);

INSERT INTO public.income (IncomeID,TotalWorth, UserID,HasExtra)
VALUES (DEFAULT, 6000 , 4 , true);

INSERT INTO public.salary (SalaryNo, Worth, SalaryDate, IncomeID)
VALUES (DEFAULT, 5500, '2021-04-02', 3);

INSERT INTO public.extraincome (ExtID, IncomeID, ExtName, ExtWorth)
VALUES (DEFAULT, 3, 'social media ads', 500);

INSERT INTO public.expense (ExpID, ExpName, ExpDate, HouseNo)
VALUES (DEFAULT, 'shopping', '2021-01-22', 2);

INSERT INTO public.bill (BillNo, Cost, BillName, BillDate, ExpID)
VALUES (DEFAULT, 1000, 'shoppingBill', '2021-01-22', 2);

INSERT INTO public.balance (BalNo, Total, BalanceDate, HouseNo)
VALUES (DEFAULT, 3000, '2021-01-19', 2);

-- HOUSE 3

INSERT INTO public.house (HouseNo, HouseRent, RoomNumber, location)
VALUES (DEFAULT, 2500, 3, 'Bahçelievler Ankara');

INSERT INTO public.family (Surname, MemberCount, TotalIncome,HouseNo)
VALUES ('Altun',2 , 30000 , 3);

INSERT INTO public.users (UserID, Name, Surname,Age,Gender,Birthday,Job,HasIncome)
VALUES (DEFAULT,'Erce','Altun', 29 , 'Male', '1993-12-12','cyber security specialist', true);

INSERT INTO public.users (UserID, Name, Surname,Age,Gender,Birthday,Job,HasIncome)
VALUES (DEFAULT,'Selin','Altun', 28 , 'Female', '1994-10-02','doctor', true);

INSERT INTO public.income (IncomeID,TotalWorth, UserID,HasExtra)
VALUES (DEFAULT, 18000 , 5 , true);

INSERT INTO public.income (IncomeID,TotalWorth, UserID,HasExtra)
VALUES (DEFAULT, 12000 , 6 , false);

INSERT INTO public.salary (SalaryNo, Worth, SalaryDate, IncomeID)
VALUES (DEFAULT, 16000, '2021-05-10', 4);

INSERT INTO public.salary (SalaryNo, Worth, SalaryDate, IncomeID)
VALUES (DEFAULT, 12000, '2021-04-03', 5);

INSERT INTO public.extraincome (ExtID, IncomeID, ExtName, ExtWorth)
VALUES (DEFAULT, 4, 'web site revenue', 2000);

INSERT INTO public.expense (ExpID, ExpName, ExpDate, HouseNo)
VALUES (DEFAULT, 'taxes', '2021-08-16', 3);

INSERT INTO public.bill (BillNo, Cost, BillName, BillDate, ExpID)
VALUES (DEFAULT,2000 , 'taxBill', '2021-08-16', 3);

INSERT INTO public.balance (BalNo, Total, BalanceDate, HouseNo)
VALUES (DEFAULT, 25500, '2021-01-19', 3); 

-- HOUSE 4

INSERT INTO public.house (HouseNo, HouseRent, RoomNumber, location)
VALUES (DEFAULT, 1000, 3, 'Keçiören Ankara');

INSERT INTO public.family (Surname, MemberCount, TotalIncome,HouseNo)
VALUES ('Alpay',3 , 9000 , 4);

INSERT INTO public.users (UserID, Name, Surname,Age,Gender,Birthday,Job,HasIncome)
VALUES (DEFAULT,'Mustafa','Alpay', 50 , 'Male', '1971-11-19','cartographer', true);

INSERT INTO public.users (UserID, Name, Surname,Age,Gender,Birthday,Job,HasIncome)
VALUES (DEFAULT,'Nimet','Alpay', 45 , 'Female', '1976-10-08',NULL, false);

INSERT INTO public.users (UserID, Name, Surname,Age,Gender,Birthday,Job,HasIncome)
VALUES (DEFAULT,'Handan','Alpay', 60 , 'Female', '1961-5-06',NULL, false);

INSERT INTO public.income (IncomeID,TotalWorth, UserID,HasExtra)
VALUES (DEFAULT, 9000 , 7 , true);

INSERT INTO public.salary (SalaryNo, Worth, SalaryDate, IncomeID)
VALUES (DEFAULT, 7500, '2021-07-13', 6);

INSERT INTO public.extraincome (ExtID, IncomeID, ExtName, ExtWorth)
VALUES (DEFAULT, 6, 'rent', 1500);

INSERT INTO public.expense (ExpID, ExpName, ExpDate, HouseNo)
VALUES (DEFAULT, 'hospital charges', '2021-08-15', 4);

INSERT INTO public.bill (BillNo, Cost, BillName, BillDate, ExpID)
VALUES (DEFAULT,3000 , 'hospitalBill', '2021-08-15', 4);

INSERT INTO public.balance (BalNo, Total, BalanceDate, HouseNo)
VALUES (DEFAULT, 5000, '2021-03-23', 4);

-- HOUSE 5

INSERT INTO public.house (HouseNo, HouseRent, RoomNumber, location)
VALUES (DEFAULT, 2800, 4, 'Beşiktaş Istanbul');

INSERT INTO public.family (Surname, MemberCount, TotalIncome,HouseNo)
VALUES ('Sahin',1 , 10000 , 5);

INSERT INTO public.users (UserID, Name, Surname,Age,Gender,Birthday,Job,HasIncome)
VALUES (DEFAULT,'Serdar','Sahin', 26 , 'Male', '1995-02-10','Lawyer', true);

INSERT INTO public.income (IncomeID,TotalWorth, UserID,HasExtra)
VALUES (DEFAULT, 10000 , 10 , true);

INSERT INTO public.salary (SalaryNo, Worth, SalaryDate, IncomeID)
VALUES (DEFAULT, 9500, '2021-07-12', 7);

INSERT INTO public.extraincome (ExtID, IncomeID, ExtName, ExtWorth)
VALUES (DEFAULT, 7, 'stock market', 500);

INSERT INTO public.expense (ExpID, ExpName, ExpDate, HouseNo)
VALUES (DEFAULT, 'vacation', '2021-08-24', 5);

INSERT INTO public.bill (BillNo, Cost, BillName, BillDate, ExpID)
VALUES (DEFAULT, 3000, 'vacationBill', '2021-08-24', 5);

INSERT INTO public.balance (BalNo, Total, BalanceDate, HouseNo)
VALUES (DEFAULT, 4200, '2021-11-15', 5);

-- HOUSE 6

INSERT INTO public.house (HouseNo, HouseRent, RoomNumber, location)
VALUES (DEFAULT, 3000 , 5 , 'Eskişehir Vişnelik');

INSERT INTO public.family (Surname, MemberCount, TotalIncome,HouseNo)
VALUES ('Aslan',4 , 25000 , 6);

INSERT INTO public.users (UserID, Name, Surname,Age,Gender,Birthday,Job,HasIncome)
VALUES (DEFAULT,'Batuhan','Aslan', 50 , 'Male', '1971-03-27','Military Officer', true);

INSERT INTO public.users (UserID, Name, Surname,Age,Gender,Birthday,Job,HasIncome)
VALUES (DEFAULT,'Melek','Aslan', 42 , 'Female', '1979-10-10','Nurse', true);

INSERT INTO public.users (UserID, Name, Surname,Age,Gender,Birthday,Job,HasIncome)
VALUES (DEFAULT,'Semih','Aslan', 21 , 'Male', '2000-05-10',NULL, false);

INSERT INTO public.users (UserID, Name, Surname,Age,Gender,Birthday,Job,HasIncome)
VALUES (DEFAULT,'Kerimhan','Aslan', 14 , 'Male', '2007-02-21',NULL, false);

INSERT INTO public.income (IncomeID,TotalWorth, UserID,HasExtra) 
VALUES (DEFAULT, 17000 , 11 , true);

INSERT INTO public.income (IncomeID,TotalWorth, UserID,HasExtra)
VALUES (DEFAULT, 8000 , 12 , false); 

INSERT INTO public.salary (SalaryNo, Worth, SalaryDate, IncomeID)
VALUES (DEFAULT,10000, '2021-06-09', 8);

INSERT INTO public.salary (SalaryNo, Worth, SalaryDate, IncomeID)
VALUES (DEFAULT,8000, '2021-07-01', 9);

INSERT INTO public.extraincome (ExtID, IncomeID, ExtName, ExtWorth)
VALUES (DEFAULT, 8, 'business investment', 7000);

INSERT INTO public.expense (ExpID, ExpName, ExpDate, HouseNo)
VALUES (DEFAULT, 'bank debt', '2021-08-24', 6);

INSERT INTO public.bill (BillNo, Cost, BillName, BillDate, ExpID)
VALUES (DEFAULT, 10000, 'BillofDebt', '2021-05-06', 6);

INSERT INTO public.balance (BalNo, Total, BalanceDate, HouseNo)
VALUES (DEFAULT, 12000, '2021-10-10', 6);

--HOUSE 7

INSERT INTO public.house (HouseNo, HouseRent, RoomNumber, location)
VALUES (DEFAULT, 5000 , 5 , 'Izmir Fethiye');

INSERT INTO public.family (Surname, MemberCount, TotalIncome,HouseNo)
VALUES ('Temiz',5 , 50000 , 7);

INSERT INTO public.users (UserID, Name, Surname,Age,Gender,Birthday,Job,HasIncome)
VALUES (DEFAULT,'Ahmet','Temiz', 50 , 'Male', '1971-04-28','Entrepreneur', true);

INSERT INTO public.users (UserID, Name, Surname,Age,Gender,Birthday,Job,HasIncome)
VALUES (DEFAULT,'Zeynep','Temiz', 48 , 'Female', '1973-10-23','Teacher', true);

INSERT INTO public.users (UserID, Name, Surname,Age,Gender,Birthday,Job,HasIncome)
VALUES (DEFAULT,'Hasanalp','Temiz', 22 , 'Male', '1999-05-15','AI Developer', true);

INSERT INTO public.users (UserID, Name, Surname,Age,Gender,Birthday,Job,HasIncome)
VALUES (DEFAULT,'Gamze','Temiz', 14 , 'Female', '2005-12-07',NULL, false);

INSERT INTO public.users (UserID, Name, Surname,Age,Gender,Birthday,Job,HasIncome)
VALUES (DEFAULT,'Mert	','Temiz', 7, 'Male', '2014-07-21',NULL, false);

INSERT INTO public.income (IncomeID,TotalWorth, UserID,HasExtra) 
VALUES (DEFAULT, 25000 , 15 , true);

INSERT INTO public.income (IncomeID,TotalWorth, UserID,HasExtra)
VALUES (DEFAULT, 15000 , 16 , false); 

INSERT INTO public.income (IncomeID,TotalWorth, UserID,HasExtra) 
VALUES (DEFAULT, 10000 , 17 , true); 

INSERT INTO public.salary (SalaryNo, Worth, SalaryDate, IncomeID)
VALUES (DEFAULT,20000, '2021-03-03', 10);

INSERT INTO public.salary (SalaryNo, Worth, SalaryDate, IncomeID)
VALUES (DEFAULT,15000, '2021-02-02', 11);

INSERT INTO public.salary (SalaryNo, Worth, SalaryDate, IncomeID)
VALUES (DEFAULT,8000, '2021-01-01', 12);

INSERT INTO public.extraincome (ExtID, IncomeID, ExtName, ExtWorth)
VALUES (DEFAULT, 10, 'investment',5000);

INSERT INTO public.extraincome (ExtID, IncomeID, ExtName, ExtWorth)
VALUES (DEFAULT, 12, 'crypto trading', 2000);

INSERT INTO public.expense (ExpID, ExpName, ExpDate, HouseNo)
VALUES (DEFAULT, 'holiday vacation', '2021-01-08', 7);

INSERT INTO public.expense (ExpID, ExpName, ExpDate, HouseNo) 
VALUES (DEFAULT, 'rent a car', '2021-01-11', 7);

INSERT INTO public.bill (BillNo, Cost, BillName, BillDate, ExpID)
VALUES (DEFAULT, 12000, 'HolidayVacation', '2021-01-08', 7);

INSERT INTO public.bill (BillNo, Cost, BillName, BillDate, ExpID)
VALUES (DEFAULT, 10000, 'RentaCar', '2021-01-11', 8);

INSERT INTO public.balance (BalNo, Total, BalanceDate, HouseNo)
VALUES (DEFAULT, 23000, '2021-10-10', 7);

-- HOUSE 8

INSERT INTO public.house (HouseNo, HouseRent, RoomNumber, location)
VALUES (DEFAULT, 1200, 1, 'Altindag Ankara');

INSERT INTO public.family (Surname, MemberCount, TotalIncome,HouseNo)
VALUES ('Gece',1 , 9000 , 8);

INSERT INTO public.users (UserID, Name, Surname,Age,Gender,Birthday,Job,HasIncome)
VALUES (DEFAULT,'Ege','Gece', 22 , 'Male', '1999-02-10','Gamer', true);

INSERT INTO public.income (IncomeID,TotalWorth, UserID,HasExtra)
VALUES (DEFAULT, 9000 , 20 , true);

INSERT INTO public.salary (SalaryNo, Worth, SalaryDate, IncomeID)
VALUES (DEFAULT, 8000, '2021-07-12', 13);

INSERT INTO public.extraincome (ExtID, IncomeID, ExtName, ExtWorth)
VALUES (DEFAULT, 13, 'Donation', 1000);

INSERT INTO public.expense (ExpID, ExpName, ExpDate, HouseNo)
VALUES (DEFAULT, 'computer', '2021-08-24', 8);

INSERT INTO public.bill (BillNo, Cost, BillName, BillDate, ExpID)
VALUES (DEFAULT, 4000, 'computerBill', '2021-08-24', 9);

INSERT INTO public.balance (BalNo, Total, BalanceDate, HouseNo)
VALUES (DEFAULT, 3800, '2021-08-24', 8);

-- HOUSE 9

INSERT INTO public.house (HouseNo, HouseRent, RoomNumber, location)
VALUES (DEFAULT, 8000, 6, 'Yasamkent Ankara');

INSERT INTO public.family (Surname, MemberCount, TotalIncome,HouseNo)
VALUES ('Korkmaz',2 , 20000 , 9);

INSERT INTO public.users (UserID, Name, Surname,Age,Gender,Birthday,Job,HasIncome)
VALUES (DEFAULT,'Efe','Korkmaz', 31 , 'Male', '1990-03-11','Broker', true);

INSERT INTO public.users (UserID, Name, Surname,Age,Gender,Birthday,Job,HasIncome)
VALUES (DEFAULT,'Sude','Korkmaz', 30 , 'Female', '1991-12-10',NULL, false);

INSERT INTO public.income (IncomeID,TotalWorth, UserID,HasExtra)
VALUES (DEFAULT, 20000 , 21 , false);

INSERT INTO public.salary (SalaryNo, Worth, SalaryDate, IncomeID)
VALUES (DEFAULT, 20000, '2021-07-12', 14);

INSERT INTO public.expense (ExpID, ExpName, ExpDate, HouseNo)
VALUES (DEFAULT, 'car loan', '2021-03-14', 9);

INSERT INTO public.bill (BillNo, Cost, BillName, BillDate, ExpID)
VALUES (DEFAULT, 9000, 'carLoanBill', '2021-03-14', 10);

INSERT INTO public.balance (BalNo, Total, BalanceDate, HouseNo)
VALUES (DEFAULT, 3800, '2021-03-14', 9);

-- HOUSE 10

INSERT INTO public.house (HouseNo, HouseRent, RoomNumber, location)
VALUES (DEFAULT, 16000, 7, 'Angora Ankara');

INSERT INTO public.family (Surname, MemberCount, TotalIncome,HouseNo)
VALUES ('Bilgin',3 , 30000 , 10);

INSERT INTO public.users (UserID, Name, Surname,Age,Gender,Birthday,Job,HasIncome)
VALUES (DEFAULT,'Sadik','Bilgin', 41 , 'Male', '1980-03-15','Manager', true);

INSERT INTO public.users (UserID, Name, Surname,Age,Gender,Birthday,Job,HasIncome)
VALUES (DEFAULT,'Sema','Bilgin', 32 , 'Female', '1989-11-13','Dentist', true);

INSERT INTO public.users (UserID, Name, Surname,Age,Gender,Birthday,Job,HasIncome)
VALUES (DEFAULT,'Ada','Bilgin', 11 , 'Female', '2010-09-23',NULL, false);

INSERT INTO public.income (IncomeID,TotalWorth, UserID,HasExtra)
VALUES (DEFAULT, 23000 , 23 , true);

INSERT INTO public.income (IncomeID,TotalWorth, UserID,HasExtra)
VALUES (DEFAULT, 7000 , 24 , false);

INSERT INTO public.salary (SalaryNo, Worth, SalaryDate, IncomeID)
VALUES (DEFAULT, 15000, '2021-07-12', 15);

INSERT INTO public.salary (SalaryNo, Worth, SalaryDate, IncomeID)
VALUES (DEFAULT, 7000, '2021-07-12', 16);

INSERT INTO public.extraincome (ExtID, IncomeID, ExtName, ExtWorth)
VALUES (DEFAULT, 15, 'rental income', 8000);

INSERT INTO public.expense (ExpID, ExpName, ExpDate, HouseNo)
VALUES (DEFAULT, 'kitchen expense', '2021-04-11', 10);

INSERT INTO public.expense (ExpID, ExpName, ExpDate, HouseNo)
VALUES (DEFAULT, 'garden expenses', '2021-03-24', 10);

INSERT INTO public.bill (BillNo, Cost, BillName, BillDate, ExpID)
VALUES (DEFAULT, 2000, 'marketBill', '2021-04-11', 11);

INSERT INTO public.bill (BillNo, Cost, BillName, BillDate, ExpID)
VALUES (DEFAULT, 3000, 'gardenBill', '2021-03-24', 12);

INSERT INTO public.balance (BalNo, Total, BalanceDate, HouseNo)
VALUES (DEFAULT, 9000, '2021-03-24', 10);

-- VIEWS

CREATE VIEW unemployed as select * from users where hasincome = false;

INSERT INTO unemployed (UserID, Name, Surname,Age,Gender,Birthday,Job,HasIncome)
VALUES (DEFAULT,'Eda','Bilgin', 0 , 'Male', '2021-03-11',NULL, false);

CREATE VIEW highEndHouses as select * from house where houserent >= 5000;

INSERT INTO highEndHouses (HouseNo, HouseRent, RoomNumber, location)
VALUES (DEFAULT, 8000, 5, 'Bağlıca Ankara');

CREATE VIEW nuclearfamily as select * from family where MemberCount >= 2 AND MemberCount <= 4;

INSERT INTO nuclearfamily (Surname, MemberCount, TotalIncome,HouseNo)
VALUES ('Saglam',3 ,15000, 11);

---- UPDATES

UPDATE house SET houserent = 10000 where houseno = 9;

UPDATE expense SET expname = '2 new computer' where expid = 9;

UPDATE balance SET total = 9100 where balno = 1 and houseno = 1;

UPDATE users SET age = age+1 where name = 'Efe';

UPDATE family SET TotalIncome = 30000 where Surname = 'Korkmaz' ;

UPDATE income SET TotalWorth = 9500 where UserID = 24;

UPDATE extraincome SET extworth = 5000 where extid = 8;

UPDATE salary SET worth = 12000 where salaryno = 9;

UPDATE bill SET cost = 5000 where billname = 'hospitalBill';

UPDATE unemployed SET hasincome = true, job = 'Fitness Coach' where name = 'Sude';

UPDATE nuclearfamily SET MemberCount = MemberCount + 1,TotalIncome = 20000 where Surname = 'Bilgin' ;

UPDATE highEndHouses SET houserent = 10000 where houseno = 11;

-- DELETIONS

DELETE FROM extraincome where incomeid = 13;

DELETE FROM salary where incomeid = 13;

DELETE FROM income where incomeid = 13;

DELETE FROM users where userid = 20;

DELETE FROM family where surname = 'Gece';

DELETE FROM bill where expid = 9;

DELETE FROM expense where houseno = 8;

DELETE FROM balance where houseno = 8;

DELETE FROM house where houseno = 8;

DELETE FROM unemployed where age = 0;

DELETE FROM nuclearfamily where houseno = 11;

DELETE FROM highendhouses where houseno = 11;

-- ALTER TABLE

ALTER TABLE house RENAME COLUMN houserent TO rent;

ALTER TABLE house ADD COLUMN hasGarden boolean;

ALTER TABLE bill ALTER COLUMN cost DROP NOT NULL;

ALTER TABLE users ADD COLUMN single boolean ;

ALTER TABLE family ADD COLUMN motherland varchar(25);

ALTER TABLE salary RENAME COLUMN incomeid TO incId;

ALTER TABLE income ADD COLUMN hasBonus BOOL;

ALTER TABLE balance rename column BalanceDate TO BDate ;

------------


