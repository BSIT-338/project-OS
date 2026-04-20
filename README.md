# Project-OS

## Project Description

Project-OS is a simple 32-bit operating system kernel implemented in C and assembly language. It includes a bootloader, kernel entry point, interrupt descriptor table (IDT), interrupt service routines (ISR), and a basic keyboard driver. The project demonstrates low-level OS concepts such as bootloading, kernel initialization, and hardware interaction.

## Folder Structure

```
project-OS/
├── .git/                          # Git repository
├── bootloader.asm                 # Bootloader in assembly
├── bootloader.bin                 # Compiled bootloader binary
├── idt.c                          # Interrupt Descriptor Table implementation
├── isr_asm.asm                    # Interrupt Service Routines in assembly
├── kernel_entry.asm               # Kernel entry point in assembly
├── kernel_entry.o                 # Compiled kernel entry object
├── kernel.c                       # Main kernel code
├── keyboard.c                     # Keyboard driver
├── LICENSE                        # Project license
├── linker.ld                      # Linker script for kernel
├── Makefile                       # Build script
├── nasm-2.16.01.tar.gz            # NASM source archive (if built locally)
├── nasm-2.16.01/                  # Extracted NASM source (if built locally)
└── README.md                      # This file
```

## Prerequisites

Before building and running the OS, ensure the following tools are installed:

- **NASM** (Netwide Assembler) - For assembling assembly code
- **i686-elf-gcc** - Cross-compiler for 32-bit ELF binaries
- **i686-elf-ld** - Cross-linker for 32-bit ELF binaries
- **QEMU** - Emulator for running the OS

### Installing Prerequisites

#### On Ubuntu/Debian:
```bash
sudo apt update
sudo apt install nasm qemu-system-i386
```

For the cross-compiler, you may need to build it from source or use a pre-built toolchain. One option is to use the i686-elf-gcc toolchain:

```bash
# Install dependencies
sudo apt install build-essential bison flex libgmp3-dev libmpc-dev libmpfr-dev texinfo

# Download and build binutils
wget https://ftp.gnu.org/gnu/binutils/binutils-2.38.tar.gz
tar -xzf binutils-2.38.tar.gz
cd binutils-2.38
mkdir build && cd build
../configure --target=i686-elf --prefix=/usr/local --with-sysroot --disable-nls --disable-werror
make -j$(nproc)
sudo make install

# Download and build GCC
cd ../..
wget https://ftp.gnu.org/gnu/gcc/gcc-11.2.0/gcc-11.2.0.tar.gz
tar -xzf gcc-11.2.0.tar.gz
cd gcc-11.2.0
mkdir build && cd build
../configure --target=i686-elf --prefix=/usr/local --disable-nls --enable-languages=c --without-headers
make all-gcc -j$(nproc)
sudo make install-gcc
```

#### On macOS:
```bash
brew install nasm qemu i686-elf-gcc
```

#### On Windows:
Use WSL or MinGW. Install NASM and QEMU via package managers, and use a pre-built i686-elf toolchain.

## Setup Steps

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd project-OS
   ```

2. Ensure all prerequisites are installed as described above.

3. If building NASM locally (optional):
   ```bash
   tar -xzf nasm-2.16.01.tar.gz
   cd nasm-2.16.01
   ./configure
   make
   sudo make install
   ```

## Build Instructions

To build the OS image, run:

```bash
make all
```

This will create:
- `bootloader.bin`: The bootloader binary
- `kernel.elf`: The linked kernel ELF file
- `os.img`: The floppy disk image containing both bootloader and kernel

## Running the OS

To run the OS in QEMU emulator:

```bash
make run
```

This launches QEMU with the OS image as a floppy disk. The OS should boot and display kernel messages.

## Team Members

- **Prashanna** - Developer

## Troubleshooting

### Common Issues

1. **Cross-compiler not found**:
   - Ensure `i686-elf-gcc` and `i686-elf-ld` are in your PATH.
   - If not installed, follow the setup steps above.

2. **NASM not found**:
   - Install NASM using your package manager.
   - Verify with `nasm -v`.

3. **QEMU not found**:
   - Install QEMU: `sudo apt install qemu-system-i386` (on Debian/Ubuntu).
   - Ensure it's the i386 version.

4. **Build errors**:
   - Check that all source files are present.
   - Ensure correct file permissions.
   - Verify Makefile syntax.

5. **OS doesn't boot**:
   - Check QEMU output for errors.
   - Verify `os.img` was created successfully.
   - Ensure bootloader and kernel are correctly placed in the image.

6. **Keyboard input not working**:
   - The keyboard driver is basic; ensure PS/2 keyboard emulation in QEMU.

If issues persist, check the kernel output messages for debugging information.