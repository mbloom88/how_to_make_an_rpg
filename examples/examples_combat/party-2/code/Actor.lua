
Actor = {}
Actor.__index = Actor
function Actor:Create(def)

    local growth = ShallowClone(def.statGrowth or {})

    local this =
    {
        mName = def.name,
        mId = def.id,

        mActions = def.actions,
        mPortrait = Sprite.Create(),
        mStats = Stats:Create(def.stats),
        mStatGrowth = growth,
        mXP = def.xp or 0,
        mLevel = def.level or 1,
        mEquipment =
        {
            weapon = def.weapon,
            armor = def.armor,
            acces1 = def.acces1,
            acces2 = def.acces2,
        }
    }

    if def.portrait then
        this.mPortraitTexture = Texture.Find(def.portrait)
        this.mPortrait:SetTexture(this.mPortraitTexture)
    end

    this.mNextLevelXP = NextLevel(this.mLevel)

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
    self.mNextLevelXP = NextLevel(self.mLevel)

    assert(self.mXP >= 0)

    for k, v in pairs(levelup.stats) do
        self.mStats.mBase[k] = self.mStats.mBase[k] + v
    end

    -- Unlock any special abilities etc.
end