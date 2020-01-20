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

    local storyboard = nil

    if this.mDef.player then
        this.mAttackAnim = gEntities.slash
        this.mDefaultTargeter = CombatSelector.WeakestEnemy

        storyboard =
        {
            SOP.RunState(this.mController, CSMove.mName, {dir = 1}),
            SOP.RunState(this.mController, CSRunAnim.mName, {'attack', false}),
            SOP.Function(function() this:DoAttack() end),
            SOP.RunState(this.mController, CSMove.mName, {dir = -1}),
            SOP.Function(function() this:OnFinish() end)
        }

    else
        this.mAttackAnim = gEntities.claw
        this.mDefaultTargeter = CombatSelector.RandomAlivePlayer

        storyboard =
        {
            SOP.RunState(this.mController,
                        CSMove.mName,
                        {dir = 1, distance = 8, time = 0.1}),
            SOP.Function(function() this:DoAttack() end),
            SOP.RunState(this.mController,
                        CSMove.mName,
                        {dir = -1, distance = 8, time = 0.4}),
            SOP.Function(function() this:OnFinish() end)
        }


    end

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

    for i = #self.mTargets, 1, -1 do
        local v = self.mTargets[i]
        local hp = v.mStats:Get("hp_now")
        if hp <= 0 then
            table.remove(self.mTargets, i)
        end
    end

    if not next(self.mTargets) then
        -- Find another enemy
        self.mTargets = self.mDefaultTargeter(self.mState)
    end
end

function CEAttack:IsFinished()
    return self.mIsFinished
end

function CEAttack:Update()
   -- self.mState:Update()
end

function CEAttack:DoAttack()
    for _, target in ipairs(self.mTargets) do
        self:AttackTarget(target)
    end
end

function CEAttack:AttackTarget(target)

    local damage = Formula.MeleeAttack(self.mState, self.mOwner, target)
    local entity = self.mState.mActorCharMap[target].mEntity

    self.mState:ApplyDamage(target, damage)

    local x = entity.mX
    local y = entity.mY
    local effect = AnimEntityFx:Create(x, y,
                            self.mAttackAnim,
                            self.mAttackAnim.frames)

    self.mState:AddEffect(effect)

end

