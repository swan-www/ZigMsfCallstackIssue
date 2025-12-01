const std = @import("std");
//const sdl = @import("sdl");
//const imgui = @import("zimgui");
//
//const SDLError = error{
//    SDLInitFail,
//    AddEventWatchFailure,
//    ShadercrossInitFail,
//    GPUCreateDeviceFail,
//    CreateWindowFail,
//    GPUClaimWindowFail,
//    InvalidShaderStage,
//    FailedToLoadShaderFromDisk,
//    FailedToCompileShaderFromSpirv,
//    FailedToCreatePipeline,
//    AcquireGPUCommandBufferFailed,
//    AcquireGPUSwapchainTextureFailed,
//    CreateRendererFailure,
//    NullDisplayMode,
//};
//
//const ImGuiError = error{
//    FailedToCreateContext,
//};
//
//var renderer : ?*sdl.SDL_Renderer = null;
//var window : ?*sdl.SDL_Window = null;
//const clear_color = @Vector(4, f32){0.45, 0.55, 0.60, 1.00};
//var showDemo = true;
//
//var gpa : ?std.heap.GeneralPurposeAllocator(.{}) = null;
//
//fn Init() !void {
//
//    gpa = std.heap.GeneralPurposeAllocator(.{}){};
//    //try metr_imgui.Init();
//
//    var displayRect = sdl.SDL_Rect{};
//    _ = sdl.SDL_GetDisplayBounds(1, &displayRect);
//
//    var displayUsableRect = sdl.SDL_Rect{};
//    _ = sdl.SDL_GetDisplayUsableBounds(1, &displayUsableRect);
//
//    const window_flags = sdl.SDL_WINDOW_VULKAN | sdl.SDL_WINDOW_HIDDEN;
//    window = sdl.SDL_CreateWindow("RTTI Viewer", 1280, 720, window_flags);
//    if (window == null)
//    {
//        return SDLError.CreateWindowFail;
//    }
//
//    var borderSize = [4]c_int{ 0, 0, 0, 0 };
//    _ = sdl.SDL_GetWindowBordersSize(window, &borderSize[0], &borderSize[1], &borderSize[2], &borderSize[3]);
//    _ = sdl.SDL_SetWindowSize(window, displayUsableRect.w, displayUsableRect.h - borderSize[0]);
//    _ = sdl.SDL_SetWindowPosition(window, 0, borderSize[0]);
//    _ = sdl.SDL_ShowWindow(window);
//
//    renderer = sdl.SDL_CreateRenderer(window, null);
//    _ = sdl.SDL_SetRenderVSync(renderer, 1);
//    if (renderer == null)
//    {
//         return SDLError.CreateRendererFailure;
//    }
//
//    // Setup Dear ImGui context
//    //const version_string = imgui.igGetVersion();
//    //_ = imgui.igDebugCheckVersionAndDataLayout(version_string, @sizeOf(imgui.ImGuiIO), @sizeOf(imgui.ImGuiStyle), @sizeOf(imgui.ImVec2), @sizeOf(imgui.ImVec4), @sizeOf(imgui.ImDrawVert), @sizeOf(imgui.ImDrawIdx));
//    //const imgui_context = imgui.igCreateContext(null) orelse return ImGuiError.FailedToCreateContext;
//    //const io = imgui.igGetIO_ContextPtr(imgui_context);
//    //io.*.ConfigFlags |= imgui.ImGuiConfigFlags_NavEnableKeyboard;     // Enable Keyboard Controls
//    //io.*.ConfigFlags |= imgui.ImGuiConfigFlags_NavEnableGamepad;      // Enable Gamepad Controls
//
//    // Setup Dear ImGui style
//    //imgui.igStyleColorsDark(null);
//
//    // Setup Platform/Renderer backends
//    //_ = imgui.ImGui_ImplSDL3_InitForSDLRenderer(@constCast(@ptrCast(window)), @constCast(@ptrCast(renderer)));
//    //_ = imgui.ImGui_ImplSDLRenderer3_Init(@constCast(@ptrCast(renderer)));
//}
//
//fn DrawMenuBar() !void
//{
//    //if (imgui.igBeginMenuBar())
//    //{
//    //    if (imgui.igBeginMenu("Menu", true))
//    //    {
//    //        imgui.igEndMenu();
//    //    }
//    //
//    //    imgui.igEndMenuBar();
//    //}
//}
//
//fn Update() !void 
//{
////    imgui.ImGui_ImplSDLRenderer3_NewFrame();
////    imgui.ImGui_ImplSDL3_NewFrame();
////    imgui.igNewFrame();
////
////    const main_viewport = imgui.igGetMainViewport();
////    imgui.igSetNextWindowPos(imgui.ImVec2{.x = main_viewport.*.WorkPos.x, .y = main_viewport.*.WorkPos.y}, imgui.ImGuiCond_Always, imgui.ImVec2{.x = 0, .y = 0});
////    imgui.igSetNextWindowSize(imgui.ImVec2{.x = main_viewport.*.WorkSize.x, .y = main_viewport.*.WorkSize.y}, imgui.ImGuiCond_Always);
////
////    const imgui_window_flags = imgui.ImGuiWindowFlags_MenuBar
////        | imgui.ImGuiWindowFlags_NoMove
////        | imgui.ImGuiWindowFlags_NoResize
////        | imgui.ImGuiWindowFlags_NoCollapse;
////        
////    _ = imgui.igBegin("RTTI Viewer", null, imgui_window_flags);
////
////    //Menu Bar
////    try DrawMenuBar();
////
////    //try metr_imgui.Draw(gpa.?.allocator());
////    imgui.igEnd();
//}
//
//fn Draw() !void
//{
//    //imgui.igRender();
//    
//    _ = sdl.SDL_SetRenderDrawColorFloat(renderer, clear_color[0], clear_color[1], clear_color[2], clear_color[3]);
//    _ = sdl.SDL_RenderClear(renderer);
//    //imgui.ImGui_ImplSDLRenderer3_RenderDrawData(imgui.igGetDrawData(), @constCast(@ptrCast(renderer)));
//    _ = sdl.SDL_RenderPresent(renderer);
//}
//
//fn Quit() void {
//    //imgui.ImGui_ImplSDLRenderer3_Shutdown();
//    //imgui.ImGui_ImplSDL3_Shutdown();
//    //imgui.igDestroyContext(null);
//
//    sdl.SDL_DestroyRenderer(renderer);
//    sdl.SDL_DestroyWindow(window);
//
//    const deinit_status = gpa.?.deinit();
//    if (deinit_status == .leak) @panic("Memory Leak");
//}
//pub fn main() !void {
//   if (!sdl.SDL_Init(sdl.SDL_INIT_VIDEO | sdl.SDL_INIT_GAMEPAD)) {
//        std.log.err("Failed to initialize SDL: {s}", .{sdl.SDL_GetError()});
//        return SDLError.SDLInitFail;
//    }
//    std.log.info("SDL Initialized!", .{});
//    const basePath = sdl.SDL_GetBasePath();
//    std.log.info("SDL Base Path: {s}", .{basePath.?});
//
//    try Init();
//
//    var quit = false;
//    var canDraw = true;
//
//    _ = try gpa.?.allocator().alloc(u8, 2048);
//
//    _ = &canDraw;
//    while (!quit) {
//        var evt = sdl.SDL_Event{
//            .type = 0,
//        };
//        while (sdl.SDL_PollEvent(&evt)) {
//            //_ = imgui.ImGui_ImplSDL3_ProcessEvent(@constCast(@ptrCast(&evt)));
//            if (evt.type == sdl.SDL_EVENT_QUIT) {
//                quit = true;
//            }
//            if (evt.type == sdl.SDL_EVENT_WINDOW_CLOSE_REQUESTED and evt.window.windowID == sdl.SDL_GetWindowID(window)) {
//                quit = true;
//            }
//        }
//        if ((sdl.SDL_GetWindowFlags(window) & sdl.SDL_WINDOW_MINIMIZED) != 0)
//        {
//            sdl.SDL_Delay(10);
//            continue;
//        }
//
//        if (quit) {
//            break;
//        }
//
//        try Update();
//        if (canDraw) {
//            try Draw();
//        }
//    }
//
//    Quit();
//    sdl.SDL_Quit();
//}

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