#!/bin/bash
# Start Claude monitor if not already running
cd /home/jleechan/claude_misc

# Check if already running
if ps aux | grep -v grep | grep claude_monitor.sh > /dev/null; then
    echo "$(date): Claude monitor already running" >> /home/jleechan/claude_monitor_startup.log
else
    nohup ./claude_monitor.sh > claude_monitor.log 2>&1 &
    echo "$(date): Claude monitor started" >> /home/jleechan/claude_monitor_startup.log
fi