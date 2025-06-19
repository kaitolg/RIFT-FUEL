# Notification Setup Guide

This guide will help you set up push notifications for the RiftFuel application.

## 1. Firebase VAPID Key Setup

### Step 1: Get VAPID Key from Firebase Console
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project: `riftfuel-ba023`
3. Go to **Project Settings** (gear icon)
4. Click on the **Cloud Messaging** tab
5. Scroll down to **Web configuration**
6. If you don't have a Web Push certificate, click **Generate key pair**
7. Copy the **Key pair** value (this is your VAPID key)

### Step 2: Add VAPID Key to Environment Variables
1. Open your `.env` file
2. Uncomment and update the VAPID key line:
   ```
   VITE_FIREBASE_VAPID_KEY=your-actual-vapid-key-here
   ```
3. Replace `your-actual-vapid-key-here` with the key you copied from Firebase Console
4. Save the file and restart your development server

## 2. Firestore Index Setup

### The Missing Index Error
You may see this error in the console:
```
The query requires an index. You can create it here: https://console.firebase.google.com/...
```

### Step 1: Create the Required Index
1. Click on the URL provided in the error message, OR
2. Go to [Firebase Console](https://console.firebase.google.com/)
3. Select your project: `riftfuel-ba023`
4. Go to **Firestore Database**
5. Click on **Indexes** tab
6. Click **Create Index**
7. Set up the index with these fields:
   - **Collection ID**: `notifications`
   - **Fields to index**:
     - `userId` (Ascending)
     - `createdAt` (Descending)
   - **Query scopes**: Collection
8. Click **Create**

### Step 2: Wait for Index Creation
- Index creation can take a few minutes
- You'll see the status change from "Building" to "Enabled"
- Once enabled, the notification queries will work properly

## 3. Testing Notifications

### Browser Permissions
1. When you first load the app, you should see a browser notification permission prompt
2. Click **Allow** to enable notifications
3. If you missed it, you can manually enable it in your browser settings

### Verification
1. Check the browser console for these messages:
   - `Notification permission granted`
   - `FCM token received: ...`
   - `Push notifications initialized successfully`

2. If you see warnings instead of errors, the app is working correctly without push notifications

## 4. Troubleshooting

### Common Issues

**VAPID Key Error**
- Error: `The provided applicationServerKey is not valid`
- Solution: Make sure you copied the correct VAPID key from Firebase Console

**Index Error**
- Error: `The query requires an index`
- Solution: Create the Firestore index as described above

**Permission Denied**
- Error: Notifications not working
- Solution: Check browser notification permissions in browser settings

### Fallback Behavior
The app is designed to work gracefully without push notifications:
- If VAPID key is missing, push notifications are disabled but app continues to work
- If Firestore index is missing, notification queries return empty arrays
- Users will still see in-app notifications and other features work normally

## 5. Production Considerations

### Security
- Never commit your actual VAPID key to version control
- Use environment variables for all sensitive configuration
- Consider using different VAPID keys for development and production

### Performance
- Firestore indexes improve query performance significantly
- Consider creating additional indexes for complex notification queries
- Monitor Firebase usage and costs

### User Experience
- Always request notification permissions at appropriate times
- Provide clear explanations of why notifications are useful
- Allow users to manage notification preferences
