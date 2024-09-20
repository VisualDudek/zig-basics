// zig run -lc <filename.zig>

const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    const stdout_fd = std.io.getStdOut().handle;
    const stdin_fd = std.io.getStdIn().handle;
    const is_out_tty = std.posix.isatty(stdout_fd);
    const is_in_tty = std.posix.isatty(stdin_fd);

    std.debug.print("Is stdout a TTY? {}\n", .{is_out_tty});
    std.debug.print("Is stdin a TTY? {}\n", .{is_in_tty});
}
