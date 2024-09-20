// xxd clone
// DONE: add colors into string formating, using ANSI escape codes
// DONE: check if given char is ASCII or UTF-8, added isUTF_8 fn

const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    // ANSI escape codes for colors
    const green = "\x1b[32m";
    const reset = "\x1b[0m";

    var buffer: [1024]u8 = undefined;

    // input loop
    while (true) {
        const bytes_read = try stdin.read(&buffer);
        if (bytes_read == 0) {
            break;
        }
        for (buffer[0..bytes_read], 0..) |byte, index| {
            if (byte == '\n') {
                buffer[index] = '.';
            }
            // if byte is UTF-8 print in color
            if (isUFT_8(byte)) {
                try stdout.print("{s}{X:0>2}{s} ", .{ green, byte, reset });
            } else {
                try stdout.print("{X:0>2} ", .{byte});
            }
        }
        try stdout.print("{s}", .{[_]u8{' '} ** 20});
        // print char in collor
        try stdout.print("{s}{s}{s}\n", .{ green, buffer[0..bytes_read], reset });
    }
    std.debug.print("Got EOF.", .{});
}

fn isUFT_8(c: u8) bool {
    if (c <= 127) {
        return false;
    }
    return true;
}
