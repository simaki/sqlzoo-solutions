-- 1

SELECT name
FROM world
WHERE population > (
  SELECT population
  FROM world
  WHERE name = 'Russia'
)

-- 2

SELECT name FROM world
WHERE (
  continent = 'Europe'
  AND gdp / population > (
    SELECT gdp / population
    FROM world
    WHERE name = 'United Kingdom'
  )
)

-- 3

SELECT name, continent
FROM world
WHERE (
  continent = (
    SELECT continent
    FROM world
    WHERE name = 'Argentina'
  )
  OR continent = (
    SELECT continent
    FROM world
    WHERE name = 'Australia'
  )
)
ORDER BY name

-- 4

SELECT name, population
FROM world
WHERE (
  population > (
    SELECT population
    FROM world
    WHERE name = 'Canada'
  )
  AND population < (
    SELECT population
    FROM world
    WHERE name = 'Poland'
  )
)

-- 5

SELECT
name,
CONCAT(ROUND(
    100 * population / (
      SELECT population
      FROM world
      WHERE name = 'Germany'
    )
), '%')
FROM world
WHERE continent = 'Europe'

-- 6

SELECT name FROM world
WHERE gdp > ALL(
  SELECT gdp
  FROM world
  WHERE (
    continent = 'Europe'
    AND gdp IS NOT null
  )
)

-- 7

SELECT continent, name, area
FROM world x
WHERE area >= ALL(
  SELECT area
  FROM world
  WHERE continent = x.continent
)

-- 8

SELECT continent, name
FROM world x
WHERE name <= ALL(
  SELECT name
  FROM world
  WHERE continent = x.continent
)

-- 9

SELECT name, continent, population
FROM world x
WHERE 25000000 > ALL(
  SELECT population
  FROM world
  WHERE continent = x.continent
)

-- 10

SELECT name, continent
FROM world x
WHERE population >= ALL(
  SELECT 3 * population
  FROM world
  WHERE continent = x.continent
  AND name <> x.name
)
