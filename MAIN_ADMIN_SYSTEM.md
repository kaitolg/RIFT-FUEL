# Main Admin System Documentation

## Overview

The Main Admin system provides a hierarchical administrative structure that allows a super administrator to manage multiple companies and their respective administrators. This system ensures proper data isolation while providing centralized management capabilities.

## System Architecture

### User Hierarchy

```
MainAdmin (Super Admin)
├── Company A
│   ├── Admin (Company Admin)
│   ├── Supervisor
│   ├── Operator
│   └── Accountant
├── Company B
│   ├── Admin (Company Admin)
│   ├── Supervisor
│   ├── Operator
│   └── Accountant
└── Company C
    ├── Admin (Company Admin)
    ├── Supervisor
    ├── Operator
    └── Accountant
```

### Role Definitions

#### MainAdmin (Super Administrator)
- **Global Access**: Can view and manage all companies and users
- **Company Management**: Create, edit, delete companies
- **Admin Assignment**: Assign and manage company administrators
- **User Management**: Global user management across all companies
- **System Oversight**: Full system administration capabilities

#### Admin (Company Administrator)
- **Company-Scoped Access**: Can only manage users within their assigned company
- **User Management**: Create, edit, delete users in their company
- **Company Operations**: Full access to company-specific data and operations
- **No Cross-Company Access**: Cannot view or modify other companies' data

## Features

### 1. Company Management
- Create new companies with detailed information
- Edit company details and settings
- Activate/deactivate companies
- Delete companies (with proper safeguards)
- Assign administrators to companies

### 2. Global User Management
- View all users across all companies
- Assign users to companies
- Remove users from companies
- Promote users to company administrators
- Demote company administrators
- Global user search and filtering

### 3. Admin Assignment
- Assign existing admins to companies
- Promote regular users to company administrators
- Change company administrators
- Handle unassigned users

### 4. Security & Access Control
- Role-based access control with proper hierarchy
- Company-level data isolation
- Firestore security rules enforcement
- Session management and validation

## Implementation Details

### Database Schema

#### Companies Collection
```javascript
{
  id: "company_id",
  name: "Company Name",
  description: "Company description",
  industry: "Industry type",
  location: "City, Country",
  adminUserId: "admin_user_id", // Company admin
  subscriptionPlan: "standard",
  monthlyFee: 60000,
  currency: "KES",
  isActive: true,
  createdAt: timestamp,
  updatedAt: timestamp,
  createdBy: "main_admin_id",
  contactEmail: "contact@company.com",
  contactPhone: "+254700000000",
  address: "Full address",
  logoUrl: null
}
```

#### Updated Users Collection
```javascript
{
  id: "user_id",
  email: "user@example.com",
  role: "MainAdmin" | "Admin" | "Supervisor" | "Operator" | "Accountant",
  companyID: "company_id", // Empty for MainAdmin
  firstName: "First",
  lastName: "Last",
  phoneNumber: "+254700000000",
  department: "Department",
  isActive: true,
  createdAt: timestamp,
  updatedAt: timestamp,
  lastLoginAt: timestamp,
  profileImageUrl: null
}
```

### Security Rules

The Firestore security rules have been updated to support the MainAdmin role:

```javascript
// MainAdmin has global access
function isMainAdmin() {
  return getUserRole() == 'MainAdmin';
}

// Companies collection - only MainAdmin can manage
match /companies/{companyId} {
  allow read: if isAuthenticated() && (isMainAdmin() || isAdmin());
  allow create, update, delete: if isAuthenticated() && isMainAdmin();
}

// Users collection - MainAdmin has global access
match /users/{userId} {
  allow read: if isAuthenticated() && (
    request.auth.uid == userId || 
    isMainAdmin() ||
    (isAdmin() && belongsToSameCompany(resource.data.companyID))
  );
  // ... other rules updated similarly
}
```

### Services

#### Company Service (`src/services/companyService.js`)
- `getAllCompanies()` - Get all companies
- `createCompany(companyData)` - Create new company
- `updateCompany(companyId, updateData)` - Update company
- `deleteCompany(companyId)` - Delete company
- `assignCompanyAdmin(companyId, adminUserId)` - Assign admin

#### Main Admin Service (`src/services/mainAdminService.js`)
- `getAllUsersGlobal()` - Get all users across companies
- `getUsersByCompanyGlobal(companyId)` - Get users by company
- `assignUserToCompany(userId, companyId)` - Assign user to company
- `promoteToCompanyAdmin(userId, companyId)` - Promote to admin
- `getGlobalUserStats()` - Get global user statistics

### Components

#### Main Admin Dashboard (`src/components/dashboards/MainAdminDashboard.jsx`)
- Overview tab with system statistics
- Company management interface
- Global user management interface

#### Company Management (`src/components/admin/CompanyManagement.jsx`)
- Company list with search and filtering
- Add/edit company modals
- Admin assignment functionality

#### Global User Management (`src/components/admin/GlobalUserManagement.jsx`)
- Global user list with filtering
- User assignment to companies
- Role promotion/demotion

## Setup Instructions

### 1. Create Main Admin User

#### Option A: Development Helper (Development Only)
```javascript
// In browser console (development only)
await createDevMainAdmin();
```

#### Option B: Manual Creation
```javascript
import { createMainAdmin } from './src/utils/createMainAdmin';

await createMainAdmin(
  'mainadmin@yourcompany.com',
  'SecurePassword123!',
  'Main Administrator'
);
```

### 2. Deploy Security Rules
```bash
firebase deploy --only firestore:rules
```

### 3. Access Main Admin Dashboard
1. Login with Main Admin credentials
2. You'll be automatically redirected to `/dashboard/main-admin`
3. Use the interface to create companies and assign administrators

## Usage Workflow

### Setting Up a New Company

1. **Main Admin logs in** and accesses the Main Admin Dashboard
2. **Create Company**: Use the Company Management interface to create a new company
3. **Assign Administrator**: 
   - Option A: Assign an existing admin user to the company
   - Option B: Promote an existing user to company admin
   - Option C: Create a new user and promote them to admin
4. **Company Admin Access**: The assigned admin can now manage their company

### Managing Users

1. **Global View**: Main Admin can see all users across all companies
2. **Company Assignment**: Assign unassigned users to companies
3. **Role Management**: Promote/demote users as needed
4. **Cross-Company Moves**: Move users between companies if needed

## Security Considerations

### Data Isolation
- Company Admins can only access their company's data
- Firestore rules enforce company-level isolation
- MainAdmin has override access for system management

### Access Control
- Role hierarchy prevents privilege escalation
- Session validation ensures secure access
- Audit logging tracks administrative actions

### Best Practices
- Limit the number of MainAdmin users
- Regularly audit user assignments and permissions
- Monitor cross-company data access
- Implement proper backup and recovery procedures

## Troubleshooting

### Common Issues

1. **MainAdmin can't access company data**
   - Check Firestore security rules deployment
   - Verify user role is set to 'MainAdmin'

2. **Company Admin can't manage users**
   - Verify admin is assigned to the company
   - Check companyID field in user documents

3. **Users can't access their company data**
   - Verify user's companyID matches company ID
   - Check user's isActive status

### Debug Tools

```javascript
// Check if MainAdmin exists
await checkMainAdminExists();

// Get user role
const userData = await getUserRole(userId);
console.log('User role:', userData.role);

// Verify company assignment
const companies = await getCompaniesByAdmin(adminUserId);
console.log('Admin companies:', companies);
```

## Future Enhancements

- Multi-tenant billing and subscription management
- Company-specific branding and customization
- Advanced reporting across companies
- API access for third-party integrations
- Automated user provisioning and deprovisioning
