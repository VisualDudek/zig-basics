const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    const range = [_]u8{ 1, 2, 3, 4, 5 };

    for (range) |i| {
        print("{}\n", .{i});
    }
}
