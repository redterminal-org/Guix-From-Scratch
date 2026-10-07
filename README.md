# Guix-From-Scratch

---

## Personal Guix configuration

This is my Guix setup for my *personal* use and learning, but it may be of use for other people as well. I'm trying to rebuild my NixOS-From-Scratch setup with Guix, after a hint from Christopher Howard. Lots of thanks for that!

---

Starter Guix System + Guix Home configuration for one Lenovo T460s (grumpy) so far.

Goals: UEFI/GRUB EFI; labels EFI/GUIX/SWAP; Nonguix Intel i915/iWlwifi/SOF firmware; Wayland/Hyprland; XWayland; PipeWire; SwayNC; mutable dotfile overlay; separate LazyVim repository; first-login SSH secrets import.

## Important

This is a starter repository. Guix channel revisions can change package/service APIs.

Ly is deliberately an integration point rather than a fake `ly-service-type`: no native Guix/Nonguix Ly service was verified while assembling this archive. Ly itself documents non-systemd support. Add a package/service for your chosen Ly revision before enabling it.

The two personal package files are placeholders for pinned `gemget` and `todo.txt-cli` definitions. Generate/verify current definitions with Guix before enabling them.

## Apply

Use a persistent checkout and inspect it first:

    guix pull -C channels.scm
    sudo guix system reconfigure -L . system/hosts/grumpy.scm
    guix home reconfigure -L . home/daniel.scm
    sudo -H guix home reconfigure -L . home/root.scm

System packages are shared by all users. Each user has a separate Home environment for additional packages and Home services. The current per-user package lists are empty.

## Home environments

`home/common.scm` defines the shared Home environment. `home/daniel.scm` uses it with an empty user-specific package list and enables private-data import. `home/root.scm` uses the same environment with private-data import disabled. Future non-root users can follow the `daniel` configuration pattern.

## Dotfiles

During every Home activation, `dotfiles/home/` is copied recursively to `~/` and `dotfiles/config/` is copied recursively to `~/.config/`. Files supplied by the repository overwrite their counterparts. Files that exist only in the user's home directory are preserved, and removed repository files are not automatically deleted.

`~/.config/nvim/` is intentionally absent: manage it with your separate local-network LazyVim Git repository.

## Themes

GTK 3 and GTK 4 use the shared Tokyo Night theme under `~/.themes/Tokyo-Night/`. Qt 5 and Qt 6 use matching Fusion palettes through qt5ct and qt6ct. The theme colors are derived from the existing Waybar palette.

The session exports `QT_QPA_PLATFORMTHEME=qt5ct`. This is the qt5ct/qt6ct-compatible setup used for mixed Qt 5/6 environments. Kvantum is installed as an optional Qt style engine, but the default theme deliberately uses Fusion so both Qt generations use the same palette without depending on a Qt-5 Kvantum build.

## Secrets

No secrets belong in this repository. The Home service imports GPG, SSH, password-store and Rogallo data to mutable user directories and writes a one-time marker at `~/.local/state/.guix-private-data-import-marker`. This service is enabled for `daniel` and future non-root users, but deliberately disabled for `root`.
