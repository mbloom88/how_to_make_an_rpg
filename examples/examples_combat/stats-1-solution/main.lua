LoadLibrary("System")
LoadLibrary("Renderer")
LoadLibrary("Asset")

Asset.Run("stats.lua")

gRenderer = Renderer.Create()

local stats =
Stats:Create
{
    ["hp_now"] = 300,
    ["hp_max"] = 300,
    ["mp_now"] = 300,
    ["mp_max"] = 300,
    ["strength"] = 10,
    ["speed"] = 10,
    ["intelligence"] = 10,
}
print(stats:GetBase("intelligence"))     -- 10
print(stats:GetBase("hp_now"))  -- 300

function update()
    gRenderer:DrawText2d(0, 0, "Let's make a stat class!")
end