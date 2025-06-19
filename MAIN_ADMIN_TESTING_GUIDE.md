# Main Admin System Testing Guide

## 🧪 Quick Testing Instructions

### Prerequisites
1. **Main Admin User**: Create a Main Admin user if one doesn't exist
2. **Development Environment**: Ensure the development server is running
3. **Firebase Connection**: Verify Firebase is properly configured

### Creating a Main Admin User

#### Option 1: Browser Console (Development)
```javascript
// Open browser console and run:
await createDevMainAdmin();
```

#### Option 2: Manual Creation
```javascript
// In browser console:
import { createMainAdmin } from './src/utils/createMainAdmin';
await createMainAdmin(
  'mainadmin@yourcompany.com',
  'SecurePassword123!',
  'Main Administrator'
);
```

## 🔍 Testing Checklist

### 1. **Main Admin Dashboard Access**
- [ ] Login with Main Admin credentials
- [ ] Verify automatic redirect to `/dashboard/main-admin`
- [ ] Check that all new tabs are visible:
  - [ ] Overview
  - [ ] Companies
  - [ ] Global Users
  - [ ] System Analytics
  - [ ] Audit Logs
  - [ ] System Health
  - [ ] User Migration
  - [ ] Debug Tools

### 2. **System Activity Feed Testing**
- [ ] Navigate to Overview tab
- [ ] Verify activity feed loads (may show demo data)
- [ ] Check activity icons and timestamps
- [ ] Verify "View all activity" button appears if >10 activities
- [ ] Test error handling by checking network tab

### 3. **System Analytics Testing**
- [ ] Navigate to System Analytics tab
- [ ] Verify all metric cards display data:
  - [ ] Total Companies
  - [ ] Total Users
  - [ ] Fuel Requests
  - [ ] Total Revenue
- [ ] Test time range selector (7d, 30d, 90d, 1y)
- [ ] Verify charts render properly:
  - [ ] User Growth (Line Chart)
  - [ ] Company Distribution (Pie Chart)
  - [ ] Fuel Request Trends (Bar Chart)
  - [ ] Revenue Trends (Line Chart)
- [ ] Check system performance metrics display

### 4. **Audit Log Viewer Testing**
- [ ] Navigate to Audit Logs tab
- [ ] Verify audit logs table loads
- [ ] Test filtering functionality:
  - [ ] Action filter dropdown
  - [ ] User search field
  - [ ] Company search field
  - [ ] Date range filters
  - [ ] General search field
- [ ] Test pagination (if >50 logs)
- [ ] Test CSV export functionality
- [ ] Verify log details display correctly

### 5. **System Health Monitor Testing**
- [ ] Navigate to System Health tab
- [ ] Verify overall system status displays
- [ ] Check all service status cards:
  - [ ] Database
  - [ ] Authentication
  - [ ] Storage
  - [ ] API Services
  - [ ] Email Service
  - [ ] Notifications
- [ ] Test refresh button functionality
- [ ] Test "Run Diagnostics" button
- [ ] Verify system metrics display
- [ ] Check auto-refresh (wait 30 seconds)

### 6. **Error Handling Testing**
- [ ] Test with network disconnected
- [ ] Verify error messages display appropriately
- [ ] Check retry functionality works
- [ ] Verify demo data fallbacks work

### 7. **Responsive Design Testing**
- [ ] Test on mobile device/small screen
- [ ] Verify navigation adapts properly
- [ ] Check chart responsiveness
- [ ] Verify table scrolling on mobile

## 🐛 Common Issues & Solutions

### Issue: "Main Admin already exists" error
**Solution**: Check if a Main Admin user already exists:
```javascript
await checkMainAdminExists();
```

### Issue: Charts not rendering
**Solution**: 
1. Check browser console for errors
2. Verify Recharts is properly installed
3. Check if demo data is being generated

### Issue: Audit logs not loading
**Solution**:
1. Check Firestore security rules
2. Verify audit_logs collection exists
3. Demo data should load as fallback

### Issue: System health shows all "Unknown"
**Solution**: This is expected behavior - the system returns demo health data

### Issue: Activity feed shows "No recent activity"
**Solution**: 
1. Check if audit_logs collection has data
2. Demo data should generate automatically
3. Try refreshing the page

## 📊 Expected Demo Data

### System Analytics
- **Companies**: 12 total (10 active, 2 inactive)
- **Users**: 156 total
- **Fuel Requests**: 1,247 total
- **Revenue**: KES 720,000

### Activity Feed
- User registration activities
- Fuel request submissions
- Approval/rejection actions
- Company creation events
- Dispensing operations

### Audit Logs
- 100 demo log entries
- Various action types (create, update, delete, login, etc.)
- Random timestamps within last 7 days
- Multiple users and companies

### System Health
- All services showing "healthy" status
- Random but realistic metrics
- No recent issues (empty array)

## 🔧 Development Testing

### Service Function Testing
Test individual service functions in browser console:

```javascript
// Test system activity
const activity = await getSystemActivity();
console.log('Activity:', activity);

// Test system analytics
const analytics = await getSystemAnalytics('30d');
console.log('Analytics:', analytics);

// Test audit logs
const logs = await getSystemAuditLogs(50);
console.log('Audit Logs:', logs);

// Test system health
const health = await getSystemHealth();
console.log('Health:', health);
```

### Component Testing
1. Check React DevTools for component state
2. Verify props are passed correctly
3. Test loading and error states
4. Check for memory leaks with repeated navigation

## ✅ Success Criteria

The implementation is working correctly if:

1. **All tabs load without errors**
2. **Demo data displays in all sections**
3. **Charts render properly**
4. **Filtering and pagination work**
5. **Export functionality works**
6. **Responsive design adapts to screen size**
7. **Error handling shows appropriate messages**
8. **Auto-refresh works for system health**

## 🚀 Next Steps After Testing

1. **Create real audit log entries** by performing actions in the system
2. **Set up real system health monitoring** with actual service checks
3. **Configure real analytics** with historical data
4. **Implement real-time notifications** for system events
5. **Add more comprehensive error handling** for production use

## 📞 Support

If you encounter issues during testing:

1. Check browser console for JavaScript errors
2. Verify Firebase configuration is correct
3. Ensure all dependencies are installed (`npm install`)
4. Check that you're using a Main Admin account
5. Try refreshing the page or clearing browser cache

The implementation includes comprehensive error handling and demo data fallbacks, so most features should work even without real data in the system.
