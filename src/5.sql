    SELECT
        t.production_date,
        t.toys_produced,
        y.toys_produced AS previous_day_production,
        t.toys_produced - y.toys_produced AS production_change,
        (t.toys_produced / y.toys_produced - 1) * 100 AS production_change_percentage
    FROM toy_production t
    JOIN toy_production y
    ON t.production_date = y.production_date + 1
    ORDER BY production_change_percentage DESC;

SELECT production_date FROM
    (SELECT production_date, toys_produced::numeric/lag(toys_produced) OVER (ORDER BY production_date) AS diff
    FROM toy_production) pd
ORDER BY diff DESC
LIMIT 1;

SELECT production_date, toys_produced::numeric/lag(toys_produced) OVER (ORDER BY production_date) AS diff
FROM toy_production
ORDER BY production_date DESC;

SELECT * FROM toy_production

    SELECT production_date
        FROM toy_production
    ORDER BY coalesce(
                toys_produced::numeric/lag(toys_produced)
                OVER (ORDER BY production_date),
            -1) DESC
    LIMIT 1;