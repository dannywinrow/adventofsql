WITH 
    extremes (primary_skill,maxyears,minyears) AS (
        SELECT
            primary_skill,
            MAX(years_experience) as maxyears,
            MIN(years_experience) as minyears
        FROM workshop_elves
        GROUP BY primary_skill
    ),
    elves AS (
        SELECT
            elf_id,
            workshop_elves.primary_skill,
            years_experience
        FROM extremes JOIN workshop_elves
        ON extremes.primary_skill = workshop_elves.primary_skill
        AND (
            extremes.maxyears = workshop_elves.years_experience
            OR extremes.minyears = workshop_elves.years_experience
        )
    )

SELECT DISTINCT ON (w.primary_skill)
    w.elf_id, v.elf_id,
    w.primary_skill as shared_skill
FROM elves w JOIN elves v
ON w.primary_skill = v.primary_skill
WHERE w.years_experience > v.years_experience
    AND w.elf_id <> v.elf_id
ORDER BY w.primary_skill, w.elf_id, v.elf_id
LIMIT 3;