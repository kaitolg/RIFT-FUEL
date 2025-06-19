# Security Implementation Guide

## Overview

This document outlines the comprehensive security implementation for the Fuel Management System, including role-based access control, session management, and security monitoring.

## Security Features

### 1. Enhanced Authentication System

#### Session Management
- **Session Timeout**: 30 minutes of inactivity
- **Session Warning**: 5 minutes before expiry
- **Session Persistence**: Secure localStorage with integrity validation
- **Multi-tab Synchronization**: Activity tracking across browser tabs

#### Security Monitoring
- **Activity Tracking**: Mouse, keyboard, and touch events
- **Security Logging**: All authentication and authorization events
- **Rate Limiting**: Protection against brute force attacks
- **Integrity Checks**: Session data validation

### 2. Role-Based Access Control (RBAC)

#### User Roles
- **Admin**: Full system access
- **Supervisor**: Fuel approval and management
- **Accountant**: Financial reporting and billing
- **Operator**: Basic operations and requests

#### Permission System
```javascript
// Example permissions by role
const ROLE_PERMISSIONS = {
  'Admin': [
    'user.create', 'user.read', 'user.update', 'user.delete',
    'fleet.create', 'fleet.read', 'fleet.update', 'fleet.delete',
    'fuel.create', 'fuel.read', 'fuel.update', 'fuel.delete', 'fuel.approve',
    'reports.read', 'reports.export', 'billing.read', 'audit.read'
  ],
  'Supervisor': [
    'fuel.approve', 'fuel.reject', 'dispensing.create', 'reports.read'
  ],
  // ... other roles
};
```

### 3. Route Protection

#### Enhanced ProtectedRoute Component
- **Authentication Check**: Verify user is logged in
- **Session Validation**: Ensure session is active and valid
- **Email Verification**: Require verified email for sensitive routes
- **Role Authorization**: Check user has required role
- **Permission Authorization**: Check user has specific permissions
- **Security Logging**: Log all access attempts

#### Usage Examples
```jsx
// Require specific role
<ProtectedRoute requiredRole="Admin">
  <AdminPanel />
</ProtectedRoute>

// Require specific permission
<ProtectedRoute requiredPermission="fuel.approve">
  <FuelApproval />
</ProtectedRoute>

// Allow multiple roles
<ProtectedRoute allowedRoles={["Admin", "Supervisor"]}>
  <ManagementDashboard />
</ProtectedRoute>
```

### 4. Security Hooks

#### useAuth Hook
Enhanced authentication hook with security features:
- `secureLogin()`: Login with rate limiting and logging
- `secureLogout()`: Logout with cleanup and logging
- `hasPermission()`: Check user permissions
- `hasRole()`: Check user roles
- `requireAuth()`: Programmatic authentication check
- `extendSession()`: Extend session on user activity

#### useActivity Hook
Activity monitoring and session management:
- Tracks user activity across multiple event types
- Handles session timeouts and warnings
- Provides activity status and time remaining
- Supports manual session extension

### 5. Security Utilities

#### Session Manager
- **Session Initialization**: Create secure session on login
- **Activity Tracking**: Update activity timestamps
- **Validity Checking**: Verify session hasn't expired
- **Integrity Validation**: Ensure session data hasn't been tampered with
- **Cleanup**: Secure session cleanup on logout

#### Security Utils
- **Permission Checking**: Role and permission validation
- **Input Sanitization**: Clean user input
- **Rate Limiting**: Prevent abuse
- **Security Logging**: Track security events
- **Client Information**: Gather security-relevant client data

### 6. Security Monitoring

#### Security Provider
Comprehensive security monitoring wrapper:
- **Periodic Security Checks**: Regular validation of session and user state
- **Suspicious Activity Detection**: Monitor for unusual patterns
- **Security Alerts**: Real-time security notifications
- **Automatic Response**: Handle security events automatically

#### Security Events Logged
- Login attempts (success/failure)
- Route access attempts
- Permission violations
- Session events (timeout, extension)
- Suspicious activity patterns

## Implementation Guide

### 1. Basic Setup

```jsx
// App.jsx
import SecurityProvider from './components/security/SecurityProvider';

function App() {
  return (
    <Router>
      <AuthProvider>
        <SecurityProvider>
          <NotificationProvider>
            {/* Your app content */}
          </NotificationProvider>
        </SecurityProvider>
      </AuthProvider>
    </Router>
  );
}
```

### 2. Using Security Hooks

```jsx
// In your components
import { useAuth } from './hooks/useAuth';
import { useSecurity } from './components/security/SecurityProvider';

function MyComponent() {
  const { 
    isAuthenticated, 
    hasPermission, 
    requireRole 
  } = useAuth();
  
  const { 
    getSecurityStatus, 
    addSecurityAlert 
  } = useSecurity();

  // Check permissions
  if (!hasPermission('fuel.approve')) {
    return <div>Access Denied</div>;
  }

  // Require specific role
  if (!requireRole('Supervisor')) {
    return null; // Will redirect automatically
  }

  return <div>Protected Content</div>;
}
```

### 3. Custom Route Protection

```jsx
// Custom protection for sensitive operations
function SensitiveOperation() {
  const { requirePermission } = useAuth();
  
  const handleSensitiveAction = () => {
    if (!requirePermission('admin.delete')) {
      return; // Will redirect to unauthorized
    }
    
    // Perform sensitive action
  };
  
  return (
    <button onClick={handleSensitiveAction}>
      Delete All Data
    </button>
  );
}
```

## Security Best Practices

### 1. Session Security
- Sessions automatically expire after 30 minutes of inactivity
- Users receive warnings 5 minutes before expiry
- Session data is validated for integrity
- Multi-tab activity synchronization prevents premature timeouts

### 2. Permission Checking
- Always check permissions at both route and component level
- Use the principle of least privilege
- Admin role has all permissions by default
- Custom permissions can be assigned to users

### 3. Security Logging
- All security events are logged with timestamps
- Logs include user ID, role, and relevant context
- Failed attempts are tracked for rate limiting
- Logs are stored locally for debugging (send to server in production)

### 4. Rate Limiting
- Login attempts are limited to 5 per 15 minutes
- Rate limits are enforced client-side (implement server-side in production)
- Successful login clears rate limit counters

### 5. Input Validation
- All user inputs are sanitized
- Email format validation on login
- Password strength checking on registration
- XSS prevention through input cleaning

## Configuration

### Session Timeout Configuration
```javascript
// Customize session timeout
sessionManager.setSessionTimeout(45 * 60 * 1000); // 45 minutes
sessionManager.setWarningThreshold(10 * 60 * 1000); // 10 minutes warning
```

### Security Check Configuration
```javascript
// Toggle security monitoring
const { toggleSecurityChecks } = useSecurity();
toggleSecurityChecks(false); // Disable for testing
```

## Troubleshooting

### Common Issues

1. **Session Expires Too Quickly**
   - Check if user activity is being tracked properly
   - Verify activity events are registered
   - Ensure session manager is initialized

2. **Permission Denied Errors**
   - Verify user role in Firestore
   - Check permission assignments
   - Ensure role hierarchy is correct

3. **Security Alerts Not Showing**
   - Check SecurityProvider is wrapping the app
   - Verify security monitoring is enabled
   - Check console for security events

### Debug Information
```javascript
// Get session information
const sessionInfo = sessionManager.getSessionInfo();
console.log('Session Info:', sessionInfo);

// Get security status
const { getSecurityStatus } = useSecurity();
console.log('Security Status:', getSecurityStatus());

// View security logs
const logs = securityUtils.getSecurityLogs();
console.log('Security Logs:', logs);
```

## Production Considerations

1. **Server-Side Validation**: Implement all security checks on the server
2. **HTTPS Only**: Ensure all communication is encrypted
3. **Security Headers**: Implement proper security headers
4. **Audit Logging**: Send security logs to secure logging service
5. **Rate Limiting**: Implement server-side rate limiting
6. **Session Storage**: Consider using secure HTTP-only cookies
7. **Regular Security Reviews**: Conduct periodic security assessments
