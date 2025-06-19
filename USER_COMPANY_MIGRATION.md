# User-to-Company Migration Guide

This guide explains how to associate existing users to existing companies while maintaining their roles, except for the main administrator.

## Overview

The User-to-Company Migration system provides tools to:
- Associate existing users with companies
- Maintain user roles during migration
- Exclude main administrators from company association
- Distribute users evenly across companies or assign to specific companies
- Preview changes before applying them
- Track migration results and handle errors

## Key Features

### 🔄 **Automatic Distribution**
- Users are distributed evenly across all available companies
- Maintains role hierarchy and permissions
- Preserves user data integrity

### 🎯 **Targeted Assignment**
- Assign all unassigned users to a specific company
- Useful for single-company setups or specific business needs

### 👑 **Main Admin Protection**
- Main administrators are automatically excluded from migration
- Ensures system-level access remains intact

### 🔍 **Preview Mode**
- See exactly what changes will be made before applying them
- No risk of accidental data modification

### 💪 **Force Migration**
- Option to reassign users already associated with companies
- Useful for reorganizing company structures

## How to Use

### Method 1: Using the Web Interface (Recommended)

1. **Access the Migration Panel**
   - Log in as a Main Administrator
   - Go to Main Admin Dashboard
   - Click on the "User Migration" tab

2. **Review Current Status**
   - Check how many companies are available
   - See how many users need migration
   - Review the list of users to be migrated

3. **Configure Migration Options**
   - **Target Company**: Leave empty to distribute evenly, or select a specific company
   - **Force Migration**: Check this to include users already assigned to companies

4. **Preview Migration**
   - Click "Preview Migration" to see what changes will be made
   - Review the preview without making any actual changes

5. **Perform Migration**
   - Click "Perform Migration" to execute the changes
   - Monitor the progress and results
   - Review any errors that may occur

### Method 2: Using Command Line Scripts

#### Basic Migration (Distribute Evenly)
```bash
npm run migrate-users
```

#### Dry Run (Preview Only)
```bash
npm run migrate-users:dry-run
```

#### Force Migration (Include Already Assigned Users)
```bash
npm run migrate-users:force
```

#### Assign to Specific Company
```bash
node scripts/migrate-users-to-companies.js --company-id COMP-001
```

### Method 3: Using JavaScript Functions

```javascript
import { 
  migrateUsersToCompanies, 
  migrateUsersToSpecificCompany,
  previewUserMigration 
} from './src/utils/userCompanyMigration';

// Preview migration
const preview = await previewUserMigration();

// Migrate users (distribute evenly)
const results = await migrateUsersToCompanies();

// Migrate to specific company
const results = await migrateUsersToSpecificCompany('COMP-001');
```

## Migration Rules

### Users Included in Migration
- ✅ Users with role: Admin, Supervisor, Operator, Accountant
- ✅ Users without company assignment (companyID is empty)
- ✅ Active users (isActive: true)

### Users Excluded from Migration
- ❌ Main administrators (role: MainAdmin)
- ❌ Users already assigned to companies (unless force option is used)
- ❌ Inactive users (unless specifically included)

### Data Preserved During Migration
- ✅ User roles remain unchanged
- ✅ User permissions stay intact
- ✅ Personal information is preserved
- ✅ Account status remains the same

### Data Modified During Migration
- 🔄 `companyID` field is updated
- 🔄 `updatedAt` timestamp is set
- 🔄 `migratedAt` timestamp is added
- 🔄 `migratedBy` field is set to identify migration source

## Example Scenarios

### Scenario 1: New System Setup
You have created users and companies but haven't associated them yet.

**Solution**: Use basic migration to distribute users evenly across companies.
```bash
npm run migrate-users
```

### Scenario 2: Single Company Setup
You want all users to belong to one specific company.

**Solution**: Use targeted migration to assign all users to one company.
```bash
node scripts/migrate-users-to-companies.js --company-id COMP-001
```

### Scenario 3: Company Restructuring
You need to reassign users already associated with companies.

**Solution**: Use force migration to reassign all users.
```bash
npm run migrate-users:force
```

### Scenario 4: Testing Changes
You want to see what changes will be made before applying them.

**Solution**: Use dry run mode to preview changes.
```bash
npm run migrate-users:dry-run
```

## Troubleshooting

### Common Issues

**Issue**: "No companies found in database"
- **Solution**: Create companies first before running migration

**Issue**: "No users require migration"
- **Solution**: Check if users are already assigned or use force option

**Issue**: "Migration failed for some users"
- **Solution**: Check error details and verify user data integrity

**Issue**: "Access denied"
- **Solution**: Ensure you're logged in as a Main Administrator

### Error Handling

The migration system includes comprehensive error handling:
- Individual user failures don't stop the entire migration
- Detailed error messages for troubleshooting
- Rollback capabilities for critical failures
- Audit logging for all migration activities

## Best Practices

1. **Always Preview First**: Use dry run mode to understand changes before applying
2. **Backup Data**: Consider backing up user data before major migrations
3. **Test with Small Groups**: Start with a few users to verify the process
4. **Monitor Results**: Review migration results and handle any errors
5. **Document Changes**: Keep records of when and why migrations were performed

## Security Considerations

- Only Main Administrators can perform migrations
- Main Admin users are protected from accidental assignment
- All migration activities are logged for audit purposes
- User permissions and roles are preserved during migration
- Company data isolation is maintained after migration

## Support

If you encounter issues with the migration process:
1. Check the browser console for detailed error messages
2. Review the migration results for specific user failures
3. Verify that companies exist before running migration
4. Ensure proper Main Admin permissions
5. Contact system administrators for database-level issues
