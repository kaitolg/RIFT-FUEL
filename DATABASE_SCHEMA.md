# Database Schema Documentation

## Overview

This document describes the Firestore database schema for the Fuel Management System. The system uses role-based access control with company-level data isolation.

## Security Model

- **Authentication**: All operations require user authentication
- **Authorization**: Role-based access control (Admin, Supervisor, Operator, Accountant)
- **Data Isolation**: Company-level data separation using `companyID` field
- **Audit Trail**: All significant actions are logged in `audit_logs` collection

## User Roles

| Role | Permissions |
|------|-------------|
| **Admin** | Full access to all company data, user management, system configuration |
| **Supervisor** | Approve/reject fuel requests, view reports, manage approvals |
| **Operator** | Create fuel requests, dispense fuel, manage vehicles/drivers |
| **Accountant** | View financial reports, manage subscriptions, access audit logs |

## Collections

### 1. users
User profiles and authentication data.

```javascript
{
  id: "user_id", // Document ID (matches Firebase Auth UID)
  email: "user@company.com",
  role: "Admin|Supervisor|Operator|Accountant",
  companyID: "company_uuid",
  firstName: "John",
  lastName: "Doe",
  phoneNumber: "+254700000000",
  department: "Operations",
  isActive: true,
  createdAt: timestamp,
  updatedAt: timestamp,
  lastLoginAt: timestamp,
  profileImageUrl: "https://..."
}
```

**Indexes:**
- `companyID + role`

### 2. vehicles
Fleet vehicle information and status.

```javascript
{
  id: "vehicle_id",
  companyID: "company_uuid",
  plateNumber: "KCA 001A",
  make: "Toyota",
  model: "Hilux",
  year: 2022,
  fuelType: "petrol|diesel|hybrid|electric",
  fuelCapacity: 80, // liters
  currentFuelLevel: 60, // liters
  department: "Operations",
  assignedDriverId: "driver_id",
  status: "active|maintenance|inactive",
  mileage: 15000,
  lastServiceDate: timestamp,
  nextServiceDate: timestamp,
  insuranceExpiryDate: timestamp,
  registrationExpiryDate: timestamp,
  createdAt: timestamp,
  updatedAt: timestamp
}
```

**Indexes:**
- `companyID + status`
- `companyID + department`

### 3. drivers
Driver profiles and assignments.

```javascript
{
  id: "driver_id",
  companyID: "company_uuid",
  firstName: "James",
  lastName: "Mwangi",
  email: "james@company.com",
  phoneNumber: "+254700000000",
  licenseNumber: "DL001234567",
  licenseExpiryDate: timestamp,
  department: "Operations",
  employeeId: "EMP001",
  status: "active|inactive|suspended",
  assignedVehicleIds: ["vehicle_id1", "vehicle_id2"],
  createdAt: timestamp,
  updatedAt: timestamp
}
```

**Indexes:**
- `companyID + status`

### 4. fuel_requests
Fuel request submissions and tracking.

```javascript
{
  id: "request_id",
  companyID: "company_uuid",
  requestedBy: "user_id",
  vehicleId: "vehicle_id",
  driverId: "driver_id",
  fuelType: "petrol|diesel",
  requestedQuantity: 50, // liters
  estimatedCost: 7500, // KES
  purpose: "Official duty - Nairobi to Mombasa",
  urgency: "low|normal|high|emergency",
  status: "pending|approved|rejected|dispensed|cancelled",
  requestedDate: timestamp,
  requiredDate: timestamp,
  approvalId: "approval_id",
  rejectionReason: "Insufficient budget",
  createdAt: timestamp,
  updatedAt: timestamp
}
```

**Indexes:**
- `companyID + status + createdAt`
- `companyID + requestedBy + createdAt`
- `companyID + vehicleId + createdAt`

### 5. approvals
Approval workflow records.

```javascript
{
  id: "approval_id",
  companyID: "company_uuid",
  requestId: "request_id",
  requestType: "fuel_request",
  approvedBy: "user_id",
  status: "pending|approved|rejected",
  approvedQuantity: 45, // liters (may be less than requested)
  approvedCost: 6750, // KES
  comments: "Approved with reduced quantity",
  approvedAt: timestamp,
  createdAt: timestamp,
  updatedAt: timestamp
}
```

**Indexes:**
- `companyID + status + createdAt`
- `companyID + approvedBy + createdAt`

### 6. fuel_dispenses
Actual fuel dispensing records.

```javascript
{
  id: "dispense_id",
  companyID: "company_uuid",
  requestId: "request_id",
  approvalId: "approval_id",
  vehicleId: "vehicle_id",
  driverId: "driver_id",
  dispensedBy: "user_id",
  fuelType: "petrol|diesel",
  requestedQuantity: 50,
  dispensedQuantity: 48, // actual amount dispensed
  costPerLiter: 150, // KES
  totalCost: 7200, // KES
  odometerReading: 15500,
  pumpNumber: "PUMP_01",
  receiptNumber: "RCP001234",
  dispensedAt: timestamp,
  createdAt: timestamp
}
```

**Indexes:**
- `companyID + vehicleId + dispensedAt`
- `companyID + dispensedBy + dispensedAt`

### 7. notifications
User notifications and alerts.

```javascript
{
  id: "notification_id",
  companyID: "company_uuid",
  userId: "user_id",
  type: "fuel_request|approval|rejection|low_stock|subscription",
  title: "Fuel Request Approved",
  message: "Your fuel request for KCA 001A has been approved",
  data: {
    requestId: "request_id",
    vehicleId: "vehicle_id"
  },
  read: false,
  actionUrl: "/requests/request_id",
  createdAt: timestamp
}
```

**Indexes:**
- `companyID + userId + createdAt`
- `companyID + read + createdAt`

### 8. subscriptions
Company subscription management.

```javascript
{
  id: "subscription_id",
  companyID: "company_uuid",
  planType: "basic|standard|premium",
  status: "active|expired|cancelled|pending",
  startDate: timestamp,
  endDate: timestamp,
  monthlyFee: 60000, // KES
  currency: "KES",
  paymentMethod: "bank_transfer|mpesa|card",
  lastPaymentDate: timestamp,
  nextPaymentDate: timestamp,
  autoRenew: true,
  features: [
    "unlimited_vehicles",
    "unlimited_drivers",
    "fuel_tracking",
    "approval_workflow",
    "reporting_analytics",
    "mobile_app",
    "email_notifications"
  ],
  createdAt: timestamp,
  updatedAt: timestamp
}
```

**Indexes:**
- `companyID + status`

### 9. audit_logs
System audit trail for compliance and security.

```javascript
{
  id: "log_id",
  companyID: "company_uuid",
  userId: "user_id",
  action: "create|update|delete|approve|reject|dispense",
  resource: "users|vehicles|fuel_requests|approvals|fuel_dispenses",
  resourceId: "resource_id",
  oldData: { /* previous state */ },
  newData: { /* new state */ },
  ipAddress: "192.168.1.100",
  userAgent: "Mozilla/5.0...",
  timestamp: timestamp
}
```

**Indexes:**
- `companyID + action + timestamp`
- `companyID + userId + timestamp`

## Security Rules

The Firestore security rules implement:

1. **Authentication Check**: All operations require valid authentication
2. **Company Isolation**: Users can only access data from their company
3. **Role-Based Access**: Different permissions based on user role
4. **Resource Ownership**: Users can access their own data
5. **Audit Integrity**: Audit logs cannot be modified or deleted

## Usage Examples

### Initialize Database
```javascript
import DatabaseInitializer from './utils/databaseInitializer';

// Initialize sample data for a company
const data = await DatabaseInitializer.initializeCompanyData(
  'company_123',
  'Demo Company Ltd'
);
```

### Create Fuel Request
```javascript
import { FuelRequestService } from './services/collectionServices';

const request = await FuelRequestService.createFuelRequest({
  companyID: 'company_123',
  requestedBy: 'user_123',
  vehicleId: 'vehicle_456',
  driverId: 'driver_789',
  fuelType: 'diesel',
  requestedQuantity: 50,
  estimatedCost: 7500,
  purpose: 'Official duty',
  urgency: 'normal'
});
```

### Query Company Vehicles
```javascript
import { VehicleService } from './services/collectionServices';

const vehicles = await VehicleService.getVehiclesByCompany('company_123');
const activeVehicles = await VehicleService.getActiveVehicles('company_123');
```

## Best Practices

1. **Always include companyID** in queries for data isolation
2. **Use batch operations** for multiple related updates
3. **Log significant actions** in audit_logs for compliance
4. **Validate data** before writing to collections
5. **Use transactions** for operations that must be atomic
6. **Index frequently queried fields** for performance
7. **Implement proper error handling** for all database operations

## Migration and Maintenance

- Use Firebase Console for manual data management
- Implement data migration scripts for schema changes
- Regular backup of critical data
- Monitor query performance and optimize indexes
- Review security rules regularly for compliance
