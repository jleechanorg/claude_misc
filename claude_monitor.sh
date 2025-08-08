#\!/bin/bash
# Claude Code Memory Leak Monitor

while true; do
    MEM_PCT=$(free | grep Mem | awk "{print int(\/\*100)}")
    
    if [ "$MEM_PCT" -gt 80 ]; then
        echo "$(date): High memory usage: ${MEM_PCT}% - Cleaning cache"
        echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null 2>&1
        echo "$(date): Cache dropped"
    fi
    
    if [ "$MEM_PCT" -gt 90 ]; then
        echo "$(date): CRITICAL memory usage: ${MEM_PCT}% - Emergency cleanup"
        pkill -f claude > /dev/null 2>&1
        echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null 2>&1
    fi
    
    sleep 10
done
