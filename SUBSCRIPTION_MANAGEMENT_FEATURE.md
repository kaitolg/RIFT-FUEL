# Company Subscription & Access Management Feature

## Overview

This feature adds comprehensive subscription and access management functionality to the RiftFuel company management system. Main Admins can now view, manage, and control company subscriptions and access permissions with detailed oversight capabilities.

## Features Implemented

### 1. Enhanced Company Management Dashboard

**Location:** `src/components/admin/CompanyManagement.jsx`

**New Features:**
- **Subscription Status Overview**: Visual indicators showing subscription status for each company
- **Access Control Filters**: Filter companies by subscription status (Active, Expired, Suspended)
- **Enhanced Statistics**: New metrics including active subscriptions, expired subscriptions, and suspended companies
- **Quick Actions**: Direct access to subscription management from the company list

**New Statistics Cards:**
- Total Companies
- Active Subscriptions
- Expired Subscriptions
- Suspended Companies
- Companies with Admin
- Companies without Admin

### 2. Company Subscription Modal

**Location:** `src/components/admin/CompanySubscriptionModal.jsx`

**Tabs:**
1. **Overview Tab**
   - Company information summary
   - Current subscription status
   - Quick action buttons (Suspend/Activate, Extend subscription)

2. **Subscription Details Tab**
   - Edit subscription plan type (Basic, Standard, Premium)
   - Modify monthly fee and currency
   - Toggle auto-renewal settings
   - Update subscription status

3. **Access Control Tab**
   - System access management
   - Suspend/activate company access
   - View current access status and history

**Quick Actions:**
- Suspend/Activate company access
- Extend subscription (1 month or 1 year)
- Update subscription details
- View subscription history

### 3. Enhanced Company List

**Location:** `src/components/admin/CompanyList.jsx`

**New Columns:**
- **Subscription Status**: Visual badge showing subscription status with monthly fee
- **Enhanced Actions**: New action buttons for subscription management

**New Action Buttons:**
- **Subscription**: Opens detailed subscription management modal
- **Suspend/Activate**: Quick access control toggle
- **Edit**: Company details editing
- **Admin**: Assign/change company administrator
- **Delete**: Remove company (with confirmation)

### 4. Subscription Management Service

**Location:** `src/services/subscriptionManagementService.js`

**Functions:**
- `getCompanySubscriptions()`: Fetch all company subscriptions
- `getCompanySubscription(companyId)`: Get specific company subscription
- `updateCompanySubscription(companyId, data)`: Create/update subscription
- `suspendCompany(companyId)`: Suspend company access
- `activateCompany(companyId)`: Activate company access
- `extendSubscription(companyId, months)`: Extend subscription period
- `getSubscriptionAnalytics()`: Get subscription analytics

### 5. Demo Data Service

**Location:** `src/services/demoSubscriptionData.js`

**Purpose:** Provides demo data for testing and development when Firebase is not available

**Demo Companies:**
- TechCorp Solutions (Premium, Active)
- LogiFlow Ltd (Standard, Suspended)
- GreenEnergy Co (Standard, Expired)
- AgriTech Innovations (No subscription)

### 6. Subscription Status Badge Component

**Location:** `src/components/admin/SubscriptionStatusBadge.jsx`

**Features:**
- Visual status indicators with icons
- Subscription details display
- Quick action components
- Reusable across the application

## Usage Instructions

### For Main Admins

1. **Access Company Management**
   - Navigate to `/dashboard/main-admin/companies`
   - Only Main Admins have access to this feature

2. **View Subscription Overview**
   - Statistics cards show subscription metrics at a glance
   - Use filters to view companies by subscription status

3. **Manage Individual Company Subscriptions**
   - Click "Subscription" button in the company list
   - Use the modal tabs to manage different aspects:
     - Overview: Quick actions and status summary
     - Subscription Details: Modify subscription settings
     - Access Control: Manage system access

4. **Quick Actions**
   - **Suspend Company**: Immediately revoke system access
   - **Activate Company**: Restore system access
   - **Extend Subscription**: Add 1 month or 1 year to subscription
   - **Update Details**: Modify subscription plan and pricing

### Subscription Status Types

- **Active**: Company has valid subscription and system access
- **Expired**: Subscription has ended, may need renewal
- **Suspended**: Access temporarily revoked by admin
- **Pending**: New subscription awaiting activation

### Access Control Decisions

**When to Suspend:**
- Non-payment of subscription fees
- Policy violations
- Security concerns
- Temporary service interruption

**When to Activate:**
- Payment received
- Issues resolved
- New subscription created

## Technical Implementation

### Database Schema

**Subscriptions Collection:**
```javascript
{
  id: "subscription_id",
  companyID: "company_uuid",
  planType: "basic|standard|premium",
  status: "active|expired|suspended|pending",
  monthlyFee: 60000, // KES
  currency: "KES",
  autoRenew: true,
  startDate: timestamp,
  endDate: timestamp,
  lastPaymentDate: timestamp,
  nextPaymentDate: timestamp,
  features: ["unlimited_vehicles", "fuel_tracking", ...],
  createdAt: timestamp,
  updatedAt: timestamp
}
```

**Companies Collection (Enhanced):**
```javascript
{
  // ... existing fields
  accessStatus: "active|suspended",
  suspendedAt: timestamp,
  // ... other fields
}
```

### Security Rules

- Only Main Admins can access subscription management
- Company-level data isolation maintained
- Audit logging for all subscription changes

### Error Handling

- Graceful fallback to demo data when Firebase is unavailable
- User-friendly error messages
- Loading states for all async operations

## Future Enhancements

1. **Payment Integration**
   - M-Pesa integration for automatic payments
   - Payment history tracking
   - Invoice generation

2. **Automated Notifications**
   - Email alerts for subscription expiry
   - Payment reminders
   - Access suspension notifications

3. **Advanced Analytics**
   - Revenue tracking
   - Subscription trends
   - Company usage metrics

4. **Bulk Operations**
   - Mass subscription updates
   - Bulk access control changes
   - Export/import functionality

## Testing

The feature includes comprehensive demo data for testing:
- Multiple companies with different subscription states
- Realistic subscription data
- Fallback mechanisms for offline testing

To test:
1. Log in as Main Admin
2. Navigate to Company Management
3. Explore different subscription statuses
4. Test suspension/activation workflows
5. Verify access control restrictions

## Files Modified/Created

### New Files:
- `src/components/admin/CompanySubscriptionModal.jsx`
- `src/components/admin/SubscriptionStatusBadge.jsx`
- `src/services/subscriptionManagementService.js`
- `src/services/demoSubscriptionData.js`

### Modified Files:
- `src/components/admin/CompanyManagement.jsx`
- `src/components/admin/CompanyList.jsx`
- `src/services/companyService.js`

This feature provides Main Admins with comprehensive tools to manage company subscriptions and access, enabling better control over the RiftFuel platform and ensuring proper subscription compliance.
