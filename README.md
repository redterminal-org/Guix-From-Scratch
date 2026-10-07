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
    guix home reconfigure -L . home/common.scm

Change `CHANGE-ME` in `system/common.scm` to your actual account name before applying.

## Dotfiles

`dotfiles/config/` is copied recursively to `~/.config/` during Home activation. Files supplied by the repository overwrite their counterparts. Files that exist only in `$HOME` are preserved. Removed repository files are not automatically deleted.

`~/.config/nvim/` is intentionally absent: manage it with your separate local-network LazyVim Git repository.

Individual files are copied separately: `dotfiles/bashrc -> ~/.bashrc`, `dotfiles/gitconfig -> ~/.gitconfig`.

## Secrets

No secrets belong in this repository. The Home service imports GPG, SSH, password-store and Rogallo data to mutable user directories and writes a one-time marker at `~/.local/state/.guix-private-data-import-marker`.
