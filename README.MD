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

To set up the environment on a new machine:

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

> Requires [GNU Stow](https://www.gnu.org/software/stow/) – install with `brew install stow`
