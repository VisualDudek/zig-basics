const std = @import("std");

pub fn main() void {
    std.debug.print("Hello, World!\n", .{});
}

// Takeaway:
// - `main() void` means main cannot return errors; handle fallible calls with `catch`.
// - `main() !void` means main may fail; you can use `try` and propagate errors.
// - Prefer `!void` for real CLI apps; use `void` for guaranteed no-fail demos.
