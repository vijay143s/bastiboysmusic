-- Find songs trying to reference non-existent albums
SELECT DISTINCT 
    SUBSTRING(sql_text FROM 'WHERE title=''([^'']+)''') as missing_album
FROM (
    SELECT unnest(string_to_array(
        pg_read_file('all_songs.sql')::text, 
        E'\n'
    )) as sql_text
) lines
WHERE sql_text LIKE '%SELECT id FROM albums WHERE title=%'
  AND SUBSTRING(sql_text FROM 'WHERE title=''([^'']+)''') NOT IN (
    SELECT title FROM albums WHERE title IS NOT NULL
  )
LIMIT 20;
