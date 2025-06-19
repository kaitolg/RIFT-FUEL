# RiftFuel - Fleet Fuel Management System

> **Comprehensive fleet fuel management solutions for modern fleets**  
> Founded by Geoffrey Kimani | Kshs 60,000/month subscription

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/your-username/riftfuel)
[![CI/CD](https://github.com/your-username/riftfuel/workflows/CI/CD%20Pipeline/badge.svg)](https://github.com/your-username/riftfuel/actions)
[![Coverage](https://codecov.io/gh/your-username/riftfuel/branch/main/graph/badge.svg)](https://codecov.io/gh/your-username/riftfuel)

## 🚀 Live Demo

- **Production**: [https://riftfuel.vercel.app](https://riftfuel.vercel.app)
- **Staging**: [https://riftfuel-staging.vercel.app](https://riftfuel-staging.vercel.app)

## ✨ Features

### 🎯 **Core Features**
- **Matt Green Branding** - Professional design with consistent green color scheme
- **Multi-role Authentication** (Admin, Operator, Accountant, Supervisor)
- **Multi-step Fuel Request Forms** with approval workflows
- **Real-time Analytics** with consumption tracking and trend analysis
- **Progressive Web App** with offline capabilities
- **Mobile-first Responsive Design** optimized for all devices

### 🔐 **Authentication & Security**
- Email verification required for account activation
- Password reset functionality with secure tokens
- Session management with automatic logout on inactivity
- Role-based access control with protected routes
- Security headers and CSRF protection

### 🚛 **Fleet Management**
- Vehicle registration and comprehensive management
- Driver assignment and performance tracking
- Vehicle status monitoring (active/maintenance/retired)
- Fuel capacity and consumption tracking
- Maintenance records and mileage logging

### ⛽ **Fuel Management**
- **Multi-step Request Forms** with image upload support
- **Approval Workflows** (pending → approved → dispensed)
- **Supervisor Dashboards** for bulk approvals
- **Inventory Management** with real-time stock tracking
- **Fuel Dispensing** with actual quantity recording

### 📊 **Analytics & Reporting**
- Interactive charts with Recharts integration
- Vehicle and department consumption breakdowns
- Trend analysis and forecasting capabilities
- Alert systems for low fuel and unusual consumption
- PDF exportable reports with jsPDF

### 📱 **Progressive Web App**
- Offline functionality with background sync
- Mobile-responsive design for tablets and phones
- App-like experience with home screen installation
- Push notifications for critical updates
- Service worker caching for optimal performance

## 🛠 Technology Stack

### **Frontend**
- **React 18** - Modern hooks and context API
- **React Router 7** - Client-side routing with protected routes
- **TailwindCSS 4** - Utility-first CSS framework
- **Recharts** - Interactive data visualization
- **Vite** - Fast build tool and development server

### **Backend & Services**
- **Firebase Authentication** - Secure user management
- **Cloud Firestore** - Real-time NoSQL database
- **Firebase Storage** - File upload and management
- **Firebase Functions** - Serverless backend logic

### **DevOps & Deployment**
- **Vercel** - Production hosting with edge functions
- **GitHub Actions** - CI/CD pipeline automation
- **ESLint** - Code quality and consistency
- **Vitest** - Unit testing framework
- **Lighthouse CI** - Performance monitoring

## 🚀 Quick Start

### Prerequisites
- Node.js 18+ installed
- Firebase project configured
- Vercel account (for deployment)

### 1. Clone & Install
```bash
git clone https://github.com/your-username/riftfuel.git
cd riftfuel
npm install
```

### 2. Environment Setup
```bash
cp .env.example .env.local
```

Add your Firebase configuration:
```env
VITE_FIREBASE_API_KEY=your-firebase-api-key
VITE_FIREBASE_AUTH_DOMAIN=your-project.firebaseapp.com
VITE_FIREBASE_PROJECT_ID=your-project-id
VITE_FIREBASE_STORAGE_BUCKET=your-project.appspot.com
VITE_FIREBASE_MESSAGING_SENDER_ID=123456789
VITE_FIREBASE_APP_ID=your-app-id
```

### 3. Development
```bash
npm run dev
```
Visit `http://localhost:5173`

### 4. Testing
```bash
npm run test          # Run all tests
npm run test:coverage # Generate coverage report
npm run lint          # Check code quality
```

### 5. Build & Deploy
```bash
npm run build         # Production build
npm run preview       # Preview production build
```

## 🚀 Deployment

### **Vercel (Recommended)**

#### One-Click Deploy
[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new/clone?repository-url=https://github.com/your-username/riftfuel)

#### Manual Deploy
```bash
npm i -g vercel
vercel login
vercel
```

#### Environment Variables
Set these in Vercel dashboard:
- `VITE_FIREBASE_API_KEY`
- `VITE_FIREBASE_AUTH_DOMAIN`
- `VITE_FIREBASE_PROJECT_ID`
- `VITE_FIREBASE_STORAGE_BUCKET`
- `VITE_FIREBASE_MESSAGING_SENDER_ID`
- `VITE_FIREBASE_APP_ID`

### **CI/CD Pipeline**
Automated deployment via GitHub Actions:
- ✅ **Tests** run on every push/PR
- ✅ **Preview deployments** for pull requests
- ✅ **Production deployment** on main branch
- ✅ **Lighthouse audits** for performance monitoring

## 📊 Performance & SEO

### **Performance Optimizations**
- Code splitting and lazy loading
- Image optimization and compression
- Bundle size optimization (< 1MB)
- Service worker caching
- CDN delivery via Vercel Edge Network

### **SEO Features**
- Server-side meta tag generation
- Open Graph and Twitter Card support
- Structured data (JSON-LD)
- Sitemap generation
- Canonical URLs

### **Lighthouse Scores**
- **Performance**: 90+ 🟢
- **Accessibility**: 95+ 🟢
- **Best Practices**: 90+ 🟢
- **SEO**: 95+ 🟢
- **PWA**: 85+ 🟢

## 🧪 Testing

### **Test Coverage**
- **Login Module**: Authentication flows and error handling
- **Fuel Request Form**: Multi-step validation and submission
- **Component Integration**: React Testing Library
- **Performance**: Lighthouse CI monitoring

### **Running Tests**
```bash
npm run test           # Interactive test runner
npm run test:run       # Single test run
npm run test:coverage  # Coverage report
npm run test:ui        # Visual test interface
```

## 📁 Project Structure

```
src/
├── components/
│   ├── auth/              # Authentication components
│   ├── fuel/              # Fuel management components
│   ├── fleet/             # Fleet management components
│   ├── marketing/         # Landing page components
│   └── dashboards/        # Role-specific dashboards
├── contexts/              # React contexts
├── services/              # API services
├── utils/                 # Utility functions
│   ├── performance.js     # Performance optimizations
│   └── seo.js            # SEO utilities
├── test/                  # Test utilities and setup
└── firebase/              # Firebase configuration
```

## 🔧 Configuration Files

- `vercel.json` - Vercel deployment configuration
- `vite.config.js` - Build tool configuration
- `tailwind.config.js` - Styling configuration
- `vitest.config.js` - Testing configuration
- `.github/workflows/` - CI/CD pipeline
- `lighthouserc.json` - Performance monitoring

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit changes (`git commit -m 'Add amazing feature'`)
4. Push to branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💼 About the Founder

**Geoffrey Kimani** brings over a decade of experience in fleet management and technology solutions. Having witnessed firsthand the challenges faced by fleet operators, Geoffrey founded RiftFuel to provide a comprehensive platform that streamlines fuel management processes while providing actionable insights for better decision-making.

## 📞 Support

- **Documentation**: [DEPLOYMENT.md](DEPLOYMENT.md)
- **Issues**: [GitHub Issues](https://github.com/your-username/riftfuel/issues)
- **Email**: support@riftfuel.com
- **Website**: [https://riftfuel.vercel.app](https://riftfuel.vercel.app)

---

**RiftFuel** - Streamline your fleet's fuel management  
Built with ❤️ by Geoffrey Kimani | Deployed on Vercel
