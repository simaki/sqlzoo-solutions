-- 1

SELECT COUNT(*) AS n_stops
FROM stops

-- 2

SELECT id
FROM stops
WHERE name = 'Craiglockhart'

-- 3

SELECT id, name
FROM (
  route
  JOIN stops ON route.stop = stops.id
)
WHERE (company = 'LRT' AND num = '4')

-- 4

SELECT company, num, COUNT(*) AS n_routes
FROM route
WHERE (stop = 149 OR stop = 53)
GROUP BY company, num
HAVING n_routes = 2

-- 5

SELECT a.company, a.num, a.stop AS departure, b.stop AS arrival
FROM (
  route a
  JOIN route b ON (a.company = b.company AND a.num = b.num)
)
WHERE (a.stop = 53 AND b.stop = 149)

-- 6

SELECT a.company, a.num, stopa.name, stopb.name
FROM (
  route a
  JOIN route b ON (a.company = b.company AND a.num = b.num)
  JOIN stops stopa ON a.stop = stopa.id
  JOIN stops stopb ON b.stop = stopb.id
)
WHERE (
  stopa.name = 'Craiglockhart'
  AND stopb.name = 'London Road'
)

-- 7

SELECT a.company, a.num
FROM (
  route a
  JOIN route b ON (a.company = b.company AND a.num = b.num)
)
WHERE (a.stop = 115 AND b.stop = 137)
GROUP BY company, num

-- 8

SELECT a.company, a.num
FROM (
  route a
  JOIN route b ON (a.company = b.company AND a.num = b.num)
  JOIN stops stopa ON a.stop = stopa.id
  JOIN stops stopb ON b.stop = stopb.id
)
WHERE (stopa.name = 'Craiglockhart' AND stopb.name = 'Tollcross')

-- 9

SELECT stopb.name, a.company, a.num
FROM (
  route a
  JOIN route b ON a.company = b.company AND a.num = b.num)
  JOIN stops stopa ON a.stop = stopa.id
  JOIN stops stopb ON b.stop = stopb.id
)
WHERE stopa.name = 'Craiglockhart'

-- 10

SELECT a.num, a.company, stopb.name, d.num, d.company
FROM (
  (
    -- route a = b operates between a.stop AND b.stop
    (
      route a
      JOIN route b ON (a.company = b.company AND a.num = b.num)
    )
    JOIN
    -- route c = d operates between c.stop AND d.stop
    (
      route c
      JOIN route d ON (c.company = d.company AND c.num = d.num)
    )
    ON b.stop = c.stop
  )
  JOIN stops stopa ON a.stop = stopa.id
  JOIN stops stopb ON b.stop = stopb.id
  JOIN stops stopc ON c.stop = stopc.id
  JOIN stops stopd ON d.stop = stopd.id
)
WHERE (stopa.name = 'Craiglockhart' AND stopd.name = 'Lochend')
ORDER BY a.num, a.company, stopb.name, d.num, d.company
