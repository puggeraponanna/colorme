#!/bin/bash

# Default scheme
SCHEME=${1:-nord}

echo "Applying colorscheme: $SCHEME"

# Ensure directories exist
mkdir -p ~/.config/nvim/colors
mkdir -p ~/.config/ghostty

# 1. Neovim
if [ -f "output/neovim/${SCHEME}.lua" ]; then
    mkdir -p ~/.config/nvim/lua
    mkdir -p ~/.config/nvim/colors

    echo "  - Copying Neovim Lua module to ~/.config/nvim/lua/colorme.lua"
    cp "output/neovim/${SCHEME}.lua" ~/.config/nvim/lua/colorme.lua
    
    echo "  - Creating Neovim colorscheme wrapper at ~/.config/nvim/colors/colorme.lua"
    echo "require('colorme')" > ~/.config/nvim/colors/colorme.lua
    
    echo "    (Tip: Add 'vim.cmd(\"colorscheme colorme\")' to your init.lua)"
    echo "    (Tip: You can now use require('colorme').lualine_theme for lualine setup)"
else
    echo "  - Warning: Neovim scheme for $SCHEME not found."
fi

# 2. Tmux
if [ -f "output/tmux/${SCHEME}.conf" ]; then
    mkdir -p ~/.config/tmux
    echo "  - Copying Tmux configuration to ~/.config/tmux/colorme.conf"
    cp "output/tmux/${SCHEME}.conf" ~/.config/tmux/colorme.conf
    echo "    (Tip: Add 'source-file ~/.config/tmux/colorme.conf' to your ~/.tmux.conf or ~/.config/tmux/tmux.conf)"
fi

# 3. Ghostty
if [ -f "output/ghostty/${SCHEME}" ]; then
    echo "  - Copying Ghostty configuration to ~/.config/ghostty/colorme"
    cp "output/ghostty/${SCHEME}" ~/.config/ghostty/colorme
    echo "    (Tip: Add 'config-file = colorme' to your ~/.config/ghostty/config)"
fi

# 4. FZF
if [ -f "output/fzf/${SCHEME}.sh" ]; then
    echo "  - Copying FZF setup to ~/.fzf_colors.sh"
    cp "output/fzf/${SCHEME}.sh" ~/.fzf_colors.sh
    echo "    (Tip: Add 'source ~/.fzf_colors.sh' to your ~/.zshrc or ~/.bashrc)"
fi

if [ -f "output/starship/${SCHEME}.toml" ]; then
    if [ -f ~/.config/starship_base.toml ]; then
        echo "  - Generating Starship configuration (merging base + ${SCHEME} colors)"
        cat ~/.config/starship_base.toml "output/starship/${SCHEME}.toml" > ~/.config/starship.toml
    else
        echo "  - Warning: ~/.config/starship_base.toml not found."
    fi
fi

# 6. Bat
if [ -f "output/bat/${SCHEME}.tmTheme" ]; then
    echo "  - Installing Bat theme"
    mkdir -p ~/.config/bat/themes
    cp "output/bat/${SCHEME}.tmTheme" ~/.config/bat/themes/colorme.tmTheme
    bat cache --build > /dev/null
    
    # Ensure theme is set in bat config
    mkdir -p ~/.config/bat
    touch ~/.config/bat/config
    if ! grep -q "colorme" ~/.config/bat/config; then
        echo "--theme=\"colorme\"" >> ~/.config/bat/config
    fi
fi

echo "Done! Some apps might require a restart or manual sourcing to reflect changes."
