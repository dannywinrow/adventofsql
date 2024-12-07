SELECT country, city, AVG(naughty_nice_score), COUNT(*) AS cnt
FROM children INNER JOIN christmaslist ON children.child_id = christmaslist.child_id
GROUP BY city, country
HAVING COUNT(*) >= 5
ORDER BY AVG(naughty_nice_score);