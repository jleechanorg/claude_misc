#!/bin/bash
# Install modern session persistence tools

echo "🔧 Installing session persistence tools..."

# Install Zellij (most user-friendly)
if ! command -v zellij &> /dev/null; then
    echo "Installing Zellij..."
    if command -v cargo &> /dev/null; then
        cargo install --locked zellij
    else
        # Download binary release
        curl -L https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz | tar -xz -C ~/.local/bin/
    fi
    echo "✅ Zellij installed"
else
    echo "✅ Zellij already installed"
fi

# Install shpool (lightweight)
if ! command -v shpool &> /dev/null; then
    echo "Installing shpool..."
    if command -v cargo &> /dev/null; then
        cargo install shpool
    else
        echo "❌ Cargo needed for shpool installation"
    fi
    echo "✅ shpool installed"
else
    echo "✅ shpool already installed"
fi

# Create Zellij config
mkdir -p ~/.config/zellij
cat > ~/.config/zellij/config.kdl << 'EOF'
// Zellij config for crash recovery
default_shell "bash"
session_serialization true
pane_viewport_serialization true
scrollback_lines_to_serialize 10000

keybinds {
    normal {
        bind "Ctrl q" { Quit; }
        bind "Ctrl d" { Detach; }
    }
}
EOF

echo "🎉 Session tools installed!"
echo ""
echo "Usage:"
echo "  zellij                    # Start new session"
echo "  zellij attach [name]      # Attach to session"  
echo "  zellij list-sessions      # List all sessions"
echo ""
echo "  shpool attach [name]      # Attach to shpool session"
echo "  shpool list              # List shpool sessions"