# Spotify Clone Backend

This project now uses **MySQL** instead of MongoDB for all persistence. The backend is a Node/Express API that the Vite/React frontend consumes.

## Prerequisites

- Node.js 18+
- MySQL 8+
- Cloudinary account (for media uploads)

## Environment configuration

1. Copy `.env.example` to `.env` in the project root.
2. Fill in the following values:
   - `PORT` – API port (defaults to `5000`).
   - `NODE_ENV` – `development` or `production`.
   - `Jwt_secret` – long random string for JWT signing.
   - `Cloud_Name`, `Cloud_Api`, `Cloud_Secret` – Cloudinary credentials.
   - `MYSQL_HOST`, `MYSQL_PORT`, `MYSQL_USER`, `MYSQL_PASSWORD`, `MYSQL_DATABASE` – point to your MySQL instance.

## Database setup

1. Create the database specified by `MYSQL_DATABASE`.
2. Execute `backend/database/schema.sql` against that database to create the required tables (`users`, `albums`, `songs`, `user_playlists`).
3. If you need to migrate existing MongoDB data, export it (e.g., via `mongodump`) and import it manually into the new tables, matching the column names used in the schema.

## Running the app

```powershell
# install backend deps (from repo root)
npm install

# install frontend deps
cd frontend
npm install

# run backend (from repo root)
npm run dev

# run frontend dev server
cd frontend
npm run dev
```

The backend expects a reachable MySQL database before starting. Use `backend/database/schema.sql` whenever you need to recreate the schema from scratch.
