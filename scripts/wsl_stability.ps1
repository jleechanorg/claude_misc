# WSL2 Stability Management Script
# Run as Administrator in PowerShell

Write-Host "🔧 WSL2 Stability Management" -ForegroundColor Green

function Restart-WSLServices {
    Write-Host "Restarting WSL services..." -ForegroundColor Yellow
    
    try {
        Stop-Service -Name vmcompute -Force
        Start-Service -Name vmcompute
        Write-Host "✅ vmcompute service restarted" -ForegroundColor Green
    }
    catch {
        Write-Host "❌ Failed to restart vmcompute: $_" -ForegroundColor Red
    }
    
    try {
        Stop-Service -Name hvhost -Force  
        Start-Service -Name hvhost
        Write-Host "✅ hvhost service restarted" -ForegroundColor Green
    }
    catch {
        Write-Host "❌ Failed to restart hvhost: $_" -ForegroundColor Red
    }
    
    try {
        Stop-Service -Name LxssManager -Force
        Start-Service -Name LxssManager  
        Write-Host "✅ LxssManager service restarted" -ForegroundColor Green
    }
    catch {
        Write-Host "❌ Failed to restart LxssManager: $_" -ForegroundColor Red
    }
}

function Kill-WSLProcesses {
    Write-Host "Killing WSL processes..." -ForegroundColor Yellow
    
    Get-Process -Name "wsl*" -ErrorAction SilentlyContinue | Stop-Process -Force
    Get-Process -Name "wslhost*" -ErrorAction SilentlyContinue | Stop-Process -Force
    
    Write-Host "✅ WSL processes terminated" -ForegroundColor Green
}

function Reset-WSL {
    Write-Host "Performing full WSL reset..." -ForegroundColor Yellow
    
    wsl --shutdown
    Start-Sleep -Seconds 3
    
    Kill-WSLProcesses
    Restart-WSLServices
    
    Write-Host "✅ WSL reset complete" -ForegroundColor Green
    Write-Host "You can now restart WSL with: wsl" -ForegroundColor Cyan
}

# Main menu
Write-Host ""
Write-Host "Choose an option:"
Write-Host "1. Restart WSL services only"
Write-Host "2. Kill WSL processes only" 
Write-Host "3. Full WSL reset (recommended)"
Write-Host ""

$choice = Read-Host "Enter choice (1-3)"

switch ($choice) {
    "1" { Restart-WSLServices }
    "2" { Kill-WSLProcesses }
    "3" { Reset-WSL }
    default { Write-Host "Invalid choice" -ForegroundColor Red }
}