# RiftFuel Network Development Server Starter
# PowerShell script to start the development server with network access

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "   RiftFuel - Network Development Server" -ForegroundColor Green  
Write-Host "========================================" -ForegroundColor Green
Write-Host ""

# Function to get network IP addresses
function Get-NetworkIPs {
    $ips = @()
    $adapters = Get-NetAdapter | Where-Object { $_.Status -eq "Up" }
    
    foreach ($adapter in $adapters) {
        $ipConfig = Get-NetIPAddress -InterfaceIndex $adapter.InterfaceIndex -AddressFamily IPv4 -ErrorAction SilentlyContinue
        foreach ($ip in $ipConfig) {
            if ($ip.IPAddress -ne "127.0.0.1" -and $ip.PrefixOrigin -eq "Dhcp" -or $ip.PrefixOrigin -eq "Manual") {
                $ips += @{
                    Name = $adapter.Name
                    IP = $ip.IPAddress
                }
            }
        }
    }
    return $ips
}

# Function to check if port is available
function Test-Port {
    param([int]$Port)
    try {
        $listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Any, $Port)
        $listener.Start()
        $listener.Stop()
        return $true
    }
    catch {
        return $false
    }
}

# Function to add firewall rule
function Add-FirewallRule {
    param([int]$Port)
    
    $ruleName = "RiftFuel Dev Server Port $Port"
    
    # Check if rule already exists
    $existingRule = Get-NetFirewallRule -DisplayName $ruleName -ErrorAction SilentlyContinue
    
    if (-not $existingRule) {
        try {
            Write-Host "🔥 Adding firewall rule for port $Port..." -ForegroundColor Yellow
            New-NetFirewallRule -DisplayName $ruleName -Direction Inbound -Protocol TCP -LocalPort $Port -Action Allow -ErrorAction Stop
            Write-Host "✅ Firewall rule added successfully" -ForegroundColor Green
        }
        catch {
            Write-Host "⚠️  Could not add firewall rule. You may need to run as administrator." -ForegroundColor Yellow
            Write-Host "   Manual command: New-NetFirewallRule -DisplayName '$ruleName' -Direction Inbound -Protocol TCP -LocalPort $Port -Action Allow" -ForegroundColor Gray
        }
    }
}

# Check Node.js installation
try {
    $nodeVersion = node --version
    Write-Host "✅ Node.js version: $nodeVersion" -ForegroundColor Green
}
catch {
    Write-Host "❌ Node.js is not installed or not in PATH" -ForegroundColor Red
    Write-Host "   Please install Node.js from https://nodejs.org/" -ForegroundColor Yellow
    Read-Host "Press Enter to exit"
    exit 1
}

# Check if dependencies are installed
if (-not (Test-Path "node_modules")) {
    Write-Host "📦 Installing dependencies..." -ForegroundColor Yellow
    npm install
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Failed to install dependencies" -ForegroundColor Red
        Read-Host "Press Enter to exit"
        exit 1
    }
}

# Check port availability
$port = 5173
if (-not (Test-Port -Port $port)) {
    Write-Host "⚠️  Port $port is already in use. The server will try to use the next available port." -ForegroundColor Yellow
}

# Add firewall rule
Add-FirewallRule -Port $port

# Display network information
Write-Host "🌐 Network Access URLs:" -ForegroundColor Cyan
Write-Host "------------------------" -ForegroundColor Cyan

$networkIPs = Get-NetworkIPs
if ($networkIPs.Count -eq 0) {
    Write-Host "❌ No active network interfaces found" -ForegroundColor Red
} else {
    foreach ($ip in $networkIPs) {
        $url = "http://$($ip.IP):$port"
        Write-Host "📱 $($ip.Name): $url" -ForegroundColor White
    }
}

Write-Host ""
Write-Host "💡 Instructions:" -ForegroundColor Yellow
Write-Host "1. Make sure your devices are on the same WiFi network" -ForegroundColor Gray
Write-Host "2. Use any of the URLs above on your mobile device or other computer" -ForegroundColor Gray
Write-Host "3. The server will automatically open your default browser" -ForegroundColor Gray

Write-Host ""
Write-Host "🚀 Starting development server..." -ForegroundColor Green
Write-Host ""

# Start the development server
try {
    npm run dev:network
}
catch {
    Write-Host "❌ Failed to start development server" -ForegroundColor Red
    Write-Host "Error: $_" -ForegroundColor Red
}

Write-Host ""
Write-Host "👋 Server stopped. Press Enter to exit..." -ForegroundColor Yellow
Read-Host
