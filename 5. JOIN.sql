/*
                              game
id      mdate           stadium                     team1   team2
1001	  8 June 2012     National Stadium, Warsaw    POL     GRE
1002	  8 June 2012     Stadion Miejski (Wroclaw)   RUS     CZE
1003	  12 June 2012    Stadion Miejski (Wroclaw)   GRE     CZE
1004	  12 June 2012    National Stadium, Warsaw    POL     RUS
...

                              goal
matchid   teamid  player                gtime
1001      POL     Robert Lewandowski    17
1001      GRE     Dimitris Salpingidis  51
1002      RUS     Alan Dzagoev          15
1002      RUS     Roman Pavlyuchenko    82
...

                             eteam
id    teamname        coach
POL   Poland          Franciszek Smuda
RUS   Russia          Dick Advocaat
CZE   Czech Republic  Michal Bilek
GRE   Greece          Fernando Santos
...
*/

-- Show the team1, team2 and player for every goal scored by a player called Mario

SELECT team1, team2, player
FROM game
JOIN goal
ON game.id = goal.matchid
WHERE player LIKE 'Mario%'

-- Show player, teamid, coach, gtime for all goals scored in the first 10 minutes

SELECT player, teamid, coach, gtime
FROM goal
JOIN eteam
ON goal.teamid = eteam.id
WHERE gtime <= 10

-- List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach

SELECT mdate, teamname
FROM game
JOIN eteam
ON game.team1 = eteam.id
WHERE eteam.coach = 'Fernando Santos'

-- Show the name of all players who scored a goal against Germany

SELECT DISTINCT player
FROM goal
JOIN game
ON goal.matchid = game.id
WHERE (team1 = 'GER' AND teamid != 'GER')
OR (team2 = 'GER' AND teamid != 'GER')

-- Show teamname and the total number of goals scored

SELECT teamname, COUNT(player)
FROM eteam
JOIN goal
ON eteam.id = goal.teamid
GROUP BY teamname

-- For every match involving 'POL', show the matchid, date and the number of goals scored

SELECT matchid, mdate, COUNT(player)
FROM goal
JOIN game
ON goal.matchid = game.id
WHERE (team1 = 'POL') OR (team2 = 'POL')
GROUP BY mdate, matchid

-- For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'

SELECT matchid, mdate, COUNT(player)
FROM goal
JOIN game
ON goal.matchid = game.id
WHERE teamid = 'GER'
GROUP BY matchid, mdate

-- List every match with the goals scored by each team; sort your result by mdate, matchid, team1 and team2
/* SOME MATCHES IN (TABLE:GAME) WOULD RETURN NO ROWS WHEN INNER JOINED WITH (TABLE: GOAL) BECAUSE SCORELESS MATCHES DO NO GET ENTRY INTO (TABLE:GOAL)
   THEREFORE, A LEFT JOIN IS WARRANTED TO FIRST CAPTURE ALL GAMES/MATCHES THAT HAVE OCCURRED BEFORE JOINNING WITH DATA IN (TABLE:GOAL) */
   
SELECT mdate, team1, SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) AS score1, team2, SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) AS score2
FROM game
LEFT JOIN goal
ON game.id = goal.matchid
GROUP BY mdate, matchid, team1, team2
ORDER BY mdate, matchid, team1, team2
