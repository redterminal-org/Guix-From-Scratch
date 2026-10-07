#!/bin/sh

# Create a temporary directory
TMPDIR=$(mktemp -d)

# Set trap to catch some signals
trap "/usr/bin/rm -rf ${TMPDIR}; exit 255;" SIGINT SIGTERM

# Compile the tex document
lualatex -interaction=nonstopmode -output-directory=${TMPDIR} "${1}"

# Copy resulting PDF into current directory and remove temp dir
mv ${TMPDIR}/*.pdf .
rm -rf ${TMPDIR}
