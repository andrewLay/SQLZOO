/*
             nobel
yr    subject     winner
1960  Chemistry   Willard F. Libby
1960  Literature  Saint-John Perse
1960  Medicine    Sir Frank Macfarlane Burnet
1960  Medicine    Peter Madawar
...
*/

-- Show who won the 1962 prize for Literature

SELECT winner
FROM nobel
WHERE yr = 1962
AND subject = 'Literature'

-- Give the name of the 'Peace' winners since the year 2000, including 2000

SELECT winner
FROM nobel
WHERE subject = 'Peace'
AND yr >= 2000

-- Show all details (yr, subject, winner) of the Literature prize winners for 1980 to 1989 inclusive

SELECT *
FROM nobel
WHERE yr BETWEEN 1980 AND 1989
AND subject = 'Literature'

-- Show all details of the presidential winners:

SELECT *
FROM nobel
WHERE winner IN ('Theodore Roosevelt', 'Woodrow Wilson', 'Jimmy Carter', 'Barack Obama')

-- Show the winners with first name John

SELECT winner
FROM nobel
WHERE winner LIKE 'John%'

-- Show the year, subject, and name of Physics winners for 1980 together with the Chemistry winners for 1984

SELECT yr, subject, winner
FROM nobel
WHERE (subject = 'Physics' AND yr = 1980)
OR (subject = 'Chemistry' AND yr = 1984)

-- Show the year, subject, and name of winners for 1980 excluding Chemistry and Medicine

SELECT *
FROM nobel
WHERE yr = 1980
AND subject NOT IN ('Chemistry', 'Medicine')

-- Show details of people who won a 'Medicine' prize before 1910 (not includive) together with 'Literature' winners after 2004 (inclusive)

SELECT *
FROM nobel
WHERE (subject = 'Medicine' AND yr <1910)
OR (subject = 'Literature' AND yr >= 2004)

-- Find all details of the prize won by EUGENE O'NEILL

SELECT *
FROM nobel
WHERE winner LIKE 'EUGENE O''NEILL'

-- List the winners, year and subject where the winner starts with Sir with the most recent first, then by name

SELECT winner, yr, subject 
FROM nobel
WHERE winner LIKE 'Sir%'
ORDER BY yr DESC, winner ASC

-- Show the 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last

SELECT winner, subject
FROM nobel
WHERE yr = 1984
ORDER BY (CASE WHEN subject IN ('Chemistry', 'Physics') THEN 1 ELSE 0 END), subject, winner
