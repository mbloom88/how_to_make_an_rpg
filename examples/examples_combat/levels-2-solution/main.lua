LoadLibrary("System")
LoadLibrary("Renderer")
LoadLibrary("Asset")

function NextLevel(level)
    local exponent = 1.5
    local baseXP = 1000
    return math.floor(baseXP * (level ^ exponent))
end

Asset.Run("Dice.lua")
Asset.Run("Stats.lua")
Asset.Run("Actor.lua")

gRenderer = Renderer.Create()


-- Let's design some growth strategies
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

local Growth =
{
    fast = Dice:Create("3d2"),
    med = Dice:Create("1d3"),
    slow = Dice:Create("1d2")
}

heroDef =
{
    stats = stats, -- starting stats
    statGrowth =
    {
        ["hp_max"] = Dice:Create("4d50+100"),
        ["mp_max"] = Dice:Create("2d50+100"),
        ["strength"] = Growth.fast,
        ["speed"] = Growth.fast,
        ["intelligence"] = Growth.med,
    },
    -- additional actor definition info
}

thiefDef =
{
    stats = stats, -- starting stats
    statGrowth =
    {
        ["hp_max"] = Dice:Create("4d40+100"),
        ["mp_max"] = Dice:Create("2d25+100"),
        ["strength"] = Growth.fast,
        ["speed"] = Growth.fast,
        ["intelligence"] = Growth.slow,
    },
    -- additional actor definition info
}

mageDef =
{
    stats = stats, -- starting stats
    statGrowth =
    {
        ["hp_max"] = Dice:Create("3d40+100"),
        ["mp_max"] = Dice:Create("4d50+100"),
        ["strength"] = Growth.med,
        ["speed"] = Growth.med,
        ["intelligence"] = Growth.fast,
    },
    -- additional character definition info
}

mage = Actor:Create(mageDef)
thief = Actor:Create(thiefDef)
hero = Actor:Create(heroDef)

function update()
    gRenderer:DrawText2d(0, 0, "Let's make a level class!")
end