SELECT W.Equipe, W.Vitorias, T.Partidas, ((Vitorias/Partidas)*100) AS Percentual_de_Vitorias FROM
(SELECT Equipe, COUNT(Equipe) AS Vitorias FROM
(SELECT * FROM
(SELECT blueTeamTag AS Equipe, bResult, blueSupport as Suporte
FROM LeagueOfLegends 
WHERE bResult = 1 AND (blueSupport LIKE '%Baiano%')) AS Blue
UNION ALL 
SELECT * FROM
(SELECT redTeamTag AS Equipe, rResult, redSupport
FROM LeagueOfLegends 
WHERE rResult = 1 AND (redSupport LIKE '%Baiano%')) AS Red) AS TABELA
GROUP BY Equipe) AS W
JOIN
(SELECT Equipe, COUNT(Equipe) AS Partidas FROM
(SELECT * FROM
(SELECT blueTeamTag AS Equipe, bResult, blueSupport as Suporte
FROM LeagueOfLegends 
WHERE blueTop LIKE '%Baiano%') AS Blue
UNION ALL 
SELECT * FROM
(SELECT redTeamTag AS Equipe, rResult, redSupport
FROM LeagueOfLegends 
WHERE redSupport LIKE '%Baiano%') AS Red) AS TABELA
GROUP BY Equipe) AS T
ON W.Equipe=T.Equipe;