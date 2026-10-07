**CHANGELOG**

## 0.1.0
### Add gemget to daniel's Home profile
* Package gemget 1.9.0 from its upstream source and make it available only to daniel.
### Add todo.txt-cli to user Home profiles
* Package todo.txt-cli 2.14.0 from its upstream release and make it available to both daniel and root.
### Add McFly to user Home profiles
* Package McFly 0.9.4 locally from its upstream Linux x86_64 release and make it available to both daniel and root.
* Allow shared Home environment construction to accept local package objects alongside user-specific package selections.
### Deploy Home environments through system reconfigure
* Register daniel's and root's existing Home environments with guix-home-service-type so a system reconfigure builds and activates both Home environments.
### Unify GTK and Qt theming with Tokyo Night
* Add GTK 3/4 themes and Qt 5/6 color schemes based on the existing Waybar Tokyo Night palette.
* Install qt5ct, qt6ct, and Kvantum system-wide and enable qt5ct as the shared Qt platform theme for the desktop session.
### Separate user Home environments and private-data handling
* Move neovim to the system-wide package profile and give each user an independent Home package list, initially empty for daniel and root.
* Share the Home dotfiles and Rogallo setup while enabling private-data import for daniel and future non-root users and disabling it for root.
### Copy repository home and config trees during Home activation
* Recursively copy dotfiles/home/ to ~/ and dotfiles/config/ to ~/.config/ on each Guix Home activation while preserving files not supplied by the repository.
### Install and update Rogallo with pipx
* Install Rogallo with pipx and update it on each Guix Home activation.
### Add LazyVim runtime dependencies to system packages
* Add gcc, fd, fzf, tree-sitter-cli, pyright, gitui, nodejs, and par to the system package profile.
### Initial Commit (unuseable)