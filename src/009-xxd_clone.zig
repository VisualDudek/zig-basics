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

const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    // get stdin reader
    const stdin_file: std.fs.File = std.io.getStdIn(); // manuall annotanion based on docs helps
    const reader = stdin_file.reader();
    var buffer: [1024]u8 = undefined;

    // read from stdin
    // const read_result = try reader.readAll(&buffer);
    while (try reader.readUntilDelimiterOrEof(&buffer, 4)) |line| {
        std.debug.print("Read from stdin {s}\n", .{line});
    }
    std.debug.print("EOF\n", .{});
}
