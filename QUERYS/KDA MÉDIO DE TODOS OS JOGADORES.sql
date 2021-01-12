SELECT AVG(KDA) FROM
(SELECT KR.Player, 
SUM(Kills_Realizadas) AS Kills_Realizadas,
SUM(Kills_Sofridas) AS Kills_Sofridas,
SUM(Assistencias) AS Assistencias,
((SUM(Assistencias)+SUM(Kills_Realizadas))/(SUM(Kills_Sofridas)+1)) AS KDA
FROM
(SELECT
SUBSTRING(killer,5,10) AS Player, 
COUNT(killer) AS Kills_Realizadas
FROM  kills
GROUP BY Player) AS KR
INNER JOIN
(SELECT
SUBSTRING(victim,5,10) AS Player, 
COUNT(victim) AS Kills_Sofridas
FROM  kills
GROUP BY Player) AS Ks
ON KR.Player = KS.Player
INNER JOIN
(SELECT Lista_Assist,
SUBSTRING(Lista_Assist,5,10) AS 'Player',
COUNT(Lista_Assist) AS Assistencias FROM
(SELECT Assist_1 as Lista_Assist FROM kills 
UNION ALL SELECT Assist_2 FROM kills 
UNION ALL SELECT Assist_3 FROM kills 
UNION ALL SELECT Assist_4 FROM kills) AS Coluna
GROUP BY Lista_Assist) AS A
ON KR.Player=A.Player
GROUP BY Player) AS TABELA_KDA;