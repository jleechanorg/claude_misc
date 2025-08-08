#!/bin/bash
# Claude Code Memory Leak Monitor - Fixed Version

echo "$(date): Claude Code memory monitor started"

while true; do
    # Get memory percentage
    MEM_PCT=$(free | grep Mem | awk '{print int($3/$2*100)}')
    
    # Log current status every minute (6 cycles)
    if [ $(($(date +%s) % 60)) -lt 10 ]; then
        echo "$(date): Memory usage: ${MEM_PCT}%"
    fi
    
    # Clean cache when memory > 80%
    if [ "$MEM_PCT" -gt 80 ]; then
        echo "$(date): HIGH memory usage: ${MEM_PCT}% - Cleaning cache"
        echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null 2>&1
        echo "$(date): Cache cleaned"
    fi
    
    # Emergency cleanup when memory > 90%
    if [ "$MEM_PCT" -gt 90 ]; then
        echo "$(date): CRITICAL memory usage: ${MEM_PCT}% - Emergency cleanup"
        pkill -f claude > /dev/null 2>&1
        echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null 2>&1
        echo "$(date): Emergency cleanup completed"
    fi
    
    sleep 10
done