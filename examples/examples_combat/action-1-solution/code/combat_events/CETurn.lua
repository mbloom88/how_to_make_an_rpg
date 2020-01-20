CETurn = {}
CETurn.__index = CETurn
function CETurn:Create(state, owner)
    local this =
    {
        mState = state,
        mOwner = owner,
        mFinished = false,
        mName = nil,
    }

    this.mName = string.format("Turn for %s", this.mOwner.mName)

    setmetatable(this, self)
    return this
end


function CETurn:TimePoints(queue)
    local speed = self.mOwner.mStats:Get("speed")
    return queue:SpeedToTimePoints(speed)
end

function CETurn:Execute(queue)

    if self.mState:IsPartyMember(self.mOwner) then
        local state = CombatChoiceState:Create(self.mState, self.mOwner)
        self.mState.mStack:Push(state)
        self.mFinished = true
        return
    else
    -- 2. Am I an enemy
    --  - Query my AI for a task
    end

    -- Both:
    -- Get the task, push it on the stack, set finished to true

end

function CETurn:Update()
end

function CETurn:IsFinished()
    return self.mFinished
end