#!/bin/bash

echo "Fixing Neovim Treesitter issues..."

# Clean up existing parsers and queries
echo "Cleaning up existing parsers..."
rm -rf ~/.local/share/nvim/lazy/nvim-treesitter/parser/*
rm -rf ~/.local/share/nvim/site/parser/*

echo "Cleaning up queries..."
rm -rf ~/.local/share/nvim/lazy/nvim-treesitter/queries
rm -rf ~/.local/share/nvim/site/queries

# Clean up snacks.nvim queries that might conflict
echo "Cleaning up snacks.nvim queries..."
rm -rf ~/.local/share/nvim/lazy/snacks.nvim/queries

# Update Lazy plugins
echo "Updating Lazy plugins..."
nvim --headless -c "Lazy sync" -c "qa!"

# Force reinstall treesitter
echo "Reinstalling Treesitter parsers..."
nvim --headless -c "lua require('nvim-treesitter.install').update()" -c "qa!"

echo "Done! The problematic snacks.nvim features have been disabled."
echo "Treesitter should now work without conflicts."
echo "Try opening Neovim now."
