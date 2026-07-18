#!/bin/bash

if [ -f "$HOME/.zshenv" ]; then
    sed 's/export[ +]ZDOTDIR=.*/ZDOTDIR="$HOME\/.config\/zsh\/g"' "$HOME/.zshenv"
else
    echo 'export ZDOTDIR="$HOME/.config/zsh/"' >> "$HOME/.zshenv"
fi
