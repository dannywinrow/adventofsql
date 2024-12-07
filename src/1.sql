SELECT name,
   wishes::json->>'first_choice' as primary_wish,
   wishes::json->>'second_choice' as backup_wish,
   wishes::json#>>'{colors,0}' as favourite_color,
   json_array_length(wishes::json->'colors') as color_count,
   CASE WHEN difficulty_to_make = 1 THEN 'Simple Gift'
        WHEN difficulty_to_make = 2 THEN 'Moderate Gift'
        ELSE                             'Complex Gift'
   END as gift_complexity,
   CASE WHEN category = 'outdoor' THEN 'Outside Workshop'
        WHEN category = 'educational' THEN 'Learning Workshop'
        ELSE 'General Workshop'
   END as workshop_assignment
FROM wish_lists
LEFT JOIN children ON wish_lists.child_id = children.child_id
LEFT JOIN toy_catalogue ON wishes::json->>'first_choice' = toy_catalogue.toy_name
WHERE (wish_lists.child_id,submitted_date) in (select child_id,max(submitted_date) from wish_lists group by child_id)
ORDER BY name ASC
LIMIT 5
;

"ACTUAL SOLUTION, the one above which I think should work doesn't, as the answer allows multiple
inputs per child."

     SELECT name,
          wishes->>'first_choice' as primary_wish,
          wishes->>'second_choice' as backup_wish,
          wishes#>>'{colors,0}' as favourite_color,
          json_array_length(wishes::json->'colors') as color_count,
          CASE WHEN difficulty_to_make = 1 THEN 'Simple Gift'
               WHEN difficulty_to_make = 2 THEN 'Moderate Gift'
               ELSE                             'Complex Gift'
          END as gift_complexity,
          CASE WHEN category = 'outdoor' THEN 'Outside Workshop'
               WHEN category = 'educational' THEN 'Learning Workshop'
               ELSE 'General Workshop'
          END as workshop_assignment
     FROM wish_lists
          LEFT JOIN children
               ON wish_lists.child_id = children.child_id
          LEFT JOIN toy_catalogue
               ON wishes::json->>'first_choice' = toy_catalogue.toy_name
     ORDER BY name ASC
     LIMIT 5;