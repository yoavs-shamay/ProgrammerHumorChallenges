program: main.o util.o program.o
	ld -o program main.o util.o program.o

main.o: main.asm
	yasm -f elf64 main.asm -o main.o

util.o: util.asm
	yasm -f elf64 util.asm -o util.o

program.o: program.asm
	yasm -f elf64 program.asm -o program.o
