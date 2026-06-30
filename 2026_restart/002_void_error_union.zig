const std = @import("std");

pub fn main(init: std.process.Init) !void {
    try std.Io.File.stdout().writeStreamingAll(init.io, "Hello, World!\n");

    const stdout = std.Io.File.stdout();
    stdout.writeStreamingAll(init.io, "Hello, World!\n") catch {};

    b();
}

fn b() void {
    std.debug.print("b() called\n", .{});
}
