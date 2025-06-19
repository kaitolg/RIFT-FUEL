# React Firebase Authentication App

A complete authentication system built with React, Firebase, and TailwindCSS featuring role-based access control.

## Features

- **User Authentication**
  - Sign up with email and password
  - Sign in with email and password
  - Password reset functionality
  - Email verification
  - Logout functionality

- **Role-Based Access Control**
  - Admin: Full system access and comprehensive user management
  - Operator: Operational tasks and process monitoring
  - Accountant: Financial reports and accounting functions

- **User Management (Admin Only)**
  - View all users with detailed information
  - Add new users with role assignment
  - Edit user information and roles
  - Activate/deactivate user accounts
  - Delete users permanently
  - Search and filter users
  - User statistics and analytics

- **User-to-Company Migration (Main Admin Only)**
  - Associate existing users to companies while maintaining roles
  - Distribute users evenly across companies or assign to specific company
  - Preview migration changes before applying them
  - Force migration for users already assigned to companies
  - Exclude main administrators from company association
  - Web interface and command-line tools available
  - Comprehensive error handling and audit logging

- **Fleet Management (Admin & Operator)**
  - Add, edit, and delete vehicles
  - Assign drivers to vehicles
  - Track vehicle details (name, plate number, fuel type, mileage)
  - Vehicle status management (active, maintenance, inactive)
  - Search and filter vehicles
  - Real-time fleet statistics
  - Driver assignment warnings and management

- **Fuel Request Management (All Roles)**
  - Multi-step fuel request form with validation
  - Vehicle selection and fuel type specification
  - Optional image upload for supporting documents
  - Complete approval workflow (pending → approved → dispensed)
  - Role-based permissions and access control
  - Real-time request tracking and status updates
  - Communication system with notes and comments
  - Search and filter capabilities

- **Supervisor Approval Dashboard (Supervisor Only)**
  - Dedicated approval interface with status-based organization
  - Enhanced approval actions with bulk operations
  - Complete request history tracking and analytics
  - Priority-based processing with visual indicators
  - Advanced filtering and search capabilities
  - Real-time statistics and performance metrics
  - Streamlined workflow for efficient approval management

- **Fuel Dispensing Module (Admin, Operator, Supervisor)**
  - Record actual fuel dispensed with operator details
  - Automatic internal tank inventory management
  - Manual data entry with validation and auto-fill
  - Real-time inventory monitoring with low stock alerts
  - Cost tracking and dispensing analytics
  - Integration with fuel request system
  - Sensor API ready architecture for future automation

- **Security Features**
  - Protected routes
  - Email verification requirement
  - Role-based page access
  - Secure Firebase authentication

- **Modern UI**
  - Responsive design with TailwindCSS
  - Clean and professional interface
  - Role-specific dashboards

## Setup Instructions

### 1. Firebase Configuration

1. Go to the [Firebase Console](https://console.firebase.google.com/)
2. Create a new project or select an existing one
3. Enable Authentication:
   - Go to Authentication > Sign-in method
   - Enable "Email/Password" provider
4. Enable Firestore Database:
   - Go to Firestore Database
   - Create database in test mode
5. Get your Firebase configuration:
   - Go to Project Settings > General
   - Scroll down to "Your apps" section
   - Click on the web app icon or "Add app" if none exists
   - Copy the Firebase configuration object

### 2. Update Firebase Configuration

Edit `src/firebase/config.js` and replace the placeholder values with your actual Firebase configuration:

```javascript
const firebaseConfig = {
  apiKey: "your-actual-api-key",
  authDomain: "your-project.firebaseapp.com",
  projectId: "your-actual-project-id",
  storageBucket: "your-project.appspot.com",
  messagingSenderId: "your-actual-sender-id",
  appId: "your-actual-app-id"
};
```

### 3. Install Dependencies

```bash
npm install
```

### 4. Create Test Users (Optional)

For testing purposes, you can create pre-configured test users:

```bash
# Create all test users for all companies
npm run create-test-users

# Preview what would be created (dry run)
npm run create-test-users:dry-run

# Create users for specific company only
npm run create-test-users -- --company-id COMP-001
```

### 5. User-to-Company Migration (Optional)

If you have existing users that need to be associated with companies:

```bash
# Migrate all unassigned users to companies (distributed evenly)
npm run migrate-users

# Preview migration without making changes
npm run migrate-users:dry-run

# Force migration (include users already assigned to companies)
npm run migrate-users:force

# Assign all users to a specific company
node scripts/migrate-users-to-companies.js --company-id COMP-001
```

**Web Interface**: Main Admins can also use the migration panel in the Main Admin Dashboard → User Migration tab.

**Main Admin Credentials:**
- **Main Admin**: admin@riftfuel.com / MainAdmin2024!

**Note**: All company-specific demo users have been removed. Use the Main Admin to create companies and assign administrators.

See [TEST_USERS.md](TEST_USERS.md) for complete credentials list and [FIREBASE_SETUP.md](FIREBASE_SETUP.md) for setup instructions.

### 6. Run the Application

```bash
npm run dev
```

The application will be available at `http://localhost:5173`

## Project Structure

```
src/
├── components/
│   ├── admin/
│   │   ├── UserManagement.jsx
│   │   ├── UserList.jsx
│   │   ├── AddUserModal.jsx
│   │   └── EditUserModal.jsx
│   ├── fleet/
│   │   ├── FleetManagement.jsx
│   │   ├── VehicleList.jsx
│   │   ├── AddVehicleModal.jsx
│   │   ├── EditVehicleModal.jsx
│   │   └── AssignDriverModal.jsx
│   ├── fuel/
│   │   ├── FuelRequestManagement.jsx
│   │   ├── FuelRequestForm.jsx
│   │   ├── FuelRequestList.jsx
│   │   ├── FuelRequestDetails.jsx
│   │   ├── SupervisorApprovalDashboard.jsx
│   │   ├── FuelDispensingManagement.jsx
│   │   ├── FuelDispensingForm.jsx
│   │   ├── FuelDispensingList.jsx
│   │   └── FuelInventoryDashboard.jsx
│   ├── auth/
│   │   ├── Login.jsx
│   │   ├── Signup.jsx
│   │   ├── PasswordReset.jsx
│   │   └── EmailVerification.jsx
│   ├── dashboards/
│   │   ├── AdminDashboard.jsx
│   │   ├── OperatorDashboard.jsx
│   │   └── AccountantDashboard.jsx
│   ├── DashboardRouter.jsx
│   ├── ProtectedRoute.jsx
│   └── Unauthorized.jsx
├── contexts/
│   └── AuthContext.jsx
├── firebase/
│   └── config.js
├── services/
│   ├── userService.js
│   ├── fleetService.js
│   ├── fuelRequestService.js
│   ├── fuelInventoryService.js
│   └── fuelDispensingService.js
├── utils/
│   ├── demoData.js
│   ├── fleetDemoData.js
│   └── fuelRequestDemoData.js
├── App.jsx
├── main.jsx
└── style.css
```

## User Roles

### Admin
- Full system access
- **Comprehensive User Management:**
  - View all users in a searchable, filterable table
  - Add new users with automatic password reset email
  - Edit user information (name, role, company ID, status)
  - Assign and change user roles (Admin, Operator, Accountant)
  - Activate/deactivate user accounts
  - Delete users permanently
  - Real-time user statistics dashboard
  - Search users by name, email, or company ID
  - Filter users by role or status
- System settings
- Reports and analytics
- Data management
- Security controls

### Operator
- Process monitoring
- Task management
- Inventory tracking
- Quality control
- Maintenance logs
- Operational reports
- **Fleet Management:**
  - Add, edit, and delete vehicles
  - Assign drivers to vehicles
  - Update vehicle status and information
  - Search and filter fleet
  - Monitor fleet statistics

### Accountant
- Financial reports
- Accounts payable/receivable
- General ledger
- Budget analysis
- Tax management
- Financial statistics
- **Fuel Request Tracking:**
  - View all fuel requests for expense tracking
  - Monitor fuel costs and consumption
  - Generate fuel expense reports
  - Track internal vs external fuel costs

### Supervisor
- Fuel request approval management
- Fleet oversight and monitoring
- Performance analytics and reporting
- **Supervisor Approval Dashboard:**
  - Status-based request organization (pending, approved, dispensed, rejected)
  - Enhanced approval actions with bulk operations
  - Complete request history tracking and timeline
  - Priority-based processing with visual indicators
  - Advanced filtering and search capabilities
  - Real-time statistics and performance metrics

## User Data Structure

Each user in the system has the following metadata stored in Firestore:

```javascript
{
  id: "firebase-user-uid",
  email: "user@example.com",
  displayName: "John Doe",
  role: "Admin" | "Operator" | "Accountant" | "Supervisor",
  companyID: "COMP-123", // Optional company identifier
  isActive: true, // User account status
  emailVerified: false, // Email verification status
  createdAt: "2024-01-01T00:00:00.000Z",
  updatedAt: "2024-01-01T00:00:00.000Z",
  createdBy: "admin-user-uid", // Who created this user
  updatedBy: "admin-user-uid"  // Who last updated this user
}
```

## Usage

1. **Sign Up**: Create a new account with email, password, name, role, and optional company ID
2. **Email Verification**: Check your email and click the verification link
3. **Sign In**: Use your credentials to log in
4. **Dashboard Access**: You'll be redirected to your role-specific dashboard
5. **Password Reset**: Use the "Forgot Password" link if needed

### Admin User Management

1. **Access User Management**: Click "User Management" tab in Admin Dashboard
2. **View Users**: See all users with their roles, status, and metadata
3. **Add Users**: Click "Add User" to create new accounts
4. **Edit Users**: Click "Edit" on any user to modify their information
5. **Manage Status**: Activate/deactivate users or delete them permanently
6. **Search & Filter**: Use search bar and role filters to find specific users

### Fleet Management (Admin & Operator)

1. **Access Fleet Management**: Click "Fleet Management" tab in Admin/Operator Dashboard
2. **View Vehicles**: See all vehicles with details, status, and assigned drivers
3. **Add Vehicles**: Click "Add Vehicle" to register new vehicles
4. **Edit Vehicles**: Click "Edit" to modify vehicle information
5. **Assign Drivers**: Use "Assign Driver" to manage driver-vehicle relationships
6. **Update Status**: Change vehicle status (active, maintenance, inactive)
7. **Search & Filter**: Find vehicles by name, plate number, fuel type, or status

### Fuel Request Management (All Roles)

1. **Access Fuel Requests**: Click "Fuel Requests" tab in your Dashboard
2. **Create Request**: Click "New Fuel Request" to start multi-step form
   - **Step 1**: Select vehicle from active vehicles
   - **Step 2**: Specify fuel type and liters needed
   - **Step 3**: Choose fuel source and provide reason
   - **Step 4**: Optional image upload and final review
3. **Track Requests**: View your submitted requests and their status
4. **Approval Workflow** (Admin/Operator only):
   - Approve pending requests
   - Reject requests with reasons
   - Mark approved requests as dispensed
5. **Communication**: Add notes to requests for team communication
6. **Search & Filter**: Find requests by vehicle, status, or requester

### Supervisor Approval Dashboard (Supervisor Only)

1. **Access Approval Dashboard**: Click "Fuel Approvals" tab in Supervisor Dashboard
2. **Status-Based Organization**: View requests organized by status tabs
   - **Pending**: Requests awaiting approval (primary focus)
   - **Approved**: Requests ready for fuel dispensing
   - **Dispensed**: Completed fuel dispensing records
   - **Rejected**: Rejected requests with reasons
3. **Individual Request Management**:
   - **Quick Approve**: One-click approval for valid requests
   - **Quick Reject**: Inline rejection with mandatory reason
   - **View History**: Complete timeline and processing analytics
   - **Mark Dispensed**: Update approved requests to dispensed status
4. **Bulk Operations**:
   - Select multiple requests using checkboxes
   - Perform bulk approve, reject, or dispense operations
   - Add remarks to all selected requests simultaneously
5. **Advanced Filtering**:
   - Filter by date (today, this week, this month, all time)
   - Search by vehicle, requester, plate number, or reason
   - Combine multiple filters for precise results
6. **Priority Processing**: Focus on high-priority requests (older than 24 hours)

### Fuel Dispensing Module (Admin, Operator, Supervisor)

1. **Access Fuel Dispensing**: Click "Fuel Dispensing" tab in your Dashboard
2. **Record New Dispensing**: Click "Record Dispensing" button
   - **Option A - From Approved Request**: Select approved fuel request from dropdown
   - **Option B - Manual Entry**: Select vehicle and enter details manually
3. **Complete Dispensing Details**:
   - Enter actual liters dispensed
   - Specify operator name and dispensing date/time
   - Add location, pump ID, and cost information
   - Include receipt number and notes if applicable
4. **Automatic Inventory Management**:
   - Internal tank stock automatically deducted
   - Real-time inventory level updates
   - Low stock alerts when below thresholds
5. **Inventory Monitoring**:
   - View real-time tank levels with visual progress bars
   - Monitor utilization percentages and alerts
   - Refill tanks with reason tracking
6. **Analytics & Reporting**:
   - Track total dispensings and fuel consumption
   - Monitor costs and operator performance
   - Search and filter dispensing records

## Security Notes

- Email verification is required before accessing protected routes
- Users can only access pages appropriate for their role
- Firebase handles secure authentication and session management
- All routes are protected and redirect unauthorized users

## Technologies Used

- **React 18**: Frontend framework
- **Firebase 11**: Authentication and database
- **React Router 7**: Client-side routing
- **TailwindCSS 4**: Styling and responsive design
- **Vite**: Build tool and development server

## Development

To add new features or modify existing ones:

1. **Add new routes**: Update `App.jsx` with new route definitions
2. **Create new components**: Add components in the appropriate directory
3. **Modify user roles**: Update the role logic in `AuthContext.jsx`
4. **Style changes**: Use TailwindCSS classes for consistent styling

## Deployment

1. Build the project: `npm run build`
2. Deploy the `dist` folder to your hosting service
3. Configure Firebase hosting rules if using Firebase Hosting
4. Update Firebase configuration for production domain

## Troubleshooting

- **Firebase errors**: Check your Firebase configuration and ensure services are enabled
- **Email verification**: Check spam folder and ensure SMTP is configured in Firebase
- **Role issues**: Verify user roles are correctly stored in Firestore
- **Routing problems**: Ensure React Router is properly configured

## License

This project is open source and available under the MIT License.
