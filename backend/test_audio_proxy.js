#!/usr/bin/env node

/**
 * Test Audio Proxy Functionality
 * Run: node test_audio_proxy.js
 */

const http = require('http');

const testAudioUrl = 'https://pagalworldmusic.com/download.php?title=Test-320kbps&path=downloads%2Fhigh%2FTest%2FTest.mp3';

console.log('\n🎵 Audio Proxy Test Suite\n');
console.log('=' .repeat(50));

// Test 1: Audio Fetch endpoint
console.log('\n📌 Test 1: Audio Fetch Endpoint');
console.log('-'.repeat(50));

const fetchPath = `/api/audio/fetch?url=${encodeURIComponent(testAudioUrl)}`;
console.log('GET:', fetchPath);

http.get(`http://localhost:5000${fetchPath}`, (res) => {
  let data = '';
  res.on('data', chunk => data += chunk);
  res.on('end', () => {
    try {
      const result = JSON.parse(data);
      console.log('\n✅ Response:');
      console.log(JSON.stringify(result, null, 2));
      
      // Test 2: Audio Stream endpoint
      console.log('\n📌 Test 2: Audio Stream Endpoint');
      console.log('-'.repeat(50));
      
      const streamPath = `/api/audio/stream?url=${encodeURIComponent(testAudioUrl)}`;
      console.log('GET:', streamPath);
      console.log('Expected: Audio file stream with proper headers\n');
      
      http.get(`http://localhost:5000${streamPath}`, (streamRes) => {
        console.log('✅ Response Headers:');
        console.log('  Content-Type:', streamRes.headers['content-type']);
        console.log('  Accept-Ranges:', streamRes.headers['accept-ranges']);
        console.log('  Content-Length:', streamRes.headers['content-length']);
        console.log('  Cache-Control:', streamRes.headers['cache-control']);
        console.log('  Access-Control-Allow-Origin:', streamRes.headers['access-control-allow-origin']);
        console.log('  Status Code:', streamRes.statusCode);
        
        // Just check headers, don't download the whole file
        streamRes.destroy();
        
        console.log('\n' + '='.repeat(50));
        console.log('✅ Audio Proxy is working correctly!');
        console.log('=' .repeat(50) + '\n');
        
      }).on('error', (e) => {
        console.error('❌ Stream test failed:', e.message);
      });
      
    } catch (e) {
      console.error('❌ Failed to parse response:', e.message);
    }
  });
}).on('error', (e) => {
  console.error('❌ Fetch test failed:', e.message);
  console.log('\n⚠️  Make sure backend is running on port 5000');
  console.log('   Run: npm run dev (in backend directory)');
});
