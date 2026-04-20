# Makefile - Build OS

CROSS = i686-elf-
CC = $(CROSS)gcc
LD = $(CROSS)ld
AS = nasm

CFLAGS = -ffreestanding -O2 -Wall -Wextra -fno-common
ASFLAGS = -f elf32
LDFLAGS = -T linker.ld -m elf_i386

# Objects
KERNEL_OBJS = kernel_entry.o kernel.o idt.o isr_asm.o keyboard.o

.PHONY: all clean run

all: bootloader.bin kernel.elf os.img

bootloader.bin: bootloader.asm
	$(AS) -f bin bootloader.asm -o bootloader.bin

kernel_entry.o: kernel_entry.asm
	$(AS) $(ASFLAGS) kernel_entry.asm -o kernel_entry.o

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

isr_asm.o: isr_asm.asm
	$(AS) $(ASFLAGS) isr_asm.asm -o isr_asm.o

kernel.elf: $(KERNEL_OBJS)
	$(LD) $(LDFLAGS) -o kernel.elf $(KERNEL_OBJS)

os.img: bootloader.bin kernel.elf
	# Create a 1.44MB floppy image
	dd if=/dev/zero of=os.img bs=512 count=2880
	dd if=bootloader.bin of=os.img bs=512 count=1 conv=notrunc
	# Copy kernel at sector 10
	dd if=kernel.elf of=os.img bs=512 seek=10 conv=notrunc

run: os.img
	qemu-system-i386 -drive format=raw,file=os.img,if=floppy -m 64

clean:
	rm -f *.o *.elf bootloader.bin os.img