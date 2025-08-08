# WSL Crash Recovery Setup

## Quick Recovery Commands

```bash
# Modern session persistence (recommended)
zellij                              # Start crash-resistant session
zellij attach main                  # Resume after crash

# Traditional recovery
./scripts/session_recovery.sh save  # Save current session
./scripts/session_recovery.sh restore # Restore after crash

# Auto-save work
./scripts/auto_commit.sh watch &    # Auto-commit every 5 minutes
./scripts/auto_commit.sh            # Manual save

# WSL system fixes (run from Windows PowerShell as Admin)
scripts\wsl_stability.ps1          # Full WSL reset and service restart
scripts\wsl_restart.bat            # Basic WSL restart
```

## What's Been Set Up

1. **Higher Memory**: `.wslconfig` allows 16GB RAM + 4GB swap for development
2. **Modern Session Tools**: Zellij/shpool for crash-resistant terminals
3. **Auto-Save**: `auto_commit.sh` saves git changes every 5 minutes  
4. **Session Recovery**: Saves/restores working directory, git branch, recent commands
5. **System Stability**: PowerShell script to fix WSL services

## Usage

- **Before working**: `./scripts/session_recovery.sh save`
- **During work**: Run `./scripts/auto_commit.sh watch` in background
- **After crash**: `./scripts/session_recovery.sh restore` to see where you were
- **WSL issues**: Double-click `scripts\wsl_restart.bat` from Windows

## Files Created

- `/c/Users/jnlc3/.wslconfig` - WSL memory configuration
- `scripts/auto_commit.sh` - Auto-save git changes
- `scripts/session_recovery.sh` - Save/restore session state  
- `scripts/wsl_restart.bat` - Windows batch to restart WSL
- `$HOME/.wsl_recovery/` - Session recovery data directory