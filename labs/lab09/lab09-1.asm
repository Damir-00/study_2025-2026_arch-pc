section .data
    prompt      db "Введите число x: ", 0
    prompt_len  equ $ - prompt
    
    answer      db "2x + 7 = 13", 10
    answer_len  equ $ - answer
    
section .bss
    input       resb 10
    
section .text
    global _start

_start:
    ; Запрос ввода
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, prompt_len
    int 0x80

    ; Чтение ввода
    mov eax, 3
    mov ebx, 0
    mov ecx, input
    mov edx, 10
    int 0x80

    ; Вывод ответа
    mov eax, 4
    mov ebx, 1
    mov ecx, answer
    mov edx, answer_len
    int 0x80

    ; Выход
    mov eax, 1
    xor ebx, ebx
    int 0x80
