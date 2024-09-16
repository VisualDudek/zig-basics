const std = @import("std");
const print = std.debug.print;

pub fn main() void {
    const range = [_]u8{ 1, 2, 3, 4, 5 };

    const foo = for (range) |i| { // now foo has type void
        // BUT using break we return type u8 (!!!) THIS IS A PROBLEM
        if (i == 3) {
            break i;
        }
    };
    // ^^^ This is a for expression, not a for loop and inplicity this branch return viod.
    // to fix we can add else branch to return a value.
    // else 0;

    print("foo: {}\n", .{foo});
}

// Compiler error:
// error: incompatible types: 'u8' and 'void'
