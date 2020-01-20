-- Values used to work out positions
-- local sx = 0.02
-- local sy = 0.08
-- local p = Vector.Create(0.25,-0.1,0)
-- local pe = Vector.Create(-0.25,-0.1,0)

CombatState =
{
    Layout =
    {
        ["party"] =
        {
            {
                Vector.Create(0.25, -0.056, 0, 0),
            },
            {
                Vector.Create(0.23, 0.024, 0, 0),
                Vector.Create(0.27, -0.136, 0, 0),
            },
            {
                Vector.Create(0.23, 0.024, 0, 0),
                Vector.Create(0.25, -0.056, 0, 0),
                Vector.Create(0.27, -0.136, 0, 0),
            },
        },
        ["enemy"] =
        {
            {
                Vector.Create(-0.25, -0.056, 0, 0),
            },
            {
                Vector.Create(-0.23, 0.024, 0, 0),
                Vector.Create(-0.27, -0.136, 0, 0),
            },
            {
                Vector.Create(-0.21, -0.056, 0, 0),
                Vector.Create(-0.23, 0.024, 0, 0),
                Vector.Create(-0.27, -0.136, 0, 0),
            },
            {
                Vector.Create(-0.18, -0.056, 0, 0),
                Vector.Create(-0.23, 0.056, 0, 0),
                Vector.Create(-0.25, -0.056, 0, 0),
                Vector.Create(-0.27, -0.168, 0, 0),
            },
            {
                Vector.Create(-0.28, 0.032, 0, 0),
                Vector.Create(-0.3, -0.056, 0, 0),
                Vector.Create(-0.32, -0.144, 0, 0),
                Vector.Create(-0.2, 0.004, 0, 0),
                Vector.Create(-0.24, -0.116, 0, 0),
            },
            {
                Vector.Create(-0.28, 0.032, 0, 0),
                Vector.Create(-0.3, -0.056, 0, 0),
                Vector.Create(-0.32, -0.144, 0, 0),
                Vector.Create(-0.16, 0.032, 0, 0),
                Vector.Create(-0.205, -0.056, 0, 0),
                Vector.Create(-0.225, -0.144, 0, 0),
            },
        }
    }
}

CombatState.__index = CombatState
function CombatState:Create(stack, def)

    local this =
    {
        mGameStack = stack,
        mStack = StateStack:Create(),
        mDef = def,
        mBackground = Sprite.Create(),
        mActors =
        {
            party = def.actors.party,
            enemy = def.actors.enemy,
        },
        mCharacters =
        {
            party = {},
            enemy = {}
        },
        mSelectedActor = nil,
        mActorCharMap = {},
    }

    this.mBackground:SetTexture(Texture.Find(def.background))

    setmetatable(this, self)

    -- Need to change actors in to characters
    this:CreateCombatCharacters('party')
    this:CreateCombatCharacters('enemy')

    return this
end

function CombatState:CreateCombatCharacters(side)

    local actorList = self.mActors[side]
    local characterList = self.mCharacters[side]
    local layout = CombatState.Layout[side][#actorList]


    -- Create an character for each actor
    for k, v in ipairs(actorList) do
        local charDef = ShallowClone(gCharacters[v.mId])

        if charDef.combatEntity then
            charDef.entity = charDef.combatEntity
        end
        local char = Character:Create(charDef, self)
        table.insert(characterList, char)
        self.mActorCharMap[v] = char

        local pos = layout[k]

        -- Combat positions are 0 - 1
        -- Need scaling to the screen size.
        local x = pos:X() * System.ScreenWidth()
        local y = pos:Y() * System.ScreenHeight()
        char.mEntity.mSprite:SetPosition(x, y)
        char.mEntity.mX = x
        char.mEntity.mY = y

        -- Change to standby because it's combat time
        char.mController:Change(CSStandby.mName)

    end

end

function CombatState:Enter()
end

function CombatState:Exit()
end

function CombatState:Update(dt)
    for k, v in ipairs(self.mCharacters['party']) do
        v.mController:Update(dt)
    end

    for k, v in ipairs(self.mCharacters['enemy']) do
        v.mController:Update(dt)
    end
end

function CombatState:HandleInput()

end

function CombatState:Render(renderer)

    renderer:DrawSprite(self.mBackground)


    for k, v in ipairs(self.mCharacters['party']) do
        v.mEntity:Render(renderer)
    end

    for k, v in ipairs(self.mCharacters['enemy']) do
        v.mEntity:Render(renderer)
    end

end