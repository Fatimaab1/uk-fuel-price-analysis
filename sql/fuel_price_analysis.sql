-- Count how many records were imported 
SELECT COUNT(*) AS row_count 
FROM fuel_prices;

-- Checking date coverage 
SELECT MIN(date) AS start_date, 
MAX(date) AS end_date 
FROM fuel_prices;

-- Checking if duty changes over time 
SELECT DISTINCT petrol_vat_pct, diesel_vat_pct
FROM fuel_prices;

-- How have prices changed over time
SELECT 
YEAR(date) AS year, 
ROUND(AVG(petrol_price_ppl), 2) AS avg_petrol_ppl,
ROUND(AVG(diesel_price_ppl), 2) AS avg_diesel_ppl
FROM fuel_prices
GROUP BY YEAR(date)
ORDER BY year;

-- which fuel is more expensive on average 
SELECT
ROUND(AVG(petrol_price_ppl), 2) AS overall_avg_petrol_ppl,
ROUND(AVG(diesel_price_ppl), 2) AS overall_avg_diesel_ppl
FROM fuel_prices;

-- What are the highest and lowest prices?
SELECT 
MAX(petrol_price_ppl) AS max_petrol_price,
MIN(petrol_price_ppl) AS min_petrol_price,
MAX(diesel_price_ppl) AS max_diesel_prie,
MIN(diesel_price_ppl) AS min_diesel_price
FROM fuel_prices;

-- Date (week/s) when petrol hit it's maximum price 
SELECT 
date, 
petrol_price_ppl 
FROM fuel_prices 
WHERE petrol_price_ppl = (SELECT MAX(petrol_price_ppl) FROM fuel_prices)
ORDER BY date;

-- Date (week/s) when diesel hit it's maximum price 
SELECT 
date,
diesel_price_ppl
FROM fuel_prices 
WHERE diesel_price_ppl = (SELECT MAX(diesel_price_ppl) 
FROM fuel_prices)
ORDER BY date;

-- Date (week/s) when petrol hit its minimum price 
SELECT 
date,
petrol_price_ppl 
FROM fuel_prices 
WHERE petrol_price_ppl = (SELECT MIN(petrol_price_ppl) 
FROM fuel_prices)
ORDER BY date;

-- Date (week/s) when diesel hit its minimum price 
SELECT 
date,
diesel_price_ppl
FROM fuel_prices
WHERE diesel_price_ppl = (SELECT MIN(diesel_price_ppl) 
FROM fuel_prices)
ORDER BY date; 

-- How diesel - petrol price gap changes over time 
SELECT 
date, 
petrol_price_ppl,
diesel_price_ppl,
ROUND(diesel_price_ppl - petrol_price_ppl, 2) AS diesel_minus_petrol_ppl
FROM fuel_prices
ORDER BY date; 

-- Year with the highest average prices
SELECT 
YEAR(date) AS year,
ROUND(AVG(petrol_price_ppl), 2) AS avg_petrol_ppl,
ROUND(AVG(diesel_price_ppl), 2) AS avg_diesel_ppl
FROM fuel_prices 
GROUP BY YEAR(date)
ORDER BY avg_diesel_ppl DESC;

-- Monthly average petrol and diesel prices
SELECT
  YEAR(`date`)  AS year,
  MONTH(`date`) AS month,
  ROUND(AVG(petrol_price_ppl), 2) AS avg_petrol_ppl,
  ROUND(AVG(diesel_price_ppl), 2) AS avg_diesel_ppl
FROM fuel_prices
GROUP BY YEAR(`date`), MONTH(`date`)
ORDER BY year, month;
