const std = @import("std");
const mem = std.mem;

const IcmpHeader = packed struct {
    type: u8,
    code: u8,
    checksum: u16,
    id: u16,
    sequence: u16,
};

const ICMP_HEADER_LEN = 8;

pub fn main() void {
    var icmp_header: [ICMP_HEADER_LEN]u8 = undefined;

    // Create ICMP header
    const icmp_ptr = mem.bytesAsValue(IcmpHeader, &icmp_header);
    icmp_ptr.* = .{
        .type = 8, // Echo request
        .code = 0,
        .checksum = 0,
        .id = @byteSwap(@as(u16, 1)),
        .sequence = 0,
    };

    std.debug.print("ICMP packet created:\n", .{});
    for (icmp_header, 0..) |byte, i| {
        if (i % 16 == 0) std.debug.print("\n", .{});
        std.debug.print("{x:0>2} ", .{byte});
    }

    std.debug.print("\nType of pointer icmp_ptr: {}\n", .{@TypeOf(icmp_ptr)});
    std.debug.print("Read value from pointer, icmp_ptr.type: {x}\n", .{icmp_ptr.type});
}
