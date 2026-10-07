#!/usr/bin/env bash
readarray ALL_EMAILS
CSV=$(mktemp --suffix=.csv)
CONV_ABOOK=$(mktemp)


IFS=$'\n'
for element in "${ALL_EMAILS[@]}"; do
  EMAIL=$(echo "${element}" | cut -f 1)
  NAME=$(echo "${element}" | cut -f 2 | tr -d '\t' | sed -e 's/\s*$//')
  if gpg --locate-keys --quiet "${EMAIL}" >/dev/null 2>&1;then
    printf "ADDED: %s <%s>!\n" "${NAME}" "${EMAIL}"
    printf "\"%s\",\"%s\",\"\",\"%s\",\"\"\n" "${NAME}" "${EMAIL}" "PGP yes" >>"${CSV}"
  else
    printf "NOT FOUND: %s <%s>\n" "${NAME}" "${EMAIL}"
    printf "\"%s\",\"%s\",\"\",\"%s\",\"\"\n" "${NAME}" "${EMAIL}" "PGP no" >>"${CSV}"
  fi
done

# create new addressbook
cp "${HOME}"/.abook/addressbook "${HOME}/.abook/addressbook-$(date +%Y%m%d-%H%M).bak"
abook --convert --informat csv --infile "${CSV}" --outformat abook --outfile "${CONV_ABOOK}"
mv "${CONV_ABOOK}" "${HOME}"/.abook/addressbook
rm "${CSV}"

# Keep the last 8 backups
find "${HOME}/.abook/" -name "addressbook-*" | sort | head -n -8 | xargs -I{} rm {} > /dev/null 2>&1
