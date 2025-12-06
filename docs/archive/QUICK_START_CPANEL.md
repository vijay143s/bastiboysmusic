# 🚀 cPanel Deployment - QUICK REFERENCE

## What's Been Fixed for cPanel

### ✅ Backend (backend/index.js)
- ✅ Added CORS support with configurable origins
- ✅ Automatic port selection (8080 for production, 5000 for dev)
- ✅ Better startup logging for debugging
- ✅ Support for ALLOWED_ORIGINS environment variable

### ✅ Dependencies (package.json)
- ✅ Added missing `cors` package
- ✅ All required packages verified

### ✅ Configuration
- ✅ Created `.env.example` template
- ✅ Created `.htaccess` proxy rules
- ✅ Created `start.sh` startup script

### ✅ Documentation
- ✅ CPANEL_DEPLOYMENT.md - Full setup guide
- ✅ CPANEL_CHECKLIST.md - Step-by-step checklist
- ✅ CPANEL_ERRORS.md - Troubleshooting guide
- ✅ deploy-cpanel.sh - Automated deployment script

---

## 🎯 What You Need to Do (3 Simple Steps)

### Step 1: Build Everything Locally (Already Done ✅)
```bash
npm run build  # Builds frontend to frontend/dist/
```

### Step 2: Upload to cPanel
```
Upload to public_html/:
- backend/
- frontend/dist/
- package.json
- .htaccess
- backend/.env (CREATE WITH YOUR CREDENTIALS)
```

### Step 3: Configure in cPanel
1. **Create database:**
   - cPanel → MySQL Databases → Create New Database
   - Note the name (format: user_dbname)

2. **Setup Node.js app:**
   - cPanel → Setup Node.js App
   - **Create Application:**
     - Node.js: 18+
     - Root: /home/username/public_html
     - Startup: backend/index.js
     - Port: 8080
     - URL: yourdomain.com

3. **Add environment variables:**
   - Click your app → Edit Environment Variables
   - Add ALL from backend/.env:
     ```
     DB_HOST=localhost
     DB_USER=cpanel_user_db
     DB_PASSWORD=yourpassword
     DB_NAME=cpanel_user_db
     NODE_ENV=production
     ALLOWED_ORIGINS=https://yourdomain.com
     ```

4. **Restart App** → Done! ✅

---

## 🔍 How to Verify Deployment

### Test 1: API Health Check
```bash
# Via SSH
curl http://127.0.0.1:8080/api/scraper/health

# Should return:
# {"success":true,"message":"Telugu Songs Scraper API is running",...}
```

### Test 2: Browser Test
- Open https://yourdomain.com
- Should see your frontend
- Open DevTools (F12) → Console
- No red errors? ✅ Good!

### Test 3: API Call Test
```javascript
// In browser console
fetch('/api/song/languages')
  .then(r => r.json())
  .then(console.log)

// Should show languages list
```

### Test 4: Database Test
- Try loading songs: https://yourdomain.com/api/song/top-played
- Should show data (not empty)

---

## 📋 Troubleshooting Quick Links

| Problem | Solution |
|---------|----------|
| **Can't GET /** | See CPANEL_ERRORS.md → "Cannot GET /" |
| **CORS Error** | See CPANEL_ERRORS.md → "CORS error" |
| **DB Connection Failed** | See CPANEL_ERRORS.md → "connect ECONNREFUSED" |
| **Port 8080 in use** | See CPANEL_ERRORS.md → "Port already in use" |
| **Module not found** | See CPANEL_ERRORS.md → "Cannot find module" |

---

## 📱 What's Already Configured

### Backend Features
- ✅ Language filtering for all content
- ✅ Caching system (LRU + TTL)
- ✅ Queue synced with language
- ✅ CORS enabled for your domain
- ✅ Socket.io for real-time updates
- ✅ Express.js with all routes

### Frontend Features
- ✅ Built to frontend/dist/
- ✅ All components working
- ✅ Language switcher integrated
- ✅ API ready to connect

### Database Support
- ✅ MySQL connection pooling
- ✅ All schemas prepared
- ✅ Indexed queries for performance

---

## 🆘 If Still Not Working

### Check These First
1. **SSH into cPanel:**
   ```bash
   ssh user@yourdomain.com
   cd public_html
   ```

2. **Check Node.js app status:**
   ```bash
   ps aux | grep node
   ```

3. **Check port 8080:**
   ```bash
   curl http://127.0.0.1:8080/api/scraper/health
   ```

4. **Check database:**
   ```bash
   mysql -u user_db -p -h localhost user_db
   SELECT 1;  # Should return 1
   ```

5. **Check logs:**
   - cPanel → Node.js Manager → Your App → View Logs

### Most Common Issues (90% of problems)

**Issue:** "Cannot connect to database"
```
Solution:
1. Copy correct database name from cPanel (with underscore)
2. Add all credentials to backend/.env
3. Restart app
```

**Issue:** "CORS error in browser"
```
Solution:
1. Add domain to ALLOWED_ORIGINS in .env
2. Make sure it's https://yourdomain.com (with https)
3. Restart app
```

**Issue:** "Frontend loads but API is 404"
```
Solution:
1. Verify .htaccess exists in public_html
2. Check mod_rewrite is enabled
3. Test: curl http://127.0.0.1:8080/api/scraper/health
```

---

## 📞 Support Resources

- **cPanel Documentation:** https://documentation.cpanel.net/
- **Node.js cPanel Guide:** Search "Node.js Application Manager" in cPanel docs
- **MySQL Troubleshooting:** https://dev.mysql.com/doc/
- **Express.js Docs:** https://expressjs.com/

---

## ✅ Final Checklist Before Going Live

- [ ] Database created and credentials working
- [ ] backend/.env has all correct values
- [ ] Node.js app created and running in cPanel
- [ ] ALLOWED_ORIGINS includes your domain
- [ ] Frontend builds to frontend/dist/
- [ ] .htaccess exists in public_html
- [ ] SSL certificate installed (HTTPS working)
- [ ] API responds: /api/scraper/health
- [ ] Frontend loads at yourdomain.com
- [ ] Data displays on homepage

---

## 🎉 You're Ready!

Once all steps are done:
1. Visit https://yourdomain.com
2. Check console for errors (F12)
3. Try clicking around
4. Test language switching
5. Check if songs play

If everything works → **Deployment successful!** 🎊

If issues persist → Check CPANEL_ERRORS.md or CPANEL_CHECKLIST.md for detailed steps.
