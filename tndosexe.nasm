;
; tndosexe.nasm: test memory access for fullprog_dosexe.inc.nasm
; by pts@fazekas.hu at Wed Jun 24 23:11:49 CEST 2020
;
; $ nasm -f bin -o tndosexe.exe tndosexe.nasm
; $ ndisasm -b 16 -e 26 -o 10 tndosexe.exe
;

%include "fullprog_dosexe.inc.nasm"

fullprog_code

mov bx, cont
jmp bx
cont:
mov ah, 9  ; WRITE_STDOUT.
push dword 'T$'
mov dx, sp
int 0x21
;pop dx  ; Not needed for DOS .com exit.
mov dx, msg
mov di, myvar
push es
push ds
pop es
mov cx, (myvar_end-myvar)>>1
rep stosw  ; Overwrite, just to prove that it doesn't hurt.
int 0x21
pop ds  ; PSP, originally in es.
mov si, 0x80
xor ax, ax
lodsb
xchg ax, cx  ; cx := ax.
mov ah, 2  ; PUTCHAR_STDOUT.
mov dl, '('
int 0x21
inc cx
jmp short check_printargstr
; First character printed is the space after the program name.
; FreeDOS doesn't remove trailing spaces.
print_argchr:
lodsb
mov dl, al
int 0x21
check_printargstr:
dec cx
jnz print_argchr
mov dl, ')'
int 0x21
mov ah, 9  ; WRITE_STDOUT
push ss
pop ds
mov dx, msg_crlf
int 0x21

fullprog_data

msg: db 'est, World!'
msg_crlf: db 13, 10, '$'

fullprog_bss

myvar: resb 8888
myvar_end:

fullprog_end
