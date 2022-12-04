-- Total number of draft hits at each position group from 2000 to 2020
SELECT COUNT(pos) as drafted_starters,
pos
FROM nfl-draft-370016.draft_2000_2020.draft_picks
WHERE AP1 > 0 OR PB > 0 OR GS > 36
GROUP BY pos
ORDER BY drafted_starters DESC;

--Total number of draft busts by position group and team
SELECT COUNT(pos) as draft_busts,
pos,
tm
FROM nfl-draft-370016.draft_2000_2020.draft_picks
WHERE AP1 = 0 OR PB = 0 OR GS <36
GROUP BY pos, tm
ORDER BY draft_busts DESC, tm;

--Total number of draft hits by position group and team
SELECT COUNT(pos) as draft_hits,
pos,
tm
FROM nfl-draft-370016.draft_2000_2020.draft_picks
WHERE AP1 > 0 OR PB > 0 OR GS > 36
GROUP BY pos, tm
ORDER BY tm;

-- Total starting quarterbacks drafted
SELECT COUNT(pos) as drafted_starters_qb,
tm
FROM nfl-draft-370016.draft_2000_2020.draft_picks
WHERE AP1 > 0 OR PB > 0 OR GS > 35
GROUP BY tm, pos
HAVING (pos) = 'QB'
ORDER BY tm ASC;

-- Total starting receivers drafted 
SELECT COUNT(pos) as drafted_starters_wr,
tm
FROM nfl-draft-370016.draft_2000_2020.draft_picks
WHERE AP1 > 0 OR PB > 0 OR GS > 35
GROUP BY tm, pos
HAVING (pos) = 'WR'
ORDER BY tm ASC;

--Total draft picks by team from 00-20
SELECT COUNT(player) as total_picks,
tm
FROM `nfl-draft-370016.draft_2000_2020.draft_picks`
GROUP BY tm
ORDER BY total_picks
;

--Average draft pick position of starting caliber running backs by team
SELECT AVG(pick) as avg_draft_position,
pos, Tm
FROM `nfl-draft-370016.draft_2000_2020.draft_picks`
WHERE AP1 > 0 OR PB > 0 OR GS >35
GROUP BY pos, Tm
HAVING (pos) = 'RB'
ORDER BY avg_draft_position
;

--Number of draft picks at each position by school
SELECT COUNT(pos) as school_positional_picks,
College_Univ,
Pos
FROM `nfl-draft-370016.draft_2000_2020.draft_picks`
WHERE College_Univ IS NOT NULL
GROUP BY College_Univ, pos
ORDER BY pos, school_positional_picks DESC
;
