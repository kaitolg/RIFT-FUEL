# 🚀 RiftFuel Main Admin System

This document contains the Main Admin credentials for the RiftFuel application. The Main Admin has global system access and can manage all companies and users.

## 🔐 Main Admin Credentials

### System Administrator

| Role | Email | Password | Access Level |
|------|-------|----------|--------------|
| **🔥 Main Admin** | `admin@riftfuel.com` | `MainAdmin2024!` | Global system access, company management, user management |

**Note**: All company-specific demo users have been removed. Only the Main Admin exists by default.

## 🎯 Testing Scenarios

### 1. Main Admin System Access
- **Test**: Login with Main Admin and verify global access
- **User**: `admin@riftfuel.com`
- **Expected**: Access to Main Admin Dashboard with company management features

### 2. Company Management
- **Test**: Create, edit, and manage companies
- **User**: `admin@riftfuel.com` (Main Admin)
- **Actions**: Create companies, assign admins, manage company settings

### 3. Global User Management
- **Test**: Manage users across all companies
- **User**: `admin@riftfuel.com` (Main Admin)
- **Actions**: View all users, assign users to companies, promote to company admin

### 4. Company Admin Assignment
- **Test**: Assign administrators to companies
- **User**: `admin@riftfuel.com` (Main Admin)
- **Actions**: Promote users to company admin, change company assignments

### 5. Hierarchical Access Control
- **Test**: Verify Main Admin can access all data while company admins are restricted
- **User**: `admin@riftfuel.com` (Main Admin)
- **Expected**: Global access to all companies and users

### 6. Company Creation Workflow
- **Test**: Complete company setup process
- **Flow**: Main Admin creates company → Assigns admin → Company admin manages users
- **User**: `admin@riftfuel.com` (Main Admin)

## 🛠️ Setup Instructions

### Option 1: Automated Creation (Recommended)
```bash
# Install dependencies
npm install

# Create Main Admin user
npm run create-main-admin

# Or use the development helper (development only)
# In browser console: await createDevMainAdmin();
```

### Option 2: Manual Creation
```javascript
import { createMainAdmin } from './src/utils/createMainAdmin';

await createMainAdmin(
  'admin@riftfuel.com',
  'MainAdmin2024!',
  'Main Administrator'
);
```

### Option 3: Using Main Admin Setup Component
1. Navigate to `/dev/main-admin-setup` in development
2. Use the Main Admin Setup interface
3. Create Main Admin with custom credentials if needed

## 🔒 Security Notes

- **Strong Passwords**: All passwords follow security requirements (8+ chars, uppercase, lowercase, numbers, symbols)
- **Email Verification**: Set to `true` for testing purposes
- **Company Isolation**: Each user can only access their company's data
- **Role Permissions**: Strictly enforced through Firestore security rules

## 📱 Mobile Testing

Test the PWA (Progressive Web App) features:
- **Install**: Add to home screen on mobile devices
- **Offline**: Test offline functionality with cached data
- **Responsive**: Verify mobile-first design with Tailwind CSS

## 🚨 Important Reminders

1. **Development Only**: These are test credentials for development/demo purposes
2. **Firebase Project**: Ensure you're using the correct Firebase project
3. **Environment**: These users are for testing, not production
4. **Data Reset**: Use Firebase Console to clear test data when needed
5. **Security Rules**: Verify Firestore rules are properly deployed

## 🆘 Troubleshooting

### User Creation Fails
- Check Firebase Admin SDK credentials
- Verify service account permissions
- Ensure Firebase project is properly configured

### Login Issues
- Verify email/password combination
- Check if user exists in Firebase Auth
- Confirm Firestore user document exists

### Permission Errors
- Verify user role in Firestore
- Check company ID matches
- Ensure security rules are deployed

### Data Isolation Issues
- Confirm `companyID` field is set correctly
- Verify security rules filter by company
- Check user's company assignment

## 📞 Support

For issues with test users or credentials:
1. Check the console for error messages
2. Verify Firebase configuration
3. Review Firestore security rules
4. Check user documents in Firestore Console

---

**Last Updated**: Created for RiftFuel v1.0  
**Founder**: Geoffrey Kimani  
**Pricing**: Kshs 60,000/month subscription
