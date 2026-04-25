# ============================================================================
#  EarlnuxOS - Universal Build Environment
# ============================================================================
FROM ubuntu:22.04

# Avoid prompts from apt
ENV DEBIAN_FRONTEND=noninteractive

# Install all necessary cross-compilation and build tools
RUN apt-get update && apt-get install -y \
    nasm \
    gcc-i686-linux-gnu \
    binutils-i686-linux-gnu \
    make \
    xorriso \
    grub-pc-bin \
    mtools \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /os

# By default, build the ISO
CMD ["make", "iso"]
