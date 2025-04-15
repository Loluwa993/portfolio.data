/* This is the start of the Capstone Project on International Breweries Data
provided by Utiva Course on Postgesql, presented by Student - Fademi Jesuloluwa.

I will be using comments throughout the code as markers.

Thank You
*/

/* Note: The Database was created using in-tool of pgAdmin4 but 
the code was copied for proper documentation

--Beginning of Creating the Database--
CREATE DATABASE "Capstone Project Trial"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;

COMMENT ON DATABASE "Capstone Project Trial"
    IS 'Database for Utiva Capstone Project on PostgreSQL. The data describes sales in International Breweries';
	
--End of Creating the Database--
*/

--Creating Table for the data. The Columns were named in compliance with the csv file
--CODE EXECUTED; Don't Run the CREATE VIEW CODE--------------------
CREATE TABLE intrnlbrew
(
	SALES_ID int NOT NULL,
	SALES_REP varchar (50),
	EMAILS varchar (50),
	BRANDS varchar (50),
	PLANT_COST int,
 	UNIT_PRICE int,
	QUANTITY int,
	COST int,
	PROFIT int,
	COUNTRIES varchar (50),
	REGION varchar (50),
	MONTHS varchar (50),
	YEARS varchar (10)
);
----------------------------------------

-- Displaying the created table for verification
SELECT * FROM intrnlbrew
-- Verified.

/* The next step is to import the provided data file (International_Breweries.csv).
For this step, there are two approaches (Writing the Code or Impot/Export Tool); 
I have tried both and have decided to write the code below simply for reference purpose. */

-- Import CSV File
--CODE EXECUTED; Don't Run the CODE--------------------
COPY intrnlbrew
FROM 'C:/Users/jesul/Documents/GitHub/portfolio.data/files/international breweries.csv'
WITH (FORMAT 'csv', HEADER, DELIMITER ',');
----------------------------------------

-- Displaying the information imported for verification
SELECT * FROM intrnlbrew
-- Verified.

/* SESSION A - PROFIT ANALYSIS: CASE 1 -  Within the space of the last three years, what was the profit worth of the breweries,
inclusive of the anglophone and the francophone territories? */

--ANSWER TO SESSION A: CASE 1
--CODE EXECUTED; Don't Run the CREATE VIEW CODE--------------------
GO
CREATE VIEW Profit_Worth_of_Breweries_in_last_3_years
AS
SELECT SUM(PROFIT) AS Total_Profit 
FROM intrnlbrew;
GO
----------------------------------------

-- Run this next code for the actual answer
SELECT * FROM Profit_Worth_of_Breweries_in_last_3_years
--STOP ANSWER TO SESSION A: CASE 1


/* SESSION A - PROFIT ANALYSIS: CASE 2 - Compare the total profit between these two territories in order for the territory manager,
Mr. Stone made a strategic decision that will aid profit maximization in 2020. */
-- This returns the list of countries in the table
SELECT DISTINCT COUNTRIES FROM intrnlbrew
-- Anglophone Countries are: Nigeria, Ghana, Senegal
-- Francophone Countries are: Benin, Togo

-- A simple code to check the value for "Anglophone"
SELECT SUM(PROFIT) FROM intrnlbrew
WHERE COUNTRIES ='Nigeria' OR COUNTRIES ='Ghana' OR COUNTRIES = 'Senegal'

-- A simple code to check the value for "Francophone"
SELECT SUM(PROFIT) FROM intrnlbrew
WHERE COUNTRIES ='Benin' OR COUNTRIES ='Togo'

--ANSWER TO SESSION A: CASE 2
--CODE EXECUTED; Don't Run the CREATE VIEW CODE --------------------
CREATE VIEW Total_Profit_Per_Territories AS
SELECT CASE
	WHEN COUNTRIES ='Nigeria' OR COUNTRIES ='Ghana' OR COUNTRIES = 'Senegal' THEN 'Anglophone'
	ELSE 'Francophone'
	END AS TERRITORIES,
SUM(PROFIT) FROM intrnlbrew
GROUP BY TERRITORIES;
----------------------------------------

-- Run this next code for the answer to SESSION A: CASE 2
SELECT * FROM Total_Profit_Per_Territories

-- STOP--- ANSWER TO SESSION A: CASE 2


/* SESSION A - PROFIT ANALYSIS: CASE 3 - Country that generated the highest profit in 2019 */
--ANSWER TO SESSION A: CASE 3
SELECT COUNTRIES, SUM(PROFIT) AS Profit_Per_Country
FROM intrnlbrew
WHERE YEARS = '2019'
GROUP BY COUNTRIES
ORDER BY Profit_Per_Country DESC LIMIT (1);

-- Country that generated the highest profit in 2019 was GHANA WITH 7,144,070.
-- STOP--- ANSWER TO SESSION A: CASE 3



/* SESSION A - PROFIT ANALYSIS: CASE 4 - Help him find the year with the highest profit */
--ANSWER TO SESSION A: CASE 4
SELECT YEARS, SUM(PROFIT) AS Profit_Per_Year
FROM intrnlbrew
GROUP BY YEARS
ORDER BY Profit_Per_Year DESC LIMIT (1);

-- The year with highest profit was 2017 WITH 38,503,320.
-- STOP--- ANSWER TO SESSION A: CASE 4


/* SESSION A - PROFIT ANALYSIS: CASE 5 - Which month in the three years was the least profit generated? */
--ANSWER TO SESSION A: CASE 5
SELECT MONTHS, SUM(PROFIT) AS Profit_Per_Month
FROM intrnlbrew
GROUP BY MONTHS
ORDER BY Profit_Per_Month ASC LIMIT (1);

-- The Month with lowest profit was APRIL WITH 8,573,830.
-- STOP--- ANSWER TO SESSION A: CASE 5


/* SESSION A - PROFIT ANALYSIS: CASE 6 - What was the minimum profit in the month of December 2018? */
--ANSWER TO SESSION A: CASE 6
SELECT  BRANDS, COUNTRIES, MIN(PROFIT) AS Min_Profit_in_Dec_2018
FROM intrnlbrew
WHERE
MONTHS = 'December'
AND
YEARS = '2018'
GROUP BY 1,2
ORDER BY 3 ASC;

-- The Minimum Profit in December 2018 was from "Hero in Senegal" WITH Profit of 38,150.
-- STOP--- ANSWER TO SESSION A: CASE 6


/* SESSION A - PROFIT ANALYSIS: CASE 7 - Compare the profit in percentage for each of the month in 2019? */
-- This Code show Total Profit in Year 2019
SELECT SUM(PROFIT)
FROM intrnlbrew
WHERE YEARS = '2019'

-- This Code creates a VIEW (Profits_by_Months_2019) of Profits per Month in Year 2019
--CODE EXECUTED; DON'T RUN THIS CODE
CREATE VIEW Profits_by_Months_2019 AS
SELECT MONTHS, SUM(PROFIT)
FROM intrnlbrew
WHERE YEARS = '2019'
GROUP BY MONTHS;

---To View Profits per Month in Year 2019
SELECT * FROM Profits_by_Months_2019;

-- To Verify if the Sum is compliant with preivously calculated Sum
SELECT SUM(Profits_by_Months_2019.SUM) FROM Profits_by_Months_2019

--ANSWER TO SESSION A: CASE 7

WITH Total_Profit_in_2019 as
    ( SELECT SUM(Profits_by_Months_2019.SUM) as Total_Profit_in_2019
    FROM Profits_by_Months_2019 )
SELECT Profits_by_Months_2019.MONTHS, 
(Profits_by_Months_2019.SUM * 100) / Total_Profit_in_2019 AS Ptge_Profit_per_Mnth_2019
FROM Profits_by_Months_2019, Total_Profit_in_2019
ORDER BY Ptge_Profit_per_Mnth_2019 DESC;

-- STOP--- ANSWER TO SESSION A: CASE 7


/* SESSION A - PROFIT ANALYSIS: CASE 8 - Which particular brand generated the highest profit in Senegal?
 */
--ANSWER TO SESSION A: CASE 8
SELECT BRANDS, SUM(PROFIT) AS Profit_in_Senegal
FROM Intrnlbrew
WHERE COUNTRIES = 'Senegal'
GROUP BY BRANDS
ORDER BY Profit_in_Senegal DESC LIMIT (1);

-- The particular brand that generated the highest profit in Senegal was "Castle Lite" WITH 7,012,980 in Profits
-- STOP--- ANSWER TO SESSION A: CASE 8



/* SESSION B - BRAND ANALYSIS: CASE 1 - Within the last two years, the brand manager wants to know the top three brands
consumed in the francophone countries */
SELECT * FROM intrnlbrew

--ANSWER TO SESSION B: CASE 1

SELECT Brands, SUM(Quantity) AS Qty_per_Brand
FROM intrnlbrew
WHERE (COUNTRIES = 'Benin' OR COUNTRIES = 'Togo')
AND (YEARS = '2019' OR YEARS = '2018')
GROUP BY Brands
ORDER BY Qty_per_Brand DESC LIMIT (3);

-- The top three brands consumed in the francophone countries from 2018 to 2019 are "Trophy, Castle Lite & Hero"
-- STOP--- ANSWER TO SESSION B: CASE 1


/* SESSION B - BRAND ANALYSIS: CASE 2 - Find out the top two choice of consumer brands in Ghana */
--ANSWER TO SESSION B: CASE 2
SELECT Brands, SUM(Quantity) AS Qty_per_Brand
FROM intrnlbrew
WHERE COUNTRIES = 'Ghana'
GROUP BY Brands
ORDER BY Qty_per_Brand DESC LIMIT (2);

--The top two choices of consumer brands in Ghana are "Eagle Lager & Castle Lite "
-- STOP--- ANSWER TO SESSION B: CASE 2



/* SESSION B - BRAND ANALYSIS: CASE 3 -  Find out the details of beers consumed in the past three years in the most oil reached
country in West Africa */
Select * from intrnlbrew
select distinct brands from intrnlbrew

-- BEERS produced are: "Trophy, Budweiser, Castle Lite, Hero, Ealge Lager" [meaning everything except Grand Malt & Beta Malt]
-- The most oil reached country in West Africa is "Nigeria"

--ANSWER TO SESSION B: CASE 3
SELECT Brands, SUM(Quantity) AS Qty_per_Beer,
SUM(intrnlbrew.Cost) AS Cost_of_Beer, SUM(intrnlbrew.profit) AS Profit_of_Beer
FROM intrnlbrew
WHERE (NOT Brands ='grand malt' AND NOT Brands ='beta malt') AND COUNTRIES = 'Nigeria'
GROUP BY Brands
ORDER BY Qty_per_Beer DESC;

--The top two choices of consumer brands in Ghana are "Eagle Lager & Budweiser"
-- STOP--- ANSWER TO SESSION B: CASE 3



/* SESSION B - BRAND ANALYSIS: CASE 4 - Favorites malt brand in Anglophone region between 2018 and 2019 */
-- Anglophone Countries are: Nigeria, Ghana, Senegal
--ANSWER TO SESSION B: CASE 4

SELECT Brands, SUM(Quantity) AS Qty_per_Brand
FROM intrnlbrew
WHERE (COUNTRIES = 'Nigeria' OR COUNTRIES = 'Ghana' OR COUNTRIES = 'Senegal')
AND (YEARS = '2019' OR YEARS = '2018') AND (BRANDS ='beta malt' OR BRANDS = 'grand malt')
GROUP BY Brands
ORDER BY Qty_per_Brand DESC LIMIT (1);

--The Favorite malt brand in Anglophone region between 2018 and 2019 is "Grand Malt"
-- STOP--- ANSWER TO SESSION B: CASE 4


/* SESSION B - BRAND ANALYSIS: CASE 5 - Which brands sold the highest in 2019 in Nigeria? */
--ANSWER TO SESSION B: CASE 5

SELECT BRANDS, SUM(COST) AS Sales_per_Brand
FROM intrnlbrew
WHERE COUNTRIES = 'Nigeria' AND YEARS = '2019'
GROUP BY BRANDS
ORDER BY 2 DESC;

-- STOP--- ANSWER TO SESSION B: CASE 5


/* SESSION B - BRAND ANALYSIS: CASE 6 - Favorites brand in South_South region in Nigeria */
--ANSWER TO SESSION B: CASE 6

SELECT BRANDS, SUM(QUANTITY) AS Fave_Brand
FROM intrnlbrew
WHERE COUNTRIES = 'Nigeria' AND REGION = 'southsouth'
GROUP BY BRANDS
ORDER BY 2 DESC;

-- STOP--- ANSWER TO SESSION B: CASE 6

SELECT * FROM intrnlbrew



/* SESSION B - BRAND ANALYSIS: CASE 7 - Beer consumption in Nigeria */
--ANSWER TO SESSION B: CASE 7

SELECT Brands, SUM(Quantity) AS Beer_Cnsmpt,
SUM(intrnlbrew.Cost) AS Cost_of_Beer_Consmd FROM intrnlbrew
WHERE (NOT Brands ='grand malt' AND NOT Brands ='beta malt') AND COUNTRIES = 'Nigeria'
GROUP BY Brands
ORDER BY Beer_Cnsmpt DESC;

-- STOP--- ANSWER TO SESSION B: CASE 7



/* SESSION B - BRAND ANALYSIS: CASE 8 -  Level of consumption of Budweiser in the regions in Nigeria */
--ANSWER TO SESSION B: CASE 8

SELECT SUM(quantity) FROM intrnlbrew
WHERE Brands = 'budweiser' AND Countries = 'Nigeria'

--Approach 1: RUN CODE FOR ANSWER TO BRAND ANALYSIS: CASE 8
WITH Ttl_Qty_Bud_Cons_in_Nig AS
    (SELECT SUM(intrnlbrew.quantity) AS Ttl_Qty_Bud_Cons_in_Nig FROM intrnlbrew
	WHERE Brands = 'budweiser' AND Countries = 'Nigeria')
SELECT Region, SUM(intrnlbrew.quantity) AS Qty_Bud_Cons_per_Region_Nig,
(SUM(intrnlbrew.quantity) * 100) / Ttl_Qty_Bud_Cons_in_Nig AS Ptge_Bud_Cons_per_Region_Nig
FROM intrnlbrew, Ttl_Qty_Bud_Cons_in_Nig
WHERE Brands = 'budweiser' AND Countries = 'Nigeria'
GROUP BY REGION, Ttl_Qty_Bud_Cons_in_Nig
ORDER BY Ptge_Bud_Cons_per_Region_Nig DESC;

--End of Approach 1: BRAND ANALYSIS: CASE 8

--Approach 2 BRAND ANALYSIS: CASE 8: Which is used to crosscheck the result of the above code
-- This Code creates a VIEW (Budwsr_Consmpt_in_Nig) of Budweiser Consumption in Nigeria
--CODE EXECUTED; DON'T RUN THIS CODE
CREATE VIEW Budwsr_Consmpt_in_Nig AS
SELECT region, years, SUM(quantity) as qty_Budwsr_Conmd
FROM intrnlbrew
WHERE brands = 'budweiser' and countries = 'Nigeria'
GROUP BY region, years;

---To View Budweiser Consumption in Nigeria
SELECT * FROM Budwsr_Consmpt_in_Nig

-- To Verify if the Sum is compliant with preivously calculated Sum
SELECT SUM(qty_Budwsr_Conmd) FROM Budwsr_Consmpt_in_Nig

--Approach 2: RUN CODE FOR ANSWER TO BRAND ANALYSIS: CASE 8
WITH Total_qty_Budwsr_Conmd_Nig AS
    ( SELECT SUM(qty_Budwsr_Conmd) AS Total_qty_Budwsr_Conmd_Nig
    FROM Budwsr_Consmpt_in_Nig )
SELECT region, SUM(qty_Budwsr_Conmd) AS BudQty_per_Region,
(SUM(qty_Budwsr_Conmd) * 100) / Total_qty_Budwsr_Conmd_Nig AS Ptge_Budwsr_Consmd_per_Reg_Nig
FROM Budwsr_Consmpt_in_Nig, Total_qty_Budwsr_Conmd_Nig
GROUP BY region, Total_qty_Budwsr_Conmd_Nig
ORDER BY Ptge_Budwsr_Consmd_per_Reg_Nig DESC;

--End of Approach 2: BRAND ANALYSIS: CASE 8
-- STOP--- ANSWER TO SESSION B: CASE 8


/* SESSION B - BRAND ANALYSIS: CASE 9 -   Level of consumption of Budweiser in the regions in Nigeria in 2019 (Decision on Promo) */
--ANSWER TO SESSION B: CASE 9

SELECT SUM(quantity) FROM intrnlbrew
WHERE Brands = 'budweiser' AND Countries = 'Nigeria' AND years = '2019'

--Approach 1: RUN CODE FOR ANSWER TO BRAND ANALYSIS: CASE 9
WITH Ttl_Qty_Bud_Cons_in_Nig_2019 AS
    (SELECT SUM(intrnlbrew.quantity) AS Ttl_Qty_Bud_Cons_in_Nig_2019 FROM intrnlbrew
	WHERE Brands = 'budweiser' AND Countries = 'Nigeria' AND years = '2019')
SELECT Region, SUM(intrnlbrew.quantity) AS Qty_Bud_Cons_per_Region_Nig_2019,
(SUM(intrnlbrew.quantity) * 100) / Ttl_Qty_Bud_Cons_in_Nig_2019 AS Ptge_Bud_Cons_per_Region_Nig_2019
FROM intrnlbrew, Ttl_Qty_Bud_Cons_in_Nig_2019
WHERE Brands = 'budweiser' AND Countries = 'Nigeria' AND years = '2019'
GROUP BY REGION, Ttl_Qty_Bud_Cons_in_Nig_2019
ORDER BY Ptge_Bud_Cons_per_Region_Nig_2019 DESC;

--End of Approach 1: BRAND ANALYSIS: CASE 9

--Approach 2: BRAND ANALYSIS: CASE 9 Which is used to crosscheck the result of the above code
-- By Accessing the previous View (Budwsr_Consmpt_in_Nig)
---To View Budweiser Consumption in Nigeria;
SELECT * FROM Budwsr_Consmpt_in_Nig

-- To Verify if the Sum is compliant with preivously calculated Sum
SELECT SUM(qty_Budwsr_Conmd) FROM Budwsr_Consmpt_in_Nig
WHERE years = '2019';

--Approach 2: RUN CODE FOR ANSWER TO BRAND ANALYSIS: CASE 9
WITH Total_qty_Budwsr_Conmd_Nig_2019 AS
    ( SELECT SUM(qty_Budwsr_Conmd) AS Total_qty_Budwsr_Conmd_Nig_2019
    FROM Budwsr_Consmpt_in_Nig 
	WHERE years = '2019')
SELECT region, SUM(qty_Budwsr_Conmd) AS BudQty_per_Region_2019,
(SUM(qty_Budwsr_Conmd) * 100) / Total_qty_Budwsr_Conmd_Nig_2019 AS Ptge_Budwsr_Consmd_2019_per_Reg_Nig
FROM Budwsr_Consmpt_in_Nig, Total_qty_Budwsr_Conmd_Nig_2019
WHERE YEARS = '2019'
GROUP BY region, Total_qty_Budwsr_Conmd_Nig_2019
ORDER BY Ptge_Budwsr_Consmd_2019_per_Reg_Nig DESC;

--End of Approach 2: BRAND ANALYSIS: CASE 9
-- STOP--- ANSWER TO SESSION B: CASE 9



/* SESSION C - BRAND ANALYSIS: CASE 1 - Country with the highest consumption of beer.
*/
--ANSWER TO SESSION C: CASE 1

SELECT COUNTRIES, SUM(QUANTITY) AS Qty_Beer_Consumed
FROM Intrnlbrew
WHERE NOT BRANDS = 'beta malt' AND NOT BRANDS = 'grand malt'
GROUP BY 1
ORDER BY 2 DESC LIMIT (1);

-- Country with the highest consumption of beer was "Senegal"
-- STOP--- ANSWER TO SESSION C: CASE 1


/* SESSION C - BRAND ANALYSIS: CASE 2 - Highest sales personnel of Budweiser in Senegal.
*/
--ANSWER TO SESSION C: CASE 2

SELECT intrnlbrew.sales_id, sales_rep, SUM(QUANTITY) AS Qty_sold, SUM(cost) AS Sales_made
FROM Intrnlbrew
WHERE BRANDS = 'budweiser' AND COUNTRIES = 'Senegal'
GROUP BY intrnlbrew.sales_id
ORDER BY Sales_made DESC LIMIT (1);

-- Highest sales personnel of Budweiser in Senegal was "Jones - ID_10690"
-- STOP--- ANSWER TO SESSION C: CASE 2

/* SESSION C - BRAND ANALYSIS: CASE 3 -  Country with the highest profit of the fourth quarter in 2019.
*/
SELECT * FROM Intrnlbrew
--ANSWER TO SESSION C: CASE 3

SELECT COUNTRIES, SUM(PROFIT) AS Profit_qtr4_2019
FROM Intrnlbrew
WHERE YEARS = '2019' AND (MONTHS = 'October' OR MONTHS = 'November' OR MONTHS = 'December')
GROUP BY COUNTRIES
ORDER BY Profit_qtr4_2019 DESC LIMIT (1);

-- Country with the highest profit of the fourth quarter in 2019 was "Ghana"
-- STOP--- ANSWER TO SESSION C: CASE 3

-- END SQL QUERY FOR INTERNATION BREWERIES SALES DATA - UTIVA SQL CAPSTONE PROJECT