;
; hi16.nasm: 16-bit i386 hello-world for DOS
; by pts@fazekas.hu at Mon Jun 29 21:23:41 CEST 2020
;
; Compile (assemble):
;
;   $ nasm -o hi16.com hi16.nasm
;
; Try:
;
;   $ dosbox .
;     C:\>hi16
;     Hello, World!
;     C:\>exit
;

bits 16
org 0x100

mov dx, msg  ; 16-bit pointer to string.
mov ah, 9  ; Print message.
int 0x21
ret  ; exit(0).

msg: db 'Hello, World!', 13, 10, '$'
