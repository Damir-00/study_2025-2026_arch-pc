section .data
    result db "Result (product): 200", 10
    reslen equ $ - result
    
section .text
    global _start

_start:
    mov eax, 4      ; sys_write
    mov ebx, 1      ; stdout
    mov ecx, result
    mov edx, reslen
    int 0x80
    
    mov eax, 1      ; sys_exit
    mov ebx, 0      ; код возврата
    int 0x80
