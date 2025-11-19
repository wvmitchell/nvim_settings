# nvim_settings

My personal Neovim configuration files for easy computer switching. This repository contains my Neovim dotfiles, designed to be portable and simple to deploy across multiple machines.

## What is this?

This repository stores my Neovim configuration, making it easy to maintain consistent editor settings across different computers. By keeping these dotfiles in version control, I can quickly set up my preferred Neovim environment on any new machine or keep existing setups synchronized.

## Installation

### Quick Setup

1. Clone this repository:
   ```bash
   git clone https://github.com/wvmitchell/nvim_settings.git ~/.config/nvim
   ```

2. Install plugins (if using a plugin manager like lazy.nvim or packer):
   ```bash
   nvim +PackerSync  # or the appropriate command for your plugin manager
   ```

3. Restart Neovim to apply all configurations

### Alternative: Manual Configuration

If you already have a config and want to test this one:
```bash
git clone https://github.com/wvmitchell/nvim_settings.git ~/nvim_backup
mv ~/.config/nvim ~/.config/nvim.old
mv ~/nvim_backup ~/.config/nvim
```

## Usage

After installation, Neovim will automatically use the configuration from this repository. Any updates to the configuration can be pulled down:

```bash
cd ~/.config/nvim
git pull
```

Then restart Neovim or source your config (`:source $MYVIMRC`).

## Updating Configuration

When you make changes to your Neovim configuration:

1. Edit the configuration files in this repository
2. Test your changes by restarting Neovim or sourcing the config
3. Commit and push your changes:
   ```bash
   git add .
   git commit -m "Update nvim configuration"
   git push
   ```

## Related Repositories

- [tmux_settings](https://github.com/wvmitchell/tmux_settings) - My tmux configuration files

Together, these repositories provide a complete terminal development environment that can be quickly deployed on any machine.

## About Neovim

Neovim is a hyperextensible text editor based on Vim. It provides:
- Modern terminal features and UI
- Built-in LSP (Language Server Protocol) support
- Lua-based configuration
- Async job control
- Extensive plugin ecosystem

For more information about Neovim, visit the [official Neovim website](https://neovim.io/).
