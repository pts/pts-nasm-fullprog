;
; hi32.nasm: 32-bit i386 hello-world for DOS
; by pts@fazekas.hu at Mon Jun 29 21:23:41 CEST 2020
;
; Create WDOSX.DX:
;
; $ wget -nv -O wdosx097.zip http://tippach.business.t-online.de/wdosx/wdosx097.zip
; $ unzip -q -c wdosx097.zip BIN/STUBIT.EXE >stubit.exe
; $ SDL_VIDEODRIVER=dummy SDL_AUDIODRIVER=dummy dosbox -conf /dev/null -c "mount c ." -c c: -c "stubit.exe -extract" -c exit
;
; Compile (assemble):
;
;   $ nasm -o hi32.exe hi32.nasm
;
; Try:
;
;   $ dosbox .
;     C:\>hi32
;     Hello, World!
;     C:\>exit
;

bits 32
wdosx_dx_start:
incbin "WDOSX.DX"  ; ~9720 bytes.
org wdosx_dx_start-$

mov ax, 0x901
int 0x31  ; Enable virtual interrupts.
mov edx, msg  ; 32-bit pointer to string.
mov ah, 9  ; Print message.
int 0x21
mov ax, 0x4c00  ; exit(0).
int 0x21

msg: db 'Hello, World!', 13, 10, '$'
