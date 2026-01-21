#!/usr/bin/env bash
set -e

DOTFILES="$HOME/repos/dotfiles"
BACKUP_DIR="$HOME/dotfiles_backup/$(date +%Y%m%d%H%M%S)"

mkdir -p "$BACKUP_DIR"

link_file() {
    local src="$1"
    local dest="$2"
    
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "File already exists: $dest"
        read -p "Do you want to back it up and replace it? [y/N] " choice < /dev/tty
        if [[ "$choice" =~ ^[Yy]$ ]]; then
            mkdir -p "$(dirname "$BACKUP_DIR/${dest#$HOME/}")"
            mv "$dest" "$BACKUP_DIR/${dest#$HOME/}"
            echo "Backed up $dest -> $BACKUP_DIR"
        else
            echo -e "Skipping $dest\n"
            return
        fi
    fi
    
    mkdir -p "$(dirname "$dest")"
    ln -s "$src" "$dest"
    echo -e "Linked $dest -> $src\n"
}

find "$DOTFILES" -type f -not -path "*/.git/*" | while read -r file; do
    rel_path="${file#$DOTFILES/}"
    
    # Skip script itself and README
    [[ "$rel_path" == "install.sh" || "$rel_path" == "README.md" ]] && continue
    
    dest="$HOME/$rel_path"
    link_file "$file" "$dest"
done

echo "Done! Backup created at: $BACKUP_DIR"
