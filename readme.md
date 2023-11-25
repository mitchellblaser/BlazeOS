# BlazeOS Readme

## Setting up development environment

### MacOS
Prerequesites:
Homebrew, Xcode Dev Tools, xorriso.

```brew install x86_64-elf-gcc```

```brew install xorriso```

#### Building BlazeOS: 
```
cd PROJECT_DIRECTORY/src
curl https://raw.githubusercontent.com/limine-bootloader/limine/trunk/limine.h -O limine.h
cd ..
make CC=x86_64-elf-gcc LD=x86_64-elf-ld
```
Output is under bin/blazeos

#### Creating an ISO
```
cd PROJECT_DIRECTORY
git clone https://github.com/limine-bootloader/limine.git --branch=v5.x-branch-binary --depth=1

make -C limine
mkdir -p iso_root

cp -v bin/blazeos limine.cfg limine/limine-bios.sys limine/limine-bios-cd.bin limine/limine-uefi-cd.bin iso_root/

xorriso -as mkisofs -b limine-bios-cd.bin \
        -no-emul-boot -boot-load-size 4 -boot-info-table \
        --efi-boot limine-uefi-cd.bin \
        -efi-boot-part --efi-boot-image --protective-msdos-label \
        iso_root -o image.iso
 
./limine/limine bios-install image.iso
```