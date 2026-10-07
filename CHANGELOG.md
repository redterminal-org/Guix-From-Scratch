**CHANGELOG**

## 0.1.0
### Updated ./system/hosts/grumpy.scm
* Integrated NetworkManager and wpa-supplicant
### Remove unsupported persistent-workspaces option from ext/workspaces
* Remove the unsupported persistent-workspaces configuration from the Waybar ext/workspaces module.
### Update README for current configuration
* Document the implemented Ly service, current per-user Home packages, Rogallo activation, and the current private-data import workflow.
### Fix repository path typo in sync scripts
* Correct the redterminal.org path in the pull and push repository scripts.
### Remove obsolete abook command references
* Remove the obsolete mutt, lpr, and lynx command references from the abook configuration.
### Prevent failed GPG imports from marking private data as successful
* Check GPG import exit codes before copying private data and creating the success marker.
### Clean up Bash history and remove obsolete ranger alias
* Use $HOME for HISTFILE instead of a hardcoded user path.
* Remove the unused rr alias for ranger.
### Remove obsolete TeX environment helper
* Remove the unused create_tex_env.sh script, which still depended on nix-shell.
### Clean up invalid .mailcap configuration
* Remove the accidentally embedded Bash configuration from .mailcap.
* Remove obsolete hardcoded Nix store references and keep only the actual mailcap entries.
### Fix missing password-store runtime dependency and remove unused snip binding
* Add password-store to the system package profile for the existing Wofi password and OTP menus.
* Remove the unused SUPER+S keybinding and its snip command from the Hyprland configuration.
### Fix ZFS receive to run on the local host
* Stream remote zfs send output through local pv into local zfs receive instead of running the receive pipeline remotely.
### Configure todo.txt for the user Home environment
* Add a versioned todo.txt configuration under ~/.config/todo that stores todo.txt, done.txt, and report.txt in ~/todo.
### Enable McFly shell integration
* Initialize McFly correctly in Bash by evaluating the shell code produced by mcfly init bash.
### Run private-data import through user Shepherd
* Move the private-data import from Home activation to a manually triggered one-shot user Shepherd service so graphical prompts run inside the Wayland session.
* Start the private-data import from Hyprland with the graphical session environment instead of the nonexistent systemd user service.
### Make the Ly build fully reproducible
* Add the missing zigini 0.5.0 dependency at the upstream commit required by Ly 1.4.1.
* Pin all Ly Zig dependencies in the Guix package.
### Remove temporary private-data downloads after import
* Always remove the temporary ~/.cache/guix-private-data tree after private-data processing, including failed downloads and import errors.
### Add and activate a Ly display manager service
* Package Ly 1.4.1 with Guix's Zig build system and pinned Zig dependencies.
* Add a Shepherd and PAM service for Ly on tty2 and remove conflicting desktop and mingetty login services.
* Activate Ly directly as the system display manager.
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
