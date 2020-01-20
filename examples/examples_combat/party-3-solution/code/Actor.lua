Actor =
{
    EquipSlotLabels =
    {
        "Weapon:",
        "Armor:",
        "Accessory:",
        "Accessory:"
    },
    EquipSlotId =
    {
        "weapon",
        "armor",
        "acces1",
        "acces2"
    },
    ActorStats =
    {
        "strength",
        "speed",
        "intelligence"
    },
    ItemStats =
    {
        "attack",
        "defense",
        "magic",
        "resist"
    },
    ActorStatLabels =
    {
        "Strength",
        "Speed",
        "Intelligence"
    },
    ItemStatLabels =
    {
        "Attack",
        "Defense",
        "Magic",
        "Resist"
    },
    ActionLabels =
    {
        ["attack"] = "Attack",
        ["item"] = "Item",
    },
}
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
        },
        mActiveEquipSlots = def.equipslots or { 1, 2, 3 },
    }

    if def.portrait then
        this.mPortraitTexture = Texture.Find(def.portrait)
        this.mPortrait:SetTexture(this.mPortraitTexture)
    end

    this.mNextLevelXP = NextLevel(this.mLevel)

    setmetatable(this, self)
    return this
end

function Actor:Equip(slot, item)

    -- 1. Remove any item current in the slot
    --    Put that item back in the inventory
    local prevItem = self.mEquipment[slot]
    self.mEquipment[slot] = nil
    if prevItem then
        gWorld:AddToInventory(prevItem)
    end

    -- 2. If there's a replacement item move it to the slot
    if not item then
        return
    end
    assert(item.count > 0) -- This should never be allowed to happen!
    gWorld:RemoveFromInventory(item.id)
    self.mEquipment[slot] = item.id
end

function Actor:RenderEquipment(menu, renderer, x, y, index)

    x = x + 100
    local label = self.EquipSlotLabels[index]
    renderer:AlignText("right", "center")
    renderer:DrawText2d(x, y, label)

    local slotId = self.EquipSlotId[index]
    local text = "none"
    if self.mEquipment[slotId] then
        local itemId = self.mEquipment[slotId]
        local item = ItemDB[itemId]
        text = item.name
    end

    renderer:AlignText("left", "center")
    renderer:DrawText2d(x + 10, y, text)
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