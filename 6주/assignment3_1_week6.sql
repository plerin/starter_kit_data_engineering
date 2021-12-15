
SELECT
  TO_CHAR(created_at, 'YYYY-MM-DD') as day,
  ROUND((SUM(CASE WHEN score BETWEEN 9 AND 10 THEN 1 ELSE 0 END) - SUM(CASE WHEN score < 7 THEN 1 ELSE 0 END))::decimal / SUM(1),2) AS daily_nps
FROM plerin152.nps
GROUP BY day
ORDER BY 1;