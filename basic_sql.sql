-- SQL queries to explore a database of community information. Relevant tables include:
--     CENSUS table
--     CRIME table
--     SCHOOLS table
-- SQL skills used: Subqueries, aggregate functions, grouping, ordering, limiting, and basic text search

-- How many crimes are recorded in the database?
SELECT COUNT(*) 
FROM CRIME;

-- Which areas have a per-capita income less than 12,000?
SELECT COMMUNITY_AREA_NAME, PER_CAPITA_INCOME 
FROM CENSUS
WHERE PER_CAPITA_INCOME < 12000;

-- Which cases involved minors?
SELECT CASE_NUMBER 
FROM CRIME 
WHERE DESCRIPTION LIKE '%MINOR%';

-- Find all kidnappings (involving children)?
SELECT CASE_NUMBER 
FROM CRIME 
WHERE CRIME_TYPE LIKE '%KIDNAPPING%' AND DESCRIPTION LIKE '%CHILD%';

-- What kinds of crimes occurred at schools?
SELECT DISTINCT(CRIME_TYPE) 
FROM CRIME
WHERE LOCATION_DESCRIPTION LIKE '%SCHOOL%';

-- What is the average safety score for each school type?
SELECT ELEMENTARY_MIDDLE_OR_HIGH, AVG(SAFETY_SCORE) AS AVERAGE_SAFETY 
FROM SCHOOLS
GROUP BY ELEMENTARY_MIDDLE_OR_HIGH;

-- Which 5 areas have the highest fraction of households in poverty?
SELECT COMMUNITY_AREA_NAME, PERCENT_BELOW_POVERTY 
FROM CENSUS
ORDER BY PERCENT_BELOW_POVERTY DESC
LIMIT 5;

-- Which area has the most crime?
SELECT COMMUNITY_AREA_NUMBER, COUNT(*) AS TOTAL_CRIMES 
FROM CRIME 
GROUP BY COMMUNITY_AREA_NUMBER
ORDER BY COUNT(*) DESC
LIMIT 1;

-- Which area has the highest hardship index?
SELECT COMMUNITY_AREA_NAME 
FROM CENSUS
WHERE HARDSHIP_INDEX = 
    (SELECT MAX(HARDSHIP_INDEX) FROM CENSUS);

-- Which area has the most crime?
SELECT COMMUNITY_AREA_NAME 
FROM CENSUS
WHERE COMMUNITY_AREA_NUMBER = 
    (SELECT COMMUNITY_AREA_NUMBER 
    FROM CRIME 
    GROUP BY COMMUNITY_AREA_NUMBER
    ORDER BY COUNT(*) DESC
    LIMIT 1);