-- Check song data structure and audio URLs
SELECT 
    id,
    title,
    singer,
    thumbnail_url,
    audio_url,
    CASE 
        WHEN audio_url IS NULL THEN 'NULL'
        WHEN audio_url = '' THEN 'EMPTY'
        WHEN audio_url LIKE 'http%' THEN 'VALID URL'
        ELSE 'INVALID'
    END as audio_status
FROM songs 
LIMIT 10;