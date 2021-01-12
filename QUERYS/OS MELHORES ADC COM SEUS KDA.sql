SELECT ADC, 
SUM(Kills_Realizadas) AS Kills_Realizadas, 
SUM(Kills_Sofridas)AS Kills_Sofridas, 
SUM(Assistencias) AS Assistencias,
((SUM(Assistencias)+SUM(Kills_Realizadas))/(SUM(Kills_Sofridas)+1)) AS KDA
FROM
(SELECT ADC FROM
(SELECT * FROM 
(SELECT Year, blueTeamTag as Team, bResult as Result, blueADC as ADC FROM LeagueOfLegends
UNION ALL
SELECT Year, redTeamTag, rResult, redADC FROM LeagueOfLegends) AS Players) AS Ordem
GROUP BY ADC) AS ADC1
INNER JOIN
(SELECT
SUBSTRING(killer,5,10) AS Player, 
COUNT(killer) AS Kills_Realizadas
FROM  kills
GROUP BY Player) AS KR
ON ADC1.ADC = KR.Player
INNER JOIN
(SELECT
SUBSTRING(victim,5,10) AS Player, 
COUNT(victim) AS Kills_Sofridas
FROM  kills
GROUP BY Player) AS Ks
ON ADC1.ADC = KS.Player
INNER JOIN
(SELECT Lista_Assist,
SUBSTRING(Lista_Assist,5,10) AS 'Player',
COUNT(Lista_Assist) AS Assistencias FROM
(SELECT Assist_1 as Lista_Assist FROM kills 
UNION ALL SELECT Assist_2 FROM kills 
UNION ALL SELECT Assist_3 FROM kills 
UNION ALL SELECT Assist_4 FROM kills) AS Coluna
GROUP BY Lista_Assist) AS A
ON ADC1.ADC = A.Player
GROUP BY ADC
ORDER BY KDA DESC;