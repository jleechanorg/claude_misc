#!/bin/bash
# Auto-commit script to save work frequently

# Function to perform auto-commit
auto_commit() {
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    
    # Check if there are any changes
    if ! git diff --quiet || ! git diff --cached --quiet; then
        echo "[$timestamp] Auto-saving changes..."
        
        # Add all changes
        git add .
        
        # Create commit with timestamp
        git commit -m "Auto-save: $timestamp

🔄 Automatic save to prevent data loss from WSL crashes"
        
        echo "✅ Changes auto-committed"
    else
        echo "[$timestamp] No changes to save"
    fi
}

# If run with 'watch' parameter, run continuously
if [ "$1" = "watch" ]; then
    echo "Starting auto-commit watcher (every 5 minutes)..."
    echo "Press Ctrl+C to stop"
    
    while true; do
        auto_commit
        sleep 300  # 5 minutes
    done
else
    # Single run
    auto_commit
fi