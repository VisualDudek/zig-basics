const std = @import("std");

const MyStruct = packed struct {
    a: u8,
    b: u8,
};

pub fn main() void {
    const src = MyStruct{ .a = 1, .b = 2 };
    const dest: MyStruct = @bitCast(src);

    // @memcpy(&dest, &src);
    // @memcpy(@as([]u8, @ptrCast(&dest)), @as(*[@sizeOf(MyStruct)]u8, @constCast(&src)));

    std.debug.print("a = {}, b = {}", .{ dest.a, dest.b });
}
