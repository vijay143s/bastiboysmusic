#!/bin/bash

# ============================================================
# Backend Verification Script for cPanel Deployment
# ============================================================
# Run this to check if everything is configured correctly

echo "🔍 Starting Backend Verification..."
echo ""

# Color codes
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Test counter
PASSED=0
FAILED=0

# Test 1: Node.js version
echo -n "1. Node.js version check... "
NODE_VERSION=$(node -v)
if [[ $NODE_VERSION == v18* ]] || [[ $NODE_VERSION == v19* ]] || [[ $NODE_VERSION == v20* ]] || [[ $NODE_VERSION == v21* ]]; then
    echo -e "${GREEN}✓ $NODE_VERSION${NC}"
    ((PASSED++))
else
    echo -e "${RED}✗ $NODE_VERSION (need v18+)${NC}"
    ((FAILED++))
fi

# Test 2: npm packages
echo -n "2. npm packages check... "
if npm list express > /dev/null 2>&1; then
    echo -e "${GREEN}✓ All packages installed${NC}"
    ((PASSED++))
else
    echo -e "${RED}✗ Missing packages - run: npm install${NC}"
    ((FAILED++))
fi

# Test 3: backend/.env file
echo -n "3. backend/.env file... "
if [ -f "backend/.env" ]; then
    echo -e "${GREEN}✓ File exists${NC}"
    ((PASSED++))
else
    echo -e "${RED}✗ File missing${NC}"
    ((FAILED++))
fi

# Test 4: backend/index.js file
echo -n "4. backend/index.js file... "
if [ -f "backend/index.js" ]; then
    echo -e "${GREEN}✓ File exists${NC}"
    ((PASSED++))
else
    echo -e "${RED}✗ File missing${NC}"
    ((FAILED++))
fi

# Test 5: frontend/dist build
echo -n "5. frontend/dist build... "
if [ -d "frontend/dist" ]; then
    echo -e "${GREEN}✓ Build exists${NC}"
    ((PASSED++))
else
    echo -e "${YELLOW}⚠ Build missing - run: cd frontend && npm run build${NC}"
    ((FAILED++))
fi

# Test 6: .htaccess file
echo -n "6. .htaccess file... "
if [ -f ".htaccess" ]; then
    echo -e "${GREEN}✓ File exists${NC}"
    ((PASSED++))
else
    echo -e "${RED}✗ File missing${NC}"
    ((FAILED++))
fi

# Test 7: Backend syntax
echo -n "7. Backend syntax check... "
if node -c backend/index.js > /dev/null 2>&1; then
    echo -e "${GREEN}✓ No syntax errors${NC}"
    ((PASSED++))
else
    echo -e "${RED}✗ Syntax errors found${NC}"
    ((FAILED++))
fi

# Test 8: CORS package
echo -n "8. CORS package... "
if npm list cors > /dev/null 2>&1; then
    echo -e "${GREEN}✓ Installed${NC}"
    ((PASSED++))
else
    echo -e "${RED}✗ Missing - run: npm install cors${NC}"
    ((FAILED++))
fi

# Test 9: Port configuration
echo -n "9. Port configuration... "
if grep -q "process.env.PORT\|8080\|5000" backend/index.js; then
    echo -e "${GREEN}✓ Port configured${NC}"
    ((PASSED++))
else
    echo -e "${RED}✗ Port not found in index.js${NC}"
    ((FAILED++))
fi

# Test 10: Required packages in package.json
echo -n "10. Required dependencies... "
MISSING=0
for pkg in express mysql2 socket.io cors dotenv; do
    if ! grep -q "\"$pkg\"" package.json; then
        echo -e "${RED}Missing: $pkg${NC}"
        ((MISSING++))
    fi
done
if [ $MISSING -eq 0 ]; then
    echo -e "${GREEN}✓ All present${NC}"
    ((PASSED++))
else
    echo -e "${RED}✗ $MISSING packages missing${NC}"
    ((FAILED++))
fi

# Summary
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo -e "Results: ${GREEN}$PASSED passed${NC}, ${RED}$FAILED failed${NC}"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

if [ $FAILED -eq 0 ]; then
    echo -e "${GREEN}✓ All checks passed! Ready to deploy.${NC}"
    echo ""
    echo "Next steps:"
    echo "  1. Upload to cPanel: public_html/"
    echo "  2. Create Node.js app: cPanel → Setup Node.js App"
    echo "  3. Start app: Restart App in Node.js Manager"
    echo ""
    exit 0
else
    echo -e "${RED}✗ $FAILED check(s) failed. Fix issues above.${NC}"
    exit 1
fi
