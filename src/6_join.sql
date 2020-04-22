-- 1

SELECT matchid, player
FROM goal
WHERE teamid = 'GER'

-- 2

SELECT id, stadium, team1, team2
FROM game
WHERE id = (
  SELECT matchid
  FROM goal
  WHERE player = 'Lars Bender'
)

-- 3

SELECT player, teamid, stadium, mdate
FROM (
  game
  JOIN goal ON game.id = goal.matchid
)
WHERE teamid = 'GER'

-- 4

SELECT game.team1, game.team2, goal.player
FROM (
  game
  JOIN goal ON game.id = goal.matchid
)
WHERE goal.player LIKE 'Mario%'

-- 5

SELECT player, teamid, coach, gtime
FROM (
  goal
  JOIN eteam ON goal.teamid = eteam.id
)
WHERE gtime <= 10

-- 6

SELECT mdate, teamname
FROM (
  game
  JOIN eteam ON game.team1 = eteam.id
)
WHERE coach = 'Fernando Santos'

-- 7

SELECT player
FROM (
  game
  JOIN goal ON game.id = goal.matchid
)
WHERE stadium = 'National Stadium, Warsaw'

-- 8

SELECT DISTINCT(player)
FROM (
  game
  JOIN goal ON game.id = goal.matchid
)
WHERE (
  (team1 = 'GER' OR team2 = 'GER')
  AND teamid <> 'GER'
)

-- 9

SELECT teamname, COUNT(*) AS ngoal
FROM (
  goal
  JOIN eteam ON goal.teamid = eteam.id
)
GROUP BY teamid
ORDER BY teamname

-- 10

SELECT stadium, COUNT(*) AS ngoal
FROM (
  game
  JOIN goal ON game.id = goal.matchid
)
GROUP BY stadium

-- 11

SELECT  matchid, mdate, COUNT(*) AS ngoal
FROM (
  game
  JOIN goal ON matchid = id
)
WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid

-- 12

SELECT matchid, mdate, COUNT(*) AS ngoal
FROM (
  game
  JOIN goal ON matchid = id
)
WHERE teamid = 'GER'
GROUP BY matchid

-- 13

SELECT
mdate,
team1,
SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) AS score1,
team2,
SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) AS score2
FROM (
  game
  LEFT JOIN goal ON matchid = id
)
GROUP BY mdate, team1, team2
ORDER BY mdate, matchid, team1, team2
