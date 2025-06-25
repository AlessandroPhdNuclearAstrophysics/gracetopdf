#!/bin/bash
# Test script for gracetopdf bash completion

echo "Testing gracetopdf bash completion..."

# Source the completion script
if [ -f "bash_completion/gracetopdf" ]; then
    source bash_completion/gracetopdf
    echo "✓ Bash completion script loaded"
else
    echo "✗ Bash completion script not found"
    exit 1
fi

# Test if the completion function is defined
if declare -f _gracetopdf_completion > /dev/null; then
    echo "✓ Completion function _gracetopdf_completion is defined"
else
    echo "✗ Completion function not found"
    exit 1
fi

# Test if completion is registered for gracetopdf
if complete -p gracetopdf > /dev/null 2>&1; then
    echo "✓ Completion is registered for gracetopdf command"
else
    echo "✗ Completion not registered for gracetopdf"
    exit 1
fi

# Test if completion is registered for xmgracetopdf alias
if complete -p xmgracetopdf > /dev/null 2>&1; then
    echo "✓ Completion is registered for xmgracetopdf alias"
else
    echo "✗ Completion not registered for xmgracetopdf alias"
    exit 1
fi

echo ""
echo "Bash completion test passed!"
echo ""
echo "To manually test completion:"
echo "1. Source the completion script: source bash_completion/gracetopdf"
echo "2. Try typing: gracetopdf --<TAB>"
echo "3. Try typing: gracetopdf --dpi <TAB>"
echo "4. Try typing: gracetopdf <TAB> (should show .agr files)"
echo "5. Try typing: xmgracetopdf --<TAB> (alias should work too)"
