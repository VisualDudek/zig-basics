// run with: zig run <filename.zig> -- [args]
// only for testing autodoc.py
const std = @import("std");
const print = std.debug.print;

pub fn main() !void {
    // std.debug.print("Hello, world!\n");
    var args_iter = std.process.args();
    var i: u8 = 0;
    // var n: i16 = undefined;

    while (args_iter.next()) |arg| {
        print("{}: Arg: {s}\n", .{ i, arg });
        if (i == 1) {
            const n = std.fmt.parseInt(i16, arg, 10) catch |err| blk: {
                std.debug.print("Faild to parse arg: {} setting default value \n", .{err});
                break :blk 6;
            };
            print("Parsed integer: {}\n", .{n});
        }
        i += 1;
    }
}
