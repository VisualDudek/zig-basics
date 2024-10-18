// zig run -lc <filename.zig>
// C allocator is only available when linking against libc

const std = @import("std");
const fs = std.fs;

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
    try printMemoryMap(allocator, pid);
}

fn printMemoryMap(allocator: std.mem.Allocator, pid: i32) !void {
    const stdout = std.io.getStdOut().writer();

    // Create path to maps file
    const maps_path = try std.fmt.allocPrint(allocator, "/proc/{}/maps", .{pid});
    defer allocator.free(maps_path);

    // Open the maps file
    const file = try fs.openFileAbsolute(maps_path, .{});
    defer file.close();

    // Create buffered reader
    var buf_reader = std.io.bufferedReader(file.reader());
    var reader = buf_reader.reader();

    // Read line by line
    var buffer: [1024]u8 = undefined;

    try stdout.print("Memory Map for PID {}:\n", .{pid});
    try stdout.print("Address Range                  Perms   Offset   Dev     Inode     Path\n", .{});
    try stdout.print("------------------------------ ------- -------- ------- --------- --------\n", .{});

    while (try reader.readUntilDelimiterOrEof(&buffer, '\n')) |line| {
        // Parse each line
        var tokens = std.mem.tokenizeAny(u8, line, " \t");

        // Address range
        if (tokens.next()) |addr_range| {
            try stdout.print("{s: <30} ", .{addr_range});
        }

        // Permissions
        if (tokens.next()) |perms| {
            try stdout.print("{s: <7} ", .{perms});
        }

        // Offset
        if (tokens.next()) |offset| {
            try stdout.print("{s: <8} ", .{offset});
        }

        // Device
        if (tokens.next()) |dev| {
            try stdout.print("{s: <7} ", .{dev});
        }

        // Inode
        if (tokens.next()) |inode| {
            try stdout.print("{s: <9} ", .{inode});
        }

        // Path (if exists)
        if (tokens.next()) |path| {
            try stdout.print("{s}", .{path});
        }

        try stdout.print("\n", .{});
    }
}
