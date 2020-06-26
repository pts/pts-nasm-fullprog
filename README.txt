pts-nasm-fullprog: libraries for writing full executable programs with NASM
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
pts-nasm-fullprog contains a few %include files for NASM for writing full
executable programs directly (rather feeding the object file output of NASM
to the linker). Thus NASM can be used without a linker. The libraries are
optimized for size, they add only a few bytes of overhead, less than how
much a generic linker would add.

Supported architecture targets:

* fullprog_doscom.inc.nasm: DOS 8086 (16-bit) .com file. It implements the
  tiny memory model, maximum size of code + data + stack is ~63 KiB.
  Shortest output program (which just exits) is 1 byte.

* fullprog_dosexe.inc.nasm: DOS 8086 (16-bit) .exe file. It implements the
  small memory model, maximum size of code is ~64 KiB, maximum size of
  data + stack is ~64 KiB. Shortest output program (which just exits) is
  31 bytes. (The same program would be >=64 bytes with OpenWatcom if ss, ds
  and sp were to be set up properly.)

See *.nasm files for examples.

See usage instructions in the respective *.inc.nasm file.

For using NASM to build tiny full executable programs for the Linux i386
(32-bit) target, see
https://www.muppetlabs.com/~breadbox/software/tiny/teensy.html . The
shortest output program (which just exits) without ELF header overlap
trickery is 91 bytes.

The pe_stub*.exe files are examples for writing a shorted DOS stub for
Windows PE executables. Typically the DOS stub is 0x80 == 128 bytes. The
minimum is 0x40 == 64 bytes, which is achieved by pe_stub1.nasm .

__END__
