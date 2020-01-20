Actor = {}
Actor.__index = Actor

-- In this case we're only interested in the Actor def but
-- in the final game, the Actor will take more parameters.
function Actor:Create(def, ...)

    local this =
    {
        mDef = def,
        mStats = Stats:Create(def.stats),
        mStatGrowth = def.statGrowth,
        mXP = 0,
        mLevel = 1,
    }

    this.mNextLevelXP = nextLevel(this.mLevel)

    setmetatable(this, self)
    return this
end

function Actor:ReadyToLevelUp()
    return self.mXP >= self.mNextLevelXP
end

function Actor:AddXP(xp)
    self.mXP = self.mXP + xp
    return self:ReadyToLevelUp()
end

function Actor:CreateLevelUp()

    local levelup =
    {
        xp = - self.mNextLevelXP,
        level = 1,
        stats = {},
    }


    for id, dice in pairs(self.mStatGrowth) do
        levelup.stats[id] = dice:Roll()
    end

    -- Additional level up code
    -- e.g. if you want to apply
    -- a bonus every 4 levels
    -- or heal the players MP/HP

    return levelup
end

function Actor:ApplyLevel(levelup)
    self.mXP = self.mXP + levelup.xp
    self.mLevel = self.mLevel + levelup.level
    self.mNextLevelXP = nextLevel(self.mLevel)

    assert(self.mXP >= 0)

    for k, v in pairs(levelup.stats) do
        self.mStats.mBase[k] = self.mStats.mBase[k] + v
    end

    -- Unlock any special abilities etc.
end

