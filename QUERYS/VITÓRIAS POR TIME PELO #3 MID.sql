SELECT W.Equipe, W.Vitorias, T.Partidas, ((Vitorias/Partidas)*100) AS Percentual_de_Vitorias FROM
(SELECT Equipe, COUNT(Equipe) AS Vitorias FROM
(SELECT * FROM
(SELECT blueTeamTag AS Equipe, bResult, blueMiddle as Mid
FROM LeagueOfLegends 
WHERE bResult = 1 AND (blueMiddle LIKE '%dyNquedo%')) AS Blue
UNION ALL 
SELECT * FROM
(SELECT redTeamTag AS Equipe, rResult, redMiddle
FROM LeagueOfLegends 
WHERE rResult = 1 AND (redMiddle LIKE '%dyNquedo%')) AS Red) AS TABELA
GROUP BY Equipe) AS W
JOIN
(SELECT Equipe, COUNT(Equipe) AS Partidas FROM
(SELECT * FROM
(SELECT blueTeamTag AS Equipe, bResult, blueMiddle as Mid
FROM LeagueOfLegends 
WHERE blueMiddle LIKE '%dyNquedo%') AS Blue
UNION ALL 
SELECT * FROM
(SELECT redTeamTag AS Equipe, rResult, redMiddle
FROM LeagueOfLegends 
WHERE redMiddle LIKE '%dyNquedo%') AS Red) AS TABELA
GROUP BY Equipe) AS T
ON W.Equipe=T.Equipe;