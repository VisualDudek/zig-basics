// xxd clone
// DONE: refactor part of code that print and better handle LF
// DOEN: print in red binary LF

const std = @import("std");
const print = std.debug.print;

const UTF8 = struct {
    is: bool,
    n: u8,
};

pub fn main() !void {
    const help =
        \\For Unicode Input into terminal press:
        \\Ctrl + Shift + U
        \\smiling face emoji: 1f60a
        \\Send EOF to exit (CTRL + D)
        \\
    ;
    // print help
    print("{s}\n", .{help});

    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    // ANSI escape codes for colors
    const green = "\x1b[32m";
    const reset = "\x1b[0m";
    const red = "\x1b[31m";

    var buffer: [1024]u8 = undefined;
    var buffer_legacy: [1024]u8 = undefined;
    var n_bytes: u8 = undefined;

    // input loop
    while (true) {
        const bytes_read = try stdin.read(&buffer);
        if (bytes_read == 0) {
            break;
        }
        // keep copy of inchanged buffer
        buffer_legacy = buffer;

        // print hex
        for (buffer[0..bytes_read]) |byte| {
            // if byte is UTF-8 print in color or LR in red
            if (byte == '\n') {
                try stdout.print("{s}{X:0>2}{s} ", .{ red, byte, reset });
            } else if (isUFT_8(byte)) {
                try stdout.print("{s}{X:0>2}{s} ", .{ green, byte, reset });
            } else {
                try stdout.print("{X:0>2} ", .{byte});
            }
        }
        // spacing
        try stdout.print("{s}", .{[_]u8{' '} ** 20});

        // print finall string char by char, if UTF-8 than in collor
        for (buffer[0..bytes_read], 0..) |byte, index| {
            if (isUFT_8(byte)) {
                n_bytes = utf8CharSize(byte); // WOW CO ZA BUGGGG NIESAMOWITE
                try stdout.print("{s}{s}{s}", .{ green, buffer[index..(index + n_bytes)], reset });
            } else {
                // check for line-feed
                if (byte == '\n') {
                    try stdout.print("{s}.{s} ", .{ red, reset });
                } else {
                    try stdout.print("{s}", .{[1]u8{byte}});
                }
            }
        }
        // need new line bc. we swap all \n into dot .
        try stdout.print("\n", .{});

        // print binary in next line
        buffer = buffer_legacy;
        for (buffer[0..bytes_read]) |byte| {
            // if byte is UTF-8 print in color
            if (isUFT_8(byte)) {
                try stdout.print("{s}{b:0>8}{s} ", .{ green, byte, reset });
            } else if (byte == '\n') {
                try stdout.print("{s}{b:0>8}{s} ", .{ red, byte, reset });
            } else {
                try stdout.print("{b:0>8} ", .{byte});
            }
        }
        try stdout.print("\n", .{});
    }
    std.debug.print("Got EOF.", .{});
}

fn isUFT_8(c: u8) bool {
    if (c <= 127) {
        return false;
    }
    return true;
}

fn utf8CharSize(first_byte: u8) u8 {
    if (first_byte & 0b1000_0000 == 0) {
        // 1-byte (ASCII) character
        return 1;
    } else if (first_byte & 0b1110_0000 == 0b1100_0000) {
        // 2-byte character
        return 2;
    } else if (first_byte & 0b1111_0000 == 0b1110_0000) {
        // 3-byte character
        return 3;
    } else if (first_byte & 0b1111_1000 == 0b1111_0000) {
        // 4-byte character
        return 4;
    } else {
        // Invalid UTF-8 byte (shouldn't happen in valid UTF-8)
        return 0;
    }
}
