# OUTPUT_FORMAT("binary")
SECTIONS
{
	# The BIOS will load our code into memory at physical address 0x7c00.
	# Ensure our code expects to be run there.
	. = 0x7c00;

	.text : {
		*(.text)

		# "Valid bootsector" signature bytes.
		. = 0x1fe;
		BYTE(0x55);
		BYTE(0xaa);
	}
}
