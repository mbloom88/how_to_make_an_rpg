
CSHurt = { mName = "cs_hurt" }
CSHurt.__index = CSHurt
function CSHurt:Create(character, context)
    local this =
    {
        mCharacter = character,
        mCombatScene = context,
    }

    setmetatable(this, self)
    return this
end

function CSHurt:Enter()
end

function CSHurt:Exit()
end

function CSHurt:Update(dt)
end

function CSHurt:Render(renderer)
end