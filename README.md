Repository for Claude Code WSL2 memory leak workarounds

See GitHub issue: https://github.com/anthropics/claude-code/issues/2938

Files:
- claude_monitor.sh: Memory monitoring script
- claude_restart.bat: Windows WSL restart script
- README.md: Full documentation

Usage: Start monitor with: nohup ./claude_monitor.sh > monitor.log 2>&1 &
## Persistent Monitoring with Crontab

To make the monitor persistent across WSL restarts:

1. **Add to crontab:**
   ```bash
   crontab -e
   
   # Add these lines:
   @reboot /path/to/claude_misc/start_monitor.sh
   */5 * * * * /path/to/claude_misc/start_monitor.sh
   ```

2. **Use the startup script:**
   ```bash
   # The start_monitor.sh script will:
   # - Check if monitor is already running
   # - Start it if not running
   # - Log startup events
   ```

3. **Monitor logs:**
   ```bash
   # Check startup events
   tail -f ~/claude_monitor_startup.log
   
   # Check monitor activity  
   tail -f ~/claude_misc/claude_monitor.log
   ```