const std = @import("std");

var gpa : ?std.heap.GeneralPurposeAllocator(.{}) = null;

pub fn main() !void {
    gpa = std.heap.GeneralPurposeAllocator(.{}){};

    _ = try gpa.?.allocator().alloc(u8, 2048);

    if(gpa.?.detectLeaks())
    {
        @panic("Memory Leak");
    }
    const deinit_status = gpa.?.deinit();
    _ = &deinit_status;
}