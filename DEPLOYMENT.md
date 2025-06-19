# RiftFuel Deployment Guide

This guide covers the complete deployment setup for RiftFuel using Vercel with CI/CD via GitHub Actions.

## 🚀 Quick Deployment

### Prerequisites
- GitHub account
- Vercel account
- Firebase project (or Supabase project)
- Node.js 18+ installed locally

### 1. Fork/Clone Repository
```bash
git clone https://github.com/your-username/riftfuel.git
cd riftfuel
npm install
```

### 2. Environment Variables Setup

#### Local Development
1. Copy `.env.example` to `.env.local`:
```bash
cp .env.example .env.local
```

2. Fill in your Firebase/Supabase credentials:
```env
# Firebase Configuration
VITE_FIREBASE_API_KEY=your-firebase-api-key
VITE_FIREBASE_AUTH_DOMAIN=your-project.firebaseapp.com
VITE_FIREBASE_PROJECT_ID=your-project-id
VITE_FIREBASE_STORAGE_BUCKET=your-project.appspot.com
VITE_FIREBASE_MESSAGING_SENDER_ID=123456789
VITE_FIREBASE_APP_ID=your-app-id

# OR Supabase Configuration
VITE_SUPABASE_URL=https://your-project.supabase.co
VITE_SUPABASE_ANON_KEY=your-supabase-anon-key
```

### 3. Vercel Deployment

#### Option A: Vercel CLI (Recommended)
```bash
# Install Vercel CLI
npm i -g vercel

# Login to Vercel
vercel login

# Deploy
vercel

# Set environment variables
vercel env add VITE_FIREBASE_API_KEY
vercel env add VITE_FIREBASE_AUTH_DOMAIN
# ... add all environment variables

# Deploy to production
vercel --prod
```

#### Option B: Vercel Dashboard
1. Go to [vercel.com](https://vercel.com)
2. Import your GitHub repository
3. Configure environment variables in project settings
4. Deploy

### 4. GitHub Secrets Setup

Add these secrets to your GitHub repository:

#### Required Secrets
```
VERCEL_TOKEN=your-vercel-token
VERCEL_ORG_ID=your-vercel-org-id
VERCEL_PROJECT_ID=your-vercel-project-id

# Firebase/Supabase
VITE_FIREBASE_API_KEY=your-firebase-api-key
VITE_FIREBASE_AUTH_DOMAIN=your-project.firebaseapp.com
VITE_FIREBASE_PROJECT_ID=your-project-id
VITE_FIREBASE_STORAGE_BUCKET=your-project.appspot.com
VITE_FIREBASE_MESSAGING_SENDER_ID=123456789
VITE_FIREBASE_APP_ID=your-app-id

VITE_SUPABASE_URL=https://your-project.supabase.co
VITE_SUPABASE_ANON_KEY=your-supabase-anon-key
```

#### How to Get Vercel Secrets
1. **VERCEL_TOKEN**: Go to Vercel → Settings → Tokens → Create
2. **VERCEL_ORG_ID**: Found in Vercel team settings
3. **VERCEL_PROJECT_ID**: Found in project settings

## 🔄 CI/CD Pipeline

### Workflow Overview
The GitHub Actions workflow (`.github/workflows/ci-cd.yml`) includes:

1. **Test Stage**: Runs on every push/PR
   - Linting with ESLint
   - Unit tests with Vitest
   - Coverage reporting

2. **Build Stage**: After tests pass
   - Builds the application
   - Uploads build artifacts

3. **Deploy Preview**: For pull requests
   - Deploys to Vercel preview environment
   - Provides preview URL for testing

4. **Deploy Production**: For main branch
   - Deploys to production
   - Runs Lighthouse performance audit

### Branch Strategy
- `main`: Production deployments
- `develop`: Development/staging
- Feature branches: Preview deployments via PRs

## 🧪 Testing

### Running Tests Locally
```bash
# Run all tests
npm test

# Run tests in watch mode
npm run test:ui

# Run tests with coverage
npm run test:coverage

# Run linting
npm run lint
npm run lint:fix
```

### Test Coverage
- Target: 80%+ coverage
- Automated coverage reporting via Codecov
- Coverage reports generated in `coverage/` directory

## 📊 Performance Monitoring

### Lighthouse Audits
Automated Lighthouse audits run on production deployments:
- Performance: 80%+ target
- Accessibility: 90%+ target
- Best Practices: 80%+ target
- SEO: 80%+ target
- PWA: 70%+ target

### Performance Optimizations Included
- Code splitting and lazy loading
- Image optimization
- Bundle size optimization
- Service worker caching
- CDN delivery via Vercel

## 🔒 Security

### Environment Variables
- Never commit `.env` files
- Use Vercel environment variables for production
- Separate environments for development/staging/production

### Security Headers
Configured in `vercel.json`:
- Content Security Policy
- X-Frame-Options
- X-Content-Type-Options
- Referrer Policy

## 🐛 Troubleshooting

### Common Issues

#### Build Failures
```bash
# Clear cache and reinstall
rm -rf node_modules package-lock.json
npm install

# Check for TypeScript errors
npm run build
```

#### Environment Variables Not Working
1. Ensure variables start with `VITE_`
2. Check Vercel dashboard environment settings
3. Redeploy after adding new variables

#### Tests Failing
```bash
# Update test snapshots
npm run test -- --update-snapshots

# Run specific test file
npm run test Login.test.jsx
```

### Deployment Logs
- Check Vercel deployment logs in dashboard
- GitHub Actions logs in repository Actions tab
- Browser console for runtime errors

## 📈 Monitoring & Analytics

### Available Integrations
- Vercel Analytics (built-in)
- Google Analytics (add tracking ID)
- Sentry for error tracking
- Lighthouse CI for performance monitoring

### Custom Monitoring
Add monitoring services by updating environment variables:
```env
VITE_SENTRY_DSN=your-sentry-dsn
VITE_GA_TRACKING_ID=your-google-analytics-id
```

## 🔄 Updates & Maintenance

### Updating Dependencies
```bash
# Check for updates
npm outdated

# Update all dependencies
npm update

# Update specific package
npm install package-name@latest
```

### Database Migrations
```bash
# Deploy Firestore rules
npm run deploy-rules

# Deploy Firestore indexes
npm run deploy-indexes
```

## 📞 Support

For deployment issues:
1. Check this documentation
2. Review GitHub Actions logs
3. Check Vercel deployment logs
4. Contact: Geoffrey Kimani (founder@riftfuel.com)

---

**RiftFuel** - Comprehensive fleet fuel management by Geoffrey Kimani
Deployed with ❤️ using Vercel
