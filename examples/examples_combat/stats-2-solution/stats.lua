Stats = {}
Stats.__index = Stats
function Stats:Create(stats)
    local this =
    {
        mBase = {},
        mModifiers = {}
    }

    -- Shallow copy
    for k, v in pairs(stats) do
        this.mBase[k] = v
    end

    setmetatable(this, self)
    return this
end

function Stats:GetBase(id)
    return self.mBase[id]
end

--
--  id = used to uniquely identify the modifier
-- modifier =
-- {
--     add = { table of stat increments }
--     mult = { table of stat multipliers }
-- }
function Stats:AddModifier(id, modifier)
    self.mModifiers[id] =
    {
        add     = modifier.add or {},
        mult    = modifier.mult or {}
    }
end

function Stats:RemoveModifier(id)
    self.mModifiers[id] = nil
end

function Stats:Get(id)
    local total = self.mBase[id] or 0
    local multiplier = 0

    for k, v in pairs(self.mModifiers) do
        total = total + (v.add[id] or 0)
        multiplier = multiplier + (v.mult[id] or 0)
    end


    print(string.format("Multiplier: %f", multiplier))
    return total + (total * multiplier)
end

local stats =
Stats:Create
{
    ["hp_now"] = 300,
    ["hp_max"] = 300,
    ["mp_now"] = 300,
    ["mp_max"] = 300,
    ["str"] = 10,
    ["spd"] = 10,
    ["int"] = 10,
}

print(stats:GetBase("int"))     -- 10
print(stats:GetBase("hp_now"))  -- 300
print(stats:Get("int"))
print(stats:Get("hp_now"))

magic_hat =
{
    unique_id = 1,
    modifier =
    {
        id = 2,
        add =
        {
            ["str"] = 5
        },
    }
}

magic_sword =
{
    unique_id = 2,
    modifier =
    {
        add =
        {
            ["str"] = 5,
            ["spd"] = 5
        }
    }
}

stats:AddModifier(magic_sword.unique_id, magic_sword.modifier)

print(stats:GetBase("str"))
print(stats:Get("str"))

stats:AddModifier(magic_hat.unique_id, magic_hat.modifier)

print(stats:GetBase("str"))
print(stats:Get("str"))

spell_curse =
{
    unique_id = "curse",
    modifier =
    {
        mult =
        {
            ["str"] = -0.5,
            ["spd"] = -0.5,
            ["int"] = -0.5,
        }
    }
}

spell_bravery =
{
    unique_id = "bravery",
    modifier =
    {
        mult =
        {
            ["str"] = 0.1,
            ["spd"] = 0.1,
            ["int"] = 0.1
        }
    }
}

stats:AddModifier(spell_bravery.unique_id, spell_bravery.modifier)

print(">Bravery +10% to all stats")
print(string.format("str:%d:%d", stats:GetBase("str"), stats:Get("str")))

print(">Cursed! All stats halved.")
stats:AddModifier(spell_curse.unique_id, spell_curse.modifier)

print(string.format("str:%d:%d", stats:GetBase("str"), stats:Get("str")))
