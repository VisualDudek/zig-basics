## 010-xxd_clone.zig
```txt
// xxd clone
// TODO: simple echo, read from stdin and write to stdout
// from this programm you can understand how buffer overflow of stdin read works
```

## 006-cImport.zig
```txt
// zig run -lc <filename.zig>
```

## 011-xxd_clone.zig
```txt
// xxd clone
// TODO: change debug to stdout
// TODO: print bytes in hex format
// TODO: capture newline and change it into dot .
```

## 008-cli_args.zig
```txt
// run with: zig run <filename.zig> -- [args]
// only for testing autodoc.py
```

## 009-xxd_clone.zig
```txt
// run with: zig run <filename.zig> -- [args]
// xxd clone
// TODO: simple echo, read from stdin and write to stdout
// Ctrl+D in Linux terminal does not send a signal in the same way as Ctrl+C or Ctrl+Z
// if pressed at the beginning of a line, generates an EOF condition on the input stream
// it is an input character, not a signal, sends ASCII code 4 (EOT) to the tranmission
// which has a value 4.
// is it a good idea? to have implicite EOF and implicete EOT?
// reader.readUntilDelimiterOrEof(&buffer, 4)
// NO
```

