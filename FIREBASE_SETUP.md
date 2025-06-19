# 🔥 Firebase Setup for Test User Creation

This guide explains how to set up Firebase Admin SDK credentials for creating test users automatically.

## 📋 Prerequisites

1. **Firebase Project**: You need an active Firebase project
2. **Admin Access**: You must be an owner or editor of the Firebase project
3. **Node.js**: Required for running the test user creation script

## 🔑 Service Account Setup

### Step 1: Generate Service Account Key

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your RiftFuel project
3. Click the gear icon ⚙️ → **Project Settings**
4. Navigate to the **Service Accounts** tab
5. Click **Generate new private key**
6. Click **Generate key** to download the JSON file

### Step 2: Save the Service Account Key

1. Rename the downloaded file to `firebase-service-account.json`
2. Move it to your project root directory (same level as `package.json`)
3. **IMPORTANT**: Add it to `.gitignore` to keep it secure

```bash
# Add to .gitignore
echo "firebase-service-account.json" >> .gitignore
```

### Step 3: Verify File Structure

Your project should look like this:
```
your-project/
├── firebase-service-account.json  ← Service account key
├── package.json
├── src/
├── scripts/
└── ...
```

## 🚀 Create Test Users

### Option 1: Create All Users (Recommended)
```bash
npm run create-test-users
```

### Option 2: Preview First (Dry Run)
```bash
npm run create-test-users:dry-run
```

### Option 3: Create for Specific Company
```bash
npm run create-test-users -- --company-id COMP-001
```

### Option 4: Force Overwrite Existing Users
```bash
npm run create-test-users:force
```

## 🔍 Verification

After running the script, verify users were created:

1. **Firebase Console**: Go to Authentication → Users
2. **Firestore**: Check the `users` collection for user documents
3. **Login Test**: Try logging in with the test credentials

## 📝 Test Credentials Created

The script creates these users:

### Main Admin (System Administrator)
- **Main Admin**: admin@riftfuel.com / MainAdmin2024!

**Note**: All company-specific demo users have been removed. Only the Main Admin exists by default. Company admins should be created through the Main Admin Dashboard after logging in with the Main Admin credentials above.

## 🛠️ Troubleshooting

### Error: Service Account Key Not Found
```
❌ Firebase service account key not found at: /path/to/firebase-service-account.json
```
**Solution**: Download and place the service account key file as described in Step 2.

### Error: Permission Denied
```
❌ Permission denied: Missing or insufficient permissions
```
**Solution**: Ensure your service account has the following roles:
- Firebase Authentication Admin
- Cloud Firestore User

### Error: User Already Exists
```
❌ User already exists (use --force to overwrite)
```
**Solution**: Use the force flag to overwrite existing users:
```bash
npm run create-test-users:force
```

### Error: Invalid Project ID
```
❌ Project ID not found or invalid
```
**Solution**: Verify your service account key is from the correct Firebase project.

## 🔒 Security Best Practices

### 1. Keep Service Account Key Secure
- ✅ Add to `.gitignore`
- ✅ Never commit to version control
- ✅ Store securely in production environments
- ✅ Rotate keys regularly

### 2. Limit Service Account Permissions
Only grant necessary permissions:
- Firebase Authentication Admin (for user creation)
- Cloud Firestore User (for user documents)

### 3. Environment-Specific Keys
Use different service accounts for:
- Development
- Staging  
- Production

### 4. Monitor Usage
- Check Firebase Console for unusual activity
- Review authentication logs
- Monitor Firestore usage

## 🔄 Alternative Setup Methods

### Method 1: Manual User Creation
If you prefer not to use the automated script:

1. Go to Firebase Console → Authentication
2. Click **Add user**
3. Enter email and password from the credentials list
4. Go to Firestore → `users` collection
5. Create user document with proper role and company ID

### Method 2: Using Firebase CLI
```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login to Firebase
firebase login

# Use Firebase Admin SDK in your own script
```

### Method 3: In-App User Creation
Use the RiftFuel admin interface:
1. Login as an existing admin user
2. Go to User Management
3. Create users using the admin interface

## 📞 Support

If you encounter issues:

1. **Check Firebase Console**: Verify project settings and permissions
2. **Review Logs**: Check console output for detailed error messages
3. **Verify Credentials**: Ensure service account key is valid and properly placed
4. **Test Connectivity**: Verify internet connection and Firebase project access

## 🎯 Next Steps

After setting up test users:

1. **Test Login**: Verify you can login with the created credentials
2. **Test Roles**: Confirm role-based access control works
3. **Test Multi-Company**: Verify data isolation between companies
4. **Run Tests**: Execute your test suite with the new users
5. **Document**: Update your team on the available test credentials

---

**Security Note**: These are test credentials for development only. Never use these passwords in production environments.
