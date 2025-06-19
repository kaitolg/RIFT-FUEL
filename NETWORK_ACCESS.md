# Network Access Setup for RiftFuel

This guide explains how to make your RiftFuel development server accessible from other devices on your network (mobile phones, tablets, other computers).

## Quick Start

### Option 1: Use the Automated Scripts (Recommended)

#### Windows PowerShell (Recommended)
```powershell
# Right-click PowerShell and "Run as Administrator" for best results
.\start-network.ps1
```

#### Windows Command Prompt
```cmd
start-network.bat
```

#### Node.js Script (Cross-platform)
```bash
npm run start:network
```

### Option 2: Manual Commands

#### Standard Vite with Network Access
```bash
npm run dev:network
```

#### Or use the regular dev command (now configured for network access)
```bash
npm run dev
```

## Your Network Information

Based on your current network configuration:

- **Primary IP Address**: `192.168.100.85`
- **Network**: `192.168.100.0/24`
- **Gateway**: `192.168.100.1`

### Access URLs

Once the server is running, you can access your app from other devices using:

- **Main URL**: `http://192.168.100.85:5173`
- **Localhost** (same computer): `http://localhost:5173`

## Device Setup Instructions

### Mobile Devices (iOS/Android)
1. Connect your mobile device to the **same WiFi network** as your computer
2. Open your mobile browser (Safari, Chrome, etc.)
3. Navigate to: `http://192.168.100.85:5173`
4. The RiftFuel app should load normally

### Other Computers
1. Ensure the computer is on the **same network**
2. Open any web browser
3. Navigate to: `http://192.168.100.85:5173`

## Troubleshooting

### Common Issues

#### 1. "Site can't be reached" or Connection Refused
**Cause**: Firewall blocking the connection

**Solutions**:
```powershell
# Run as Administrator in PowerShell
New-NetFirewallRule -DisplayName "RiftFuel Dev Server" -Direction Inbound -Protocol TCP -LocalPort 5173 -Action Allow
```

Or manually:
1. Open Windows Defender Firewall
2. Click "Advanced settings"
3. Click "Inbound Rules" → "New Rule"
4. Select "Port" → "TCP" → "Specific local ports" → Enter `5173`
5. Select "Allow the connection"
6. Apply to all profiles
7. Name it "RiftFuel Dev Server"

#### 2. Different Port Number
If port 5173 is busy, Vite will automatically use the next available port (5174, 5175, etc.). Update your URLs accordingly.

#### 3. IP Address Changed
If your computer's IP address changes:
1. Run `ipconfig` in Command Prompt
2. Look for "IPv4 Address" under your active network adapter
3. Update the URL with the new IP address

#### 4. Network Not Working
- Ensure all devices are on the same WiFi network
- Try disabling VPN if you're using one
- Restart your router if needed
- Check if your network allows device-to-device communication

### Advanced Troubleshooting

#### Check Network Connectivity
```cmd
# From another device, ping your computer
ping 192.168.100.85
```

#### Check if Port is Open
```powershell
# Test if the port is accessible
Test-NetConnection -ComputerName 192.168.100.85 -Port 5173
```

#### Alternative Port
If you need to use a different port, modify `vite.config.js`:
```javascript
server: {
  host: true,
  port: 3000, // Change to your preferred port
  // ...
}
```

## Security Considerations

### Development Only
- This setup is for **development only**
- Never use this configuration in production
- The server is accessible to anyone on your network

### Network Security
- Only use on trusted networks (home/office WiFi)
- Avoid using on public WiFi networks
- Consider using a VPN for additional security

## Configuration Details

### Files Modified
- `vite.config.js` - Added `host: true` to server config
- `package.json` - Added network-specific scripts
- Created helper scripts for easy startup

### Vite Configuration
```javascript
server: {
  host: true, // Listen on all network interfaces (0.0.0.0)
  port: 5173, // Default Vite port
  hmr: {
    overlay: false
  }
}
```

## Testing Checklist

- [ ] Server starts without errors
- [ ] Localhost access works (`http://localhost:5173`)
- [ ] Network access works (`http://192.168.100.85:5173`)
- [ ] Mobile device can access the site
- [ ] All features work on mobile (authentication, navigation, etc.)
- [ ] PWA features work (if applicable)

## Support

If you encounter issues:

1. Check the console output for error messages
2. Verify your network configuration with `ipconfig`
3. Test connectivity with `ping` from other devices
4. Check Windows Firewall settings
5. Try restarting the development server

## Additional Scripts

### Get Network Information
```bash
node scripts/start-network-server.js
```

### Manual Firewall Rule (PowerShell as Admin)
```powershell
New-NetFirewallRule -DisplayName "RiftFuel Dev Server" -Direction Inbound -Protocol TCP -LocalPort 5173 -Action Allow
```

### Remove Firewall Rule (if needed)
```powershell
Remove-NetFirewallRule -DisplayName "RiftFuel Dev Server"
```
