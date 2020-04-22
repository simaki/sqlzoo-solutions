-- 1

SELECT id, title
FROM movie
WHERE yr = 1962

-- 2

SELECT yr
FROM movie
WHERE title = 'Citizen Kane'

-- 3

SELECT id, title, yr
FROM movie
WHERE title LIKE '%Star Trek%'
ORDER by yr

-- 4

SELECT id
FROM actor
WHERE name = 'Glenn Close'

-- 5

SELECT id
FROM movie
WHERE title = 'Casablanca'

-- 6

SELECT name
FROM (
  casting
  JOIN actor ON casting.actorid = actor.id
)
WHERE movieid = (
  SELECT id
  FROM movie
  WHERE title = 'Casablanca'
)

-- 7

SELECT name
FROM (
  casting
  JOIN actor ON casting.actorid = actor.id
)
WHERE movieid = (
  SELECT id
  FROM movie
  WHERE title = 'Alien'
)

-- 8

SELECT title
FROM (
  movie
  JOIN casting ON movie.id = casting.movieid
)
WHERE actorid = (
  SELECT id
  FROM actor
  WHERE name = 'Harrison Ford'
)

-- 9

SELECT title
FROM (
  movie
  JOIN casting ON movie.id = casting.movieid
)
WHERE (
  actorid = (
    SELECT id
    FROM actor
    WHERE name = 'Harrison Ford'
  )
  AND NOT ord = 1
)

-- 10

SELECT title, name
FROM (
  movie
  JOIN casting ON (movie.id = casting.movieid)
  JOIN actor ON (casting.actorid = actor.id)
)
WHERE (ord = 1 AND yr = 1962)

-- 11

SELECT yr, COUNT(title) AS n_movie
FROM (
  movie
  JOIN casting ON movie.id = movieid
  JOIN actor ON actorid = actor.id
)
WHERE name = 'Rock Hudson'
GROUP BY yr
HAVING COUNT(title) > 2

-- 12

SELECT title, name
FROM (
  movie
  JOIN casting ON movie.id = movieid
  JOIN actor ON actorid = actor.id
)
WHERE (
  ord = 1
  AND movieid IN (
    -- movieid of movies in which Julie Andrews appears
    SELECT movieid
    FROM casting JOIN actor ON casting.actorid = actor.id
    WHERE name = 'Julie Andrews'
  )
)

-- 13

SELECT name
FROM (
  casting
  JOIN actor ON (
    casting.actorid = actor.id
    AND (
      SELECT COUNT(ord)
      FROM casting
      WHERE ord = 1 AND actorid = actor.id
    ) >= 15
  )
)
GROUP BY name
ORDER BY name

-- 14

SELECT title, COUNT(*) AS n_actor
FROM (
  movie
  JOIN casting ON movie.id = casting.movieid
)
WHERE yr = 1978
GROUP BY title
ORDER BY n_actor DESC, title

-- 15

SELECT DISTINCT(name)
FROM (
  casting
  JOIN actor ON casting.actorid = actor.id
)
WHERE (
  actorid IN (
    -- actorid of actors who have worked with Art Garfunkel
    SELECT actorid
    FROM casting
    WHERE movieid IN (
      -- movieid of movies in which Art Garfunkel have worked
      SELECT movieid
      FROM casting
      WHERE actorid = (
        -- actorid of Art Garfunkel
        SELECT id
        FROM actor
        WHERE name = 'Art Garfunkel'
      )
    )
  )
  -- NOT Art Garfunkel himself
  AND NOT actorid = (
    -- actorid of Art Garfunkel
    SELECT id
    FROM actor
    WHERE name = 'Art Garfunkel'
  )
)
