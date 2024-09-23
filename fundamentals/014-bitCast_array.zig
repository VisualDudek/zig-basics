const std = @import("std");

const MyStruct = packed struct {
    field1: u8,
    field2: u8,
    field3: u8,
};

const Small = packed struct {
    field1: u8,
    field2: u8,
};

pub fn main() void {
    const bytes = [_]u8{ 0x12, 0x34, 0x56 };
    const dest: MyStruct = @bitCast(bytes);
    const small: Small = @bitCast(bytes[0..2].*); // Slice is a pointer and a length.
    // cannot bitCast pointer to struct
    // thats why dereference

    std.debug.print("Array of bytes: {X}\n", .{bytes});
    std.debug.print("Destination: {{ field1: {X}, field2: {X}, field3: {X} }}\n", .{ dest.field1, dest.field2, dest.field3 });
    std.debug.print("Small: {{ field1: {X}, field2: {X} }}\n", .{ small.field1, small.field2 });
}
