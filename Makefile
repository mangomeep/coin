NAME = coin
ASM = ${NAME}.asm
OBJ = ${NAME}.o
ELF = ${NAME}.elf
OP = -O0
ARCH = 64
LINKS = ${OP} -m${ARCH} -no-pie -nostdlib

all: assemble link

assemble:
	as ${ASM} --${ARCH} -o ${OBJ}

link:
	gcc ${OBJ} ${LINKS} -o ${ELF}

install: all
	@cp ${ELF} ${NAME}
	@cp ${NAME} /usr/local/bin

clean:
	@rm -vf ${NAME} ${OBJ} ${ELF} 

