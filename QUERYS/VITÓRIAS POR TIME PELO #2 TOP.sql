SELECT W.Equipe, W.Vitorias, T.Partidas, ((Vitorias/Partidas)*100) AS Percentual_de_Vitorias FROM
(SELECT Equipe, COUNT(Equipe) AS Vitorias FROM
(SELECT * FROM
(SELECT blueTeamTag AS Equipe, bResult, blueTop as Top
FROM LeagueOfLegends 
WHERE bResult = 1 AND (blueTop LIKE '%SkyBart%')) AS Blue
UNION ALL 
SELECT * FROM
(SELECT redTeamTag AS Equipe, rResult, redTop
FROM LeagueOfLegends 
WHERE rResult = 1 AND (redTop LIKE '%SkyBart%')) AS Red) AS TABELA
GROUP BY Equipe) AS W
JOIN
(SELECT Equipe, COUNT(Equipe) AS Partidas FROM
(SELECT * FROM
(SELECT blueTeamTag AS Equipe, bResult, blueTop as Top
FROM LeagueOfLegends 
WHERE blueTop LIKE '%SkyBart%') AS Blue
UNION ALL 
SELECT * FROM
(SELECT redTeamTag AS Equipe, rResult, redTop
FROM LeagueOfLegends 
WHERE redTop LIKE '%SkyBart%') AS Red) AS TABELA
GROUP BY Equipe) AS T
ON W.Equipe=T.Equipe;