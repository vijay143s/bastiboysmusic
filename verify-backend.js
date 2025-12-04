#!/usr/bin/env node

/**
 * Backend Verification Script for cPanel Deployment
 * Run: node verify-backend.js
 */

const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

console.log('🔍 Starting Backend Verification...\n');

let passed = 0;
let failed = 0;

// Test 1: Node.js version
process.stdout.write('1. Node.js version check... ');
const nodeVersion = process.version;
if (nodeVersion >= 'v18.0.0') {
  console.log(`✓ ${nodeVersion}`);
  passed++;
} else {
  console.log(`✗ ${nodeVersion} (need v18+)`);
  failed++;
}

// Test 2: Backend file
process.stdout.write('2. backend/index.js... ');
if (fs.existsSync('backend/index.js')) {
  console.log('✓ Exists');
  passed++;
} else {
  console.log('✗ Missing');
  failed++;
}

// Test 3: .env file
process.stdout.write('3. backend/.env file... ');
if (fs.existsSync('backend/.env')) {
  console.log('✓ Exists');
  passed++;
} else {
  console.log('✗ Missing');
  failed++;
}

// Test 4: .htaccess file
process.stdout.write('4. .htaccess file... ');
if (fs.existsSync('.htaccess')) {
  console.log('✓ Exists');
  passed++;
} else {
  console.log('✗ Missing');
  failed++;
}

// Test 5: frontend/dist
process.stdout.write('5. frontend/dist build... ');
if (fs.existsSync('frontend/dist')) {
  console.log('✓ Exists');
  passed++;
} else {
  console.log('⚠ Missing');
  failed++;
}

// Test 6: package.json
process.stdout.write('6. package.json... ');
if (fs.existsSync('package.json')) {
  const pkg = require('./package.json');
  const required = ['express', 'mysql2', 'socket.io', 'cors', 'dotenv'];
  const missing = required.filter(r => !pkg.dependencies || !pkg.dependencies[r]);
  if (missing.length === 0) {
    console.log('✓ All dependencies present');
    passed++;
  } else {
    console.log(`✗ Missing: ${missing.join(', ')}`);
    failed++;
  }
} else {
  console.log('✗ Missing');
  failed++;
}

// Test 7: Node modules
process.stdout.write('7. node_modules... ');
if (fs.existsSync('node_modules')) {
  console.log('✓ Installed');
  passed++;
} else {
  console.log('⚠ Not installed (run: npm install)');
  failed++;
}

// Summary
console.log('\n' + '═'.repeat(55));
console.log(`Results: ${passed} passed, ${failed} failed`);
console.log('═'.repeat(55));

if (failed === 0) {
  console.log('\n✓ All checks passed! Ready to deploy.\n');
  console.log('Next steps:');
  console.log('  1. Upload to cPanel: public_html/');
  console.log('  2. Create Node.js app: cPanel → Setup Node.js App');
  console.log('  3. Start app: Restart App in Node.js Manager\n');
  process.exit(0);
} else {
  console.log(`\n✗ ${failed} check(s) failed. Fix issues above.\n`);
  process.exit(1);
}
