/*
TABLE:
1. stops(id, name)
2. route(num, company, pos, stop)
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

SELECT DISTINCT a.company, a.num
FROM route a JOIN route b
ON (a.company = b.company AND a.num = b.num)
JOIN stops c ON a.stop = c.id
JOIN stops d ON b.stop = d.id
WHERE c.name = 'Craiglockhart' AND d.name = 'Tollcross'

-- Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself, offered by the LRT company

SELECT DISTINCT d.name, a.company, a.num
FROM route a JOIN route b
ON (a.company = b.company AND a.num = b.num)
JOIN stops c ON a.stop = c.id
JOIN stops d ON b.stop = d.id
WHERE c.name = 'Craiglockhart'

-- Find the routes involving two buses that can go from Craiglockhart to Lochend; show both bus no.s and companies, along with the name of the stop for the transfer
/* USE ('AS') ALIAS IN REFERENCE TO THE SUBQUERY RESULTS RETURNED FROM NESTED SELECTS FOR CROSSING MULTIPLE SUBQUERY RESULTS  */
/* CLAUSAL CONDITIONAL: [ON (1) AND (2)] VS. [ON (1) WHERE (2)] MAKES NO DIFFERENCE FOR INNER JOINS */

SELECT bus1.num, bus1.company, stops.name, bus2.num, bus2.company FROM 

(
SELECT a.num, a.company, b.stop
FROM route a
JOIN route b ON (a.num = b.num AND a.company = b.company)
JOIN stops c ON (a.stop = c.id AND c.name = 'Craiglockhart')
) AS bus1

JOIN

(
SELECT d.num, d.company, e.stop
FROM route d
JOIN route e ON (d.num = e.num AND d.company = e.company)
JOIN stops f ON (d.stop = f.id AND f.name = 'Lochend')
) AS bus2

ON bus1.stop = bus2.stop
JOIN stops ON bus1.stop = stops.id
