#!/bin/bash
set -uo pipefail
LFS=/app/lfs_build
STAMPS="$LFS/.stamps9"
mkdir -p "$STAMPS"
LOG="$LFS/ch9_output.log"

run_step () {
  local name="$1"
  local script="$2"
  if [ -f "$STAMPS/$name" ]; then
    echo "[$(date +%T)] $name already done" | tee -a "$LOG"
    return 0
  fi
  echo "[$(date +%T)] === $name ===" | tee -a "$LOG"
  if bash /app/lfs_build/scripts/chroot-run.sh "$script" >> "$LOG" 2>&1; then
    touch "$STAMPS/$name"
    echo "[$(date +%T)] === $name DONE ===" | tee -a "$LOG"
  else
    echo "[$(date +%T)] !!! $name FAILED !!!" | tee -a "$LOG"
    exit 1
  fi
}

run_step "lfs-bootscripts" /scripts_chroot/lfs-bootscripts.sh
run_step "system-config"   /scripts_chroot/system-config.sh

echo "[$(date +%T)] === CHAPTER 9 COMPLETE ===" | tee -a "$LOG"
