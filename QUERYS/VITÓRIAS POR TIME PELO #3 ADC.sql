SELECT W.Equipe, W.Vitorias, T.Partidas, ((Vitorias/Partidas)*100) AS Percentual_de_Vitorias FROM
(SELECT Equipe, COUNT(Equipe) AS Vitorias FROM
(SELECT * FROM
(SELECT blueTeamTag AS Equipe, bResult, blueADC as ADC
FROM LeagueOfLegends 
WHERE bResult = 1 AND (blueADC LIKE '%micaO%')) AS Blue
UNION ALL 
SELECT * FROM
(SELECT redTeamTag AS Equipe, rResult, redADC
FROM LeagueOfLegends 
WHERE rResult = 1 AND (redADC LIKE '%micaO%')) AS Red) AS TABELA
GROUP BY Equipe) AS W
JOIN
(SELECT Equipe, COUNT(Equipe) AS Partidas FROM
(SELECT * FROM
(SELECT blueTeamTag AS Equipe, bResult, redADC as ADC
FROM LeagueOfLegends 
WHERE blueADC LIKE '%micaO%') AS Blue
UNION ALL 
SELECT * FROM
(SELECT redTeamTag AS Equipe, rResult, redADC
FROM LeagueOfLegends 
WHERE redADC LIKE '%micaO%') AS Red) AS TABELA
GROUP BY Equipe) AS T
ON W.Equipe=T.Equipe;