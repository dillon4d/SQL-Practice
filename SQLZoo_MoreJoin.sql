"List the films where the yr is 1962 [Show id, title] "
SELECT id, title
 FROM movie
 WHERE yr=1962
 
"Give year of 'Citizen Kane'."
SELECT yr FROM movie
  WHERE title = 'Citizen Kane'

"List all of the Star Trek movies, include the id, title and yr (all of these movies include the words Star Trek in the title). Order results by year. "
SELECT id, title, yr 
  FROM movie
WHERE title LIKE 'Star Trek%'
  ORDER BY yr

"What id number does the actor 'Glenn Close' have? "
SELECT id FROM actor
  WHERE name = 'Glenn Close'

"What is the id of the film 'Casablanca'"
SELECT id FROM movie
  WHERE title = 'Casablanca'
  
"Obtain the cast list for 'Casablanca'.
Use movieid=11768, (or whatever value you got from the previous question)"
SELECT name 
  FROM actor JOIN casting ON (actor.id = casting.actorid)
WHERE movieid=11768

"Obtain the cast list for the film 'Alien'"
SELECT actor.name FROM casting 
  JOIN actor ON (casting.actorid = actor.id) 
  JOIN movie ON (casting.movieid = movie.id)
WHERE movie.title = 'Alien'

"List the films in which 'Harrison Ford' has appeared "
SELECT movie.title FROM casting 
  JOIN actor ON (casting.actorid = actor.id) 
  JOIN movie ON (casting.movieid = movie.id)
WHERE actor.name = 'Harrison Ford'

"List the films where 'Harrison Ford' has appeared - but not in the starring role. [Note: the ord field of casting gives the position of the actor. If ord=1 then this actor is in the starring role]"
SELECT movie.title FROM casting 
  JOIN actor ON (casting.actorid = actor.id) 
  JOIN movie ON (casting.movieid = movie.id)
WHERE actor.name = 'Harrison Ford' AND casting.ord != 1

"List the films together with the leading star for all 1962 films."
SELECT movie.title, actor.name FROM casting 
  JOIN actor ON (casting.actorid = actor.id) 
  JOIN movie ON (casting.movieid = movie.id)
WHERE casting.ord = 1 AND movie.yr = 1962

"Which were the busiest years for 'Rock Hudson', show the year and the number of movies he made each year for any year in which he made more than 2 movies."
SELECT movie.yr, COUNT(movie.title) FROM casting 
  JOIN actor ON (casting.actorid = actor.id) 
  JOIN movie ON (casting.movieid = movie.id)
WHERE actor.name='Rock Hudson'
  GROUP BY movie.yr
HAVING COUNT(movie.title) > 2

"List the film title and the leading actor for all of the films 'Julie Andrews' played in."
SELECT movie.title, actor.name
  FROM movie, casting, actor
WHERE movieid=movie.id AND actorid=actor.id 
  AND ord=1 AND movieid IN(SELECT movieid FROM casting, actor 
WHERE actorid=actor.id AND name = 'Julie Andrews')

"Obtain a list, in alphabetical order, of actors who've had at least 15 starring roles."
SELECT actor.name FROM casting 
  JOIN actor ON (casting.actorid = actor.id) 
  JOIN movie ON (casting.movieid = movie.id)
WHERE ord = 1
 GROUP BY actor.name
   HAVING COUNT(casting.movieid) >= 15
   
" List the films released in the year 1978 ordered by the number of actors in the cast, then by title."
SELECT movie.title, COUNT(casting.actorid) FROM casting 
  JOIN actor ON (casting.actorid = actor.id) 
  JOIN movie ON (casting.movieid = movie.id)
WHERE movie.yr = 1978
  GROUP BY movie.title
  ORDER BY 2 DESC
  
"List all the people who have worked with 'Art Garfunkel'."
SELECT a.name 
FROM actor a 
  JOIN casting b ON (b.actorid=a.id)
  JOIN casting c ON (b.movieid = c.movieid)
  JOIN actor d ON (c.actorid = d.id AND d.name = 'Art Garfunkel')
WHERE a.id!=d.id

"1. Select the statement which lists the unfortunate directors of the movies which have caused financial loses (gross < budget)"
SELECT name
  FROM actor INNER JOIN movie ON actor.id = director
 WHERE gross < budget
 
"2. Select the correct example of JOINing three tables "
SELECT *
  FROM actor JOIN casting ON actor.id = actorid
  JOIN movie ON movie.id = movieid
  
"3. Select the statement that shows the list of actors called 'John' by order of number of movies in which they acted "
SELECT name, COUNT(movieid)
  FROM casting JOIN actor ON actorid=actor.id
 WHERE name LIKE 'John %'
 GROUP BY name ORDER BY 2 DESC
 
"4. Select the result that would be obtained from the following code: "
 SELECT title 
   FROM movie JOIN casting ON (movieid=movie.id)
              JOIN actor   ON (actorid=actor.id)
  WHERE name='Paul Hogan' AND ord = 1
'
|"Crocodile" Dundee             |
|Crocodile Dundee in Los Angeles|
|Flipper                        |
|Lightning Jack                 |
'

"5. Select the statement that lists all the actors that starred in movies directed by Ridley Scott who has id 351 "
SELECT name
  FROM movie JOIN casting ON movie.id = movieid
  JOIN actor ON actor.id = actorid
WHERE ord = 1 AND director = 351

"6. There are two sensible ways to connect movie and actor. They are:"
"
    link the director column in movies with the primary key in actor
    connect the primary keys of movie and actor via the casting table
"

"7. Select the result that would be obtained from the following code:"
 SELECT title, yr 
   FROM movie, casting, actor 
  WHERE name='Robert De Niro' AND movieid=movie.id AND actorid=actor.id AND ord = 3
'
|A Bronx Tale         |1993|
|Bang The Drum Slowly |1973|
|Limitless            |2011|
'
