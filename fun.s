.code16

startup:

# Reset the video mode to clear the screen.
mov $0x00, %ah # Opcode: set video mode.
mov $0x00, %al # Desired video mode. Plain 40x25 text mode.
int $0x10

mov $message, %bp
mov $0, %si  # Character index.

print_loop:
	# Move the cursor to the next position.
	mov $0x02, %ah # Opcode.
	mov $0, %bh # Page number.
	mov %si, %dx # %dl is column.
	mov $0, %dh # Row (always 0, at the top).
	int $0x10

	# Fetch the next character.
	movb (%bp, %si), %al
	test %al, %al
	jz busy_loop # Stop when we've reached NUL.

	# Print the character.
	mov $0x0a, %ah # Opcode.
	# Character to write already exists in %al.
	mov $0, %bx # Display page and foreground color?
	mov $4, %bl
	mov $1, %cx # Write one character.
	int $0x10 # Call the interrupt.
	inc %si
jmp print_loop

message:
.asciz "Hello, world!"

busy_loop:
jmp busy_loop
