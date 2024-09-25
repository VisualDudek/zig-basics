const std = @import("std");
const c = @cImport({
    @cInclude("sys/socket.h");
    @cInclude("ifaddrs.h");
});

pub fn main() !void {
    var addresses: ?*c.ifaddrs = null;

    if (c.getifaddrs(&addresses) == -1) {
        std.debug.print("Error", .{});
        return error.Error;
    }

    std.debug.print("OK\n", .{});

    var address: ?*c.ifaddrs = addresses;
    while (address) |addr| {
        if (addr.ifa_addr == null) {
            address = addr.ifa_next;
            continue;
        }
        // std.debug.print("{any}\n", .{addr.ifa_addr.*.sa_family});
        std.debug.print("{s}\n", .{addr.ifa_name});
        address = addr.ifa_next;
    }

    if (addresses) |addrs| {
        c.freeifaddrs(addrs);
    }
}
