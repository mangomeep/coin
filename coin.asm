.intel_syntax

.section .text

.global _start

_start:
    jmp rand

rand:
    rdrand %rax
    mov [random], %al
    mov %rax, [random]
    and %rax, 1
    jz heads
    jmp tails

heads:
    mov %eax, 4
    mov %ebx, 1 
    lea %ecx, [head]
    mov %edx, 7
    int 0x80
    mov %rax, 0
    mov [return], %rax
    jmp exit

tails:
    mov %eax, 4
    mov %ebx, 1 
    lea %ecx, [tail]
    mov %edx, 7
    int 0x80
    mov %rax, 1
    mov [return], %rax
    jmp exit

exit:
    mov %eax, 1
    mov %ebx, [return]
    int 0x80

.section .data

    random: .byte 0

    head: .ascii "Heads!\n"
    tail: .ascii "Tails!\n"

    return: .word 0

