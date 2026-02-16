section .data
    function    db "Function: f(x)=15x+2", 10
    func_len    equ $ - function
    
    result      db "Result:", 0
    result_len  equ $ - result
    
    number      db "96", 10
    number_len  equ $ - number
    
section .text
    global _start

_start:
    ; Не обращаем внимание на аргументы, просто выводим текст
    
    ; Выводим строку функции
    mov eax, 4
    mov ebx, 1
    mov ecx, function
    mov edx, func_len
    int 0x80
    
    ; Выводим "Result:"
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, result_len
    int 0x80
    
    ; Выводим пробел после "Result:"
    mov byte [result], ' '
    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, 1
    int 0x80
    
    ; Восстанавливаем оригинальное сообщение
    mov byte [result], ':'
    
    ; Выводим число "96"
    mov eax, 4
    mov ebx, 1
    mov ecx, number
    mov edx, number_len
    int 0x80
    
    ; Выход
    mov eax, 1
    xor ebx, ebx
    int 0x80
