#!/bin/bash

# cPanel Node.js Deployment Script
# This script starts the Node.js application on cPanel shared hosting

cd "$(dirname "$0")"

# Kill existing process on port 8080 if running
kill $(lsof -t -i:8080) 2>/dev/null || true
sleep 1

# Set environment
export NODE_ENV=production
export PORT=8080

# Install dependencies
npm install --production 2>/dev/null

# Start the application
node backend/index.js &
BG_PID=$!

# Keep process running
wait $BG_PID
