#!/usr/bin/env bash

set -euo pipefail

# Check for pv (progress bar)
if ! command -v pv >/dev/null; then
  echo "pv not installed - proceeding without progress bar"
  pv_cmd="cat"
else
  pv_cmd="pv"
fi

# Remote ZFS server
SERVER="root@pve1.pve"

# Source and destination pools
SEND_POOL="zdata"
RECV_POOL="zbackup"

# ---------------------------------------------------------------------------
# Command‑line options and dry‑run handling
# ---------------------------------------------------------------------------

DRY_RUN=false
while [[ $# -gt 0 ]]; do
  case "$1" in
  --dry-run)
    DRY_RUN=true
    shift
    ;;
  -s | --server)
    SERVER="$2"
    shift 2
    ;;
  -S | --send-pool)
    SEND_POOL="$2"
    shift 2
    ;;
  -r | --recv-pool)
    RECV_POOL="$2"
    shift 2
    ;;
  *)
    break
    ;;
  esac
done

# ---------------------------------------------------------------------------
# Usage
# ---------------------------------------------------------------------------

usage() {
  echo "Usage: $0 [options] <from-snapshot> <to-snapshot>"
  echo
  echo "Options:"
  echo "  --dry-run            Show the command that would be executed,"
  echo "                       without running it."
  echo ""
  echo "  -s|--server SERVER   Remote ZFS server (default: $SERVER)"
  echo "  -S|--send-pool POOL  Source pool name (default: $SEND_POOL)"
  echo "  -r|--recv-pool POOL  Destination pool name (default: $RECV_POOL)"
  echo
  echo "Example:"
  echo "  $0 --dry-run weekly-2026-09-20-0400 weekly-2026-10-04-0400"
  exit 1
}

if [[ $# -ne 2 ]]; then
  usage
fi

FROM_SNAPSHOT="$1"
TO_SNAPSHOT="$2"

# ---------------------------------------------------------------------------
# Validate snapshot names
# ---------------------------------------------------------------------------

if [[ "$FROM_SNAPSHOT" == *"/"* || "$FROM_SNAPSHOT" == *"@"* ]]; then
  echo "Error: snapshot names must not contain '/' or '@'."
  exit 1
fi

if [[ "$TO_SNAPSHOT" == *"/"* || "$TO_SNAPSHOT" == *"@"* ]]; then
  echo "Error: snapshot names must not contain '/' or '@'."
  exit 1
fi

# ---------------------------------------------------------------------------
# Check that the source snapshots exist on the remote server
# ---------------------------------------------------------------------------

echo "Checking source snapshots on ${SERVER}..."

ssh "$SERVER" \
  "zfs list -H -t snapshot -o name '${SEND_POOL}@${FROM_SNAPSHOT}' >/dev/null"

ssh "$SERVER" \
  "zfs list -H -t snapshot -o name '${SEND_POOL}@${TO_SNAPSHOT}' >/dev/null"

# ---------------------------------------------------------------------------
# Validate snapshot chronology (remote only)
# ---------------------------------------------------------------------------

FROM_DATE=$(ssh "$SERVER" "zfs get -Hp -o value creation '${SEND_POOL}@${FROM_SNAPSHOT}'")
TO_DATE=$(ssh "$SERVER" "zfs get -Hp -o value creation '${SEND_POOL}@${TO_SNAPSHOT}'")

# Trim trailing newlines from dates returned by zfs
FROM_DATE=${FROM_DATE//$'\n'/}
TO_DATE=${TO_DATE//$'\n'/}

if [[ "$TO_DATE" < "$FROM_DATE" ]]; then
  echo "Error: destination snapshot is older or equal to source snapshot."
  exit 1
fi

# ---------------------------------------------------------------------------
# Check that the base snapshot exists locally
# ---------------------------------------------------------------------------

echo "Checking destination snapshot..."

if ! zfs list -H -t snapshot -o name \
  "${RECV_POOL}@${FROM_SNAPSHOT}" >/dev/null 2>&1; then

  echo "Error: destination snapshot does not exist:"
  echo "  ${RECV_POOL}@${FROM_SNAPSHOT}"
  exit 1
fi

# ---------------------------------------------------------------------------
# Start replication
#
# -R  Replicate the complete dataset hierarchy below SEND_POOL
# -I  Send all incremental snapshots between FROM_SNAPSHOT and TO_SNAPSHOT
#
# The data is streamed directly from the remote zfs send through pv
# into the local zfs receive.
# ---------------------------------------------------------------------------

echo
echo "Replicating:"
echo "  ${SERVER}:${SEND_POOL}@${FROM_SNAPSHOT}"
echo "       -> ${SERVER}:${SEND_POOL}@${TO_SNAPSHOT}"
echo
echo "Receiving into:"
echo "  ${RECV_POOL}"
echo

if $DRY_RUN; then
  echo "Dry‑run mode: would execute:"
  echo "ssh ${SERVER} zfs send -R -I '${SEND_POOL}@${FROM_SNAPSHOT}' '${SEND_POOL}@${TO_SNAPSHOT}' | ${pv_cmd:-cat} | sudo zfs receive -F -d '${RECV_POOL}'"
else
  ssh "$SERVER" \
    "zfs send -R -I '${SEND_POOL}@${FROM_SNAPSHOT}' '${SEND_POOL}@${TO_SNAPSHOT}' |
    ${pv_cmd:-cat} |
    sudo zfs receive -F -d '${RECV_POOL}'"
fi

echo
echo "Replication completed successfully."
