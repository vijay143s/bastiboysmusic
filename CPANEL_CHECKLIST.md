# cPanel Deployment Checklist

## ✅ Pre-Deployment Steps

- [ ] Build frontend: `cd frontend && npm run build`
- [ ] Verify dist/ folder exists in frontend/
- [ ] Test backend locally: `npm run dev`
- [ ] Test frontend build locally: `npm run build && npm start`
- [ ] Commit all changes to git

## ✅ cPanel Setup Steps

### 1. Database Setup
- [ ] Create MySQL database in cPanel
- [ ] Note database name (format: username_dbname)
- [ ] Create database user
- [ ] Set password for database user
- [ ] Grant ALL privileges to user
- [ ] Test connection with credentials

### 2. File Upload
- [ ] Upload entire project to public_html
  ```
  public_html/
  ├── backend/
  ├── frontend/dist/
  ├── node_modules/ (or install on server)
  ├── package.json
  ├── .htaccess
  ├── start.sh
  └── ...
  ```

### 3. Environment Configuration
- [ ] Create `backend/.env` with:
  ```
  DB_HOST=localhost
  DB_USER=cpanel_user_db
  DB_PASSWORD=password
  DB_NAME=cpanel_user_db
  PORT=8080
  NODE_ENV=production
  ALLOWED_ORIGINS=https://yourdomain.com
  ```
- [ ] Never commit .env to git

### 4. Node.js Manager Setup
- [ ] Open cPanel → **Setup Node.js App**
- [ ] Click **Create Application**
- [ ] Fill in:
  - **Node.js version:** 18.x or higher
  - **Application mode:** Development (for debugging)
  - **Application root:** /home/username/public_html
  - **Application startup file:** backend/index.js
  - **Application URL:** yourdomain.com
  - **Application port:** 8080

### 5. Environment Variables in cPanel
- [ ] Click on your app in Node.js Manager
- [ ] Click **Edit Environment Variables**
- [ ] Add all .env variables:
  ```
  DB_HOST=localhost
  DB_USER=cpanel_user_db
  DB_PASSWORD=password
  DB_NAME=cpanel_user_db
  NODE_ENV=production
  ```

### 6. .htaccess Configuration
- [ ] Ensure `.htaccess` exists in public_html/
- [ ] Content should proxy /api requests to Node.js

### 7. Install Dependencies
- [ ] SSH into server (or use cPanel Terminal)
- [ ] Navigate to public_html
  ```bash
  cd ~/public_html
  npm install --production
  ```

### 8. Start Application
- [ ] In cPanel Node.js Manager, click **Restart App**
- [ ] Wait 2-3 seconds for startup
- [ ] Check status - should show "Running"

## ✅ Post-Deployment Testing

### Health Checks
- [ ] Check if API responds: `curl https://yourdomain.com/api/scraper/health`
- [ ] Check logs in cPanel Node.js Manager
- [ ] Verify port 8080 is accessible: `curl http://127.0.0.1:8080/api/scraper/health`

### Frontend Tests
- [ ] Open https://yourdomain.com in browser
- [ ] Check browser console for errors (F12)
- [ ] Test API call in console:
  ```javascript
  fetch('/api/song/languages').then(r => r.json()).then(console.log)
  ```

### Database Tests
- [ ] Try fetching songs: `https://yourdomain.com/api/song/top-played`
- [ ] Check if data loads
- [ ] Open cPanel MySQL Databases to verify connection

## ✅ Troubleshooting

### App won't start
- [ ] Check Node.js version (18+ required)
- [ ] Check application logs in cPanel
- [ ] Verify startup file path: `backend/index.js`
- [ ] Run: `npm install` on server

### CORS Error
- [ ] Check `ALLOWED_ORIGINS` in backend/.env
- [ ] Add your domain to the list
- [ ] Restart app in cPanel
- [ ] Check browser console for exact error

### Database Connection Failed
- [ ] Verify credentials in .env
- [ ] Ensure MySQL is running: `mysql -u user -p`
- [ ] Check database exists: `SHOW DATABASES;`
- [ ] Check user has proper privileges

### Static Files 404
- [ ] Verify `frontend/dist/` exists
- [ ] Run `npm run build` in frontend/
- [ ] Check .htaccess exists in public_html
- [ ] Verify file permissions: `chmod 755 files`

### Port 8080 Already in Use
- [ ] Kill existing process: `kill $(lsof -t -i:8080)`
- [ ] Restart app in cPanel Node.js Manager
- [ ] Check system limits with: `ulimit -n`

### Socket.io Connection Issues
- [ ] Check CORS settings in backend/index.js
- [ ] Verify WebSocket support enabled in cPanel
- [ ] Check browser console for WebSocket errors

## 📋 Important Notes

1. **Node version:** cPanel supports specific versions. Check your account's Node.js manager
2. **Memory limit:** Shared hosting has memory limits. Monitor in cPanel
3. **File uploads:** Set max upload size in cPanel PHP settings
4. **Database:** MySQL on shared hosting may have connection limits
5. **Backups:** Enable automatic backups in cPanel
6. **SSL:** Install free SSL in cPanel (AutoSSL)

## 🔧 Maintenance Commands

Monitor logs:
```bash
# SSH into server
tail -f /home/username/public_html/logs/node.log
```

Restart app:
- Use cPanel Node.js Manager → Restart App

Stop app:
- Use cPanel Node.js Manager → Stop App

View process:
```bash
ps aux | grep node
```

## 📞 Support

If issues persist:
1. Check cPanel documentation
2. Contact your hosting provider's support
3. Check Node.js app logs in cPanel
4. Review browser console errors (F12)
