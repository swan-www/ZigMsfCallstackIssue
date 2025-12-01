const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const callstack_bug_exe = b.addExecutable(.{
        .name = "callstack_bug",
        .root_module = b.createModule(.{ .target=target, .optimize=optimize, .root_source_file = b.path("callstack_bug.zig") }),
    });

    const zig_sdl = b.dependency("zig_sdl", .{ .target=target, .optimize=optimize,});
    const sdl_module = zig_sdl.module("sdl");

    const zimgui = b.dependency("zimgui", .{ .target=target, .optimize=optimize, .CIMGUI_USE_SDL3=true, .CIMGUI_USE_SDL3_GPU=true, });

    callstack_bug_exe.root_module.addCMacro("CIMGUI_USE_SDL3", "");
    callstack_bug_exe.root_module.addCMacro("IMGUI_DISABLE_OBSOLETE_FUNCTIONS", "");
    callstack_bug_exe.linkLibC();
    callstack_bug_exe.root_module.addImport("sdl", sdl_module);    
    const sdl_lib = zig_sdl.artifact("sdl3");
    callstack_bug_exe.linkLibrary(sdl_lib);

    const zimgui_module = zimgui.module("zimgui");
    callstack_bug_exe.root_module.addImport("zimgui", zimgui_module);
    const zimgui_lib = zimgui.artifact("zimgui_lib");
    callstack_bug_exe.linkLibrary(zimgui_lib);

    const mod_imgui_impl_sdl3gpu_source = zimgui.module("imgui_impl_sdl3gpu_source");
    const mod_imgui_impl_sdlrenderer3_source = zimgui.module("imgui_impl_sdlrenderer3_source");
    const mod_imgui_impl_sdl3_source = zimgui.module("imgui_impl_sdl3_source");
    callstack_bug_exe.root_module.addCSourceFile(.{ .file = mod_imgui_impl_sdl3gpu_source.root_source_file.?, .flags = &.{ "-DIMGUI_IMPL_API=extern \"C\""}, });
    callstack_bug_exe.root_module.addCSourceFile(.{ .file = mod_imgui_impl_sdlrenderer3_source.root_source_file.?, .flags = &.{ "-DIMGUI_IMPL_API=extern \"C\""}, });
    callstack_bug_exe.root_module.addCSourceFile(.{ .file = mod_imgui_impl_sdl3_source.root_source_file.?, .flags = &.{ "-DIMGUI_IMPL_API=extern \"C\""}, });
    mod_imgui_impl_sdl3gpu_source.addIncludePath(zig_sdl.namedLazyPath("sdl_include_path"));

    switch (target.result.os.tag) {
        .windows => {
            callstack_bug_exe.linkSystemLibrary("Advapi32");
        },
        else => {
            //TODO
        },
    }
    
    b.installArtifact(callstack_bug_exe);

    const run_exe = b.addRunArtifact(callstack_bug_exe);
    const run_step = b.step("run", "Run the application");
    run_step.dependOn(&run_exe.step);
}