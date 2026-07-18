#!/bin/bash
# Point zsh at the synced config in ~/.config/zsh.
#
# ~/.zshenv cannot live in ~/.config: zsh reads it from $HOME before ZDOTDIR
# exists, so this one line is the bootstrap that can't bootstrap itself.
# Run once per workstation. Safe to re-run.

set -euo pipefail

ZSHENV="$HOME/.zshenv"
# Single-quoted so $HOME is written literally and expands at shell startup,
# not now — the file must stay portable across machines.
LINE='export ZDOTDIR="$HOME/.config/zsh"'

if [ ! -e "$ZSHENV" ]; then
    printf '%s\n' "$LINE" > "$ZSHENV"
    echo "created $ZSHENV"
elif grep -qE '^[[:space:]]*(export[[:space:]]+)?ZDOTDIR=' "$ZSHENV"; then
    # Replace the existing assignment in place. | as delimiter so the path's
    # slashes need no escaping.
    sed -i -E "s|^[[:space:]]*(export[[:space:]]+)?ZDOTDIR=.*|$LINE|" "$ZSHENV"
    echo "updated ZDOTDIR in $ZSHENV"
else
    # File exists but has no ZDOTDIR — append rather than silently doing
    # nothing. Guard against a missing trailing newline on the last line.
    [ -s "$ZSHENV" ] && [ -n "$(tail -c 1 "$ZSHENV")" ] && printf '\n' >> "$ZSHENV"
    printf '%s\n' "$LINE" >> "$ZSHENV"
    echo "appended ZDOTDIR to $ZSHENV"
fi
