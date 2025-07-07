#!/bin/bash
# Fix script for gracetopdf bash completion
# This script fixes the common issue where the completion file path
# was added to .bashrc without the 'source' command

set -euo pipefail

COMPLETION_FILE="$HOME/.local/share/bash-completion/completions/gracetopdf"
BASHRC_FILE="$HOME/.bashrc"

echo "Fixing gracetopdf bash completion in $BASHRC_FILE..."

# Check if the problematic line exists
if grep -qF "$COMPLETION_FILE" "$BASHRC_FILE" && ! grep -qF "source $COMPLETION_FILE" "$BASHRC_FILE"; then
    echo "Found problematic line in .bashrc, fixing..."
    
    # Create a backup
    cp "$BASHRC_FILE" "$BASHRC_FILE.backup.$(date +%Y%m%d_%H%M%S)"
    echo "Created backup: $BASHRC_FILE.backup.$(date +%Y%m%d_%H%M%S)"
    
    # Remove the problematic line and add the correct one
    sed -i "\|^$COMPLETION_FILE$|d" "$BASHRC_FILE"
    
    # Add the correct completion loading code
    cat >> "$BASHRC_FILE" << EOF

# Load gracetopdf bash completion
if [ -f ~/.local/share/bash-completion/completions/gracetopdf ]; then
    source ~/.local/share/bash-completion/completions/gracetopdf
fi
EOF
    
    echo "✓ Fixed bash completion in .bashrc"
    echo "Please run 'source ~/.bashrc' or restart your terminal to apply the changes."
    
elif grep -qF "source $COMPLETION_FILE" "$BASHRC_FILE"; then
    echo "✓ Bash completion is already properly configured in .bashrc"
    
else
    echo "Adding bash completion to .bashrc..."
    cat >> "$BASHRC_FILE" << EOF

# Load gracetopdf bash completion
if [ -f ~/.local/share/bash-completion/completions/gracetopdf ]; then
    source ~/.local/share/bash-completion/completions/gracetopdf
fi
EOF
    echo "✓ Added bash completion to .bashrc"
    echo "Please run 'source ~/.bashrc' or restart your terminal to apply the changes."
fi
