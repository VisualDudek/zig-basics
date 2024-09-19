// zig run -lc <filename.zig>

const std = @import("std");
const print = std.debug.print;

const c = @cImport({
    @cInclude("stdio.h");
    @cInclude("unistd.h");
});

pub fn main() void {
    // std.debug.print("Hello, world!\n");
    _ = c.printf("Hello, world!\n");
    const c_res = c.write(2, "Hello, world!\n", 13);
    print("c_res: {}\n", .{c_res});
}
