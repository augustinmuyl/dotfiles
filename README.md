# Dotfiles

A repo for my personal dotfiles setup.

## Structure

```text
.
├── ghostty
├── git
├── nvim
├── ruff
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

> Installation via [`Homebrew`](https://brew.sh/) recommended

### 1. Clone the repo

```bash
git clone https://github.com/augustinmuyl/dotfiles.git
cd dotfiles
```

### 2. Make `tmux` scripts executable

```bash
chmod +x tmux/.ready-tmux
chmod +x tmux/bin/ready-tmux
chmod +x tmux/bin/setup-tmux-launchagent
chmod +x tmux/bin/tmux-kill-sessions
chmod +x tmux/bin/tmux-sessionizer
```

### 3. Symlink the configs

```bash
stow -t ~ git nvim ruff skhd tmux yabai zsh ghostty
```

### 4. Set up the LaunchAgent

```bash
~/bin/setup-tmux-launchagent
```
