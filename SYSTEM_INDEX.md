# RiftFuel System Index

## 🏗️ System Overview

RiftFuel is a comprehensive fuel management system built with React, Firebase, and modern web technologies. It provides multi-company fuel request management with role-based access control, real-time notifications, and PWA capabilities.

### Core Technologies
- **Frontend**: React 19.1.0 + Vite 6.3.5
- **Backend**: Firebase (Firestore, Auth, Functions, Storage)
- **Styling**: TailwindCSS 4.1.10
- **Charts**: Recharts 2.15.3
- **PWA**: Vite PWA Plugin + Workbox
- **Deployment**: Vercel + Firebase

## 🏢 Business Model

### Pricing
- **Monthly Subscription**: Kshs 60,000/month per company
- **Founder**: Geoffrey Kimani
- **Branding**: Matt Green color scheme

### Target Market
- Fleet management companies
- Organizations with vehicle fleets
- Companies requiring fuel tracking and approval workflows

## 🔐 User Roles & Permissions

### Role Hierarchy
```
MainAdmin (Super Admin)
├── Company A
│   ├── Admin (Company Admin)
│   ├── Supervisor
│   ├── Operator
│   └── Accountant
├── Company B
│   └── [Same structure]
```

### Role Permissions
| Role | Permissions |
|------|-------------|
| **MainAdmin** | Global access, company management, system oversight |
| **Admin** | Company-scoped access, user management, full operations |
| **Supervisor** | Approve/reject requests, view reports, manage approvals |
| **Operator** | Create requests, dispense fuel, manage vehicles/drivers |
| **Accountant** | Financial reports, audit logs, subscription management |

## 📊 Database Schema

### Core Collections
1. **users** - User profiles with role-based access
2. **companies** - Multi-tenant company management
3. **vehicles** - Fleet vehicle information
4. **drivers** - Driver profiles and assignments
5. **fuel_requests** - Request submissions and tracking
6. **approvals** - Approval workflow records
7. **fuel_dispenses** - Actual dispensing records
8. **notifications** - User alerts and messages
9. **subscriptions** - Billing and feature management
10. **audit_logs** - System audit trail

### Security Model
- **Authentication**: Firebase Auth with email verification
- **Authorization**: Role-based access control
- **Data Isolation**: Company-level separation using `companyID`
- **Audit Trail**: Immutable logging of all significant actions

## 🏗️ Application Architecture

### Entry Points
- **Main App**: `src/App.jsx` - Root component with routing
- **Main Entry**: `src/main.jsx` - React DOM rendering + PWA registration
- **Firebase Config**: `src/firebase/config.js` - Firebase initialization

### Routing Structure
```
/ - Landing page
/login, /signup - Authentication
/dashboard/* - Protected dashboard routes
  ├── /main-admin - MainAdmin dashboard
  ├── /requests - Fuel request management
  ├── /dispensing - Fuel dispensing
  ├── /analytics - Fuel analytics
  ├── /fleet - Vehicle/driver management
  ├── /approvals - Approval workflows
  ├── /billing - Subscription management
  └── /reports - Admin reporting
```

### Context Providers
- **AuthContext** (`src/contexts/AuthContext.jsx`)
  - User authentication state
  - Role-based permissions
  - Session management
  - Activity tracking

- **NotificationContext** (`src/contexts/NotificationContext.jsx`)
  - Real-time notifications
  - Push notification handling
  - Notification state management

## 🔧 Core Services

### Authentication & Authorization
- **AuthContext**: Session management, role validation
- **useAuth Hook**: Authentication utilities
- **ProtectedRoute**: Route-level access control
- **Session Manager**: Automatic logout, activity tracking

### Database Services
- **databaseService.js**: Core Firestore operations
- **collectionServices.js**: Collection-specific CRUD operations
- **userService.js**: User management
- **companyService.js**: Company management
- **mainAdminService.js**: Global admin operations

### Business Logic Services
- **fuelRequestService.js**: Fuel request workflow
- **fuelDispensingService.js**: Dispensing operations
- **fuelAnalyticsService.js**: Analytics and reporting
- **fleetService.js**: Vehicle/driver management
- **subscriptionManagementService.js**: Billing operations
- **auditLogService.js**: Audit trail management

### Communication Services
- **emailService.js**: Email notifications
- **notificationService.js**: In-app notifications
- **pushNotificationService.js**: FCM push notifications

## 🔌 API Documentation

### Firebase Cloud Functions API
- **Base URL**: `https://us-central1-riftfuel-ba023.cloudfunctions.net`
- **Authentication**: Firebase Auth tokens
- **Rate Limiting**: Firebase default limits

### Core API Endpoints

#### Authentication Endpoints
```javascript
// User Registration
POST /api/auth/register
Body: { email, password, displayName, companyName }
Response: { user, company, token }

// User Login
POST /api/auth/login
Body: { email, password }
Response: { user, token, permissions }

// Password Reset
POST /api/auth/reset-password
Body: { email }
Response: { success, message }
```

#### Fuel Request Endpoints
```javascript
// Create Fuel Request
POST /api/fuel-requests
Headers: { Authorization: "Bearer <token>" }
Body: { vehicleId, driverId, fuelType, quantity, purpose }
Response: { requestId, status, estimatedCost }

// Get Fuel Requests
GET /api/fuel-requests?status=pending&limit=20
Headers: { Authorization: "Bearer <token>" }
Response: { requests[], pagination }

// Update Request Status
PUT /api/fuel-requests/{requestId}/status
Body: { status, comments, approvedQuantity }
Response: { success, updatedRequest }
```

#### Fleet Management Endpoints
```javascript
// Get Vehicles
GET /api/vehicles?department=operations
Headers: { Authorization: "Bearer <token>" }
Response: { vehicles[], total }

// Create Vehicle
POST /api/vehicles
Body: { plateNumber, make, model, fuelType, capacity }
Response: { vehicleId, vehicle }

// Get Drivers
GET /api/drivers?status=active
Response: { drivers[], total }
```

#### Analytics Endpoints
```javascript
// Fuel Analytics
GET /api/analytics/fuel?period=monthly&year=2024
Response: { consumption, costs, trends }

// Fleet Analytics
GET /api/analytics/fleet?vehicleId=123
Response: { efficiency, maintenance, usage }
```

### API Response Format
```javascript
// Success Response
{
  "success": true,
  "data": { /* response data */ },
  "message": "Operation completed successfully",
  "timestamp": "2024-01-15T10:30:00Z"
}

// Error Response
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid input data",
    "details": { /* validation errors */ }
  },
  "timestamp": "2024-01-15T10:30:00Z"
}
```

### API Security
- **Authentication**: Firebase Auth JWT tokens
- **Authorization**: Role-based access control
- **Rate Limiting**: 1000 requests/hour per user
- **Input Validation**: Comprehensive request validation
- **CORS**: Configured for allowed origins

## 🎯 Key Features

### Fuel Management Workflow
1. **Request Creation** (Operator/Admin)
   - Multi-step form with validation
   - Vehicle/driver selection
   - Purpose and urgency specification
   - Image attachment support

2. **Approval Process** (Accountant)
   - Request review and validation
   - Quantity/cost adjustments
   - Approval/rejection with comments
   - Email notifications

3. **Fuel Dispensing** (Supervisor/Admin)
   - Actual dispensing tracking
   - Odometer readings
   - Receipt management
   - Inventory updates

### Fleet Management
- **Vehicle Management**: Registration, maintenance, fuel levels
- **Driver Management**: License tracking, assignments
- **Department Organization**: Role-based access by department

### Analytics & Reporting
- **Fuel Analytics Dashboard**: Consumption trends, cost analysis
- **Admin Reporting**: Usage by vehicle/driver, approval logs
- **Audit Logs**: Compliance tracking, security monitoring

### Subscription Management
- **Billing Dashboard**: Invoice generation, payment tracking
- **Feature Access Control**: Subscription-based feature gating
- **Multi-company Billing**: Separate billing per company

## 📱 PWA Implementation

### Service Worker Features
- **Offline Caching**: Static assets, Firebase resources
- **Auto-Update**: Automatic service worker updates
- **Background Sync**: Offline request queuing
- **Push Notifications**: FCM integration

### Mobile Optimization
- **Responsive Design**: Mobile-first TailwindCSS
- **Touch-Friendly UI**: Optimized for mobile interaction
- **Offline Functionality**: Core features work offline

## 🔔 Notification System

### Notification Types
- **Fuel Requests**: New request alerts
- **Approvals**: Approval/rejection notifications
- **Low Stock**: Inventory alerts
- **Subscription**: Billing reminders

### Delivery Channels
- **In-App**: Real-time Firestore listeners
- **Email**: SMTP via Firebase Functions
- **Push**: FCM for mobile notifications

## 🚨 Error Handling & Monitoring

### Error Tracking System
- **Client-Side Errors**: React Error Boundaries
  - Component: `ErrorBoundary.jsx`
  - Fallback UI for component crashes
  - Error reporting to monitoring service

- **Service Layer Errors**: Comprehensive error handling
  - Try-catch blocks in all services
  - Structured error responses
  - Error classification (user, system, network)

- **Firebase Errors**: Specific error handling
  - Authentication errors
  - Firestore permission errors
  - Network connectivity issues
  - Quota exceeded handling

### Application Monitoring
- **Performance Monitoring**: Firebase Performance
  - Page load times
  - Network request monitoring
  - Custom performance traces
  - Real user monitoring (RUM)

- **Analytics Integration**: Firebase Analytics
  - User behavior tracking
  - Custom event logging
  - Conversion funnel analysis
  - Crash reporting

- **Error Logging**: Structured logging
  - Console logging with levels
  - Error context preservation
  - User session information
  - Stack trace capture

### Error Recovery Strategies
- **Retry Logic**: Automatic retry for transient failures
- **Graceful Degradation**: Fallback functionality
- **Offline Handling**: Service worker error management
- **User Feedback**: Error notification system

```javascript
// Error Handling Example
try {
  await fuelRequestService.createRequest(requestData);
} catch (error) {
  console.error('Fuel request creation failed:', error);

  if (error.code === 'permission-denied') {
    showNotification('Access denied. Please check your permissions.', 'error');
  } else if (error.code === 'network-error') {
    showNotification('Network error. Please try again.', 'warning');
  } else {
    showNotification('An unexpected error occurred.', 'error');
    // Log to monitoring service
  }
}
```

## 🛡️ Security Implementation

### Authentication Security
- **Email Verification**: Required for account activation
- **Session Management**: Automatic timeout, activity tracking
- **Password Security**: Firebase Auth password policies
- **Multi-Factor Authentication**: Planned enhancement

### Authorization Security
- **Firestore Rules**: Server-side access control
- **Role Validation**: Client and server-side checks
- **Company Isolation**: Strict data separation
- **API Security**: Request validation and sanitization

### Input Validation & Sanitization
- **Client-Side Validation**: Form validation with Yup/Zod
- **Server-Side Validation**: Firebase Functions validation
- **XSS Protection**: Content sanitization
- **SQL Injection Prevention**: Parameterized queries

### Data Protection
- **Encryption at Rest**: Firebase default encryption
- **Encryption in Transit**: HTTPS/TLS enforcement
- **Sensitive Data Handling**: PII protection
- **Data Masking**: Sensitive field obfuscation

### Security Headers
```javascript
// Vercel security headers
{
  "headers": [
    {
      "source": "/(.*)",
      "headers": [
        {
          "key": "X-Content-Type-Options",
          "value": "nosniff"
        },
        {
          "key": "X-Frame-Options",
          "value": "DENY"
        },
        {
          "key": "X-XSS-Protection",
          "value": "1; mode=block"
        }
      ]
    }
  ]
}
```

### Audit & Compliance
- **Audit Logs**: All significant actions logged
- **Data Integrity**: Immutable audit records
- **Access Monitoring**: User activity tracking
- **Compliance Reporting**: Automated compliance checks

## 🚀 Deployment & DevOps

### Development Environment
- **Local Development**: Vite dev server
- **Firebase Emulators**: Local testing environment
- **Test Scripts**: Automated testing utilities

### Production Deployment
- **Frontend**: Vercel deployment
- **Backend**: Firebase hosting
- **CI/CD**: GitHub integration
- **Monitoring**: Firebase Analytics

## 🚀 CI/CD Pipeline & Deployment

### Deployment Pipeline
```yaml
# GitHub Actions Workflow
name: Deploy RiftFuel
on:
  push:
    branches: [main, staging]
  pull_request:
    branches: [main]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'
      - name: Install dependencies
        run: npm ci
      - name: Run tests
        run: npm run test:ci
      - name: Run linting
        run: npm run lint
      - name: Build application
        run: npm run build

  deploy-staging:
    needs: test
    if: github.ref == 'refs/heads/staging'
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to Vercel Staging
        run: vercel --prod --token=${{ secrets.VERCEL_TOKEN }}

  deploy-production:
    needs: test
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to Vercel Production
        run: vercel --prod --token=${{ secrets.VERCEL_TOKEN }}
      - name: Deploy Firebase Functions
        run: firebase deploy --only functions --token=${{ secrets.FIREBASE_TOKEN }}
```

### Environment Strategy
- **Development**: Local development with Firebase emulators
- **Staging**: Pre-production testing environment
- **Production**: Live production environment

### Deployment Environments
```javascript
// Environment Configuration
const environments = {
  development: {
    apiUrl: 'http://localhost:5001',
    firebaseProject: 'riftfuel-dev',
    debug: true
  },
  staging: {
    apiUrl: 'https://staging-api.riftfuel.com',
    firebaseProject: 'riftfuel-staging',
    debug: false
  },
  production: {
    apiUrl: 'https://api.riftfuel.com',
    firebaseProject: 'riftfuel-ba023',
    debug: false
  }
};
```

### Rollback Procedures
1. **Automatic Rollback**: Failed health checks trigger rollback
2. **Manual Rollback**: One-click rollback to previous version
3. **Database Rollback**: Restore from backup if needed
4. **Verification**: Post-rollback system validation

### Feature Flag Management
```javascript
// Feature flags for gradual rollouts
const featureFlags = {
  newAnalyticsDashboard: {
    enabled: true,
    rolloutPercentage: 50,
    targetRoles: ['Admin', 'Supervisor']
  },
  advancedReporting: {
    enabled: false,
    rolloutPercentage: 0,
    targetCompanies: ['company_123']
  }
};
```

### Deployment Checklist
- [ ] All tests passing
- [ ] Code review completed
- [ ] Database migrations tested
- [ ] Security scan passed
- [ ] Performance benchmarks met
- [ ] Backup created
- [ ] Rollback plan ready
- [ ] Stakeholders notified

### Database Management
- **Firestore Rules**: Security rule deployment
- **Indexes**: Performance optimization
- **Backup**: Automated data backup
- **Migration**: Schema migration scripts

## 💾 Data Backup & Recovery

### Backup Strategy
- **Automated Backups**: Daily Firestore exports
  - Schedule: 2:00 AM UTC daily
  - Retention: 30 days for daily, 12 months for monthly
  - Location: Google Cloud Storage bucket
  - Format: Firestore export format

- **Manual Backups**: On-demand exports
  - Pre-deployment backups
  - Before major data migrations
  - Critical operation checkpoints

### Backup Procedures
```bash
# Automated backup script
gcloud firestore export gs://riftfuel-backups/$(date +%Y-%m-%d) \
  --project=riftfuel-ba023 \
  --async

# Manual backup with specific collections
gcloud firestore export gs://riftfuel-backups/manual/$(date +%Y-%m-%d-%H%M) \
  --collection-ids=users,companies,fuel_requests \
  --project=riftfuel-ba023
```

### Recovery Procedures
- **Point-in-Time Recovery**: Restore to specific backup
- **Selective Recovery**: Restore specific collections
- **Data Validation**: Post-recovery integrity checks
- **Rollback Capability**: Quick rollback to previous state

### Disaster Recovery Plan
1. **Detection**: Automated monitoring alerts
2. **Assessment**: Impact evaluation (RTO: 4 hours, RPO: 1 hour)
3. **Recovery**: Restore from latest backup
4. **Validation**: Data integrity verification
5. **Communication**: Stakeholder notification

### Data Retention Policies
- **User Data**: Retained for account lifetime + 2 years
- **Audit Logs**: 7 years retention for compliance
- **Fuel Records**: 5 years for tax/regulatory requirements
- **Backup Data**: 30 days daily, 12 months monthly

### Recovery Testing
- **Monthly**: Backup restoration testing
- **Quarterly**: Full disaster recovery simulation
- **Annual**: Complete system recovery drill

## 📁 Project Structure

```
src/
├── components/           # React components
│   ├── admin/           # Admin-specific components
│   ├── auth/            # Authentication components
│   ├── dashboard/       # Dashboard components
│   ├── dashboards/      # Role-specific dashboards
│   ├── fuel/            # Fuel management components
│   ├── fleet/           # Fleet management components
│   ├── layout/          # Layout components
│   ├── marketing/       # Marketing pages
│   ├── notifications/   # Notification components
│   └── ui/              # Reusable UI components
├── contexts/            # React contexts
├── firebase/            # Firebase configuration
├── hooks/               # Custom React hooks
├── services/            # Business logic services
├── utils/               # Utility functions
└── styles/              # CSS styles

functions/               # Firebase Cloud Functions
scripts/                 # Development scripts
public/                  # Static assets
```

## 🔧 Development Tools

### Scripts
- `npm run dev` - Development server
- `npm run build` - Production build
- `npm run setup-db` - Database initialization
- `npm run create-test-users` - Test user creation
- `npm run migrate-users` - User migration
- `npm run deploy-*` - Firebase deployment

### Testing
- **Unit Tests**: Vitest framework
- **Integration Tests**: Firebase emulator testing
- **E2E Tests**: Manual testing procedures

### Development Utilities
- **Main Admin Creation**: `createDevMainAdmin()`
- **Migration Testing**: `testMigrationSystem()`
- **Database Initialization**: Setup scripts
- **Demo Data**: Test data generation

## 📈 Performance Optimization

### Frontend Optimization
- **Code Splitting**: Route-based splitting
- **Lazy Loading**: Component lazy loading
- **Bundle Optimization**: Vite optimization
- **Image Optimization**: Responsive images

### Database Optimization
- **Firestore Indexes**: Query optimization
- **Data Pagination**: Large dataset handling
- **Caching Strategy**: Client-side caching
- **Offline Storage**: Local data persistence

## 🔮 Future Enhancements

### Planned Features
- **Multi-tenant Billing**: Advanced billing features
- **API Integration**: Third-party integrations
- **Advanced Analytics**: Machine learning insights
- **Mobile App**: Native mobile application

### Scalability Considerations
- **Microservices**: Service decomposition
- **CDN Integration**: Global content delivery
- **Database Sharding**: Horizontal scaling
- **Load Balancing**: Traffic distribution

## 🏗️ Scalability Architecture

### Current Architecture Limitations
- **Single Firebase Project**: All companies in one project
- **Monolithic Frontend**: Single React application
- **Shared Database**: All data in single Firestore instance
- **Regional Deployment**: Single region deployment

### Horizontal Scaling Strategy

#### Database Scaling
```javascript
// Company-based sharding strategy
const shardingStrategy = {
  // Shard by company size
  small: {
    companies: '<100 users',
    shard: 'firestore-small',
    region: 'us-central1'
  },
  medium: {
    companies: '100-1000 users',
    shard: 'firestore-medium',
    region: 'us-central1'
  },
  large: {
    companies: '>1000 users',
    shard: 'firestore-large',
    region: 'multi-region'
  }
};

// Geographic sharding
const geoSharding = {
  'us-central': ['US', 'CA', 'MX'],
  'europe-west': ['UK', 'DE', 'FR', 'ES'],
  'asia-southeast': ['SG', 'MY', 'TH', 'ID']
};
```

#### Microservices Architecture
```javascript
// Service decomposition plan
const microservices = {
  authService: {
    responsibilities: ['Authentication', 'Authorization', 'User management'],
    technology: 'Firebase Auth + Custom API',
    scaling: 'Auto-scaling Cloud Run'
  },
  fuelService: {
    responsibilities: ['Fuel requests', 'Approvals', 'Dispensing'],
    technology: 'Node.js + Firestore',
    scaling: 'Horizontal pod autoscaling'
  },
  fleetService: {
    responsibilities: ['Vehicles', 'Drivers', 'Maintenance'],
    technology: 'Node.js + Firestore',
    scaling: 'Load balancer + multiple instances'
  },
  analyticsService: {
    responsibilities: ['Reporting', 'Analytics', 'Insights'],
    technology: 'Python + BigQuery',
    scaling: 'Serverless functions'
  },
  notificationService: {
    responsibilities: ['Email', 'Push', 'In-app notifications'],
    technology: 'Node.js + Pub/Sub',
    scaling: 'Event-driven scaling'
  }
};
```

### Load Balancing Strategy
```javascript
// Multi-tier load balancing
const loadBalancing = {
  cdn: {
    provider: 'Cloudflare',
    features: ['Global CDN', 'DDoS protection', 'SSL termination'],
    caching: 'Static assets, API responses'
  },
  applicationLoadBalancer: {
    provider: 'Google Cloud Load Balancer',
    algorithm: 'Round robin with health checks',
    features: ['SSL offloading', 'Session affinity']
  },
  databaseLoadBalancer: {
    readReplicas: 'Multiple read replicas per region',
    writeSharding: 'Company-based write distribution',
    caching: 'Redis for frequently accessed data'
  }
};
```

### Caching Strategy
```javascript
// Multi-level caching
const cachingLayers = {
  browser: {
    type: 'Service Worker + IndexedDB',
    duration: '24 hours',
    content: 'Static assets, user preferences'
  },
  cdn: {
    type: 'Cloudflare Edge Cache',
    duration: '1 hour',
    content: 'API responses, images'
  },
  application: {
    type: 'Redis Cluster',
    duration: '15 minutes',
    content: 'Database queries, session data'
  },
  database: {
    type: 'Firestore built-in caching',
    duration: '5 minutes',
    content: 'Frequently accessed documents'
  }
};
```

### Auto-Scaling Configuration
```yaml
# Kubernetes HPA configuration
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: riftfuel-api
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: riftfuel-api
  minReplicas: 3
  maxReplicas: 50
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70
  - type: Resource
    resource:
      name: memory
      target:
        type: Utilization
        averageUtilization: 80
```

### Performance Targets
```javascript
// Scalability benchmarks
const performanceTargets = {
  responseTime: {
    api: '<200ms p95',
    pageLoad: '<2s p95',
    database: '<100ms p95'
  },
  throughput: {
    concurrent_users: '10,000+',
    requests_per_second: '1,000+',
    transactions_per_minute: '5,000+'
  },
  availability: {
    uptime: '99.9%',
    recovery_time: '<4 hours',
    data_loss: '<1 hour RPO'
  }
};
```

### Migration Strategy
1. **Phase 1**: Implement caching and CDN
2. **Phase 2**: Extract notification service
3. **Phase 3**: Separate analytics service
4. **Phase 4**: Implement database sharding
5. **Phase 5**: Full microservices architecture

## 📋 Component Architecture

### Dashboard Components
- **MainAdminDashboard**: Global system management
- **AdminDashboard**: Company-level administration
- **SupervisorDashboard**: Approval workflows
- **OperatorDashboard**: Request creation and dispensing
- **AccountantDashboard**: Financial reporting

### Feature Components
- **FuelRequestManagement**: Complete request workflow
- **FuelDispensingManagement**: Dispensing operations
- **FuelAnalyticsDashboard**: Analytics and insights
- **FleetManagement**: Vehicle and driver management
- **BillingDashboard**: Subscription and billing
- **UserManagement**: User administration

### UI Components
- **ProtectedRoute**: Route-level access control
- **DashboardLayout**: Consistent layout structure
- **NotificationCenter**: Real-time notifications
- **PWAInstallPrompt**: Progressive web app features

## 🔄 Data Flow Architecture

### Authentication Flow
1. User login → Firebase Auth
2. Token validation → User role retrieval
3. Permission setup → Route access control
4. Session management → Activity tracking

### Request Workflow
1. Operator creates request → Firestore
2. Notification sent → Accountant
3. Approval/rejection → Status update
4. Dispensing tracking → Inventory update
5. Audit logging → Compliance trail

### Real-time Updates
- **Firestore Listeners**: Real-time data synchronization
- **Push Notifications**: FCM integration
- **State Management**: React context providers
- **Offline Sync**: Service worker background sync

## 🧪 Testing Strategy

### Test Coverage
- **Unit Tests**: Service layer testing
  - Location: `src/test/`, `src/utils/__tests__/`
  - Framework: Vitest
  - Coverage Target: 80% minimum
  - Files: `emailService.test.js`, `reportingService.test.js`

- **Integration Tests**: Firebase emulator testing
  - Location: `scripts/test-runner.js`
  - Emulator Suite: Auth, Firestore, Functions
  - Test Scenarios: Complete user workflows

- **Component Tests**: React Testing Library
  - Location: `src/tests/`
  - Files: `analytics-dashboard-test.js`
  - Coverage: Critical UI components

- **E2E Tests**: User workflow testing
  - Manual testing procedures
  - Automated Playwright tests (planned)
  - User journey validation

### Test Data Management
- **Demo Data**: Realistic test scenarios
  - Files: `fuelRequestDemoData.js`, `fleetDemoData.js`
  - Company-specific test data
  - Automated data cleanup

- **User Migration**: Data migration testing
  - Script: `testMigration.js`
  - Dry-run capabilities
  - Rollback procedures

- **Performance Testing**: Load testing utilities
  - Firebase performance monitoring
  - Lighthouse CI integration
  - Bundle size analysis

- **Security Testing**: Access control validation
  - Firestore rules testing
  - Role-based access verification
  - Authentication flow testing

### Testing Procedures
```bash
# Run all tests
npm run test

# Run specific test suites
npm run test:unit
npm run test:integration
npm run test:e2e

# Test with coverage
npm run test:coverage

# Performance testing
npm run test:performance
```

## 📚 Documentation Structure

### Technical Documentation
- **DATABASE_SCHEMA.md**: Complete database design
- **MAIN_ADMIN_SYSTEM.md**: Administrative hierarchy
- **PWA_IMPLEMENTATION_SUMMARY.md**: Progressive web app features
- **SECURITY.md**: Security implementation details

### Feature Documentation
- **FUEL_REQUEST_FEATURES.md**: Request workflow
- **FLEET_MANAGEMENT_FEATURES.md**: Fleet operations
- **ANALYTICS_DASHBOARD_STATUS.md**: Analytics features
- **SUBSCRIPTION_MANAGEMENT_FEATURE.md**: Billing system

### Setup Documentation
- **FIREBASE_SETUP.md**: Firebase configuration
- **DEPLOYMENT.md**: Deployment procedures
- **EMAIL_SETUP_GUIDE.md**: Email service setup
- **TEST_USERS.md**: Test user management

## 🔧 Configuration Management

### Environment Variables
```
VITE_FIREBASE_API_KEY
VITE_FIREBASE_AUTH_DOMAIN
VITE_FIREBASE_PROJECT_ID
VITE_FIREBASE_STORAGE_BUCKET
VITE_FIREBASE_MESSAGING_SENDER_ID
VITE_FIREBASE_APP_ID
VITE_FIREBASE_MEASUREMENT_ID
```

### Firebase Configuration
- **Project ID**: riftfuel-ba023
- **API Key**: AIzaSyCq2pdXs5RjbcBDjqtXvsgMPJWxWGSymQo
- **Analytics**: G-V52QLY50CM
- **Real Credentials**: Production-ready setup

### Build Configuration
- **Vite Config**: Modern build tooling
- **Tailwind Config**: Design system setup
- **PWA Config**: Service worker configuration
- **Vercel Config**: Deployment optimization

## 🔄 Business Process Workflows

### Customer Onboarding Workflow
```mermaid
graph TD
    A[Company Signup] --> B[Admin Registration]
    B --> C[Email Verification]
    C --> D[Company Profile Setup]
    D --> E[Subscription Selection]
    E --> F[Payment Processing]
    F --> G[Account Activation]
    G --> H[Initial Setup Wizard]
    H --> I[User Training]
    I --> J[Go Live]
```

#### Onboarding Steps
1. **Company Registration**
   - Admin provides company details
   - System creates company record
   - Generates unique company ID

2. **Account Setup**
   - Email verification required
   - Password policy enforcement
   - Profile completion

3. **Subscription Activation**
   - Plan selection (Standard: Kshs 60,000/month)
   - Payment method setup
   - Billing cycle configuration

4. **Initial Configuration**
   - Fleet data import
   - User role assignments
   - Department structure setup
   - Approval workflow configuration

5. **Training & Support**
   - System walkthrough
   - Feature demonstration
   - Documentation access
   - Support contact setup

### Fuel Request Workflow
```mermaid
graph TD
    A[Operator Creates Request] --> B[System Validation]
    B --> C[Request Submitted]
    C --> D[Accountant Notification]
    D --> E{Approval Decision}
    E -->|Approved| F[Approval Notification]
    E -->|Rejected| G[Rejection Notification]
    F --> H[Dispensing Authorization]
    H --> I[Fuel Dispensed]
    I --> J[Inventory Update]
    J --> K[Completion Notification]
    G --> L[Request Closed]
```

#### Process Details
1. **Request Creation** (Operator/Admin)
   - Vehicle selection and validation
   - Driver assignment
   - Fuel type and quantity specification
   - Purpose and urgency definition
   - Supporting documentation upload

2. **Validation & Routing** (System)
   - Data validation checks
   - Budget verification
   - Policy compliance check
   - Route to appropriate accountant

3. **Approval Process** (Accountant)
   - Request review and analysis
   - Budget impact assessment
   - Quantity adjustment if needed
   - Approval/rejection decision
   - Comments and feedback

4. **Dispensing Process** (Supervisor/Admin)
   - Authorization verification
   - Physical fuel dispensing
   - Odometer reading capture
   - Receipt documentation
   - Inventory deduction

### User Management Workflow
```mermaid
graph TD
    A[Admin Creates User] --> B[User Invitation Sent]
    B --> C[User Accepts Invitation]
    C --> D[Password Setup]
    D --> E[Profile Completion]
    E --> F[Role Assignment]
    F --> G[Department Assignment]
    G --> H[Permission Verification]
    H --> I[Account Activation]
```

### Subscription Management Workflow
```mermaid
graph TD
    A[Subscription Due] --> B[Invoice Generation]
    B --> C[Payment Notification]
    C --> D{Payment Received?}
    D -->|Yes| E[Subscription Renewed]
    D -->|No| F[Grace Period]
    F --> G{Grace Period Expired?}
    G -->|No| C
    G -->|Yes| H[Account Suspension]
    H --> I[Data Retention Period]
    I --> J[Account Termination]
    E --> K[Service Continuation]
```

### Incident Management Workflow
```mermaid
graph TD
    A[Issue Detected] --> B[Incident Classification]
    B --> C{Severity Level}
    C -->|Critical| D[Immediate Response]
    C -->|High| E[4 Hour Response]
    C -->|Medium| F[24 Hour Response]
    C -->|Low| G[72 Hour Response]
    D --> H[Incident Resolution]
    E --> H
    F --> H
    G --> H
    H --> I[Post-Incident Review]
    I --> J[Documentation Update]
```

### Audit & Compliance Workflow
```mermaid
graph TD
    A[User Action] --> B[Audit Log Creation]
    B --> C[Data Validation]
    C --> D[Compliance Check]
    D --> E{Compliance Met?}
    E -->|Yes| F[Action Approved]
    E -->|No| G[Action Blocked]
    G --> H[Compliance Notification]
    F --> I[Audit Trail Update]
    H --> J[Remediation Required]
```

### Business Process Automation
```javascript
// Automated workflow triggers
const automationRules = {
  fuelRequestApproval: {
    trigger: 'request_created',
    conditions: [
      'amount < 5000', // Auto-approve small amounts
      'user.role === "Admin"', // Admin requests
      'vehicle.department === user.department' // Same department
    ],
    action: 'auto_approve',
    notification: 'supervisor'
  },

  lowInventoryAlert: {
    trigger: 'inventory_update',
    conditions: ['current_level < threshold'],
    action: 'send_notification',
    recipients: ['admin', 'supervisor']
  },

  subscriptionRenewal: {
    trigger: 'subscription_expiry_7_days',
    action: 'send_renewal_notice',
    escalation: 'daily_reminders'
  }
};
```

### Key Performance Indicators (KPIs)
```javascript
// Business process metrics
const businessKPIs = {
  customerOnboarding: {
    timeToValue: '<7 days',
    completionRate: '>90%',
    userAdoption: '>80% within 30 days'
  },

  fuelRequestProcessing: {
    averageApprovalTime: '<4 hours',
    approvalRate: '>85%',
    dispensingAccuracy: '>99%'
  },

  customerSatisfaction: {
    npsScore: '>50',
    supportTicketResolution: '<24 hours',
    systemUptime: '>99.9%'
  },

  businessGrowth: {
    monthlyRecurringRevenue: 'Kshs 60,000 per company',
    customerRetentionRate: '>95%',
    averageRevenuePerUser: 'Kshs 1,500'
  }
};
```

### Process Optimization
- **Continuous Improvement**: Regular process review and optimization
- **Automation Opportunities**: Identify manual tasks for automation
- **User Feedback Integration**: Incorporate user suggestions
- **Performance Monitoring**: Track process efficiency metrics
- **Compliance Updates**: Adapt to regulatory changes

---

*This comprehensive index provides a complete overview of the RiftFuel system architecture, features, implementation details, and business processes. For specific implementation details, refer to the individual documentation files and source code components.*
