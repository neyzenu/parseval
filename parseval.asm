section .data
    ; Zaman domeni sinyal verileri (x[n])
    x:  dd 1, 2, 3, 4, 5, 6, 7, 8
    N:  equ 8          ; Veri sayısı

    ; Frekans domeni sinyal verileri (X[k] - mutlak kareler)
    X:  dd 64, 16, 16, 16, 16, 16, 16, 16
    ; Not: Örneğin, X[k] değerleri önceden hesaplanmıştır.

    fmt_sum_time db "Zaman domeni enerji: %d", 10, 0
    fmt_sum_freq db "Frekans domeni enerji: %d", 10, 0

section .bss
    sum_time resd 1
    sum_freq resd 1

section .text
    global main
    extern printf

main:
    ; Hesaplama için gerekli register'ları temizle
    xor rax, rax
    xor rbx, rbx

    ; Zaman domeni enerjisini hesapla
    mov ecx, 0          ; Sayaç
    mov ebx, 0          ; Toplam için EBX kullanılacak

sum_time_loop:
    cmp ecx, N
    jge sum_time_done

    mov eax, [x + rcx*4]    ; x[ecx]
    imul eax, eax           ; x[n]^2
    add ebx, eax            ; Toplama ekle

    inc ecx
    jmp sum_time_loop

sum_time_done:
    mov [sum_time], ebx     ; Toplamı sakla

    ; Frekans domeni enerjisini hesapla
    xor ebx, ebx             ; Toplamı temizle
    mov ecx, 0

sum_freq_loop:
    cmp ecx, N
    jge sum_freq_done

    mov eax, [X + rcx*4]    ; X[k]
    imul eax, eax           ; X[k]^2
    add ebx, eax            ; Toplama ekle

    inc ecx
    jmp sum_freq_loop

sum_freq_done:
    mov [sum_freq], ebx

    ; Sonuçları ekrana yazdır
    ; printf("Zaman domeni enerji: %d\n", sum_time)
    mov rdi, fmt_sum_time
    mov eax, [sum_time]
    mov rsi, eax
    xor rax, rax
    call printf

    ; printf("Frekans domeni enerji: %d\n", sum_freq)
    mov rdi, fmt_sum_freq
    mov eax, [sum_freq]
    mov rsi, eax
    xor rax, rax
    call printf

    ; Programı sonlandır
    mov eax, 0
    ret
