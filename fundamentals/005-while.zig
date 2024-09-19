const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    var i: u8 = 0;
    while (i < 3) : (i += 1) {
        print("i: {}\n", .{i});
    }
}
