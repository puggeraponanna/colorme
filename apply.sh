#!/bin/bash

# Default scheme
SCHEME=${1:-nord}

echo "Applying colorscheme: $SCHEME"

# Ensure directories exist
mkdir -p ~/.config/nvim/colors
mkdir -p ~/.config/ghostty

# 1. Neovim
if [ -f "output/neovim/${SCHEME}.lua" ]; then
    echo "  - Copying Neovim colorscheme to ~/.config/nvim/colors/${SCHEME}.lua"
    cp "output/neovim/${SCHEME}.lua" ~/.config/nvim/colors/
    echo "    (Tip: Add 'vim.cmd(\"colorscheme ${SCHEME}\")' to your init.lua)"
else
    echo "  - Warning: Neovim scheme for $SCHEME not found."
fi

# 2. Tmux
if [ -f "output/tmux/${SCHEME}.conf" ]; then
    mkdir -p ~/.config/tmux
    echo "  - Copying Tmux configuration to ~/.config/tmux/tmux.conf.colors"
    cp "output/tmux/${SCHEME}.conf" ~/.config/tmux/tmux.conf.colors
    echo "    (Tip: Add 'source-file ~/.config/tmux/tmux.conf.colors' to your ~/.tmux.conf or ~/.config/tmux/tmux.conf)"
fi

# 3. Ghostty
if [ -f "output/ghostty/${SCHEME}" ]; then
    echo "  - Copying Ghostty configuration to ~/.config/ghostty/theme"
    cp "output/ghostty/${SCHEME}" ~/.config/ghostty/theme
    echo "    (Tip: Add 'config-file = theme' to your ~/.config/ghostty/config)"
fi

# 4. FZF
if [ -f "output/fzf/${SCHEME}.sh" ]; then
    echo "  - Copying FZF setup to ~/.fzf_colors.sh"
    cp "output/fzf/${SCHEME}.sh" ~/.fzf_colors.sh
    echo "    (Tip: Add 'source ~/.fzf_colors.sh' to your ~/.zshrc or ~/.bashrc)"
fi

# 5. Starship
if [ -f "output/starship/${SCHEME}.toml" ]; then
    echo "  - Copying Starship palette to ~/.config/starship_colors.toml"
    cp "output/starship/${SCHEME}.toml" ~/.config/starship_colors.toml
    echo "    (Tip: Add 'palette = \"${SCHEME}\"' and 'format = ...' setup to your starship.toml. You can 'add_to_config = \"~/.config/starship_colors.toml\"' if using newer starship versions or just manual copy.)"
fi

echo "Done! Some apps might require a restart or manual sourcing to reflect changes."
