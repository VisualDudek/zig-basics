// xxd clone
// DONE: add colors into string formating, using ANSI escape codes
// DONE: check if given char is ASCII or UTF-8, added isUTF_8 fn
// TODO: print string char by char checking if UTF-8 if yes than print in color
// BUG: UFT-8 one char can have more than one byte !!! SOLUTION in next iteration

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
            // check for line-feed
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
        // spacing
        try stdout.print("{s}", .{[_]u8{' '} ** 20});

        // print finall string char by char, if UTF-8 than in collor
        for (buffer[0..bytes_read]) |byte| {
            if (isUFT_8(byte)) {
                try stdout.print("{s}{s}{s}", .{ green, [1]u8{byte}, reset });
            } else {
                try stdout.print("{s}", .{[1]u8{byte}});
            }
        }
        // need new line bc. we swap all \n into dot .
        try stdout.print("\n", .{});
        // try stdout.print("{s}{s}{s}\n", .{ green, buffer[0..bytes_read], reset });
    }
    std.debug.print("Got EOF.", .{});
}

fn isUFT_8(c: u8) bool {
    if (c <= 127) {
        return false;
    }
    return true;
}
