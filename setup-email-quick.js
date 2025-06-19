#!/usr/bin/env node

/**
 * Quick Email Setup for RiftFuel
 * This script helps you quickly configure email service
 */

console.log('🔧 RiftFuel Email Service Quick Setup\n');

console.log('📋 Before we start, you need:');
console.log('1. Gmail account with 2-factor authentication enabled');
console.log('2. Gmail App Password (not your regular password)');
console.log('3. Firebase CLI logged in\n');

console.log('📧 Gmail App Password Setup:');
console.log('1. Go to Google Account settings');
console.log('2. Security → 2-Step Verification → App passwords');
console.log('3. Generate password for "Mail"');
console.log('4. Use that 16-character password below\n');

console.log('🚀 Run these commands to set up email service:\n');

console.log('# 1. Login to Firebase (if not already logged in)');
console.log('firebase login\n');

console.log('# 2. Set the project');
console.log('firebase use riftfuel-ba023\n');

console.log('# 3. Configure email settings (replace with your details)');
console.log('firebase functions:config:set email.host="smtp.gmail.com"');
console.log('firebase functions:config:set email.port="587"');
console.log('firebase functions:config:set email.secure="false"');
console.log('firebase functions:config:set email.user="your-email@gmail.com"');
console.log('firebase functions:config:set email.password="your-16-char-app-password"\n');

console.log('# 4. Deploy Firebase Functions');
console.log('npm run deploy-functions\n');

console.log('# 5. Test the email service');
console.log('# Go to Admin Dashboard → Email Test tab\n');

console.log('💡 Example configuration:');
console.log('firebase functions:config:set email.host="smtp.gmail.com"');
console.log('firebase functions:config:set email.port="587"');
console.log('firebase functions:config:set email.secure="false"');
console.log('firebase functions:config:set email.user="geoffrey.kimani@riftfuel.com"');
console.log('firebase functions:config:set email.password="abcd efgh ijkl mnop"\n');

console.log('🔍 To check current configuration:');
console.log('firebase functions:config:get\n');

console.log('❌ Common Issues:');
console.log('- Using regular Gmail password instead of App Password');
console.log('- Not enabling 2-factor authentication first');
console.log('- Firebase CLI not logged in');
console.log('- Functions not deployed after configuration\n');

console.log('📞 Need help? Check EMAIL_SETUP_GUIDE.md for detailed instructions');
