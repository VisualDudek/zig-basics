// xxd clone
// TODO: simple echo, read from stdin and write to stdout
// from this programm you can understand how buffer overflow of stdin read works

const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    const stdin = std.io.getStdIn().reader();

    // var buffer: [4]u8 = undefined;
    var buffer: [1024]u8 = undefined;

    while (true) {
        const bytes_read = try stdin.read(&buffer);
        if (bytes_read == 0) {
            break;
        }
        std.debug.print("{s}\n", .{buffer[0..bytes_read]});
    }
    std.debug.print("Got EOF.", .{});
}
