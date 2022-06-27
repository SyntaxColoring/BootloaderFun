# Unclear why this is required.
set architecture i386:x86-64

target remote localhost:1234

layout src
layout regs

break *0x7c00

continue
