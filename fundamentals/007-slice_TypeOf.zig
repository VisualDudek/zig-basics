const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    // const arr: []const u32 = &[_]u32{ 1, 2, 3, 4, 5 };
    const arr = &[_]u32{ 1, 2, 3, 4, 5 };
    const s = @TypeOf(arr);
    std.debug.print("{}\n", .{s});
}
