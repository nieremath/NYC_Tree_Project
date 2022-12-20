# NYC_Tree_Project2

## "If you want to map inequality in New York, you can just count trees"

### By Melody Niere
Capstone Project Idea

Trees are a vital to sustaining life on Earth. In August 2021, articles discussed the importance of trees in NYC : Rich People Are Cool! New Map Shows More Money Means More Trees by Julianne Cuba, Aug 10 2021 and Why an East Harlem Street Is 31 Degrees Hotter Than Central Park West by John Leland, Aug 2021. The articles suggested that the number of trees in a neighborhood is correlated with the income of the neighborhood, with the tagline of the NYTimes article being "If you want to map inequality in New York, you can just count trees".

This project reviews the studies posed by the NYTimes Article and StreetsBlog NYC, comparing tree count and median income. 

By exploring this data, we can determine locations where the tree population must increase to ensure tree equity in NYC.

## Data Sources

### Tree Data Sources from NYC Open Data
##### [Tree Census 2015](https://data.cityofnewyork.us/Environment/2015-Street-Tree-Census-Tree-Data/pi5s-9p35),    [Tree Census 2005](https://data.cityofnewyork.us/Environment/2005-Street-Tree-Census/29bw-z7pj),    [Tree Census 1995](https://data.cityofnewyork.us/Environment/1995-Street-Tree-Census/kyad-zm4j)


### Income Data Source from Census 2020
#### [Median Income by Zipcode](https://data.census.gov/table?t=Income+and+Poverty&g=0500000US36005$8600000,36047$8600000,36061$8600000,36081$8600000,36085$8600000&tid=ACSST5Y2020.S1901),    [Median Income by Borough](https://www.census.gov/quickfacts/fact/table/queenscountynewyork,richmondcountynewyork,kingscountynewyork,newyorkcountynewyork,bronxcountynewyork/PST045221)

### Population Data Source from Census 2020
#### [Census Population Data](https://data.census.gov/table?t=Population+Total&g=0500000US36005$8600000,36047$8600000,36061$8600000,36081$8600000,36085$8600000&tid=ACSDT5Y2020.B01003)

### Land Area in Square Meter by Zipcode Data Source
#### [NYC Zipcode Land Area](https://namecensus.com/zip-codes/new-york/city/new-york/)
[City Block Size](https://www.reference.com/history-geography/many-acres-city-block-c2e3daa4355c15a2), according to Reference.com the average size of a Manhattan block is 660ft by 330ft, or 217800 Sqft, or 24200 Sqyd.

## Data Cleaning
In SQL for all tree datasets, I dropped any row with a dead trees, and selected columns with TreeID, Borough, Longitude, Latitude, Status, Zip_code and Year
<br> Trees Categories Removed in 1995: Dead, Stump, Shaft, Planting Spaces       
Trees Categories Kept in 1995: Excellent, Good, Poor
<br> Trees Categories Removed in 2005: Empty, Pit, Stump, Shaft, Dead            
Trees Categories Kept in 1995: Excellent, Good, Poor
<br> Trees Categories Removed in 2015: Dead                                      
Trees Categories Kept in 1995: Alive

## Compiling Data
Using SQL, I joined the income, population and land size data with the clean 2015 tree census table. 
Using CTEs, then I used those columns to create new ratios such as Humans per Block, Trees per Block and Human to Trees. 

