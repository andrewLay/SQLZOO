/*
TABLE:
1) stops(id, name)
2) route(num, company, pos, stop)
*/

-- Give the id and the name for the stops on the '4' 'LRT' service

SELECT id, name
FROM stops
JOIN route ON stops.id = route.stop
WHERE route.num = '4' AND route.company = 'LRT'

-- Give the number of routes that visit either London Road (149) or Craiglockhart (53), and  restrict the output to stops that have a count of 2

SELECT company, num, COUNT(*)
FROM route
WHERE stop = 149 OR stop = 53
GROUP BY company, num
HAVING COUNT(*) = 2

-- Show the services from Craiglockhart to London Road without changing routes
/* WITHOUT CHANGING ROUTES, THE ROUTE'S (NUM, COMPANY) MUST STAY THE SAME; EXECUTE A SELF JOIN TO GET FROM 1 STOP TO ANY OTHER STOP IN SAME ROUTE */

SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b
ON a.company = b.company AND a.num = b.num
WHERE a.stop = 53 AND b.stop = 149

-- Show the services from Craiglockhart to London Road without changing routes, but reference the stops by name instead

SELECT a.company, a.num, c.name, d.name
FROM route a 
JOIN route b
ON a.company = b.company AND a.num = b.num
JOIN stops c ON a.stop = c.id
JOIN stops d ON b.stop = d.id
WHERE c.name = 'Craiglockhart'
AND d.name = 'London Road'

-- Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')

SELECT DISTINCT a.company, a.num
FROM route a JOIN route b
ON (a.company = b.company AND a.num = b.num)
WHERE a.stop = 115 AND b.stop = 137

-- Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'

