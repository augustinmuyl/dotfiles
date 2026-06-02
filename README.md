# Dotfiles

A repo for my personal dotfiles setup.

## Structure

```text
.
├── ghostty
├── git
├── nvim
├── ruff
├── scripts
├── skhd
├── tmux
│   └── bin
├── yabai
└── zsh
```

## Initialization

To set up the environment on a new machine (macOS):

### Prerequisites

- [`neovim`](https://neovim.io/)
- [`tmux`](https://github.com/tmux/tmux/wiki)
- [`fzf`](https://github.com/junegunn/fzf)
- [`stow`](https://www.gnu.org/software/stow/)
- [`ripgrep`](https://github.com/BurntSushi/ripgrep)
- [`fd`](https://github.com/sharkdp/fd)
- [`bat`](https://github.com/sharkdp/bat)
- [`yabai`](https://github.com/koekeishiya/yabai)
- [`skhd`](https://github.com/koekeishiya/skhd)
- [`fastfetch`](https://github.com/fastfetch-cli/fastfetch)
- [`pyenv`](https://github.com/pyenv/pyenv)
- [`rbenv`](https://github.com/rbenv/rbenv)
- [`nvm`](https://github.com/nvm-sh/nvm)
- [`timewarrior`](https://timewarrior.net/)
- [`ruff`](https://docs.astral.sh/ruff/)
- [`markdownlint-cli`](https://github.com/igorshubovych/markdownlint-cli)
- [`tinymist`](https://github.com/Myriad-Dreamin/tinymist)
- [`unzip`](https://infozip.sourceforge.net/)
- [`pure`](https://github.com/sindresorhus/pure)

Install the command-line tools via [Homebrew](https://brew.sh/):

```bash
brew install neovim tmux fzf stow ripgrep fd bat yabai skhd fastfetch pyenv rbenv nvm timewarrior ruff markdownlint-cli tinymist unzip pure
```

### 1. Clone the repo

```bash
git clone https://github.com/augustinmuyl/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles
```

### 2. Install Oh My Zsh

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

### 3. Make `tmux` scripts executable

```bash
chmod +x tmux/.ready-tmux tmux/bin/*
```

### 4. Symlink the configs

```bash
stow -t ~ git nvim ruff skhd tmux yabai zsh ghostty
```

### 5. Set up the LaunchAgent

```bash
~/bin/setup-tmux-launchagent
```
