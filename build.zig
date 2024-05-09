const std = @import("std");

const allocator = std.heap.page_allocator;

pub fn build(b: *std.Build) !void {
    const exe = b.addExecutable(.{
        .name = "hello-zig",
        .root_source_file = .{ .path = "hello.zig" },
        .target = b.host,
    });

    const raylib_path_include = try std.process.getEnvVarOwned(allocator, "RAYLIB_PATH_INCLUDE");
    const raylib_path_lib = try std.process.getEnvVarOwned(allocator, "RAYLIB_PATH_LIB");
    const opengl_path_lib = try std.process.getEnvVarOwned(allocator, "OPENGL_PATH_LIB");

    exe.addIncludePath( .{ .path = raylib_path_include } );
    exe.addLibraryPath( .{ .path = raylib_path_lib } );
    exe.addLibraryPath( .{ .path = opengl_path_lib } );

    exe.linkSystemLibrary("raylib");
    exe.linkSystemLibrary("OpenGL");
    exe.linkSystemLibrary("c");

    b.installArtifact(exe);
}
