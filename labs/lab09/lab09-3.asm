section .data
    msg db 'Hello, world!', 0xA  ; сообщение + символ новой строки
    len equ $ - msg              ; длина сообщения

section .text
    global _start

_start:
    ; Вывод сообщения
    mov eax, 4      ; номер системного вызова sys_write
    mov ebx, 1      ; файловый дескриптор stdout
    mov ecx, msg    ; указатель на сообщение
    mov edx, len    ; длина сообщения
    int 0x80        ; вызов ядра

    ; Завершение программы
    mov eax, 1      ; номер системного вызова sys_exit
    xor ebx, ebx    ; код возврата 0
    int 0x80        ; вызов ядра
