# ============================================================
# Backend Verification Script for cPanel Deployment (PowerShell)
# ============================================================
# Run this to check if everything is configured correctly

Write-Host "🔍 Starting Backend Verification..." -ForegroundColor Cyan
Write-Host ""

$PASSED = 0
$FAILED = 0

# Test 1: Node.js version
Write-Host -NoNewline "1. Node.js version check... "
$NODE_VERSION = node -v
if ($NODE_VERSION -like "v18*" -or $NODE_VERSION -like "v19*" -or $NODE_VERSION -like "v20*" -or $NODE_VERSION -like "v21*") {
    Write-Host "✓ $NODE_VERSION" -ForegroundColor Green
    $PASSED++
} else {
    Write-Host "✗ $NODE_VERSION (need v18+)" -ForegroundColor Red
    $FAILED++
}

# Test 2: npm packages
Write-Host -NoNewline "2. npm packages check... "
$npmCheck = npm list express 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ All packages installed" -ForegroundColor Green
    $PASSED++
} else {
    Write-Host "✗ Missing packages - run: npm install" -ForegroundColor Red
    $FAILED++
}

# Test 3: backend/.env file
Write-Host -NoNewline "3. backend/.env file... "
if (Test-Path "backend\.env") {
    Write-Host "✓ File exists" -ForegroundColor Green
    $PASSED++
} else {
    Write-Host "✗ File missing" -ForegroundColor Red
    $FAILED++
}

# Test 4: backend/index.js file
Write-Host -NoNewline "4. backend/index.js file... "
if (Test-Path "backend\index.js") {
    Write-Host "✓ File exists" -ForegroundColor Green
    $PASSED++
} else {
    Write-Host "✗ File missing" -ForegroundColor Red
    $FAILED++
}

# Test 5: frontend/dist build
Write-Host -NoNewline "5. frontend/dist build... "
if (Test-Path "frontend\dist") {
    Write-Host "✓ Build exists" -ForegroundColor Green
    $PASSED++
} else {
    Write-Host "⚠ Build missing - run: cd frontend && npm run build" -ForegroundColor Yellow
    $FAILED++
}

# Test 6: .htaccess file
Write-Host -NoNewline "6. .htaccess file... "
if (Test-Path ".htaccess") {
    Write-Host "✓ File exists" -ForegroundColor Green
    $PASSED++
} else {
    Write-Host "✗ File missing" -ForegroundColor Red
    $FAILED++
}

# Test 7: Backend syntax
Write-Host -NoNewline "7. Backend syntax check... "
$syntaxCheck = node -c backend/index.js 2>&1
if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ No syntax errors" -ForegroundColor Green
    $PASSED++
} else {
    Write-Host "✗ Syntax errors found" -ForegroundColor Red
    $FAILED++
}

# Test 8: CORS package
Write-Host -NoNewline "8. CORS package... "
$corsCheck = npm list cors 2>$null
if ($corsCheck -like "*cors*") {
    Write-Host "✓ Installed" -ForegroundColor Green
    $PASSED++
} else {
    Write-Host "✗ Missing - run: npm install cors" -ForegroundColor Red
    $FAILED++
}

# Test 9: Port configuration
Write-Host -NoNewline "9. Port configuration... "
$portCheck = Select-String -Path "backend\index.js" -Pattern "PORT|8080|5000"
if ($portCheck) {
    Write-Host "✓ Port configured" -ForegroundColor Green
    $PASSED++
} else {
    Write-Host "✗ Port not found in index.js" -ForegroundColor Red
    $FAILED++
}

# Test 10: Required packages
Write-Host -NoNewline "10. Required dependencies... "
$packageJson = Get-Content "package.json" -Raw
$required = @("express", "mysql2", "socket.io", "cors", "dotenv")
$missing = 0
foreach ($pkg in $required) {
    if ($packageJson -notlike "*`"$pkg`"*") {
        Write-Host "Missing: $pkg" -ForegroundColor Red
        $missing++
    }
}
if ($missing -eq 0) {
    Write-Host "✓ All present" -ForegroundColor Green
    $PASSED++
} else {
    Write-Host "✗ $missing packages missing" -ForegroundColor Red
    $FAILED++
}

# Summary
Write-Host ""
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan
Write-Host "Results: $PASSED passed, $FAILED failed" -ForegroundColor Cyan
Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Cyan

if ($FAILED -eq 0) {
    Write-Host "✓ All checks passed! Ready to deploy." -ForegroundColor Green
    Write-Host ""
    Write-Host "Next steps:" -ForegroundColor Green
    Write-Host "  1. Upload to cPanel: public_html/" -ForegroundColor Green
    Write-Host "  2. Create Node.js app: cPanel → Setup Node.js App" -ForegroundColor Green
    Write-Host "  3. Start app: Restart App in Node.js Manager" -ForegroundColor Green
    Write-Host ""
} else {
    Write-Host "✗ $FAILED check(s) failed. Fix issues above." -ForegroundColor Red
}
