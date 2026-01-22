# Bootable VMware/Floppy Image

This repository builds the FreeDOS kernel and provides a simple GUI launcher
under `bin/`. To create a bootable 1.44MB FAT12 floppy image for VMware, use
`utils/make_bootable_image.sh` after you have a built `KERNEL.SYS` and a
`COMMAND.COM`.

## Prerequisites

- `mkfs.fat` (from dosfstools)
- `mtools` (`mcopy`, `mdir`)
- `make` (and `nasm` if `boot/fat12com.bin` needs to be built)

## Example

```
make all
# Use the kernel produced by the build and any COMMAND.COM you provide.
./utils/make_bootable_image.sh fdgui.img /path/to/KERNEL.SYS /path/to/COMMAND.COM
```

The script will:

1. Create a 1.44MB FAT12 image.
2. Write the FreeDOS boot sector (`boot/fat12com.bin`).
3. Copy `KERNEL.SYS`, `COMMAND.COM`, and everything in `bin/` (including the GUI).

You can then attach `fdgui.img` as a floppy image in VMware.

# Bootable CD/ISO Image

To boot from a CD in VMware, use `utils/make_bootable_iso.sh`, which builds a
floppy-emulation El Torito ISO using the same files.

## Additional prerequisites

- `genisoimage` (or `mkisofs`)

## Example

```
make all
./utils/make_bootable_iso.sh fdgui.iso /path/to/KERNEL.SYS /path/to/COMMAND.COM
```

## CD-ROM drivers inside DOS

Booting from a CD is separate from *accessing* the CD drive once DOS is running.
To access the CD contents, you must provide:

- A CD-ROM device driver (e.g., `OAKCDROM.SYS` or `UDVD2.SYS`)
- A CD redirector (e.g., `SHSUCDX.COM` or `MSCDEX.EXE`)

If you place these in `bin/`, the included `config.sys` comments and
`cdrom.bat` will load them using the device name `FDCD0001`.
