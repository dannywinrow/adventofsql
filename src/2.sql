    -- my first attempt
    select string_agg(chr(value),'') from
    (select value from letters_a union all
    select value from letters_b) as letters
    where (value >= ascii('A') and value <= ascii('Z'))
    OR (value >= ascii('a') and value <= ascii('z'))
    OR value = ascii(' ')
    OR value = ascii('.')
    OR value = ascii(',')
    OR value = ascii('!');

    -- a cleaner version
    with letters (char) as (
        select chr(value) from letters_a
        union all
        select chr(value) from letters_b
    )
    select string_agg(char,'')
    from letters
    where      (char between 'A' and 'Z')
            OR (char between 'a' and 'z')
            OR char in (' ','.',',','!');