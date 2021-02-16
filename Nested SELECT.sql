/*
                      world
name        continent   area    population  gdp
Afghanistan Asia        652230  25500100    20343000000
Albania	    Europe      28748   2831741     12960000000
Algeria	    Africa      2381741 37100000    188681000000
Andorra	    Europe      468     78115       3712000000
Angola	    Africa      1246700 20609294    100990000000
....
*/

-- List each country name where the population is larger than that of 'Russia'

SELECT name
FROM world
WHERE population > (SELECT population FROM world WHERE name = 'Russia')

-- Show the countries in Europe with a per capita GDP greater than 'United Kingdom'

SELECT name
FROM world
WHERE continent = 'Europe'
AND (gdp/population) > (SELECT (gdp/population) FROM world WHERE name = 'United Kingdom')

-- List the name and continent of countries in the continents containing either Argentina or Australia, ordered by country

SELECT name, continent
FROM world
WHERE continent IN (SELECT continent FROM world WHERE name IN ('Argentina', 'Australia'))
ORDER BY name

-- Which country has a population that is more than Canada but less than Poland?

SELECT name, population
FROM world
WHERE population > (SELECT population FROM world WHERE name = 'Canada')
AND population < (SELECT population FROM world WHERE name = 'Poland')

-- Show the name and the population of each country in Europe as a percentage of the population of Germany (e.g. 3%)

SELECT name, CAST( CAST( ROUND(population/(SELECT population FROM world WHERE name = 'Germany')*100, 0) AS INT ) AS VARCHAR ) + '%' AS percentage
FROM world
WHERE continent = 'Europe'

-- Which countries have a GDP greater than every country in Europe? (Some countries may have NULL gdp values)

SELECT name
FROM world
WHERE gdp > ALL(SELECT gdp FROM world WHERE continent = 'Europe' AND gdp > 0)

-- Find the largest country (by area) in each continent, show the continent, the name and the area (Some countries may have NULL area values)

SELECT continent, name, area
FROM world x
WHERE area >= ALL (SELECT area FROM world y WHERE x.continent = y.continent AND area > 0)
