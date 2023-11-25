make CC=x86_64-elf-gcc LD=x86_64-elf-ld

rm -rf iso_root
mkdir -p iso_root

cp -v bin/blazeos limine.cfg limine/limine-bios.sys limine/limine-bios-cd.bin limine/limine-uefi-cd.bin iso_root/

rm image.iso

xorriso -as mkisofs -b limine-bios-cd.bin \
        -no-emul-boot -boot-load-size 4 -boot-info-table \
        --efi-boot limine-uefi-cd.bin \
        -efi-boot-part --efi-boot-image --protective-msdos-label \
        iso_root -o image.iso

./limine/limine bios-install image.iso

qemu-system-x86_64 -boot d -cdrom image.iso -m 512