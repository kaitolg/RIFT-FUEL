@echo off
echo.
echo ========================================
echo   RiftFuel - Network Development Server
echo ========================================
echo.
echo Starting server with network access...
echo.

REM Check if Node.js is installed
node --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Node.js is not installed or not in PATH
    echo Please install Node.js from https://nodejs.org/
    pause
    exit /b 1
)

REM Check if npm dependencies are installed
if not exist "node_modules" (
    echo 📦 Installing dependencies...
    npm install
    if errorlevel 1 (
        echo ❌ Failed to install dependencies
        pause
        exit /b 1
    )
)

REM Display network information
echo 🌐 Your network IP addresses:
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /c:"IPv4 Address"') do (
    set ip=%%a
    setlocal enabledelayedexpansion
    set ip=!ip: =!
    echo    http://!ip!:5173
    endlocal
)

echo.
echo 💡 Use any of the above URLs to access from other devices
echo.

REM Start the development server
echo 🚀 Starting development server...
echo.
npm run dev:network

pause
