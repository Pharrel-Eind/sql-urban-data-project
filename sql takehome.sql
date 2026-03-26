create database if not exists Smart_City_System;
use Smart_City_System;

create table Energy_Consumption (
Energy_ID int auto_increment primary key,
Energy_Type varchar(50) not null,
Provider varchar(100),
Consumption_Level decimal (10,2),
Renewable boolean
);

describe Energy_Consumption;

create table Buildings (
Building_ID int auto_increment primary key,
Building_Name varchar(100),
Building_type varchar(50),
Address varchar(150),
Wijk varchar(50),
Construction_Year year,
Energy_ID int,

foreign key (Energy_ID)
references Energy_Consumption (Energy_ID)
);

describe Buildings;

create table Burgers (
Burger_ID int auto_increment primary key,
First_Name varchar(50) not null,
Last_Name varchar(50) not null,
Date_of_Birth date,
Gender varchar(10),
Address varchar(100),
Phone_Number varchar(50),
Email varchar(100),
Building_ID int,
foreign key (Building_ID)
references Buildings (Building_ID)
);

describe Burgers;

create table Transport (
Transport_ID int auto_increment primary key,
Transport_Type varchar(50),
Registration_Number varchar(50),
Capacity int,
Fuel_Type varchar(50),
Burger_ID int,

foreign key (Burger_ID)
references Burgers (Burger_ID)
);

describe Transport;

-- i used a python script to insert 150 entities into all 4 tables 
SELECT COUNT(*) FROM Burgers;
select COUNT(*) FROM Buildings;
SELECT COUNT(*) FROM Energy_Consumption;
SELECT COUNT(*) FROM Transport; 

-- average energy consumption
 select AVG(Consumption_Level)
 FROM Energy_Consumption; 
    
    --  alle burgers die wonen in gebouwen met energieverbruik hoger dan het gemiddelde.
SELECT b.Burger_ID,
       b.First_Name,
       b.Last_Name,
       bl.Building_Name,
       e.Consumption_Level
FROM Burgers b
JOIN Buildings bl ON b.Building_ID = bl.Building_ID
JOIN Energy_Consumption e ON bl.Energy_ID = e.Energy_ID
WHERE e.Consumption_Level > (
    SELECT AVG(Consumption_Level) FROM Energy_Consumption
)
ORDER BY e.Consumption_Level DESC;

-- Aantal transport middelen per burger
SELECT 
    b.Burger_ID,
    b.First_Name,
    b.Last_Name, 
    COUNT(t.Transport_ID) AS Aantal_Transportmiddelen  
FROM Burgers b
LEFT JOIN Transport t ON b.Burger_ID = t.Burger_ID
GROUP BY b.Burger_ID, b.First_Name, b.Last_Name
ORDER BY Aantal_Transportmiddelen DESC; 

-- gebouwen zonder geregistreerde bewoners
SELECT 
    bl.Building_ID,
    bl.Building_Name
FROM Buildings bl
LEFT JOIN Burgers b ON bl.Building_ID = b.Building_ID
WHERE b.Burger_ID IS NULL;

--  het gemiddelde energieverbruik per wijk.
SELECT 
    bl.Wijk,
    AVG(e.Consumption_Level) AS Gemiddeld_Verbruik
FROM Buildings bl
JOIN Energy_Consumption e ON bl.Energy_ID = e.Energy_ID
GROUP BY bl.Wijk;

-- Energy consumption
SELECT * FROM Energy_Consumption LIMIT 5;

-- Buildings
SELECT * FROM Buildings LIMIT 5;

-- Burgers
SELECT * FROM Burgers LIMIT 5;

-- Transport
SELECT * FROM Transport LIMIT 5;

-- Burgers linked to Buildings
SELECT b.Burger_ID, b.First_Name, b.Last_Name, bl.Building_Name 
FROM Burgers b
JOIN Buildings bl ON b.Building_ID = bl.Building_ID
LIMIT 10;

-- Buildings linked to Energy_Consumption
SELECT bl.Building_ID, bl.Building_Name, e.Energy_Type
FROM Buildings bl
JOIN Energy_Consumption e ON bl.Energy_ID = e.Energy_ID
LIMIT 10;

-- Transport linked to Burgers
SELECT t.Transport_ID, t.Transport_Type, b.First_Name, b.Last_Name
FROM Transport t
JOIN Burgers b ON t.Burger_ID = b.Burger_ID
LIMIT 10;

-- all 4 tables linked
SELECT 
    b.First_Name,
    b.Last_Name,
    bl.Building_Name,
    e.Energy_Type,
    t.Transport_Type
FROM Burgers b
JOIN Buildings bl ON b.Building_ID = bl.Building_ID
JOIN Energy_Consumption e ON bl.Energy_ID = e.Energy_ID
JOIN Transport t ON t.Burger_ID = b.Burger_ID
LIMIT 10;

-- Insert 15 new Burgers
INSERT INTO Burgers 
(First_Name, Last_Name, Date_of_Birth, Gender, Address, Phone_Number, Email, Building_ID)
VALUES
('Lotte', 'Jansen', '1995-04-12', 'Female', '12 Park Ave', '0612345678', 'lotte.jansen@mail.com', 1),
('Daan', 'deVries', '1988-09-05', 'Male', '45 Main St', '0698765432', 'daan.devries@mail.com', 2),
('Sophie', 'Smits', '2000-01-20', 'Female', '78 Oak Rd', '0611122233', 'sophie.smits@mail.com', 3),
('Lucas', 'Mulder', '1992-07-17', 'Male', '34 Pine St', '0623344556', 'lucas.mulder@mail.com', 4),
('Emma', 'Bakker', '1998-11-03', 'Female', '56 High St', '0655566677', 'emma.bakker@mail.com', 5),
('Finn', 'Visser', '1985-03-21', 'Male', '23 Park Ave', '0667788990', 'finn.visser@mail.com', 6),
('Nina', 'Meijer', '1990-05-14', 'Female', '89 Main St', '0612233445', 'nina.meijer@mail.com', 7),
('Thomas', 'Bos', '1982-08-09', 'Male', '12 Oak Rd', '0623344112', 'thomas.bos@mail.com', 8),
('Eva', 'Vos', '1996-12-25', 'Female', '45 Pine St', '0634455667', 'eva.vos@mail.com', 9),
('Lars', 'Peters', '1991-06-02', 'Male', '78 High St', '0645566778', 'lars.peters@mail.com', 10),
('Sara', 'Hendriks', '1993-10-18', 'Female', '34 Park Ave', '0656677889', 'sara.hendriks@mail.com', 11),
('Bram', 'Dekker', '1987-02-14', 'Male', '56 Main St', '0667788991', 'bram.dekker@mail.com', 12),
('Mila', 'Jacobs', '1999-09-30', 'Female', '23 Oak Rd', '0611123344', 'mila.jacobs@mail.com', 13),
('Noah', 'Willems', '1994-07-11', 'Male', '89 Pine St', '0622233445', 'noah.willems@mail.com', 14),
('Fleur', 'Sanders', '1997-03-05', 'Female', '12 High St', '0633344556', 'fleur.sanders@mail.com', 15);

-- alle niuewe burgers an hun gevens optie_1
SELECT *
FROM Burgers
WHERE Burger_ID BETWEEN 151 AND 165;
-- optie_2
select *
from Burgers
order by Burger_ID desc
limit 15;

-- Update consumption for 10 buildings
UPDATE Energy_Consumption
SET Consumption_Level = 3200.50
WHERE Energy_ID = (SELECT Energy_ID FROM Buildings WHERE Building_ID = 1);

UPDATE Energy_Consumption
SET Consumption_Level = 1500.75
WHERE Energy_ID = (SELECT Energy_ID FROM Buildings WHERE Building_ID = 2);

UPDATE Energy_Consumption
SET Consumption_Level = 2750.20
WHERE Energy_ID = (SELECT Energy_ID FROM Buildings WHERE Building_ID = 3);

UPDATE Energy_Consumption
SET Consumption_Level = 4200.10
WHERE Energy_ID = (SELECT Energy_ID FROM Buildings WHERE Building_ID = 4);

UPDATE Energy_Consumption
SET Consumption_Level = 3100.00
WHERE Energy_ID = (SELECT Energy_ID FROM Buildings WHERE Building_ID = 5);

UPDATE Energy_Consumption
SET Consumption_Level = 1800.40
WHERE Energy_ID = (SELECT Energy_ID FROM Buildings WHERE Building_ID = 6);

UPDATE Energy_Consumption
SET Consumption_Level = 2950.60
WHERE Energy_ID = (SELECT Energy_ID FROM Buildings WHERE Building_ID = 7);

UPDATE Energy_Consumption
SET Consumption_Level = 3600.80
WHERE Energy_ID = (SELECT Energy_ID FROM Buildings WHERE Building_ID = 8);

UPDATE Energy_Consumption
SET Consumption_Level = 2000.25
WHERE Energy_ID = (SELECT Energy_ID FROM Buildings WHERE Building_ID = 9);

UPDATE Energy_Consumption
SET Consumption_Level = 4100.90
WHERE Energy_ID = (SELECT Energy_ID FROM Buildings WHERE Building_ID = 10);
