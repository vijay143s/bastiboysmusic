# SQL Import Guide

## Generated: 2025-12-04T19:40:37.116247
## Language: HINDI

### Summary
- **Albums**: 5
- **Songs**: 15
- **Total Items**: 20

### Steps to Import

#### 1. Prepare the Database
```sql
-- Ensure database and tables exist
USE your_database_name;

-- Disable foreign key checks temporarily
SET FOREIGN_KEY_CHECKS=0;
```

#### 2. Insert Albums First
Run the album INSERT statements from the generated SQL file.
Example:
```sql
INSERT INTO albums (title, description, thumbnail_url, language, created_at, updated_at)
VALUES (...);
```

**After inserting albums, verify the insertion:**
```sql
SELECT id, title FROM albums ORDER BY created_at DESC LIMIT 5;
```

#### 3. Map Album IDs to Songs
Once albums are inserted, you need to get the album IDs:
```sql
-- Get all inserted albums with their IDs
SELECT id, title FROM albums 
WHERE created_at >= DATE_SUB(NOW(), INTERVAL 1 HOUR);
```

#### 4. Update Song Inserts with Album IDs
Replace the placeholder `1` in song INSERT statements with actual album IDs.

**Example mapping:**

- Album ID 1: Dhurandhar
- Album ID 2: De De Pyaar De 2 Deluxe Album
- Album ID 3: Ek Deewane Ki Deewaniyat
- Album ID 4: Tere Ishk Mein
- Album ID 5: 120 Bahadur Original Motion Picture Soundtrack

#### 5. Insert Songs
Execute all song INSERT statements with correct album_id values.

#### 6. Verify Import
```sql
-- Check total songs inserted
SELECT COUNT(*) as total_songs FROM songs;

-- Check album songs relationship
SELECT a.title, COUNT(s.id) as song_count
FROM albums a
LEFT JOIN songs s ON a.id = s.album_id
GROUP BY a.id, a.title
ORDER BY a.title;
```

#### 7. Re-enable Foreign Key Checks
```sql
SET FOREIGN_KEY_CHECKS=1;
```

### Album Details


#### Dhurandhar
- **Language**: hindi
- **ID**: ft4MGKjYem0_
- **Description**: Reble | Total songs = 6

#### De De Pyaar De 2 Deluxe Album
- **Language**: hindi
- **ID**: mT5P5rCNkj4_
- **Description**: Yo Yo Honey Singh | Total songs = 6

#### Ek Deewane Ki Deewaniyat
- **Language**: hindi
- **ID**: S5P6rg88ZDI_
- **Description**: Prince Dubey | Total songs = 2

#### Tere Ishk Mein
- **Language**: hindi
- **ID**: miLuahpnTkM_
- **Description**: A.R. Rahman | Total songs = 8

#### 120 Bahadur Original Motion Picture Soundtrack
- **Language**: hindi
- **ID**: AoyxJ5K1Iyg_
- **Description**: Javed Akhtar | Total songs = 4
