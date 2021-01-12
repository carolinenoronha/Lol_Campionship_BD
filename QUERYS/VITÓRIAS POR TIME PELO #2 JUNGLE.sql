SELECT W.Equipe, W.Vitorias, T.Partidas, ((Vitorias/Partidas)*100) AS Percentual_de_Vitorias FROM
(SELECT Equipe, COUNT(Equipe) AS Vitorias FROM
(SELECT * FROM
(SELECT blueTeamTag AS Equipe, bResult, blueJungle as Jungle
FROM LeagueOfLegends 
WHERE bResult = 1 AND (blueJungle LIKE '%Revolta%')) AS Blue
UNION ALL 
SELECT * FROM
(SELECT redTeamTag AS Equipe, rResult, redJungle
FROM LeagueOfLegends 
WHERE rResult = 1 AND (redJungle LIKE '%Revolta%')) AS Red) AS TABELA
GROUP BY Equipe) AS W
JOIN
(SELECT Equipe, COUNT(Equipe) AS Partidas FROM
(SELECT * FROM
(SELECT blueTeamTag AS Equipe, bResult, blueJungle as Jungle
FROM LeagueOfLegends 
WHERE blueJungle LIKE '%Revolta%') AS Blue
UNION ALL 
SELECT * FROM
(SELECT redTeamTag AS Equipe, rResult, redJungle
FROM LeagueOfLegends 
WHERE redJungle LIKE '%Revolta%') AS Red) AS TABELA
GROUP BY Equipe) AS T
ON W.Equipe=T.Equipe;