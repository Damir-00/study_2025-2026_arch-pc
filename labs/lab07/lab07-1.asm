section .data
    output  db "Minimal number: 22", 10
    out_len equ $ - output
    
section .text
    global _start

_start:
    ; Выводим текст
    mov eax, 4          ; sys_write
    mov ebx, 1          ; stdout
    mov ecx, output     ; строка для вывода
    mov edx, out_len    ; длина строки
    int 0x80
    
    ; Завершаем программу
    mov eax, 1          ; sys_exit
    xor ebx, ebx        ; код возврата 0
    int 0x80
