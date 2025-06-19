# 📧 Email Service Setup Guide

This guide will help you set up the email service to ensure emails are actually being sent from your RiftFuel application.

## 🎯 Overview

The RiftFuel email service consists of:
1. **Client-side email management** - Stores emails in Firestore for the inbox/sent functionality
2. **Firebase Functions email service** - Actually sends emails via SMTP using Nodemailer
3. **Email templates** - Pre-designed HTML templates for different notification types

## 📋 Prerequisites

- Firebase project set up (✅ Already done: `riftfuel-ba023`)
- Firebase CLI installed and authenticated
- Email service provider (Gmail, Outlook, or custom SMTP)

## 🚀 Quick Setup

### Step 1: Install Dependencies
```bash
# Install Firebase CLI if not already installed
npm install -g firebase-tools

# Install project dependencies
npm install
cd functions && npm install && cd ..
```

### Step 2: Login to Firebase
```bash
firebase login
```

### Step 3: Configure Email Service
```bash
# Interactive email configuration
npm run setup-email

# Or manually set configuration
firebase functions:config:set \
  email.host="smtp.gmail.com" \
  email.port="587" \
  email.secure="false" \
  email.user="your-email@gmail.com" \
  email.password="your-app-password"
```

### Step 4: Deploy Firebase Functions
```bash
npm run deploy-functions
```

### Step 5: Test Email Service
1. Login to your RiftFuel admin dashboard
2. Go to Admin → Email Service Test
3. Click "Check Config" to verify configuration
4. Send a test email to verify functionality

## 📧 Email Provider Setup

### Gmail Setup (Recommended)
1. **Enable 2-Factor Authentication** on your Gmail account
2. **Generate App Password**:
   - Go to Google Account settings
   - Security → 2-Step Verification → App passwords
   - Generate password for "Mail"
3. **Use these settings**:
   - Host: `smtp.gmail.com`
   - Port: `587`
   - Secure: `false`
   - User: Your Gmail address
   - Password: Generated App Password (not your regular password)

### Outlook/Hotmail Setup
- Host: `smtp-mail.outlook.com`
- Port: `587`
- Secure: `false`
- User: Your Outlook email
- Password: Your Outlook password

### Custom SMTP Setup
- Host: Your SMTP server
- Port: Usually 587 or 465
- Secure: `true` for port 465, `false` for port 587
- User: Your email username
- Password: Your email password

## 🔧 Configuration Commands

### View Current Configuration
```bash
npm run setup-email:show
# or
firebase functions:config:get
```

### Set Configuration Manually
```bash
firebase functions:config:set email.host="smtp.gmail.com"
firebase functions:config:set email.port="587"
firebase functions:config:set email.secure="false"
firebase functions:config:set email.user="your-email@gmail.com"
firebase functions:config:set email.password="your-app-password"
```

### Deploy After Configuration Changes
```bash
npm run deploy-functions
```

## 🧪 Testing

### Test Email Service
```bash
# Using the admin dashboard (recommended)
1. Login as admin
2. Go to Admin → Email Service Test
3. Enter test email address
4. Click "Send Test Email"

# Using Firebase Functions shell
npm run test-email
# Then in the shell:
testEmailService({email: "test@example.com"})
```

### Check Email Configuration
```bash
# In Firebase Functions shell
checkEmailConfig()
```

## 📊 Email Templates

The system includes these email templates:
- `fuel-request-created` - New fuel request notifications
- `fuel-request-approved` - Approval notifications
- `fuel-request-rejected` - Rejection notifications
- `low-fuel-stock` - Low stock alerts
- `subscription-renewal` - Billing reminders
- `test-email` - Service testing
- `custom-email` - Generic emails from the inbox

## 🔍 Troubleshooting

### Common Issues

#### 1. "Email service is not properly configured"
**Solution**: Check your SMTP configuration
```bash
npm run setup-email:show
```

#### 2. "Authentication failed"
**Solution**: 
- For Gmail: Use App Password, not regular password
- For Outlook: Ensure account allows SMTP access
- Check username/password are correct

#### 3. "Connection timeout"
**Solution**:
- Check host and port settings
- Verify firewall/network settings
- Try different port (587 vs 465)

#### 4. "Functions not deployed"
**Solution**:
```bash
npm run deploy-functions
```

#### 5. "Permission denied"
**Solution**: Ensure you're logged in to Firebase
```bash
firebase login
firebase use riftfuel-ba023
```

### Debug Steps

1. **Check Firebase Functions logs**:
```bash
firebase functions:log
```

2. **Test SMTP connection manually**:
```bash
node scripts/test-smtp-connection.js
```

3. **Verify Firebase project**:
```bash
firebase projects:list
firebase use riftfuel-ba023
```

## 🔒 Security Best Practices

1. **Use App Passwords** for Gmail (never use your main password)
2. **Store credentials securely** using Firebase Functions config
3. **Limit email sending** to authenticated users only
4. **Monitor usage** through Firebase Console
5. **Rotate passwords** regularly

## 📈 Monitoring

### Check Email Delivery
- Firebase Functions logs: `firebase functions:log`
- Email provider logs (Gmail, Outlook, etc.)
- Test emails regularly

### Performance Monitoring
- Firebase Console → Functions → Performance
- Monitor function execution time and errors
- Set up alerts for failures

## 🎯 Next Steps

After setting up email service:

1. **Test all email types**:
   - Create a fuel request to test approval notifications
   - Update fuel inventory to test low stock alerts
   - Use the email composer in the dashboard

2. **Configure email preferences**:
   - Set up user email notification preferences
   - Configure email frequency limits
   - Set up email templates for your organization

3. **Monitor and optimize**:
   - Check delivery rates
   - Monitor function performance
   - Optimize email templates for better engagement

## 📞 Support

If you encounter issues:
1. Check the troubleshooting section above
2. Review Firebase Functions logs
3. Test with a simple email provider like Gmail first
4. Verify all configuration steps were completed

---

**Note**: This setup enables actual email sending. Without this configuration, emails will only be stored in Firestore but not actually sent to recipients.
