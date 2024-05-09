const std = @import("std");

pub fn build(b: *std.Build) void {
    const exe = b.addExecutable(.{
        .name = "hello-zig",
        .root_source_file = .{ .path = "hello.zig" },
        .target = b.host,
    });

    b.installArtifact(exe);
}
