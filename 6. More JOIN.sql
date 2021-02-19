/*
                movie
id      title     yr      director      budget      gross
...

                actor
id      name
...

                casting
movieid   actorid   ord
...
*/

-- List all of the Star Trek movies, include the id, title and yr ordered by year

SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER BY yr

-- Obtain the cast list for 'Casablanca'

SELECT name
FROM actor
JOIN casting ON actor.id = casting.actorid
JOIN movie ON casting.movieid = movie.id
WHERE movie.title = 'Casablanca'

-- List the films in which 'Harrison Ford' has appeared

SELECT title
FROM movie 
JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
WHERE actor.name = 'Harrison Ford'

-- List the films where 'Harrison Ford' has appeared - but not in the starring role

SELECT title
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
WHERE actor.name = 'Harrison Ford'
AND casting.ord <> 1

-- List the films together with the leading star for all 1962 films

SELECT title, name
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
WHERE movie.yr = 1962
AND casting.ord = 1

-- Show the year and the number of movies 'Rock Hudson' made each year for any year in which he made more than 2 movies

SELECT yr, COUNT(title)
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
WHERE actor.name = 'Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2

-- List the film title and the leading actor for all of the films 'Julie Andrews' played in

SELECT title, name
FROM movie 
JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
WHERE casting.ord = 1
AND movieid IN (SELECT movieid FROM casting WHERE actorid = (SELECT id FROM actor WHERE name = 'Julie Andrews'))
                                                             
-- Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles

SELECT name
FROM actor
JOIN casting ON actor.id = casting.actorid
WHERE ord = 1
GROUP BY name
HAVING COUNT(movieid) >= 15

-- List the films released in the year 1978 ordered by the number of actors in the cast, then by title

SELECT title
FROM movie
JOIN casting ON movie.id = casting.movieid
JOIN actor ON casting.actorid = actor.id
WHERE yr = 1978
GROUP BY title
ORDER BY COUNT(actor.id) DESC, title

-- List all the people who have worked with 'Art Garfunkel'

SELECT name
FROM actor
JOIN casting ON actor.id = casting.actorid
WHERE casting.movieid IN (SELECT movieid FROM casting JOIN actor ON casting.actorid = actor.id WHERE name = 'Art Garfunkel')
AND name <> 'Art Garfunkel'
ORDER BY name
