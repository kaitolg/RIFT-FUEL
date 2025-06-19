# Firestore Indexes Setup Guide

## 🚨 **URGENT: Required Indexes for Data Isolation**

The secure data access services require specific Firestore indexes to function properly. Without these indexes, you'll get errors like:

```
FirebaseError: The query requires an index. You can create it here: https://console.firebase.google.com/...
```

## 📋 **Required Indexes**

### 1. **Vehicles Collection**
**Index:** `companyID (Ascending) + createdAt (Descending)`

**Quick Create Link:**
```
https://console.firebase.google.com/v1/r/project/riftfuel-ba023/firestore/indexes?create_composite=Cl9wcm9qZWN0cy9yaWZ0ZnVlbC1iYTAyMy9kYXRhYmFzZXMvKGRlZmF1bHQpL2NvbGxlY3Rpb25Hcm91cHMvdmVoaWNsZXMvaW5kZXhlcy9fEAEaDQoJY29tcGFueUlEEAEaDQoJY3JlYXRlZEF0EAIaDAoIX19uYW1lX18QAg
```

**Manual Creation:**
1. Go to [Firebase Console](https://console.firebase.google.com/project/riftfuel-ba023/firestore/indexes)
2. Click "Create Index"
3. Collection ID: `vehicles`
4. Add fields:
   - `companyID` (Ascending)
   - `createdAt` (Descending)
5. Click "Create"

### 2. **Fuel Requests Collection**
**Index:** `companyID (Ascending) + createdAt (Descending)`

**Quick Create Link:**
```
https://console.firebase.google.com/v1/r/project/riftfuel-ba023/firestore/indexes?create_composite=Cl9wcm9qZWN0cy9yaWZ0ZnVlbC1iYTAyMy9kYXRhYmFzZXMvKGRlZmF1bHQpL2NvbGxlY3Rpb25Hcm91cHMvZnVlbF9yZXF1ZXN0cy9pbmRleGVzL18QARoNCgljb21wYW55SUQQARoNCgljcmVhdGVkQXQQAhoMCghfX25hbWVfXxAC
```

**Manual Creation:**
1. Go to [Firebase Console](https://console.firebase.google.com/project/riftfuel-ba023/firestore/indexes)
2. Click "Create Index"
3. Collection ID: `fuel_requests`
4. Add fields:
   - `companyID` (Ascending)
   - `requestedBy` (Ascending)
   - `createdAt` (Descending)
5. Click "Create"

### 3. **Additional Required Indexes**

#### **Fuel Requests by User:**
- Collection: `fuel_requests`
- Fields: `companyID (Ascending) + requestedBy (Ascending) + createdAt (Descending)`

#### **Fuel Requests by Vehicle:**
- Collection: `fuel_requests`
- Fields: `companyID (Ascending) + vehicleId (Ascending) + createdAt (Descending)`

#### **Fuel Requests by Status:**
- Collection: `fuel_requests`
- Fields: `companyID (Ascending) + status (Ascending) + createdAt (Descending)`

#### **Vehicle Search:**
- Collection: `vehicles`
- Fields: `companyID (Ascending) + vehicleName (Ascending)`
- Fields: `companyID (Ascending) + plateNumber (Ascending)`

#### **Fuel Request Search:**
- Collection: `fuel_requests`
- Fields: `companyID (Ascending) + vehicleName (Ascending)`
- Fields: `companyID (Ascending) + vehiclePlateNumber (Ascending)`

## 🚀 **Quick Setup Instructions**

### **Option 1: Use Error Links (Recommended)**
1. Run the application
2. When you see index errors in the console, click the provided links
3. This will automatically create the required indexes

### **Option 2: Manual Creation**
1. Go to [Firebase Console - Firestore Indexes](https://console.firebase.google.com/project/riftfuel-ba023/firestore/indexes)
2. Create each index manually using the specifications above

### **Option 3: Import Index Configuration**
Create a `firestore.indexes.json` file with the following content:

```json
{
  "indexes": [
    {
      "collectionGroup": "vehicles",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "companyID", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "fuel_requests",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "companyID", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "fuel_requests",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "companyID", "order": "ASCENDING" },
        { "fieldPath": "requestedBy", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "fuel_requests",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "companyID", "order": "ASCENDING" },
        { "fieldPath": "vehicleId", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "fuel_requests",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "companyID", "order": "ASCENDING" },
        { "fieldPath": "status", "order": "ASCENDING" },
        { "fieldPath": "createdAt", "order": "DESCENDING" }
      ]
    },
    {
      "collectionGroup": "vehicles",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "companyID", "order": "ASCENDING" },
        { "fieldPath": "vehicleName", "order": "ASCENDING" }
      ]
    },
    {
      "collectionGroup": "vehicles",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "companyID", "order": "ASCENDING" },
        { "fieldPath": "plateNumber", "order": "ASCENDING" }
      ]
    }
  ],
  "fieldOverrides": []
}
```

Then deploy using Firebase CLI:
```bash
firebase deploy --only firestore:indexes
```

## ⚡ **Temporary Workaround**

The secure services now include automatic fallback logic:

1. **First attempt**: Use optimized Firestore queries with indexes
2. **Fallback**: If indexes are missing, query without ordering and sort in JavaScript
3. **Search fallback**: If search indexes are missing, filter results client-side

This means the application will work even without indexes, but performance will be slower.

## 📊 **Index Status Monitoring**

The application will log warnings when indexes are missing:

```javascript
console.warn('Index missing for vehicles with companyID + createdAt. Falling back to query without ordering.');
console.warn('Create the index here: https://console.firebase.google.com/...');
```

## 🎯 **Performance Impact**

### **With Indexes (Recommended):**
- ✅ Fast queries
- ✅ Server-side sorting
- ✅ Efficient search
- ✅ Scalable performance

### **Without Indexes (Fallback):**
- ⚠️ Slower queries
- ⚠️ Client-side sorting
- ⚠️ Client-side filtering
- ⚠️ Higher bandwidth usage

## 🔧 **Troubleshooting**

### **Index Creation Taking Too Long**
- Index creation can take several minutes
- Check the Firebase Console for progress
- The application will work with fallback logic during creation

### **Index Creation Failed**
- Ensure you have proper permissions
- Check Firebase project billing status
- Verify collection names match exactly

### **Still Getting Errors**
- Clear browser cache
- Check browser console for specific error messages
- Verify you're using the correct Firebase project

## ✅ **Verification**

After creating indexes, verify they're working:

1. Check Firebase Console - Indexes tab
2. Look for "Building" or "Enabled" status
3. Test the application - errors should disappear
4. Check browser console for success messages

---

## 🚨 **IMPORTANT NOTES**

1. **Index creation is required** for optimal performance
2. **Fallback logic is temporary** - create indexes for production
3. **Monitor console warnings** for missing indexes
4. **Index creation takes time** - be patient during the process

The application will work without indexes but will be significantly slower and use more bandwidth.
