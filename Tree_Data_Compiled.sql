-- 2015 Tree Census CLEANING
-- check DATA 
SELECT * FROM Census c 
LIMIT 100;

-- Only Alive Trees have condition excellent, good, poor
-- Remove dead, stump, shaft trees and planting spaces
-- Keep columns ID, Zip_new, Borough, Longitude, Latitude
SELECT tree_id, borough, longitude, latitude, status, postcode as zip_code, nta_name
FROM Census c 
WHERE status = "Alive";

-- Census 2015, joining income, population and land SIZE
-- creating human to block, tree per block and human to tree ratio
WITH census_clean as 
(
-- cleaning table
SELECT tree_id, borough, longitude, latitude, status, postcode as zip_code, nta_name
FROM Census c 
WHERE status = "Alive"
), tree_count_cte as 
(
-- counting trees by zipcode
SELECT zip_code, borough, nta_name, COUNT(tree_id) as tree_count
FROM census_clean
GROUP BY zip_code
), cte_join as 
(
-- JOIN income, population and land size tables with tree census
SELECT tree_count_cte.zip_code, tree_count_cte.tree_count, borough, nta_name, 
i.Households_Median_Income, p."Population Total" as population_total, l.Number_of_blocks  
FROM tree_count_cte
JOIN Income i 
ON tree_count_cte.zip_code = i.Zipcode 
JOIN population p
ON tree_count_cte.zip_code = p.Zipcode
JOIN land_area_by_zipcodes l
ON tree_count_cte.zip_code = l."ZIP Code" 
)
-- creating new ratios
SELECT *, 
population_total/number_of_blocks as Humans_per_block, 
tree_count/number_of_blocks as trees_per_block, 
population_total/tree_count as humans_to_tree 
FROM cte_join;


-- HISTORICAL DATA, 1995 and 2005
-- 1995 Tree Census CLEANING
-- Check data
SELECT * FROM Census_1995 c 
LIMIT 10;

-- Determine if postal code or zip code should be used
SELECT COUNT(*) FROM Census_1995 c 
WHERE Postcode_Original != Zip_New; 
-- 37,021 rows where postal and zip codes do not match

SELECT COUNT(*) FROM Census_1995 c 
WHERE Postcode_Original = 0;
-- 1904 rows with missing postal codes

SELECT COUNT(*) FROM Census_1995 c 
WHERE Zip_New  = 0
-- 23,299 rows with missing zip codes
-- Since there is more missing zip codes, I'll use postal code for zip codes



-- Only Alive Trees have condition excellent, good, poor
-- Remove dead, stump, shaft trees and planting spaces
-- Keep columns ID, Zip_new, Borough, Longitude, Latitude
SELECT 
	RecordId as TreeID, Borough, Longitude, Latitude, "Condition" as Status,
	CASE 
		WHEN Postcode_Original > 0 THEN Postcode_Original
		ELSE Zip_New 
	END as Zip_code
FROM Census_1995 c 
WHERE "Condition" IN ('Excellent', 'Good', 'Poor')

-- check to see how many missing zip codes
WITH cte as (
SELECT 
	CASE 
		WHEN Zip_New > 0 THEN Zip_New
		ELSE Postcode_Original
	END as Zip_code, 
	RecordId, Borough, Longitude, Latitude, "Condition"  
FROM Census_1995 c 
WHERE "Condition" IN ('Excellent', 'Good', 'Poor')
)
SELECT COUNT(*) FROM cte
WHERE zip_code = 0;
-- still 815 missing zip codes
-- I'll keep these rows because these tree can still count towards Borough Count

-- 2005 Tree Census CLEANING
-- check data
SELECT * FROM Census_2005 c 
LIMIT 100;

-- Only Alive Trees have condition excellent, good, poor
-- Remove dead, stump, shaft trees and planting spaces
-- Keep columns ID, Zip_new, Borough, Longitude, Latitude
SELECT OBJECTID as TreeID, boroname as Borough, longitude, latitude, status, zipcode  
FROM Census_2005 c 
WHERE status IN ('Excellent','Good','Poor')