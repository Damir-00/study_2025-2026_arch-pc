section .data
    text db "sum of f(x) = x + 12: 27", 10
    
section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, text
    mov edx, 25         ; длина строки
    int 0x80
    
    mov eax, 1
    mov ebx, 0
    int 0x80
