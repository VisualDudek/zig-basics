const std = @import("std");

const MyStruct = packed struct {
    field1: u16,
    field2: u8,
    field3: u8,
};

const Divided = packed struct {
    first8: u16,
    rest24: u16,
};

pub fn main() void {
    // const source: u32 = 0b1110_1010_1100_1010_1100_1010_1100_1010;
    const source: u32 = 0x12_34_56_78;

    const destination: MyStruct = @bitCast(source);
    const divided: Divided = @bitCast(source);

    const explainer =
        \\ On little-endian following hex value 0x 12 34 56 78 -> (32 bits), 
        \\one char => 4 bits, two chars (one group) => 1 byte
        \\will be stored in LSB representaion: 78 56 34 12
        \\when source is @bitCast into MyStruct following happens:
        \\      78 56 34 12
        \\      ^^^^^
        \\      cast to field1 BUT it is LSB
        \\                     so LSB 78 56 => 56 78 (human readable)
        \\
    ;

    std.debug.print("{s} \n", .{explainer});

    std.debug.print("--- hex --- \n", .{});
    std.debug.print("Source in hex: {X} source in dec: {0d}\n", .{source});
    std.debug.print("Source: {X}\n", .{source});
    std.debug.print("Destination: {{ field1: {X}, field2: {X}, field3: {X} }}\n", .{ destination.field1, destination.field2, destination.field3 });
    std.debug.print("Divided: first8: {X} \n", .{divided.first8});
    std.debug.print("--- bin --- \n", .{});
    std.debug.print("Source: {b}\n", .{source});
    std.debug.print("Destination: {{ field1: {b}, field2: {b}, field3: {b} }}\n", .{ destination.field1, destination.field2, destination.field3 });
    std.debug.print("Divided: first8: {b} \n", .{divided.first8});

    std.debug.print("--- memory addresses --- \n", .{});
    std.debug.print("Address of field1: {p}\n", .{&destination.field1});
    std.debug.print("Address of field2: {p}\n", .{&destination.field2});
    std.debug.print("Address of field2: {p}\n", .{&destination.field3});
}
