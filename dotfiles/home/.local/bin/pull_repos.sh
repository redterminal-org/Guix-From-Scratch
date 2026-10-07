#!/usr/bin/env bash

set -u

export GIT_SSH_COMMAND='ssh -o ForwardX11=no -o ForwardX11Trusted=no'

repositories=(
  "$HOME/Bilder"
  "$HOME/Dokumente"
  "$HOME/Work/Ansible/Debian_Init"
  "$HOME/Work/Ansible/Upgrades"
  "$HOME/Work/redterminal.org"
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

  echo "    Git Pull..."

  if git -C "$repository" pull; then
    echo "    Erfolgreich aktualisiert."
  else
    echo "    FEHLER beim Aktualisieren von:"
    echo "    $repository"
    echo "    Siehe die konkrete Git-Fehlermeldung oben."
  fi

  echo
done
