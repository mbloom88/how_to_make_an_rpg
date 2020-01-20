CSMove = { mName = "cs_move" }
CSMove.__index = CSMove
function CSMove:Create(character, context)
    local this =
    {
        mCharacter = character,
        mCombatScene = context,
        mEntity = character.mEntity,
    }

    setmetatable(this, self)
    return this
end

function CSMove:Enter()
end

function CSMove:Exit()
end

function CSMove:Update(dt)
    self.mAnim:Update(dt)
    self.mEntity:SetFrame(self.mAnim:Frame())
end

function CSMove:Render(renderer)
end