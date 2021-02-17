"We continue practicing simple SQL queries on a single table.
This tutorial is concerned with a table of Nobel prize winners: nobel(yr, subject, winner)"

"Display Nobel prizes for 1950."
SELECT yr, subject, winner
  FROM nobel
 WHERE yr = 1950
;
 
"Show who won the 1962 prize for Literature."
SELECT winner
  FROM nobel
 WHERE yr = 1962
   AND subject = 'Literature'
;

"Show the year and subject that won 'Albert Einstein' his prize. "
SELECT yr, subject
  FROM nobel
WHERE winner = 'Albert Einstein'
;

"Give the name of the 'Peace' winners since the year 2000, including 2000. "
SELECT winner
  FROM nobel
WHERE subject = 'Peace'
  AND yr >= 2000
;

"Show all details (yr, subject, winner) of the Literature prize winners for 1980 to 1989 inclusive. "
SELECT *
  FROM nobel
WHERE subject = 'Literature' 
  AND yr >= 1980 AND yr <1990
;

"Show all details of the presidential winners:

    Theodore Roosevelt
    Woodrow Wilson
    Jimmy Carter
    Barack Obama"

SELECT * 
  FROM nobel
WHERE winner IN ('Theodore Roosevelt',
                 'Woodrow Wilson',
                 'Jimmy Carter',
                 'Barack Obama')
;

"Show the winners with first name John "
SELECT winner
  FROM nobel
WHERE winner LIKE 'John%'


"Show the year, subject, and name of Physics winners for 1980 together with the Chemistry winners for 1984."
SELECT *
  FROM nobel
WHERE yr = 1980 AND subject = 'Physics' 
  OR yr = 1984 AND subject = 'Chemistry'
;

"Show the year, subject, and name of winners for 1980 excluding Chemistry and Medicine"
SELECT * 
  FROM nobel
WHERE yr = 1980
  AND subject NOT IN ('Chemistry',
                      'Medicine')
;

"Show year, subject, and name of people who won a 'Medicine' prize in an early year (before 1910, not including 1910) together with winners of a 'Literature' prize in a later year (after 2004, including 2004)"
SELECT *
  FROM nobel
WHERE yr <1910 AND subject = 'Medicine'
  OR yr >= 2004 AND subject = 'Literature'
;

"Find all details of the prize won by PETER GRÜNBERG
Non-ASCII characters
The u in his name has an umlaut. You may find this link useful https://en.wikipedia.org/wiki/%C3%9C#Keyboarding"
SELECT * 
  FROM nobel
WHERE winner IN ('Peter Grünberg')
;

"Find all details of the prize won by EUGENE O'NEILL
Escaping single quotes
You can't put a single quote in a quote string directly. You can use two single quotes within a quoted string."
SELECT * 
  FROM nobel
WHERE winner IN ('Eugene O''Neill')
;

"Knights in order
List the winners, year and subject where the winner starts with Sir. Show the the most recent first, then by name order."
 SELECT winner, yr, subject 
   FROM nobel
 WHERE winner LIKE 'Sir%'
   ORDER BY yr desc, winner
;

"The expression subject IN ('Chemistry','Physics') can be used as a value - it will be 0 or 1.
Show the 1984 winners and subject ordered by subject and winner name; but list Chemistry and Physics last."
SELECT winner, subject
  FROM nobel
WHERE yr = 1984
  ORDER BY subject IN ('Chemistry','Physics'), subject, winner
;


"1. Pick the code which shows the name of winner's names beginning with C and ending in n"
SELECT winner FROM nobel
 WHERE winner LIKE 'C%' AND winner LIKE '%n'
 ;

"2. Select the code that shows how many Chemistry awards were given between 1950 and 1960"
SELECT COUNT(subject) FROM nobel
 WHERE subject = 'Chemistry'
   AND yr BETWEEN 1950 and 1960
;

"3. Pick the code that shows the amount of years where no Medicine awards were given "
SELECT COUNT(DISTINCT yr) FROM nobel
 WHERE yr NOT IN (SELECT DISTINCT yr FROM nobel WHERE subject = 'Medicine')
;

"4. Select the result that would be obtained from the following code: "
SELECT subject, winner FROM nobel WHERE winner LIKE 'Sir%' AND yr LIKE '196%'
;
"
| Medicine | Sir John Eccles             |
| Medicine | Sir Frank Macfarlane Burnet |
"

"5. Select the code which would show the year when neither a Physics or Chemistry award was given "
SELECT yr FROM nobel
 WHERE yr NOT IN(SELECT yr 
                   FROM nobel
                 WHERE subject IN ('Chemistry','Physics'))
;
                                   
"6. Select the code which shows the years when a Medicine award was given but no Peace or Literature award was"
SELECT DISTINCT yr
  FROM nobel
 WHERE subject='Medicine' 
   AND yr NOT IN(SELECT yr FROM nobel 
                  WHERE subject='Literature')
   AND yr NOT IN (SELECT yr FROM nobel
                   WHERE subject='Peace')
;
                                   
"7. Pick the result that would be obtained from the following code:"
 SELECT subject, COUNT(subject) 
   FROM nobel 
  WHERE yr ='1960' 
  GROUP BY subject
;
"
| Chemistry  | 1 |
| Literature | 1 |
| Medicine   | 2 |
| Peace      | 1 |                                   
| Physics    | 1 |                               
"

