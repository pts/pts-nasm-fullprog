;
; exit_exe.nasm: shortest, 28-byte DOS .exe which calls exit(42) immediately
; by pts@fazekas.hu at Wed Jul  8 13:49:29 CEST 2020
;
; $ nasm -f bin -o exit_exe.exe exit_exe.nasm
; $ ndisasm -b 16 -e 13 exit_exe.exe
;
; Needs 317 KiB of free conventional memory to run in DOS.
;
; If we remove the bytes starting at `arbitrary:', DOSBox won't load the
; .exe file, because it is shorter than 28 bytes.
;

exit_code equ 42  ; Can be arbitrary.

exe_header:
dw 'MZ'  ; DOS .exe signature.
dw exe_header_end-exe_header  ; Image size low 9 bits: 24.
dw 1  ; Image size high bits, rounded up.
dw 0  ; Relocation count.
dw 0  ; Paragraph (16 byte) count of header.
dw 0x4f1c  ; Paragraph count of minimum required memory, large enough to fit stack (ss:sp) for any values of exit_code.
start1:
dw 0xb800  ; Paragraph count of maximum required memory. 0xb8 is `mov ax, ...'
dw 0x4c00+exit_code  ; Stack segment (ss) base, also 0x4c is EXIT DOS function, 0x2a is exit_code.
dw 0x21cd  ; Stack pointer (sp), also `int 0x21'.
dw 0  ; No file checksum.
dw (start1+1)-exe_header ; Instruction pointer (ip): 13.
dw 0  ; Code segment (cs) base.
arbirary:
dw -1  ; Relocation offset. Arbitrary.
dw -1  ; Overlay number. Arbitrary.
exe_header_end:
