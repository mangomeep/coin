.intel_syntax

.section .text

.global _start

_start:
    jmp rand

rand:
    # read rand value into rax
    rdrand %rax
    # assign bottom byte of rax into random
    mov [random], %al
    # load random value into rax
    mov %rax, [random]
    # AND random value with 1
    and %rax, 1
    # jump to heads if even
    jz heads
    # jump to tails if odd
    jmp tails

heads:
    # write syscall
    # syscall for write
    mov %eax, 4
    # write to STDOUT
    mov %ebx, 1 # 1 STDOUT, 2 STDIN, 3 STDERR
    # load text
    lea %ecx, [head]
    # text length
    mov %edx, 7
    # interrupt for syscall
    int 0x80
    # assign return code
    mov %rax, 0
    mov [return], %rax
    jmp exit

tails:
    # write syscall
    # syscall for write
    mov %eax, 4
    # write to STDOUT
    mov %ebx, 1 # 1 STDOUT, 2 STDIN, 3 STDERR
    # load text
    lea %ecx, [tail]
    # text length
    mov %edx, 7
    # interrupt for syscall
    int 0x80
    # assign return code
    mov %rax, 1
    mov [return], %rax
    jmp exit

exit:
    # exit syscall
    # syscall for interrupt
    mov %eax, 1
    # return code
    mov %ebx, [return]
    # interrupt for syscall
    int 0x80

.section .data

    random: .byte 0

    head: .ascii "Heads!\n"
    tail: .ascii "Tails!\n"

    return: .word 0

