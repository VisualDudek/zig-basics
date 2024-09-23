const std = @import("std");

const MyStruct = packed struct {
    field1: u8,
    field2: u8,
};

pub fn main() void {
    var some_value: u32 = 0x12345678;

    // Get a pointer to `some_value`
    const ptr = &some_value;

    // Read bytes from the pointer
    var byte_ptr: [*]const u8 = @ptrCast(ptr);

    // Print each byte (raw memory bytes)
    for (byte_ptr[0..@sizeOf(u32)], 0..) |byte, i| {
        std.debug.print("some_value: Byte {}: {x}\n", .{ i, byte });
    }

    // Can I do the same with struct?
    const mystruct = MyStruct{
        .field1 = 0x12,
        .field2 = 0x34,
    };

    byte_ptr = @ptrCast(&mystruct);

    for (byte_ptr[0..@sizeOf(MyStruct)], 0..) |byte, i| {
        std.debug.print("mystruct: Byte {}: {x}\n", .{ i, byte });
    }
}
