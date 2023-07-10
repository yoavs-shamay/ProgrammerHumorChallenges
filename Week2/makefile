program: main.o util.o program.o
	ld -o program main.o util.o program.o

main.o: main.asm
	nasm -f elf64 -g main.asm -o main.o

util.o: util.asm
	nasm -f elf64 -g util.asm -o util.o

program.o: program.asm
	nasm -f elf64 -g program.asm -o program.o
