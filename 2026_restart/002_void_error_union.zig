const std = @import("std");

pub fn main(init: std.process.Init) !void {
    try std.Io.File.stdout().writeStreamingAll(init.io, "Hello, World!\n");

    const stdout = std.Io.File.stdout();
    stdout.writeStreamingAll(init.io, "Hello, World!\n") catch {};

    b();
    c();
}

fn b() void {
    std.debug.print("b() called\n", .{});
}

fn c() void {
    const print = std.debug.print;
    print("c() called\n", .{});
    // do not need to try or catch here because print() cannot fail -> returns void
}
