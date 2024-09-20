// zig run -lc <filename.zig>
// and run without -lc flag

const std = @import("std");
const builtin = @import("builtin");
const print = std.debug.print;

const system = if (builtin.link_libc) std.c;

pub fn main() void {
    std.debug.print("builtin.link_libc: {}\n", .{builtin.link_libc});
    if (builtin.link_libc) {
        _ = system.printf("Hello form link_libc using printf. \n");
    }
}
