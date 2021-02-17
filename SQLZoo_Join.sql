"The first example shows the goal scored by a player with the last name 'Bender'. The * says to list all the columns in the table - a shorter way of saying matchid, teamid, player, gtime

Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'"

SELECT * FROM goal 
  WHERE player LIKE '%Bender'
  
SELECT matchid, player FROM goal 
  WHERE teamid = 'GER'
  
"From the previous query you can see that Lars Bender's scored a goal in game 1012. Now we want to know what teams were playing in that match.

Notice in the that the column matchid in the goal table corresponds to the id column in the game table. We can look up information about game 1012 by finding that row in the game table.

Show id, stadium, team1, team2 for just game 1012"

SELECT id,stadium,team1,team2
  FROM game
WHERE id = 1012


"You can combine the two steps into a single query with a JOIN. "
SELECT *
  FROM game JOIN goal ON (id=matchid)
  
"The FROM clause says to merge data from the goal table with that from the game table. The ON says how to figure out which rows in game go with which rows in goal - the matchid from goal must match id from game. (If we wanted to be more clear/specific we could say "
ON (game.id=goal.matchid)

"The code below shows the player (from the goal) and stadium name (from the game table) for every goal scored.
Modify it to show the player, teamid, stadium and mdate for every German goal."
SELECT player,stadium
  FROM game JOIN goal ON (id=matchid)

SELECT player, teamid, stadium, mdate
  FROM game JOIN goal ON (game.id=goal.matchid)
WHERE teamid = 'GER'

"Use the same JOIN as in the previous question.
Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'"
SELECT team1, team2, player
  FROM game JOIN goal ON (game.id=goal.matchid)
WHERE player LIKE 'Mario%'

"The table eteam gives details of every national team including the coach. You can JOIN goal to eteam using the phrase goal JOIN eteam on teamid=id

Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10"
SELECT player, teamid, coach, gtime
  FROM goal JOIN eteam ON (goal.teamid=eteam.id)
 WHERE gtime<=10

"To JOIN game with eteam you could use either
game JOIN eteam ON (team1=eteam.id) or game JOIN eteam ON (team2=eteam.id)

Notice that because id is a column name in both game and eteam you must specify eteam.id instead of just id

List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach."
SELECT mdate, teamname 
  FROM game JOIN eteam ON (game.team1 = eteam.id)
WHERE coach = 'Fernando Santos'

"List the player for every goal scored in a game where the stadium was 'National Stadium, Warsaw'"
SELECT player
  FROM goal JOIN game ON (goal.matchid = game.id)
WHERE stadium = 'National Stadium, Warsaw'

"The example query shows all goals scored in the Germany-Greece quarterfinal.
Instead show the name of all players who scored a goal against Germany."
SELECT player, gtime
  FROM game JOIN goal ON matchid = id 
    WHERE (team1='GER' AND team2='GRE').
    
SELECT DISTINCT(player)
  FROM game JOIN goal ON (goal.matchid = game.id) 
    WHERE (team1='GER' OR team2='GER')
      AND teamid <> 'GER'

"Show teamname and the total number of goals scored.
COUNT and GROUP BY"
SELECT teamname, COUNT(*)
  FROM eteam JOIN goal ON (eteam.id=goal.teamid)
GROUP BY teamname

"Show the stadium and the number of goals scored in each stadium."
SELECT DISTINCT(stadium), COUNT(*)
  FROM game JOIN goal ON (game.id = goal.matchid)
GROUP BY stadium

"For every match involving 'POL', show the matchid, date and the number of goals scored."
SELECT matchid, mdate, COUNT(*)
  FROM game JOIN goal ON (game.id = goal.matchid)
 WHERE (team1 = 'POL' OR team2 = 'POL')
GROUP BY matchid, mdate

"For every match where 'GER' scored, show matchid, match date and the number of goals scored by 'GER'"
SELECT matchid, mdate, COUNT(*)
  FROM game JOIN goal ON (game.id = goal.matchid)
WHERE teamid = 'GER'
  GROUP BY matchid, mdate
  
"13. 
List every match with the goals scored by each team as shown. This will use "CASE WHEN" which has not been explained in any previous exercises.
|mdate       |team1|score1|team2|score2|
|1 July 2012 |ESP  |4     |ITA  |0     |
|10 June 2012|ESP  |1     |ITA  |1     |
|10 June 2012|IRL  |1     |CRO  |3     |
|...
Notice in the query given every goal is listed. If it was a team1 goal then a 1 appears in score1, otherwise there is a 0. You could SUM this column to get a count of the goals scored by team1. Sort your result by mdate, matchid, team1 and team2."
SELECT mdate,
  team1,
  SUM(CASE WHEN teamid = team1 THEN 1 ELSE 0 END) AS score1,
  team2,
  SUM(CASE WHEN teamid = team2 THEN 1 ELSE 0 END) AS score2
FROM game JOIN goal ON (game.id=goal.matchid)
  GROUP BY mdate, matchid, team1, team2

"1. You want to find the stadium where player 'Dimitris Salpingidis' scored. Select the JOIN condition to use: "
game  JOIN goal ON (id=matchid)

"2. You JOIN the tables goal and eteam in an SQL statement. Indicate the list of column names that may be used in the SELECT line: "
matchid, teamid, player, gtime, id, teamname, coach

"3. Select the code which shows players, their team and the amount of goals they scored against Greece(GRE). "
SELECT player, teamid, COUNT(*)
  FROM game JOIN goal ON matchid = id
 WHERE (team1 = "GRE" OR team2 = "GRE")
   AND teamid != 'GRE'
 GROUP BY player, teamid

"4. Select the result that would be obtained from this code: "
SELECT DISTINCT teamid, mdate
  FROM goal JOIN game on (matchid=id)
 WHERE mdate = '9 June 2012'
'
|DEN |9 June 2012|
|GER |9 June 2012|'

"5. Select the code which would show the player and their team for those who have scored against Poland(POL) in National Stadium, Warsaw. "
  SELECT DISTINCT player, teamid 
   FROM game JOIN goal ON matchid = id 
  WHERE stadium = 'National Stadium, Warsaw' 
 AND (team1 = 'POL' OR team2 = 'POL')
   AND teamid != 'POL'
   
"6. Select the code which shows the player, their team and the time they scored, for players who have played in Stadion Miejski (Wroclaw) but not against Italy(ITA). "
SELECT DISTINCT player, teamid, gtime
  FROM game JOIN goal ON matchid = id
 WHERE stadium = 'Stadion Miejski (Wroclaw)'
   AND (( teamid = team2 AND team1 != 'ITA') OR ( teamid = team1 AND team2 != 'ITA'))
                                                 
"7. Select the result that would be obtained from this code: "
SELECT teamname, COUNT(*)
  FROM eteam JOIN goal ON teamid = id
 GROUP BY teamname
HAVING COUNT(*) < 3
'
|Netherlands         |2|
|Poland              |2|
|Republic of Ireland |1|
|Ukraine             |2|'