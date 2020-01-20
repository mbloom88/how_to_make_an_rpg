CEAttack = {}
CEAttack.__index = CEAttack
function CEAttack:Create(state, owner, def, targets)

    print("Target", target)

    local this =
    {
        mState = state,
        mOwner = owner,
        mDef = def,
        mIsFinished = false,
        mCharacter = state.mActorCharMap[owner],
        mTargets = targets,
    }

    this.mController = this.mCharacter.mController
    this.mController:Change(CSRunAnim.mName, {'prone'})
    this.mName = string.format("Attack for %s", this.mOwner.mName)

    setmetatable(this, self)

    local storyboard =
    {
        SOP.RunState(this.mController, CSMove.mName, {dir = 1}),
        SOP.RunState(this.mController, CSRunAnim.mName, {'attack', false}),
        SOP.Function(function() this:DoAttack() end),
        SOP.RunState(this.mController, CSMove.mName, {dir = -1}),
        SOP.Function(function() this:OnFinish() end)
    }

    this.mStoryboard = Storyboard:Create(this.mState.mStack,
                                         storyboard)

    return this
end

function CEAttack:TimePoints(queue)
    local speed = self.mOwner.mStats:Get("speed")
    return queue:SpeedToTimePoints(speed)
end

function CEAttack:OnFinish()
    self.mIsFinished = true
end

function CEAttack:Execute(queue)
    self.mState.mStack:Push(self.mStoryboard)
end

function CEAttack:IsFinished()
    return self.mIsFinished
end

function CEAttack:Update()
end

function CEAttack:DoAttack()
    for _, target in ipairs(self.mTargets) do
        self:AttackTarget(target)
    end
end

function CEAttack:AttackTarget(target)

    local stats = self.mOwner.mStats
    local enemyStats = target.mStats

    -- Simple attack get
    local attack = stats:Get("attack")
    attack = attack + stats:Get("strength")
    local defense = enemyStats:Get("defense")

    local damage = math.max(0, attack - defense)
    print("Attacked for ", damage, attack, defense)

    local hp = enemyStats:Get("hp_now")
    local hp =  hp - damage

    enemyStats:Set("hp_now", math.max(0, hp))
    print("hp is", enemyStats:Get("hp_now"))

    -- the enemy needs stats
    -- the player needs a weapon

end

