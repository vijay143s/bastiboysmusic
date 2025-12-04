#!/bin/bash

# ============================================================
# cPanel Deployment Script for Telugu Songs App
# ============================================================
# Usage: bash deploy-cpanel.sh

echo "🚀 Starting cPanel Deployment..."

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Step 1: Build Frontend
echo -e "${BLUE}[1/5]${NC} Building frontend..."
cd frontend
npm run build
if [ $? -ne 0 ]; then
    echo -e "${RED}✗ Frontend build failed${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Frontend built successfully${NC}"
cd ..

# Step 2: Check dependencies
echo -e "${BLUE}[2/5]${NC} Checking dependencies..."
if [ ! -f "package.json" ]; then
    echo -e "${RED}✗ package.json not found${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Dependencies verified${NC}"

# Step 3: Verify Backend Files
echo -e "${BLUE}[3/5]${NC} Verifying backend files..."
if [ ! -f "backend/index.js" ]; then
    echo -e "${RED}✗ backend/index.js not found${NC}"
    exit 1
fi
echo -e "${GREEN}✓ Backend files verified${NC}"

# Step 4: Create .env if doesn't exist
echo -e "${BLUE}[4/5]${NC} Checking configuration..."
if [ ! -f "backend/.env" ]; then
    echo -e "${YELLOW}⚠ backend/.env not found${NC}"
    cp backend/.env.example backend/.env
    echo -e "${YELLOW}ℹ Created backend/.env from template${NC}"
    echo -e "${YELLOW}ℹ IMPORTANT: Edit backend/.env with your database credentials${NC}"
else
    echo -e "${GREEN}✓ backend/.env exists${NC}"
fi

# Step 5: Summary
echo -e "${BLUE}[5/5]${NC} Deployment summary..."
echo ""
echo -e "${GREEN}═══════════════════════════════════════════════════════════${NC}"
echo -e "${GREEN}Deployment package ready!${NC}"
echo -e "${GREEN}═══════════════════════════════════════════════════════════${NC}"
echo ""
echo "📁 Files ready:"
echo "  ✓ frontend/dist/ (built frontend)"
echo "  ✓ backend/ (Node.js application)"
echo "  ✓ backend/.env (configuration)"
echo ""
echo "📋 Next steps for cPanel deployment:"
echo "  1. Upload entire project to public_html"
echo "  2. Edit backend/.env with database credentials"
echo "  3. Open cPanel → Setup Node.js App"
echo "  4. Create new app with:"
echo "     - Node.js version: 18+"
echo "     - Startup file: backend/index.js"
echo "     - Port: 8080"
echo "  5. Click 'Restart App'"
echo ""
echo "🔗 Test your deployment:"
echo "  - Open https://yourdomain.com in browser"
echo "  - Check API: https://yourdomain.com/api/scraper/health"
echo ""
echo "📚 Documentation:"
echo "  - CPANEL_DEPLOYMENT.md (setup guide)"
echo "  - CPANEL_CHECKLIST.md (step-by-step checklist)"
echo "  - CPANEL_ERRORS.md (troubleshooting)"
echo ""
echo -e "${GREEN}✓ Ready to deploy!${NC}"
