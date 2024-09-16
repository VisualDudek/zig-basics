const print = @import("std").debug.print;

pub fn main() void {
    inline for (1..6) |i| {
        print("i: {}\n", .{i});
    }

    inline for (.{ u8, u16, u32, u64, u128 }) |T| {
        print("T: {}\n", .{@typeInfo(T).int.bits});
    }
}
