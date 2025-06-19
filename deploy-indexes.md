# Deploy Firestore Indexes

## Quick Fix Applied ✅

I've updated your code to fix the index error by:

1. **Fixed collection name mismatch**: Changed all references from `fuelRequests` to `fuel_requests` to match your Firestore indexes
2. **Added graceful fallback**: Modified queries to work without `orderBy` if indexes aren't ready yet
3. **Updated all related files**: Fixed Firebase Cloud Functions, notification triggers, and other services

## Files Updated:
- `src/services/fuelRequestService.js` - All collection references updated
- `functions/src/index.ts` - Cloud Function triggers updated  
- `firestore.indexes.json` - Removed duplicate index entry
- `src/utils/notificationTriggers.js` - Collection reference updated
- `src/services/offlineStorageService.js` - IndexedDB store name updated

## To Deploy Indexes (when ready):

1. **Login to Firebase CLI:**
   ```bash
   firebase login
   ```

2. **Set your project:**
   ```bash
   firebase use riftfuel-ba023
   ```

3. **Deploy the indexes:**
   ```bash
   firebase deploy --only firestore:indexes
   ```

## Current Status:
- ✅ Code updated to use correct collection name (`fuel_requests`)
- ✅ Queries will work without indexes (with JavaScript sorting)
- ⏳ Indexes will provide better performance once deployed

## Test Your App:
Your fuel requests should now load without the index error. The app will:
- Use demo data if no real requests exist
- Sort results in JavaScript instead of Firestore
- Work immediately without waiting for index deployment

Once you deploy the indexes, queries will be faster and more efficient.
