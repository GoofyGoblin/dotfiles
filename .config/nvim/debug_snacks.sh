#!/bin/bash

# Script to test snacks.nvim features one by one to isolate Treesitter conflicts
echo "🔍 Debugging snacks.nvim Treesitter compatibility..."

# List of features to test
features=(
    "bigfile"
    "dashboard"
    "explorer"
    "indent"
    "input"
    "notifier"
    "picker"
    "quickfile"
    "scope"
    "scroll"
    "statuscolumn"
    "words"
    "zen"
    "scratch"
    "bufdelete"
    "rename"
    "gitbrowse"
    "lazygit"
    "terminal"
    "toggle"
)

# Function to test a feature
test_feature() {
    local feature=$1
    echo "🧪 Testing feature: $feature"
    
    # Enable the feature in the config
    sed -i "s/${feature} = { enabled = false }/${feature} = { enabled = true }/" /home/winterwinterwinter/.config/nvim/lua/plugins/snacks.lua
    
    # Test if nvim starts without errors
    if nvim --headless -c "echo 'Testing $feature'" -c "qa!" 2>&1 | grep -q "stack traceback.*treesitter"; then
        echo "❌ $feature causes Treesitter error!"
        # Disable it again
        sed -i "s/${feature} = { enabled = true }/${feature} = { enabled = false }/" /home/winterwinterwinter/.config/nvim/lua/plugins/snacks.lua
        return 1
    else
        echo "✅ $feature works fine"
        return 0
    fi
}

# Test each feature
problematic_features=()
working_features=()

for feature in "${features[@]}"; do
    if test_feature "$feature"; then
        working_features+=("$feature")
    else
        problematic_features+=("$feature")
    fi
    echo ""
done

echo "📊 Results:"
echo "✅ Working features: ${working_features[*]}"
echo "❌ Problematic features: ${problematic_features[*]}"

echo ""
echo "💡 Next steps:"
if [ ${#problematic_features[@]} -eq 0 ]; then
    echo "All features work! The issue might be with keymaps or interactions."
else
    echo "Focus on debugging these problematic features: ${problematic_features[*]}"
fi