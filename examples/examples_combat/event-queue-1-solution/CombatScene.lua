
CombatScene = {}
CombatScene.__index = CombatScene
function CombatScene:Create(party, enemies)
    local this =
    {
        mPartyActors = party or {},
        mEnemyActors = enemies or {},
        mEventQueue = EventQueue:Create()
    }

    setmetatable(this, self)
    return this
end

function CombatScene:Update()

end