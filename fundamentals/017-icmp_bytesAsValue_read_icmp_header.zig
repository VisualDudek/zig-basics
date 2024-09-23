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
    // data from icmp_dump.txt
    var icmp_header: [ICMP_HEADER_LEN]u8 = [_]u8{ 0x08, 0x00, 0xb3, 0x96, 0x00, 0x01, 0x00, 0x01 };

    // Create ICMP header pointer
    const icmp_ptr = mem.bytesAsValue(IcmpHeader, &icmp_header);

    std.debug.print("\nType of pointer icmp_ptr: {}\n", .{@TypeOf(icmp_ptr)});
    std.debug.print("Read value from pointer:\n", .{});
    std.debug.print("\ticmp_ptr.type: {x}\n", .{icmp_ptr.type});
    std.debug.print("\ticmp_ptr.code: {x}\n", .{icmp_ptr.code});
    std.debug.print("\ticmp_ptr.checksum (LE): {x:0>4}\n", .{icmp_ptr.checksum});
    std.debug.print("\ticmp_ptr.id (LE): {x:0>4}\n", .{icmp_ptr.id});
    std.debug.print("\ticmp_ptr.sequence (LE): {x:0>4}\n", .{icmp_ptr.sequence});
}
