    WITH food (itemid) AS (
        SELECT unnest(xpath('//food_item_id/text()',menu_data))::text::int AS itemid FROM christmas_menus
        WHERE (xpath('name(/*)',menu_data))[1]::text IN ('christmas_feast','northpole_database')
    )

    SELECT itemid FROM food
    GROUP BY itemid
    ORDER BY count(*) DESC
    LIMIT 1;


    -- Shorter alternative

    SELECT unnest(xpath('//food_item_id/text()',menu_data))::text::int AS itemid FROM christmas_menus
    WHERE (xpath('name(/*)',menu_data))[1]::text IN ('christmas_feast','northpole_database')
    GROUP BY itemid
    ORDER BY count(*) DESC
    LIMIT 1;

    -- General solution

    SELECT unnest(xpath('//food_item_id/text()',menu_data))::text::int AS itemid FROM christmas_menus
    WHERE 
        coalesce(
            (xpath('//total_present/text()',menu_data))[1],
            (xpath('//total_guests/text()',menu_data))[1],
            (xpath('//total_count/text()',menu_data))[1]
        )::text::int > 78
    GROUP BY itemid
    ORDER BY count(*) DESC
    LIMIT 1;