# sondhg's dotfile configs

## Steps to bootstrap a new Linux PC

1. Install Zsh and a terminal, preferably Wezterm
2. Clone repo into new hidden directory

```bash
git clone https://github.com/sondhg/.dotfiles.git ~/.dotfiles
```

3. Create symlinks in `$HOME` directory to the real files in the repo

```bash
# There are better and less manual ways to do this: install scripts, bootstrapping tools, etc.
# But this is the simplest way to get started quickly.
ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/.bat-config ~/.config/bat/config
ln -s ~/.dotfiles/fastfetch-config.jsonc ~/.config/fastfetch/config.jsonc
ln -s ~/.dotfiles/.wezterm.lua ~/.wezterm.lua
ln -s ~/.dotfiles/yazi ~/.config/yazi
```

4. Install Homebrew, followed by the software listed in the `Brewfile`

```bash
# These could also be in an install script

# Install Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Then follow the instructions shown in terminal to add Homebrew to your PATH

# Then pass in the Brewfile location
brew bundle --file ~/.dotfiles/Brewfile

# ... or move to the directory first
cd ~/.dotfiles
brew bundle
```

## TODO list

- Organize these steps into multiple scripts
- Automate symlinking and run scripts with tools like Dotbot
- Revisit the list in `.zshrc` to customize shell
