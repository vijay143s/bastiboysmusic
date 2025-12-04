-- Add language column to albums table
ALTER TABLE albums ADD COLUMN language VARCHAR(100) AFTER star_cast;
