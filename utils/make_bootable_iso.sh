#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
IMAGE_BUILDER="$ROOT_DIR/utils/make_bootable_image.sh"

usage() {
  cat <<'USAGE'
Usage: make_bootable_iso.sh <output.iso> <KERNEL.SYS> <COMMAND.COM>

Builds a bootable ISO (El Torito, floppy emulation) using the FreeDOS
boot sector and files from bin/. Requires genisoimage or mkisofs.
USAGE
}

if [ "$#" -ne 3 ]; then
  usage
  exit 1
fi

OUTPUT_ISO="$1"
KERNEL_SYS="$2"
COMMAND_COM="$3"

ISO_TOOL=""
if command -v genisoimage >/dev/null 2>&1; then
  ISO_TOOL="genisoimage"
elif command -v mkisofs >/dev/null 2>&1; then
  ISO_TOOL="mkisofs"
else
  echo "Missing required tool: genisoimage or mkisofs" >&2
  exit 1
fi

BOOT_IMG="${OUTPUT_ISO%.iso}.img"

"$IMAGE_BUILDER" "$BOOT_IMG" "$KERNEL_SYS" "$COMMAND_COM"

"$ISO_TOOL" -o "$OUTPUT_ISO" \
  -b "$(basename "$BOOT_IMG")" \
  -c boot.catalog \
  -no-emul-boot \
  -boot-load-size 4 \
  -boot-info-table \
  -V FDGUI \
  "$(dirname "$BOOT_IMG")"

rm -f "$BOOT_IMG" "$(dirname "$BOOT_IMG")/boot.catalog"

echo "Bootable ISO created: $OUTPUT_ISO"
