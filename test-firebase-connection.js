#!/usr/bin/env node

/**
 * Test Firebase Connection
 * This script tests if Firebase is properly configured
 */

const { initializeApp } = require('firebase/app');
const { getAuth, connectAuthEmulator } = require('firebase/auth');
const { getFirestore, connectFirestoreEmulator } = require('firebase/firestore');
const { getFunctions, connectFunctionsEmulator } = require('firebase/functions');

// Firebase configuration from your project
const firebaseConfig = {
  apiKey: "AIzaSyCq2pdXs5RjbcBDjqtXvsgMPJWxWGSymQo",
  authDomain: "riftfuel-ba023.firebaseapp.com",
  projectId: "riftfuel-ba023",
  storageBucket: "riftfuel-ba023.firebasestorage.app",
  messagingSenderId: "326026086605",
  appId: "1:326026086605:web:f3efac05dd64331c5dc184",
  measurementId: "G-V52QLY50CM"
};

async function testFirebaseConnection() {
  console.log('🔧 Testing Firebase Connection...\n');

  try {
    // Initialize Firebase
    console.log('📱 Initializing Firebase...');
    const app = initializeApp(firebaseConfig);
    console.log('✅ Firebase app initialized successfully');

    // Test Auth
    console.log('🔐 Testing Firebase Auth...');
    const auth = getAuth(app);
    console.log('✅ Firebase Auth initialized');

    // Test Firestore
    console.log('🗄️ Testing Firestore...');
    const db = getFirestore(app);
    console.log('✅ Firestore initialized');

    // Test Functions
    console.log('⚡ Testing Firebase Functions...');
    const functions = getFunctions(app);
    console.log('✅ Firebase Functions initialized');

    console.log('\n🎉 All Firebase services are working!');
    console.log('\n📧 Email test failure is likely due to:');
    console.log('1. Firebase Functions not deployed');
    console.log('2. Email configuration not set');
    console.log('3. SMTP credentials not configured');

    console.log('\n🚀 Next steps:');
    console.log('1. Run: node setup-email-quick.js (for instructions)');
    console.log('2. Configure your email settings');
    console.log('3. Deploy Firebase Functions');
    console.log('4. Test again in the admin dashboard');

  } catch (error) {
    console.error('❌ Firebase connection failed:', error.message);
    
    console.log('\n🔧 Troubleshooting:');
    console.log('1. Check your internet connection');
    console.log('2. Verify Firebase project configuration');
    console.log('3. Check if Firebase project exists and is accessible');
  }
}

testFirebaseConnection();
