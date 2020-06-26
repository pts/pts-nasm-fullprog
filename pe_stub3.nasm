;
; pe_stub3.nasm: DOS stub for Windows PE header, full message and long prefix
; by pts@fazekas.hu at Fri Jun 26 18:21:46 CEST 2020
;
; $ nasm -f bin -o pe_stub3.exe pe_stub3.nasm
; $ ndisasm -b 16 -e 77 -o 77 pe_stub3.exe
;

bits 16
cpu 8086
db 'MZ'  ; Signature.
dw pe_header  ; Image size low 9 bits.
dw 1  ; Image size high bits, rounded up.
dw 0  ; Relocation count.
dw 0  ; Paragraph (16 byte) count of header. Points to the top of the file.
dw (0x400-(pe_header-$$))>>4  ; Reserve 0x340 bytes of extra memory for stack.
dw 0xffff  ; Paragraph count of maximum required memory.
dw 0  ; Stack segment (ss) base.
dw 0x400  ; Stack pointer (sp).
dw 0  ; No file checksum.
dw start  ; Instruction pointer (ip).
dw 0  ; Code segment (cs) base.
; We reuse the final 4 bytes of the .exe header (dw relocation_table_ofs,
; overlay_number) for code.

msg: db 'This program cannot be run in DOS m$'
dd pe_header  ; At offset 60. Points to the "PE\0\0" header.
msg2: db 'ode.', 13, 10, '$'
times 6 db 0

start:
push ss
pop ds
mov ah, 9  ; WRITE_STDOUT.
mov dx, msg
int 0x21
mov dx, msg2
int 0x21
mov ax, 0x4c01  ; EXIT.
int 0x21

align 16
pe_header:
