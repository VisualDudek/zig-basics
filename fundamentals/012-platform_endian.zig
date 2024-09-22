const std = @import("std");
const native_endian = @import("builtin").target.cpu.arch.endian();

pub fn main() void {
    switch (native_endian) {
        .big => {
            std.debug.print("Big-endian\n", .{});
        },
        .little => {
            std.debug.print("Little-endian\n", .{});
        },
    }
}
