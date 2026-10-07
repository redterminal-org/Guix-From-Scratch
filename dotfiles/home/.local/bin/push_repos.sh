#!/usr/bin/env bash

set -u

export GIT_SSH_COMMAND='ssh -o ForwardX11=no -o ForwardX11Trusted=no'

repositories=(
  "$HOME/Bilder"
  "$HOME/Dokumente"
  "$HOME/Work/Ansible/Debian_Init"
  "$HOME/Work/Ansible/Upgrades"
  "$HOME/Work/redteminal.org"
  "$HOME/Work/VimWiki"
)

for repository in "${repositories[@]}"; do
  echo "==> Prüfe: $repository"

  if [[ ! -d "$repository" ]]; then
    echo "    Übersprungen: Verzeichnis existiert nicht."
    echo
    continue
  fi

  git_error=$(git -C "$repository" rev-parse --is-inside-work-tree 2>&1)

  if [[ "$git_error" != "true" ]]; then
    echo "    Übersprungen: Kein Git-Repository."
    echo "    Git-Fehler: $git_error"
    echo
    continue
  fi

  echo "    Git Add..."

  if ! git -C "$repository" add -A; then
    echo "    FEHLER bei git add -A:"
    echo "    Repository: $repository"
    echo
    continue
  fi

  echo "    Git Commit..."

  if ! git -C "$repository" commit -m "Update"; then
    echo "    FEHLER bei git commit:"
    echo "    Repository: $repository"
    echo
    continue
  fi

  echo "    Git Push..."

  if git -C "$repository" push; then
    echo "    Erfolgreich gepusht."
  else
    echo "    FEHLER bei git push:"
    echo "    Repository: $repository"
  fi

  echo
done
