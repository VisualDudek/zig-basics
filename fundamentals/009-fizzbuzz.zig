const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    var n: u32 = 1;

    while (n < 20) {
        std.debug.print("{d}: ", .{n});
        if (n % 3 == 0) {
            std.debug.print("Fizz", .{});
        }
        if (n % 5 == 0) {
            std.debug.print("Buzz", .{});
        }
        if (n % 3 != 0 and n % 5 != 0) {
            std.debug.print("{d}", .{n});
        }

        std.debug.print("\n", .{});
        n += 1;
    }
}
