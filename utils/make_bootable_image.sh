#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BOOT_SECTOR="$ROOT_DIR/boot/fat12com.bin"
BIN_DIR="$ROOT_DIR/bin"

usage() {
  cat <<'USAGE'
Usage: make_bootable_image.sh <output.img> <KERNEL.SYS> <COMMAND.COM>

Creates a 1.44MB FAT12 floppy image with the FreeDOS boot sector and
copies the provided kernel and command interpreter plus the bin/ files.
USAGE
}

if [ "$#" -ne 3 ]; then
  usage
  exit 1
fi

OUTPUT_IMG="$1"
KERNEL_SYS="$2"
COMMAND_COM="$3"

for tool in dd mkfs.fat mcopy mdir; do
  if ! command -v "$tool" >/dev/null 2>&1; then
    echo "Missing required tool: $tool" >&2
    exit 1
  fi
done

if [ ! -f "$BOOT_SECTOR" ]; then
  echo "Boot sector not found at $BOOT_SECTOR. Building it..." >&2
  make -C "$ROOT_DIR/boot" fat12com.bin
fi

if [ ! -f "$KERNEL_SYS" ]; then
  echo "Kernel not found: $KERNEL_SYS" >&2
  exit 1
fi

if [ ! -f "$COMMAND_COM" ]; then
  echo "Command interpreter not found: $COMMAND_COM" >&2
  exit 1
fi

rm -f "$OUTPUT_IMG"
dd if=/dev/zero of="$OUTPUT_IMG" bs=1024 count=1440 status=none
mkfs.fat -F 12 "$OUTPUT_IMG" >/dev/null

dd if="$BOOT_SECTOR" of="$OUTPUT_IMG" conv=notrunc status=none

mcopy -i "$OUTPUT_IMG" "$KERNEL_SYS" ::KERNEL.SYS
mcopy -i "$OUTPUT_IMG" "$COMMAND_COM" ::COMMAND.COM
mcopy -i "$OUTPUT_IMG" "$BIN_DIR"/* ::/

echo "Bootable image created: $OUTPUT_IMG"
mdir -i "$OUTPUT_IMG" ::/
