# cPanel Deployment - Common Errors & Solutions

## 🔴 Error: "Cannot GET /"

**Cause:** Frontend not serving or .htaccess not configured

**Solutions:**
1. Verify frontend build exists:
   ```bash
   ls -la ~/public_html/frontend/dist/
   ```

2. Check .htaccess has proxy rules:
   ```bash
   cat ~/public_html/.htaccess
   ```

3. Enable mod_rewrite:
   - cPanel → Apache Modules → Enable mod_rewrite
   - Restart Apache

4. Rebuild frontend:
   ```bash
   cd ~/public_html/frontend
   npm run build
   ```

---

## 🔴 Error: "Port 8080 already in use"

**Cause:** Another app using the same port

**Solutions:**
1. Kill existing process:
   ```bash
   kill $(lsof -t -i:8080)
   ```

2. Use different port in cPanel (e.g., 8081)

3. Check what's using the port:
   ```bash
   lsof -i :8080
   ```

---

## 🔴 Error: "Cannot find module 'express'"

**Cause:** node_modules not installed on server

**Solutions:**
1. SSH to server and run:
   ```bash
   cd ~/public_html
   npm install --production
   ```

2. Or enable auto-install in cPanel Node.js Manager

3. Check package.json exists

---

## 🔴 Error: "CORS error - Origin not allowed"

**Cause:** Frontend domain not in CORS whitelist

**Solutions:**
1. Update backend/.env:
   ```
   ALLOWED_ORIGINS=https://yourdomain.com,https://www.yourdomain.com
   ```

2. Restart app in cPanel

3. Check browser console for exact error

4. Test with curl:
   ```bash
   curl -H "Origin: https://yourdomain.com" http://127.0.0.1:8080/api/scraper/health
   ```

---

## 🔴 Error: "connect ECONNREFUSED 127.0.0.1:3306"

**Cause:** MySQL not running or wrong credentials

**Solutions:**
1. Test MySQL connection:
   ```bash
   mysql -u username -p -h localhost
   ```

2. Verify credentials in .env:
   - DB_HOST=localhost (not 127.0.0.1 sometimes)
   - DB_USER=correct_username
   - DB_PASSWORD=correct_password

3. Check MySQL status:
   - cPanel → MySQL Databases → Privileges

4. Restart MySQL:
   - cPanel → Main → Restart Services

---

## 🔴 Error: "Application startup file not found"

**Cause:** Wrong path to entry file

**Solutions:**
1. In cPanel Node.js Manager, set:
   - **Startup file:** backend/index.js (not just index.js)

2. Verify file exists:
   ```bash
   ls -la ~/public_html/backend/index.js
   ```

3. Check permissions:
   ```bash
   chmod 644 ~/public_html/backend/index.js
   ```

---

## 🔴 Error: "ENOTFOUND" database name

**Cause:** Wrong database name in .env

**Solutions:**
1. Check actual database name in cPanel:
   - cPanel → MySQL Databases
   - Name format: `cpaneluser_dbname` (usually has underscore)

2. Update backend/.env with exact name

3. Restart app

---

## 🔴 Error: "Read-only file system"

**Cause:** File permissions too restrictive

**Solutions:**
1. Change permissions recursively:
   ```bash
   chmod -R 755 ~/public_html
   chmod -R 644 ~/public_html/backend/.env
   ```

2. Ensure directory is writable:
   ```bash
   chmod 755 ~/public_html/logs
   ```

---

## 🔴 Error: "Cannot load .env file"

**Cause:** .env file missing or in wrong directory

**Solutions:**
1. Create .env in backend/ directory:
   ```bash
   cp ~/public_html/backend/.env.example ~/public_html/backend/.env
   ```

2. Edit with actual values

3. Verify file exists:
   ```bash
   ls -la ~/public_html/backend/.env
   ```

4. Set permissions:
   ```bash
   chmod 644 ~/public_html/backend/.env
   ```

---

## 🔴 Error: "Socket.io connection failed"

**Cause:** WebSocket not supported or port blocked

**Solutions:**
1. Check WebSocket support in cPanel

2. Disable Socket.io temporarily:
   - Modify backend/index.js to skip Socket.io if not needed

3. Test basic HTTP connection first:
   ```bash
   curl http://127.0.0.1:8080/api/scraper/health
   ```

---

## 🔴 Error: "Frontend builds but API returns 404"

**Cause:** API proxy not working in .htaccess

**Solutions:**
1. Check .htaccess content:
   ```bash
   cat ~/public_html/.htaccess
   ```

2. Should contain:
   ```apache
   RewriteRule ^api/(.*)$ http://127.0.0.1:8080/api/$1 [P,L]
   ```

3. Test API directly:
   ```bash
   curl http://127.0.0.1:8080/api/scraper/health
   ```

4. If works locally but not via domain:
   - Enable mod_proxy in Apache
   - Restart Apache

---

## 🔴 Error: "Max upload size exceeded"

**Cause:** PHP upload limit too small

**Solutions:**
1. Edit php.ini in cPanel (if allowed)

2. Or use .htaccess:
   ```apache
   php_value upload_max_filesize 100M
   php_value post_max_size 100M
   ```

3. Check current limit:
   - cPanel → MultiPHP INI Editor

---

## 🔴 Error: "Memory exhausted"

**Cause:** App using too much memory

**Solutions:**
1. Check memory usage:
   ```bash
   free -h
   ```

2. Check Node app memory:
   ```bash
   ps aux | grep node
   ```

3. Increase memory limit:
   - In backend/.env: `NODE_OPTIONS=--max-old-space-size=256`
   - Restart app

4. Contact hosting if persistent

---

## 🔴 Error: "Application logs are empty"

**Cause:** Logs not being written

**Solutions:**
1. Check log directory:
   ```bash
   ls -la ~/public_html/logs/
   ```

2. Ensure directory exists:
   ```bash
   mkdir -p ~/public_html/logs
   chmod 755 ~/public_html/logs
   ```

3. Check app logs directly in cPanel Node.js Manager

---

## ✅ Success Indicators

- ✅ `curl http://127.0.0.1:8080/api/scraper/health` returns JSON
- ✅ `https://yourdomain.com` loads frontend
- ✅ Browser console shows no CORS errors
- ✅ API calls return data (not 404 or 500)
- ✅ Database queries work
- ✅ cPanel Node.js Manager shows "Running"

---

## 📊 Debug Information to Gather

When reporting issues:
1. **cPanel Node.js Manager logs**
2. **Browser console errors (F12)**
3. **Network tab showing failed requests**
4. **SSH terminal output of:**
   ```bash
   ps aux | grep node
   lsof -i :8080
   mysql -u user -p -e "SELECT 1"
   ```
5. **Error message from:**
   - Browser
   - cPanel
   - SSH logs
