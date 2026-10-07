#!/usr/bin/env bash

nix-shell -p 'texliveSmall.withPackages (ps: with ps; [
  fontspec
  libertine
  microtype
  polyglossia
  changepage
  csquotes
  koma-script
  marvosym
  graphics
])'
