# Dotfiles

![Workspace with apps](screenshots/screenshot-app.png)
![Empty workspace](screenshots/screenshot-empty.png)

My most important dotfiles.

Primarily a Hyprland and Neovim setup with minimal animations and other fluff

## Install script

`install.sh` will symlink all files from this repository into the corresponding locations in your home directory.

If a file already exists, the script will prompt before replacing it. When you choose to replace it, the existing file is moved to a timestamped backup directory at:

`~/dotfiles_backup/<timestamp>/`

This allows you to restore your previous configuration if needed.

**Disclaimer:**
This script modifies files in your home directory. While it attempts to back up existing files before replacing them, use it at your own risk and review the script before running it.
It is primarily intended for my own personal use when bootstrapping new machines.

## Programs

I don't guarantee that this list will be kept up to date, but here is a non-exhaustive list of applications with configs in this repo

* GDB
* Zsh
* ClangFormat
* Alacritty
* Hyprland
* Neovim
* Waybar
* Wofi

## Credits

[albinalm – thanks for the wallpaper](https://github.com/albinalm/)
