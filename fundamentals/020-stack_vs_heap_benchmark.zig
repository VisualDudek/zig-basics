const std = @import("std");
const print = std.debug.print;

fn fillArray(array: []u8, value: u8) void {
    for (array) |*elem| {
        elem.* = value;
    }
}

pub fn main() void {
    const len: usize = 100_000;

    // Benchmark stack allocation
    var stackArray: [len]u8 = undefined; // Array on the stack
    const stackStart = std.time.nanoTimestamp();
    fillArray(stackArray[0..], 'A');
    const stackEnd = std.time.nanoTimestamp();
    const stackDuration = stackEnd - stackStart;

    // Print stack allocation time
    print("Stack allocation and fill: {d} ns\n", .{stackDuration});

    // Benchmark heap allocation
    const heapStart = std.time.nanoTimestamp();
    const heapArray = std.heap.page_allocator.alloc(u8, len) catch {
        print("Heap allocation failed!\n", .{});
        return;
    };
    fillArray(heapArray, 'A');
    const heapEnd = std.time.nanoTimestamp();
    const heapDuration = heapEnd - heapStart;

    // Print heap allocation time
    print("Heap allocation and fill: {d} ns\n", .{heapDuration});

    // Free heap memory
    std.heap.page_allocator.free(heapArray);
}
