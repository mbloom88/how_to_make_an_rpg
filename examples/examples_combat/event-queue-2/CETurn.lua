
CETurn = {}
CETurn.__index = CETurn
function CETurn:Create(scene, owner, speed)
    local this =
    {
        mScene = scene,
        mOwner = owner,
        mSpeed = speed,
    }

    setmetatable(this, self)
    return this
end

function CETurn:Execute(queue)

    -- Choose a random enemy target.
    local target = nil
    local targetList = self.mScene.mPartyActors
    if(self.mOwner.player) then
        targetList = self.mScene.mEnemyActors
    end
    local index = math.random(#targetList)
    target = targetList[index]

    queue:Add(CEAttack:Create(self.mScene,
                 self.mOwner,
                 target))
end

function CETurn:Update()
    -- Nothing
end

function CETurn:IsFinished()
    return true
end

-- What we need to actually fire this
-- scene with
--      mPlayerActors
--      mGameActors
--  CEAttack with
--      Create
-- EventQueue with
--      Insert
--      Basic runner update / isfinished / execute