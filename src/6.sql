SELECT name
FROM (
    SELECT children.name, gifts.price, AVG(gifts.price) OVER () AS avgprice
    FROM children JOIN gifts ON children.child_id = gifts.child_id
) AS subq
WHERE price > avgprice
ORDER BY price
LIMIT 1;