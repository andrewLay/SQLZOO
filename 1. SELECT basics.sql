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

-- Show the name and the population for 'Sweden', 'Norway' and 'Denmark'

SELECT name, population
FROM world
WHERE name in ('Sweden', 'Norway', 'Denmark')

-- Give the name and the per capita GDP for those countries with a population of at least 200 million

SELECT name, (gdp/population)
FROM world
WHERE population > 200000000

-- Show the name and population in millions for the countries of the continent 'South America'

SELECT name, (population/1000000)
FROM world
WHERE continent = 'South America'

-- Show the countries which have a name that includes the word 'United'

SELECT name
FROM world
WHERE name LIKE '%United%'

-- Show the countries that are big by area (more than 3 million sq km) or big by population (more than 250 million) by name, population and area

SELECT name, population, area
FROM world
WHERE population > 250000000
OR area > 3000000

-- Show the countries that are big by area (more than 3 million sq km) XOR big by population (more than 250 million) by name, population and area

SELECT name, population, area
FROM world
WHERE (population > 250000000 AND area <= 3000000)
OR (population <= 250000000 AND area > 3000000)

-- For South America show population in millions and GDP in billions both to 2 decimal places

SELECT name, ROUND(population/1000000, 2), ROUND(gdp/1000000000, 2)
FROM world
WHERE continent = 'South America'

-- Show per-capita GDP for the trillion dollar countries to the nearest $1000

SELECT name, ROUND(gdp/population, -3)
FROM world
WHERE gdp >= 1000000000000

-- Show the name and capital where the name and the capital have the same number of characters

SELECT name, capital
FROM world
WHERE LEN(name) = LEN(capital)

-- Show the name and the capital where the first letters of each match but don't include countries where they are the same word

SELECT name, capital
FROM world
WHERE LEFT(name, 1) = LEFT (capital, 1)
AND name <> capital

-- Find the country that has all the vowels and no spaces in its name

SELECT name
FROM world
WHERE name LIKE '%a%'
AND name LIKE '%e%'
AND name LIKE '%i%'
AND name LIKE '%o%'
AND name LIKE '%u%'
AND name NOT LIKE '% %'
