// xxd clone
// TODO: change debug to stdout
// TODO: print bytes in hex format
// TODO: capture newline and change it into dot .

const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    // var buffer: [4]u8 = undefined;
    var buffer: [1024]u8 = undefined;

    while (true) {
        const bytes_read = try stdin.read(&buffer);
        if (bytes_read == 0) {
            break;
        }
        for (buffer[0..bytes_read], 0..) |byte, index| {
            if (byte == '\n') {
                buffer[index] = '.';
            }
            try stdout.print("{X:0>2} ", .{byte});
        }
        try stdout.print("{s}", .{[_]u8{' '} ** 20});
        try stdout.print("{s}\n", .{buffer[0..bytes_read]});
    }
    std.debug.print("Got EOF.", .{});
}
