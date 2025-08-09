#!/bin/bash
# Session recovery script for WSL crashes

RECOVERY_DIR="$HOME/.wsl_recovery"
SESSION_FILE="$RECOVERY_DIR/last_session.txt"

# Create recovery directory
mkdir -p "$RECOVERY_DIR"

# Function to save current session state
save_session() {
    local timestamp=$(date +"%Y-%m-%d %H:%M:%S")
    
    {
        echo "=== WSL Session Recovery ==="
        echo "Timestamp: $timestamp"
        echo "Working Directory: $(pwd)"
        echo "Git Branch: $(git branch --show-current 2>/dev/null || echo 'not in git repo')"
        echo "Git Status:"
        git status --porcelain 2>/dev/null || echo "Not in git repo"
        echo ""
        echo "Environment Variables:"
        echo "PATH=$PATH"
        echo "VIRTUAL_ENV=$VIRTUAL_ENV"
        echo ""
        echo "Recent Commands (last 10):"
        history | tail -n 10
    } > "$SESSION_FILE"
    
    echo "✅ Session saved to $SESSION_FILE"
}

# Function to restore session
restore_session() {
    if [ -f "$SESSION_FILE" ]; then
        echo "🔄 Restoring last session..."
        cat "$SESSION_FILE"
        echo ""
        echo "To continue where you left off:"
        
        # Extract working directory
        local last_dir=$(grep "Working Directory:" "$SESSION_FILE" | cut -d' ' -f3-)
        if [ -n "$last_dir" ] && [ -d "$last_dir" ]; then
            echo "cd '$last_dir'"
        fi
        
        # Extract git branch
        local last_branch=$(grep "Git Branch:" "$SESSION_FILE" | cut -d' ' -f3-)
        if [ -n "$last_branch" ] && [ "$last_branch" != "not" ]; then
            echo "git checkout $last_branch"
        fi
        
        echo ""
        echo "Run './scripts/auto_commit.sh' to save any pending work"
    else
        echo "❌ No previous session found"
    fi
}

case "$1" in
    "save")
        save_session
        ;;
    "restore")
        restore_session
        ;;
    *)
        echo "Usage: $0 {save|restore}"
        echo "  save    - Save current session state"
        echo "  restore - Show last session info"
        ;;
esac