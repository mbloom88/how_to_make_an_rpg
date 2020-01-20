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
local statsDef =
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
    stats = statsDef, -- starting stats
    statGrowth =
    {
        ["hp_max"] = Dice:Create("4d50+100"),
        ["mp_max"] = Dice:Create("2d50+100"),
        ["strength"] = Growth.fast,
        ["speed"] = Growth.fast,
        ["intelligence"] = Growth.med,
    },
    -- additional Actor definition info
}

thiefDef =
{
    stats = statsDef, -- starting stats
    statGrowth =
    {
        ["hp_max"] = Dice:Create("4d40+100"),
        ["mp_max"] = Dice:Create("2d25+100"),
        ["strength"] = Growth.fast,
        ["speed"] = Growth.fast,
        ["intelligence"] = Growth.slow,
    },
    -- additional Actor definition info
}

mageDef =
{
    stats = statsDef, -- starting stats
    statGrowth =
    {
        ["hp_max"] = Dice:Create("3d40+100"),
        ["mp_max"] = Dice:Create("4d50+100"),
        ["strength"] = Growth.med,
        ["speed"] = Growth.med,
        ["intelligence"] = Growth.fast,
    },
    -- additional Actor definition info
}

mage = Actor:Create(mageDef)
thief = Actor:Create(thiefDef)
hero = Actor:Create(heroDef)

function PrintLevelUp(levelup)

    local stats = levelup.stats

    print(string.format("HP:+%d MP:+%d",
          stats["hp_max"],
          stats["mp_max"]))

    print(string.format("str:+%d spd:+%d int:+%d",
          stats["strength"],
          stats["speed"],
          stats["intelligence"]))
    print("")
end

function ApplyXP(char, xp)
    char:AddXP(xp)

    while(char:ReadyToLevelUp()) do

        local levelup = char:CreateLevelUp()
        local levelNumber = char.mLevel + levelup.level
        print(string.format("Level Up! (Level %d)", levelNumber))
        PrintLevelUp(levelup)
        char:ApplyLevel(levelup)

    end
end

hero = Actor:Create(heroDef)
ApplyXP(hero, 10001)

-- Print out the final stats
print("==XP applied==")
print("Level:", hero.mlevel)
print("XP:", hero.mXP)
print("Next Level XP:", hero.mNextLevelXP)

local stats = hero.mStats

print(string.format("HP:%d MP:%d",
      stats:Get("hp_max"),
      stats:Get("mp_max")))

print(string.format("str:%d spd:%d int:%d",
      stats:Get("strength"),
      stats:Get("speed"),
      stats:Get("intelligence")))

function update()
    gRenderer:DrawText2d(0, 0, "Let's make a level class!")
end