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

