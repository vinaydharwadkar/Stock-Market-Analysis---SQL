-- START -- 
-- The SCHEMA 'Assignment' must already be created.
-- All the base stock tables should be created and uploaded with respective csv data before proceeding.
-- Please execute commands in the file 'Initial Step - Create Schema,Tables and Load Data.sql' 
-- to create the schema, create base tables and load respective csv data into the base tables.
 
USE Assignment;

-- 1. Create a new table named 'bajaj1' containing the date, close price, 20 Day MA and 50 Day MA. 
--    (This has to be done for all 6 stocks)
--
-- 1.1 Create `Bajaj1` Table using `Bajaj Auto` Table
CREATE TABLE `Bajaj1`
	SELECT
      Date,
      `Close Price`,
      -- For `Date`s which have atleast 20 preceeding entries , 
      -- calculate the average of the filed `Close Price` and alias the column as `20 Day MA` 
      -- NULL for `Date`s which do not have atleast 20 preceeding values
      IF(ROW_NUMBER() OVER (ORDER BY DATE ) >= 20,
         AVG(`Close Price`) OVER (ORDER BY Date ROWS BETWEEN 19 PRECEDING AND CURRENT ROW),null) AS '20 Day MA',
      -- For `Date`s which have atleast 50 preceeding entries , 
      -- calculate the average of the filed `Close Price` and alias the column as `20 Day MA` 
      -- NULL for `Date`s which do not have atleast %0 preceeding values   
      IF(ROW_NUMBER() OVER (ORDER BY DATE ) >= 50,
       AVG(`Close Price`) OVER (ORDER BY Date ROWS BETWEEN 49 PRECEDING AND CURRENT ROW),null) AS '50 Day MA'
    FROM `Bajaj Auto`
    ORDER BY Date desc ;

-- Similarly create the other 5 tables.
-- 1.2 Create `Eicher1` Table using `Eicher Motors` Table
CREATE TABLE `Eicher1`
	SELECT
      Date,
      `Close Price`,
      IF(ROW_NUMBER() OVER (ORDER BY DATE ) >= 20,
         AVG(`Close Price`) OVER (ORDER BY Date ROWS BETWEEN 19 PRECEDING AND CURRENT ROW),null) AS '20 Day MA',
      IF(ROW_NUMBER() OVER (ORDER BY DATE ) >= 50,
       AVG(`Close Price`) OVER (ORDER BY Date ROWS BETWEEN 49 PRECEDING AND CURRENT ROW),null) AS '50 Day MA'
    FROM `Eicher Motors`
    ORDER BY Date desc ;

-- 1.3 Create `Hero1` Table using `Hero Motocorp` Table
CREATE TABLE `Hero1`
	SELECT
      Date,
      `Close Price`,
      IF(ROW_NUMBER() OVER (ORDER BY DATE ) >= 20,
         AVG(`Close Price`) OVER (ORDER BY Date ROWS BETWEEN 19 PRECEDING AND CURRENT ROW),null) AS '20 Day MA',
      IF(ROW_NUMBER() OVER (ORDER BY DATE ) >= 50,
       AVG(`Close Price`) OVER (ORDER BY Date ROWS BETWEEN 49 PRECEDING AND CURRENT ROW),null) AS '50 Day MA'
    FROM `Hero Motocorp`
    ORDER BY Date desc ;

-- 1.4 Create `Infosys1` Table using `Infosys` Table
CREATE TABLE `Infosys1`
	SELECT
      Date,
      `Close Price`,
      IF(ROW_NUMBER() OVER (ORDER BY DATE ) >= 20,
         AVG(`Close Price`) OVER (ORDER BY Date ROWS BETWEEN 19 PRECEDING AND CURRENT ROW),null) AS '20 Day MA',
      IF(ROW_NUMBER() OVER (ORDER BY DATE ) >= 50,
       AVG(`Close Price`) OVER (ORDER BY Date ROWS BETWEEN 49 PRECEDING AND CURRENT ROW),null) AS '50 Day MA'
    FROM `Infosys`
    ORDER BY Date desc ;

-- 1.5 Create `TCS1` Table using `TCS` Table
CREATE TABLE `TCS1`
	SELECT
      Date,
      `Close Price`,
      IF(ROW_NUMBER() OVER (ORDER BY DATE ) >= 20,
         AVG(`Close Price`) OVER (ORDER BY Date ROWS BETWEEN 19 PRECEDING AND CURRENT ROW),null) AS '20 Day MA',
      IF(ROW_NUMBER() OVER (ORDER BY DATE ) >= 50,
       AVG(`Close Price`) OVER (ORDER BY Date ROWS BETWEEN 49 PRECEDING AND CURRENT ROW),null) AS '50 Day MA'
    FROM `TCS`
    ORDER BY Date desc ;
    
-- 1.6 Create `TVS1` Table using `TVS MOTORS` Table
CREATE TABLE `TVS1`
	SELECT
      Date,
      `Close Price`,
      IF(ROW_NUMBER() OVER (ORDER BY DATE ) >= 20,
         AVG(`Close Price`) OVER (ORDER BY Date ROWS BETWEEN 19 PRECEDING AND CURRENT ROW),null) AS '20 Day MA',
      IF(ROW_NUMBER() OVER (ORDER BY DATE ) >= 50,
       AVG(`Close Price`) OVER (ORDER BY Date ROWS BETWEEN 49 PRECEDING AND CURRENT ROW),null) AS '50 Day MA'
    FROM `TVS MOTORS`
    ORDER BY Date desc ;    

-- Check counts of the tables to confirm creation of the tables with data. Each table should have 889 records.
SELECT
( SELECT COUNT(1) FROM `BAJAJ1` ) as COUNT_BAJAJ1,
( SELECT COUNT(1) FROM `EICHER1` ) as COUNT_EICHER1,
( SELECT COUNT(1) FROM `HERO1` ) as COUNT_HERO1,
( SELECT COUNT(1) FROM `INFOSYS1` ) as COUNT_INFOSYS1,
( SELECT COUNT(1) FROM `TCS1` ) as COUNT_TCS1,
( SELECT COUNT(1) FROM `TVS1` ) as COUNT_TVS1;

-- 2. Create a master table containing the date and close price of all the six stocks. 
--    (Column header for the price is the name of the stock)
--
-- The 'master_table' has been created by 'join'ing the six stock tables
-- bajaj1, eicher1, hero1, infosys1, tcs1 and tvs1 on the `Date` column as shown below. 
--
CREATE TABLE master_table
SELECT b.Date AS 'Date', 
b.`Close Price` AS 'Bajaj',
e.`Close Price` AS 'Eicher',
h.`Close Price` AS 'Hero',
i.`Close Price` AS 'Infosys',
tcs1.`Close Price` AS 'TCS',
tvs1.`Close Price` AS 'TVS'
FROM `BAJAJ1` b 
JOIN `EICHER1` e ON b.Date = e.Date
JOIN `HERO1` h ON b.Date = h.Date
JOIN `INFOSYS1` i ON b.Date = i.Date
JOIN `TCS1` ON b.Date = tcs1.Date
JOIN `TVS1` ON b.Date = tvs1.Date;

-- Check creation of 'master_table'. Count should be 889.
SELECT COUNT(1) AS "COUNT MASTER_TABLE" FROM master_table; 

-- Check initial few rows of 'master_table'. 
SELECT * FROM master_table LIMIT 10;

-- procedure to create table2 from table1
-- 3. Use the table created in Part(1) to generate buy and sell signal. 
--    Store this in another table named 'bajaj2'. Perform this operation for all stocks.
--
-- The creation of `table2' (like bajaj2, tcs2 etc) has been achieved by using a Stored Procedure. 
/* Stored procedure to create table2
   Ex. if table 'bajaj' is passed , then the stored procedure uses table 'bajaj1' created above
   and a new table 'bajaj2' is created with the required fields and calculations.
*********************************************************************************************************************   
*  Logic for generation of Signal:																					*	
*  The sign of the difference between 20DayMA and 50DayMA can be used identify a crossover of the moving averages. 	*
*  	BUY  : 	When Today's (20DayMA - 50DayMA) is positive and Yesterday's (20DayMA - 50DayMA) is negative.			*
*  			Since this indicates that the 20DayMA has moved above the 50DayMA. 										*
*  	SELL : 	When Today's (20DayMA - 50DayMA) is negative and Yesterday's (20DayMA - 50DayMA) is positive.			*
*  			Since this indicates that the 20DayMA has moved below the 50DayMA.										*
*  	HOLD :	For all other cases, there is no corssover of the moving averages and hence a 'HOLD' signal.			*
*********************************************************************************************************************   	
   The procedure dynamically creates an sql query to create the required table. 
   The template used for dynamically creating the sql query is as below:
	CREATE TABLE <tname>2 	
	SELECT `Date`, `Close Price`,
	-- Check Today's and Yesterday's difference between 20DayMA and 50DayMA
	CASE
	    -- IF Today's ( 20DayMA - 50DayMA) is +ve and Yesterday's ( 20DayMA - 50DayMA) is -ve : BUY
		WHEN (`20 Day MA` - `50 Day MA`) > 0 AND (LEAD((`20 Day MA` - `50 Day MA`),1) over()) < 0 THEN "BUY"
		-- IF Today's ( 20DayMA - 50DayMA) is -ve and Yesterday's ( 20DayMA - 50DayMA) is +ve : SELL
		WHEN (`20 Day MA` - `50 Day MA`) < 0 AND (LEAD((`20 Day MA` - `50 Day MA`),1) over()) > 0 THEN "SELL"
		-- All other cases : HOLD
		ELSE "HOLD"
    END AS "Signal" FROM <tname>1
    ORDER BY Date desc;
-- Procedure Name : createTable2
-- Input : <tname> --> name of the table for which table2 needs to be created using table1
		   The input parameter is accepted as just <tname> for ease of usage.
-- Output : None*/ 
DELIMITER $$
CREATE PROCEDURE `createTable2`(IN tname CHAR(10))
BEGIN
SET @sql_query = CONCAT(
'CREATE TABLE ',tname,'2', 	
'   SELECT Date, `Close Price`,
	CASE
		WHEN (`20 Day MA` - `50 Day MA`) > 0 AND (LEAD((`20 Day MA` - `50 Day MA`),1) over()) < 0 THEN "BUY"
		WHEN (`20 Day MA` - `50 Day MA`) < 0 AND (LEAD((`20 Day MA` - `50 Day MA`),1) over()) > 0 THEN "SELL"
		ELSE "HOLD"
END AS "Signal" FROM ',tname,'1',
' ORDER BY Date desc ');
PREPARE stmt FROM @sql_query;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;
END;
$$

DELIMITER ;

-- `createTable2` Stored Procedure Calls 
call createTable2('bajaj');		-- Create table `bajaj2` from table `bajaj1`
call createTable2('eicher');	-- Create table `eicher2` from table `eicher1`
call createTable2('hero');		-- Create table `hero2` from table `hero1`
call createTable2('infosys');	-- Create table `infosys2` from table `infosys1`	
call createTable2('tcs');		-- Create table `tcs2` from table `tcs1`
call createTable2('tvs');		-- Create table `tvs2` from table `tvs2`

-- Check counts of the tables to confirm creation of the tables with data. Each table should have 889 records.
SELECT
( SELECT COUNT(1) FROM bajaj2 ) as COUNT_BAJAJ2,
( SELECT COUNT(1) FROM eicher2 ) as COUNT_EICHER2,
( SELECT COUNT(1) FROM hero2 ) as COUNT_HERO2,
( SELECT COUNT(1) FROM infosys2 ) as COUNT_INFOSYS2,
( SELECT COUNT(1) FROM tcs2 ) as COUNT_TCS2,
( SELECT COUNT(1) FROM tvs2 ) as COUNT_TVS2;

-- 4. Create a User defined function, that takes the date as input 
--    and returns the signal for that particular date (Buy/Sell/Hold) for the Bajaj stock.
--    As per TA Clarification https://learn.upgrad.com/v/course/208/question/92112/answer/388616,
--    if the date provided is not present in the table(weekend and/or holiday) then by default 'HOLD' is returned.
-- Function Name : getSignalBajaj
-- Input : inp_date . The Date should be sent as a string in 'YYYY-MM-DD' format.
-- Return : Signal for the inp_date input. 
-- 			If record not found for the input date, then return 'HOLD' by default.x
CREATE FUNCTION getSignalBajaj(inp_date char(10))
RETURNS CHAR(4)
DETERMINISTIC
	return (SELECT IFNULL( (SELECT `Signal` from bajaj2 where date = inp_date) , 'HOLD'));

-- Execute the UDF get SignalBajaj to get the signal for a input date. 
select getSignalBajaj('2018-05-25') as 'Bajaj Signal 2018-05-25';
select getSignalBajaj('2018-05-26') as 'Bajaj Signal 2018-05-26';

-- Cross verify it by directly querying the table.
select * from bajaj2 where Date='2018-05-25';
select * from bajaj2 where Date='2018-05-26';

-- UDFs for other stocks is provided at the end of this script under APPENDIX_1.
-- UDF which accepts (stock name,date) and returns the signal for that stock for that date is provided under APPENDIX_2. 
-- UDF which returns the signal for that day if present, else the signal for the previous day is provided under APPENDIX_3.

-- 5. Inferences.
-- Queries related to details mentioned in the 'Stock Market Analysis - Inferences.pdf' document

-- a. BUY/SELL signals for the six stocks:
SELECT 	'BAJAJ' AS STOCK_NAME ,sum( `Signal` = 'BUY') AS Num_BUY_SIGNAL,sum( `Signal` = 'SELL') AS Num_SELL_SIGNAL,
		sum( `Signal` != 'HOLD') AS "Total_Non-HOLD_Signals" FROM bajaj2
UNION		
SELECT 	'EICHER' AS STOCK_NAME ,sum( `Signal` = 'BUY') AS Num_BUY_SIGNAL,sum( `Signal` = 'SELL') AS Num_SELL_SIGNAL,
		sum( `Signal` != 'HOLD') AS "Total_Non-HOLD_Signals" FROM eicher2
UNION
SELECT 	'HERO' AS STOCK_NAME ,sum( `Signal` = 'BUY') AS Num_BUY_SIGNAL,sum( `Signal` = 'SELL') AS Num_SELL_SIGNAL,
		sum( `Signal` != 'HOLD') AS "Total_Non-HOLD_Signals" FROM hero2
UNION
SELECT 	'INFOSYS' AS STOCK_NAME ,sum( `Signal` = 'BUY') AS Num_BUY_SIGNAL,sum( `Signal` = 'SELL') AS Num_SELL_SIGNAL,
		sum( `Signal` != 'HOLD') AS "Total_Non-HOLD_Signals" FROM infosys2
UNION
SELECT 	'TCS' AS STOCK_NAME ,sum( `Signal` = 'BUY') AS Num_BUY_SIGNAL,sum( `Signal` = 'SELL') AS Num_SELL_SIGNAL,
		sum( `Signal` != 'HOLD') AS "Total_Non-HOLD_Signals" FROM tcs2
UNION
SELECT 	'TVS' AS STOCK_NAME ,sum( `Signal` = 'BUY') AS Num_BUY_SIGNAL,sum( `Signal` = 'SELL') AS Num_SELL_SIGNAL,
		sum( `Signal` != 'HOLD') AS "Total_Non-HOLD_Signals" FROM tvs2;

-- b. Bajaj Stock Close price for signals other than 'HOLD' for the time-period between 18-May-2015 to 31-Dec-2015

SELECT * FROM bajaj2 
WHERE `Signal` !='HOLD' 
AND ( `Date` >= '2015-05-18' AND `Date` <= '2015-12-11' ); 

-- C. TVS Stock Close price for signals other than 'HOLD' for the time-period between 01-Jan-2017 to 31-Mar-2018

SELECT * FROM tvs2 
WHERE `Signal` !='HOLD' 
AND ( `Date` >= '2017-01-01' AND `Date` <= '2018-03-31' ); 

-- D. EICHER Stock uptrend from 14-June-2016 ; “BUY" signal was raised on 12-July-2016. 
SELECT * FROM eicher2 
WHERE ( `Date` >= '2016-06-14' AND `Date` <= '2016-07-12' );

-- E. TVS Stock on a decline starting 20-Dec-2017 ; “SELL" signal raised on 29-Jan-2018.
SELECT * FROM tvs2 
WHERE ( `Date` >= '2017-12-20' AND `Date` <= '2018-01-29' );

-- F. Extra-ordinary event on 31-May-2018 on TCS Stock
SELECT * FROM tcs2 
WHERE ( `Date` >= '2018-05-28' AND `Date` <= '2018-06-10' );



-- APPENDICES

-- APPENDIX_1
-- UDFs to get signal for other 5 stocks
-- UDF getSignalEicher - For Eicher Stock
CREATE FUNCTION getSignalEicher(inp_date char(10))
RETURNS CHAR(4)
DETERMINISTIC
	return (SELECT IFNULL( (SELECT `Signal` from eicher2 where date = inp_date) , 'HOLD'));

-- UDF getSignalHero - For Hero Stock
CREATE FUNCTION getSignalHero(inp_date char(10))
RETURNS CHAR(4)
DETERMINISTIC
	return (SELECT IFNULL( (SELECT `Signal` from hero2 where date = inp_date) , 'HOLD'));
	
-- UDF getSignalInfosys - For Infosys Stock
CREATE FUNCTION getSignalInfosys(inp_date char(10))
RETURNS CHAR(4)
DETERMINISTIC
	return (SELECT IFNULL( (SELECT `Signal` from infosys2 where date = inp_date) , 'HOLD'));
	
-- UDF getSignalTCS - For TCS Stock
CREATE FUNCTION getSignalTCS(inp_date char(10))
RETURNS CHAR(4)
DETERMINISTIC
	return (SELECT IFNULL( (SELECT `Signal` from tcs2 where date = inp_date) , 'HOLD'));
	
-- UDF getSignalTVS - For TVS Stock
CREATE FUNCTION getSignalTVS(inp_date char(10))
RETURNS CHAR(4)
DETERMINISTIC
	return (SELECT IFNULL( (SELECT `Signal` from tvs2 where date = inp_date) , 'HOLD'));

-- Query to check all UDFs
select 	getSignalBajaj('2018-05-25') 'Bajaj Signal', 
		getSignalEicher('2018-05-25') 'Eicher Signal',
		getSignalHero('2018-05-25') 'Hero Signal',
		getSignalInfosys('2018-05-25') 'Infosys Signal',
		getSignalTCS('2018-05-25') 'TCS Signal',
		getSignalTVS('2018-05-25') 'TVS Signal';
	
		
-- APPENDIX_2 : UDF to get signal when stock name and date are passed
CREATE FUNCTION getSignalANY(tname char(10), inp_date char(10))
RETURNS CHAR(15)
DETERMINISTIC
	return (CASE LOWER(tname)
				WHEN 'bajaj' THEN (SELECT IFNULL( (SELECT `Signal` from bajaj2 where date = inp_date) , 'HOLD'))
				WHEN 'eicher' THEN (SELECT IFNULL( (SELECT `Signal` from eicher2 where date = inp_date) , 'HOLD'))
				WHEN 'hero' THEN (SELECT IFNULL( (SELECT `Signal` from hero2 where date = inp_date) , 'HOLD'))
				WHEN 'infosys' THEN (SELECT IFNULL( (SELECT `Signal` from infosys2 where date = inp_date) , 'HOLD'))
				WHEN 'tcs' THEN (SELECT IFNULL( (SELECT `Signal` from tcs2 where date = inp_date) , 'HOLD'))
				WHEN 'tvs' THEN (SELECT IFNULL( (SELECT `Signal` from tvs2 where date = inp_date) , 'HOLD'))
				ELSE 'STOCK NOT FOUND'
			END);
			
select getSignalANY('TVS','2018-05-17') 'TVS Signal 2018-05-17';
select getSignalANY('BAJAJ','2018-05-19') 'BAJAJ Signal 2018-05-17';
select getSignalANY('ABC','2018-05-19') 'ABC Signal 2018-05-17';
			
-- APPENDIX_3 : UDF to get signal when stock name and date are passed.
-- 				If signal not found for the date passed, then send the signal corresponding to the previous working day signal.
CREATE FUNCTION getSignalANY_prevwd(tname char(10), inp_date char(10))
RETURNS CHAR(15)
DETERMINISTIC
	return (CASE LOWER(tname)
				WHEN 'bajaj' THEN 
					(SELECT IFNULL( (SELECT `Signal` from bajaj2 where date <= inp_date
									 order by date DESC
									 LIMIT 1) ,
									'HOLD' ) )
				WHEN 'eicher' THEN 
					(SELECT IFNULL( (SELECT `Signal` from eicher2 where date <= inp_date
									 order by date DESC
									 LIMIT 1) ,
									'HOLD' ) )
				WHEN 'hero' THEN 
					(SELECT IFNULL( (SELECT `Signal` from hero2 where date <= inp_date
									 order by date DESC
									 LIMIT 1) ,
									'HOLD' ) )
				WHEN 'infosys' THEN 
					(SELECT IFNULL( (SELECT `Signal` from infosys2 where date <= inp_date
									 order by date DESC
									 LIMIT 1) ,
									'HOLD' ) )
				WHEN 'tcs' THEN 
					(SELECT IFNULL( (SELECT `Signal` from tcs2 where date <= inp_date
									 order by date DESC
									 LIMIT 1) ,
									'HOLD' ) )
				WHEN 'tvs' THEN 
					(SELECT IFNULL( (SELECT `Signal` from tvs2 where date <= inp_date
									 order by date DESC
									 LIMIT 1) ,
									'HOLD' ) )									
				ELSE 'STOCK NOT FOUND'
			END);

select getSignalANY_prevwd('BAJAJ','2018-05-26') 'BAJAJ Signal 2018-05-26';			

-- END --