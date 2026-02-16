section .data
    char db 'j'           ; символ для вывода

section .text
    global _start

_start:
    ; системный вызов write
    mov eax, 4            ; номер системного вызова write (4 для 32-бит)
    mov ebx, 1            ; файловый дескриптор 1 (stdout)
    mov ecx, char         ; указатель на символ
    mov edx, 1            ; количество байт для вывода
    int 0x80              ; вызов ядра (прерывание)

    ; системный вызов exit
    mov eax, 1            ; номер системного вызова exit (1 для 32-бит)
    mov ebx, 0            ; код возврата 0
    int 0x80              ; вызов ядра
