# On an x86 host, it may be possible to use the host's native toolchain (just plain `as`, `ld`, etc.),
# but this may require additional options to avoid including stuff like standard libraries.
AS := i686-elf-as
LD := i686-elf-ld
OBJCOPY := i686-elf-objcopy

QEMU := qemu-system-x86_64
GDB := x86_64-elf-gdb

fun.bin: fun.elf
	$(OBJCOPY) -O binary $^ $@

fun.elf: fun.o fun.ld
	$(LD) -o fun.elf -T fun.ld fun.o

fun.o: fun.s
	$(AS) -gen-debug -o $@ $^

.PHONY: clean
clean:
	$(RM) *.o *.bin *.elf

.PHONY: qemu
qemu: fun.bin
	$(QEMU) -drive file=fun.bin,format=raw

.PHONY: debug-qemu
debug-qemu: fun.bin
	$(QEMU) -s -S -drive file=fun.bin,format=raw

.PHONY: debug-gdb
debug-gdb: fun.elf
	$(GDB) fun.elf -x debug_with_qemu.gdb


