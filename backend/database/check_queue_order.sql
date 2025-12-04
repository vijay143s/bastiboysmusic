SELECT 
    s.id, 
    s.title, 
    s.singer,
    s.thumbnail_url,
    s.audio_url,
    s.album_id,
    a.title as album_name
FROM songs s
LEFT JOIN albums a ON s.album_id = a.id
WHERE s.audio_url IS NOT NULL
ORDER BY a.year DESC, s.created_at DESC
LIMIT 5;