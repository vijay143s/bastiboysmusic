# cPanel Shared Hosting Deployment Guide

## Step 1: Update Backend Configuration

Your backend needs these updates for cPanel:

### A. Port Configuration
- cPanel uses port **8080** for Node.js apps
- Update `backend/index.js` PORT to 8080

### B. Database Connection
Ensure your `.env` file in backend/ has:
```
DB_HOST=localhost
DB_USER=cpanel_username_songdb
DB_PASSWORD=your_db_password
DB_NAME=cpanel_username_songdb
PORT=8080
NODE_ENV=production
```

### C. CORS Configuration
Update backend/index.js to allow your cPanel domain:
```javascript
const cors = require('cors');
app.use(cors({
  origin: ['https://yourdomain.com', 'http://yourdomain.com'],
  credentials: true
}));
```

## Step 2: Frontend Deployment

1. Build frontend:
   ```bash
   cd frontend
   npm run build
   ```

2. Upload dist folder to public_html

## Step 3: cPanel Node.js Manager

1. Login to cPanel
2. Go to **Setup Node.js App**
3. Create new app:
   - Node.js version: 18+
   - Application mode: Development
   - Application root: /home/username/public_html (or your app path)
   - Application startup file: backend/index.js
   - Application URL: yourdomain.com

4. Under "Environment Variables":
   - Add all variables from .env file
   - PORT=8080
   - NODE_ENV=production

## Step 4: URL Routing

Add this to `.htaccess` in public_html:
```apache
<IfModule mod_rewrite.c>
  RewriteEngine On
  RewriteBase /
  RewriteCond %{REQUEST_FILENAME} !-f
  RewriteCond %{REQUEST_FILENAME} !-d
  RewriteRule ^api/(.*)$ http://127.0.0.1:8080/api/$1 [P,L]
</IfModule>
```

## Step 5: Fix Issues

### Issue: "Cannot find module"
- Run: `npm install` in public_html
- Ensure node_modules is present

### Issue: "Port already in use"
- cPanel restarts apps automatically
- Check "Restart App" in Node.js Manager

### Issue: Database won't connect
- Verify MySQL is running
- Check DB credentials in .env
- Test with: `mysql -u user -p -h localhost dbname`

### Issue: Static files 404
- Build frontend: `npm run build` in frontend/
- Copy dist/ to public_html/frontend/dist/
- Update frontend API calls to use `/api/` paths

## Step 6: Verify Deployment

1. Check Node.js app status in cPanel
2. Check application logs in cPanel
3. Test API: `https://yourdomain.com/api/song/languages`
4. Check browser console for CORS errors

## Troubleshooting

### Check logs:
```bash
# SSH into your cPanel account
ssh user@domain.com
cd public_html
tail -f logs/node.log
```

### Restart app:
- cPanel → Setup Node.js App → Restart App

### Check if port is open:
```bash
netstat -tulpn | grep 8080
```

## Common cPanel Limits

- Max processes: Usually 10
- Max memory: Check your plan
- Max CPU: Subject to fair usage
- Max connections: Database specific

Contact your hosting provider if you hit these limits.
