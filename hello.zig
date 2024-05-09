const ray = @cImport(
{
    @cInclude("raylib.h");
});

pub fn main() void
{
    ray.InitWindow(800, 450, "hello-zig");
    defer ray.CloseWindow();

    ray.SetTargetFPS(60);

    while (!ray.WindowShouldClose())
    {
        ray.BeginDrawing();
        defer ray.EndDrawing();

        ray.ClearBackground(ray.ORANGE);
        ray.DrawText("Hello, Zig!", 190, 200, 20, ray.MAROON);
    }
}
