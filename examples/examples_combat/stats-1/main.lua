LoadLibrary("System")
LoadLibrary("Renderer")
LoadLibrary("Asset")

Asset.Run("stats.lua")

gRenderer = Renderer.Create()

-- Stat: [id:string] -> [value:int]
base_stats =
{
    ["hp_now"] = 300,
    ["hp_max"] = 300,
    ["mp_now"] = 300,
    ["mp_max"] = 300,
    ["str"] = 10,
    ["spd"] = 10,
    ["int"] = 10,
}

function update()
    gRenderer:DrawText2d(0, 0, "Let's make a stat class!")
end