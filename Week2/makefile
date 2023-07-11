program: main.o util.o program.o
	ld -o program main.o util.o program.o

main.o: main.asm
	nasm -f elf64 main.asm -o main.o -g -F dwarf

util.o: util.asm
	nasm -f elf64 util.asm -o util.o -g -F dwarf

program.o: program.asm
	nasm -f elf64 program.asm -o program.o -g -F dwarf
