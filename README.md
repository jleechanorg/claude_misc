Repository for Claude Code WSL2 memory leak workarounds

See GitHub issue: https://github.com/anthropics/claude-code/issues/2938

Files:
- claude_monitor.sh: Memory monitoring script
- claude_restart.bat: Windows WSL restart script
- README.md: Full documentation

Usage: Start monitor with: nohup ./claude_monitor.sh > monitor.log 2>&1 &
