const std = @import("std");
const print = std.debug.print;
const helper = @import("./023-print_memory_map_stack.zig");

fn fillArray(array: []u8, value: u8) void {
    for (array) |*elem| {
        elem.* = value;
    }
}

pub fn main() !void {
    const len: usize = 100_000;
    const allocator = std.heap.c_allocator;

    // Get process ID
    const pid = std.os.linux.getpid();

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

    // Try to allocate array on heap ucing c_allocator
    const heap_Start = std.time.nanoTimestamp();
    const heap_array = try allocator.create([len]u8);
    fillArray(heap_array, 'A');
    const heap_End = std.time.nanoTimestamp();
    const heap_Duration = heap_End - heap_Start;
    defer allocator.destroy(heap_array);

    // Print heap allocation time
    print("Heap allocation and fill: {d} ns\n", .{heapDuration});
    print("heap_array allocation and fill: {d} ns\n", .{heap_Duration});

    // Print addresses
    print("Stack array address: {*}\n", .{&stackArray});
    print("Stack array of first element address: {*}\n", .{&stackArray[0]});
    print("Heap array address: {*}\n", .{&heapArray});
    print("Heap array of first element address: {*}\n", .{&heapArray[0]});
    print("Heap_array address: {*}\n", .{&heap_array});
    print("Heap_array address of first element: {*}\n", .{&heap_array[0]});
    print("Heap_array address of 2ed element: {*}\n", .{&heap_array[1]});

    // Print memory map
    try helper.printMemoryMap(allocator, pid);

    // Free heap memory
    std.heap.page_allocator.free(heapArray);
}
