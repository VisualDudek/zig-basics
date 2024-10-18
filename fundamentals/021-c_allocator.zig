// zig run -lc <filename.zig>
// C allocator is only available when linking against libc

const std = @import("std");

pub fn main() !void {
    // Get the allocator
    const allocator = std.heap.c_allocator;

    // Get process ID
    const pid = std.os.linux.getpid();

    // Declare constant on stack
    const stack_number: i32 = 123454321;

    // Allocate variable on heap
    const heap_number = try allocator.create(i32);
    defer allocator.destroy(heap_number);
    heap_number.* = 100;

    // Print information
    const stdout = std.io.getStdOut().writer();
    try stdout.print("Process ID: {}\n", .{pid});
    try stdout.print("Stack number value: {}, address: {*}\n", .{ stack_number, &stack_number });
    try stdout.print("Heap number value: {}, address: {*}\n", .{ heap_number.*, heap_number });

    // Wait for Enter key
    const stdin = std.io.getStdIn().reader();
    try stdout.print("\nPress Enter to exit...", .{});
    _ = try stdin.readByte();
}
