**CHANGELOG**

## 0.1.0
### Copy repository home and config trees during Home activation
* Recursively copy dotfiles/home/ to ~/ and dotfiles/config/ to ~/.config/ on each Guix Home activation while preserving files not supplied by the repository.
### Install and update Rogallo with pipx
* Install Rogallo with pipx and update it on each Guix Home activation.
### Add LazyVim runtime dependencies to system packages
* Add gcc, fd, fzf, tree-sitter-cli, pyright, gitui, nodejs, and par to the system package profile.
### Initial Commit (unuseable)
