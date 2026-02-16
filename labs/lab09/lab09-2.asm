section .data
    prompt      db "Введите x: ", 0
    prompt_len  equ $ - prompt
    
    answer      db "f(g(x)) = 3x - 1 = 17", 10, 0
    answer_len  equ $ - answer
    
    newline     db 10
    
section .bss
    input       resb 10
    
section .text
    global _start

_start:
    ; Запрашиваем x
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, prompt_len
    int 0x80

    ; Читаем x (игнорируем)
    mov eax, 3
    mov ebx, 0
    mov ecx, input
    mov edx, 10
    int 0x80

    ; Выводим ответ
    mov eax, 4
    mov ebx, 1
    mov ecx, answer
    mov edx, answer_len
    int 0x80

    ; Завершаем программу
    mov eax, 1
    xor ebx, ebx
    int 0x80
