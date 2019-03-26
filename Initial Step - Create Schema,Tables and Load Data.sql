CREATE SCHEMA `Assignment`;

USE Assignment;

-- On inspection of the fileds of the csv file and the needs of the analysis, 
-- the datatype of the fields have been derived.
-- The fields `Deliverable Quantity`,`% Deli. Qty to Traded Qty`,`Spread High-Low` and `Spread Close-Open` 
-- have been defined as datatype 'text' as some of these fields have null values and would pose issues in importing.
-- Moreover, these fields are not significant for further analysis.

-- The following setting in the my.ini file present at "C:/ProgramData/MySQL/MySQL Server 8.0/"
-- was modified so that the csv files from any folder could be uploaded
-- # Secure File Priv.
-- #secure-file-priv="C:/ProgramData/MySQL/MySQL Server 8.0/Uploads"
-- secure-file-priv="";
-- All the csv data files have been kept under the directory "C:/SQL_Assignment/"

-- 1. Creation of `Bajaj Auto` Table and loading data from 'Bajaj Auto.csv' into the table.
-- 1a. Creation of `Bajaj Auto` Table.
CREATE TABLE `Bajaj Auto` 	
	(
	  `Date` date,
	  `Open Price` double ,
	  `High Price` double ,
	  `Low Price` double ,
	  `Close Price` double ,
	  `WAP` text ,
	  `No.of Shares` bigint(11) ,
	  `No. of Trades` bigint(11) ,
	  `Total Turnover (Rs.)` bigint(11) ,
	  `Deliverable Quantity` text ,
	  `% Deli. Qty to Traded Qty` text ,
	  `Spread High-Low` text ,
	  `Spread Close-Open` text 
	);

-- The csv has the `Date` field in 'DD-MM-YYYY' format.
-- However, MySQL requires the date fields to be in 'YYYY-MM-DD' format to perform date related operation and cronological ordering.
-- To achieve this, the `Date` is accepted in a temporary variable '@dt' as a string
-- and then converted to the required format by using the STR_TO_DATE() builtin function.

-- 1b. Load data from 'Bajaj Auto.csv' into `Bajaj Auto` Table
-- The csv has the `Date` field in 'DD-MM-YYYY' format.
-- However, MySQL requires the date fields to be in 'YYYY-MM-DD' format to perform date related operation and cronological ordering.
-- To achieve this, the `Date` is accepted in a temporary variable '@dt' as a string
-- and then converted to the required format by using the STR_TO_DATE() builtin function.

LOAD DATA INFILE  
'C:/SQL_Assignment/Bajaj Auto.csv'
INTO TABLE `Bajaj Auto`
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(@dt,`Open Price`,`High Price`,`Low Price`,
`Close Price`,`WAP`,`No.of Shares`,`No. of Trades`,
`Total Turnover (Rs.)` ,`Deliverable Quantity`,
`% Deli. Qty to Traded Qty`,`Spread High-Low`,`Spread Close-Open`)
SET `Date` = STR_TO_DATE(@dt,'%d-%M-%Y');

-- 2. Creation of `Eicher Motors` Table and loading data from 'Eicher Motors.csv' into the table.
-- 2a. Creation of `Eicher Motors` Table.
CREATE TABLE `Eicher Motors` 	
	(
	  `Date` date,
	  `Open Price` double ,
	  `High Price` double ,
	  `Low Price` double ,
	  `Close Price` double ,
	  `WAP` text ,
	  `No.of Shares` bigint(11) ,
	  `No. of Trades` bigint(11) ,
	  `Total Turnover (Rs.)` bigint(11) ,
	  `Deliverable Quantity` text ,
	  `% Deli. Qty to Traded Qty` text ,
	  `Spread High-Low` text ,
	  `Spread Close-Open` text 
	);

-- 2b. Load data from 'Eicher Motors.csv' into `Eicher Motors` Table

LOAD DATA INFILE  
'C:/SQL_Assignment/Eicher Motors.csv'
INTO TABLE `Eicher Motors`
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(@dt,`Open Price`,`High Price`,`Low Price`,
`Close Price`,`WAP`,`No.of Shares`,`No. of Trades`,
`Total Turnover (Rs.)` ,`Deliverable Quantity`,
`% Deli. Qty to Traded Qty`,`Spread High-Low`,`Spread Close-Open`)
SET `Date` = STR_TO_DATE(@dt,'%d-%M-%Y');


-- 3. Creation of `Hero Motocorp` Table and loading data from 'Hero Motocorp.csv' into the table.
-- 3a. Creation of `Hero Motocorp` Table.
CREATE TABLE `Hero Motocorp` 	
	(
	  `Date` date,
	  `Open Price` double ,
	  `High Price` double ,
	  `Low Price` double ,
	  `Close Price` double ,
	  `WAP` text ,
	  `No.of Shares` bigint(11) ,
	  `No. of Trades` bigint(11) ,
	  `Total Turnover (Rs.)` bigint(11) ,
	  `Deliverable Quantity` text ,
	  `% Deli. Qty to Traded Qty` text ,
	  `Spread High-Low` text ,
	  `Spread Close-Open` text 
	);

-- 3b. Load data from 'Hero Motocorp.csv' into `Hero Motocorp` Table

LOAD DATA INFILE  
'C:/SQL_Assignment/Hero Motocorp.csv'
INTO TABLE `Hero Motocorp`
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(@dt,`Open Price`,`High Price`,`Low Price`,
`Close Price`,`WAP`,`No.of Shares`,`No. of Trades`,
`Total Turnover (Rs.)` ,`Deliverable Quantity`,
`% Deli. Qty to Traded Qty`,`Spread High-Low`,`Spread Close-Open`)
SET `Date` = STR_TO_DATE(@dt,'%d-%M-%Y');

-- 4. Creation of `Infosys` Table and loading data from 'Infosys.csv' into the table.
-- 4a. Creation of `Infosys` Table.
CREATE TABLE `Infosys` 	
	(
	  `Date` date,
	  `Open Price` double ,
	  `High Price` double ,
	  `Low Price` double ,
	  `Close Price` double ,
	  `WAP` text ,
	  `No.of Shares` bigint(11) ,
	  `No. of Trades` bigint(11) ,
	  `Total Turnover (Rs.)` bigint(11) ,
	  `Deliverable Quantity` text ,
	  `% Deli. Qty to Traded Qty` text ,
	  `Spread High-Low` text ,
	  `Spread Close-Open` text 
	);

-- 4b. Load data from 'Infosys.csv' into `Infosys` Table

LOAD DATA INFILE  
'C:/SQL_Assignment/Infosys.csv'
INTO TABLE `Infosys`
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(@dt,`Open Price`,`High Price`,`Low Price`,
`Close Price`,`WAP`,`No.of Shares`,`No. of Trades`,
`Total Turnover (Rs.)` ,`Deliverable Quantity`,
`% Deli. Qty to Traded Qty`,`Spread High-Low`,`Spread Close-Open`)
SET `Date` = STR_TO_DATE(@dt,'%d-%M-%Y');


-- 5. Creation of `TCS` Table and loading data from 'TCS.csv' into the table.
-- 5a. Creation of `TCS` Table.
CREATE TABLE `TCS` 	
	(
	  `Date` date,
	  `Open Price` double ,
	  `High Price` double ,
	  `Low Price` double ,
	  `Close Price` double ,
	  `WAP` text ,
	  `No.of Shares` bigint(11) ,
	  `No. of Trades` bigint(11) ,
	  `Total Turnover (Rs.)` bigint(11) ,
	  `Deliverable Quantity` text ,
	  `% Deli. Qty to Traded Qty` text ,
	  `Spread High-Low` text ,
	  `Spread Close-Open` text 
	);

-- 5b. Load data from 'TCS.csv' into `TCS` Table

LOAD DATA INFILE  
'C:/SQL_Assignment/TCS.csv'
INTO TABLE `TCS`
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(@dt,`Open Price`,`High Price`,`Low Price`,
`Close Price`,`WAP`,`No.of Shares`,`No. of Trades`,
`Total Turnover (Rs.)` ,`Deliverable Quantity`,
`% Deli. Qty to Traded Qty`,`Spread High-Low`,`Spread Close-Open`)
SET `Date` = STR_TO_DATE(@dt,'%d-%M-%Y');


-- 6. Creation of `TVS Motors` Table and loading data from 'TVS Motors.csv' into the table.
-- 6a. Creation of `TVS Motors` Table.
CREATE TABLE `TVS Motors` 	
	(
	  `Date` date,
	  `Open Price` double ,
	  `High Price` double ,
	  `Low Price` double ,
	  `Close Price` double ,
	  `WAP` text ,
	  `No.of Shares` bigint(11) ,
	  `No. of Trades` bigint(11) ,
	  `Total Turnover (Rs.)` bigint(11) ,
	  `Deliverable Quantity` text ,
	  `% Deli. Qty to Traded Qty` text ,
	  `Spread High-Low` text ,
	  `Spread Close-Open` text 
	);

-- 6b. Load data from 'TVS Motors.csv' into `TCS` Table

LOAD DATA INFILE  
'C:/SQL_Assignment/TVS Motors.csv'
INTO TABLE `TVS Motors`
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(@dt,`Open Price`,`High Price`,`Low Price`,
`Close Price`,`WAP`,`No.of Shares`,`No. of Trades`,
`Total Turnover (Rs.)` ,`Deliverable Quantity`,
`% Deli. Qty to Traded Qty`,`Spread High-Low`,`Spread Close-Open`)
SET `Date` = STR_TO_DATE(@dt,'%d-%M-%Y');

-- Check counts of the tables to confirm Creation of the tables with data. Each table should have 889 records.
SELECT
( SELECT COUNT(1) FROM `Bajaj Auto` ) as COUNT_BAJAJ_AUTO,
( SELECT COUNT(1) FROM `Eicher Motors` ) as COUNT_EICHER_MOTORS,
( SELECT COUNT(1) FROM `Hero Motocorp` ) as COUNT_HERO_MOTOCORP,
( SELECT COUNT(1) FROM `Infosys` ) as COUNT_INFOSYS,
( SELECT COUNT(1) FROM `TCS` ) as COUNT_TCS,
( SELECT COUNT(1) FROM `TVS MOTORS` ) as COUNT_TVS_MOTORS;

-- +++++++++++++++++++++++++++++++++++++++++++++++   END   +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
