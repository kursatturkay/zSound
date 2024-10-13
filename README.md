
# zSound follows the GPL3.0 open-source license

zSound is a cross-platform audio engine derived from a game engine, and it supports all desktop and mobile platforms.

For more details, refer to the documentation: [https://github.com/PassByYou888/zSound/tree/master/document](https://github.com/PassByYou888/zSound/tree/master/document)

## Supported Development Platforms

- Delphi and IDE Requirements: Delphi Rad Studio XE10.2.1 or later
- FPC Compiler Support: FPC 3.0.4 or later. You can refer to the included [IOT Getting Started Guide](https://github.com/PassByYou888/ZServer4D/blob/master/Documents/%E5%85%A5%E6%89%8BIOT%E7%9A%84%E5%AE%8C%E5%85%A8%E6%94%BB%E7%95%A5.pdf) in this project to upgrade FPC to the latest version from GitHub.
- CodeTyphon 6.0 or later (it is recommended to use Online updates to get the latest Cross toolchain and related libraries).

## CPU Architecture Support (tested with Delphi 11/Lazarus 3.2.0)

- MIPS (fpc-little endian), soft float, tested successfully on QEMU.
- Intel X86 (fpc-x86), soft float.
- Intel X86 (Delphi + FPC), hard float: 80386, Pentium, Pentium2, Pentium3, Pentium4, PentiumM, CoreI, CoreAVX, CoreAVX2.
- Intel X64 (fpc-x86_64), soft float.
- Intel X64 (Delphi + FPC), hard float: Athlon64, CoreI, CoreAVX, CoreAVX2.
- ARM (fpc-arm32-eabi, soft float): ARMv3, ARMv4, ARMv4T, ARMv5, ARMv5T, ARMv5TE, ARMv5TEJ.
- ARM (fpc-arm32-eabi, hard float): ARMv6, ARMv6K, ARMv6T2, ARMv6Z, ARMv6M, ARMv7, ARMv7A, ARMv7R, ARMv7M, ARMv7EM.
- ARM (fpc-arm64-eabi, hard float): ARMv8, aarch64.

# Update Log

### 2024-10-13

- Pause Methods Added.
- Minor Bugs Fixed
### 2021-09-22

- Updated the base library. If you encounter compilation issues, please let me know.

### March 2020

- Kernel updates.
- ZDB data upgrade.
- Added Android-armv8 64-bit support for the Bass engine.

### 2018-05-21

- Fixed an issue where zSound applications reported errors on shutdown.
- Updated many base libraries.

### 2018-04-12

Fixed a memory out-of-bounds bug in the kernel: The symptoms of this bug included sudden memory access errors that were difficult to debug due to the memory overflow.

- Created by qq600585
