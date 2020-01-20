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
        mPanels = {},
        mTipPanel = nil,
        mNoticePanel = nil,
        mPanelTitles = {},
        mPartyList = nil,
        mStatsYCol = 208,
        mBars = {},
        mStatList = nil,

        mEventQueue = EventQueue:Create(),
        mDeathList = {},
        mEffectList = {},
        mIsFinishing = false,
    }

    -- Setup layout panel
    local layout = Layout:Create()
    layout:SplitHorz('screen', 'top', 'bottom', 0.72, 0)
    layout:SplitHorz('top', 'notice', 'top', 0.25, 0)
    layout:Contract('notice', 75, 25)
    layout:SplitHorz('bottom', 'tip', 'bottom', 0.24, 0)
    layout:SplitVert('bottom', 'left', 'right', 0.67, 0)
    this.mPanels =
    {
        layout:CreatePanel('left'),
        layout:CreatePanel('right'),
    }
    this.mTipPanel = layout:CreatePanel('tip')
    this.mNoticePanel = layout:CreatePanel('notice')

    this.mBackground:SetTexture(Texture.Find(def.background))

    setmetatable(this, self)

    -- Need to change actors in to characters
    this:CreateCombatCharacters('party')
    this:CreateCombatCharacters('enemy')


    -- Set up player list
    this.mPartyList = Selection:Create
    {
        data = this.mActors.party,
        columns = 1,
        spacingX = 0,
        spacingY = 19,
        rows = #this.mActors.party,
        RenderItem =
        function(self, renderer, x, y, item)
            this:RenderPartyNames(renderer, x, y, item)
        end,
        OnSelection = this.OnPartyMemberSelect,
    }

    local x = -System.ScreenWidth() / 2
    local y = layout:Top('left')

    this.mPanelTitles =
    {
        {
            text = 'NAME',
            x = x + 32,
            y = y - 9
        },
        {
            text = 'HP',
            x = layout:Left('right') + 24,
            y = y - 9
        },
        {
            text = 'MP',
            x = layout:Left('right') + 24 + this.mStatsYCol,
            y = y - 9
        }
    }

    y = y - 25 -- padding
    this.mPartyList:SetPosition(x, y)
    this.mPartyList:HideCursor()

    for k, v in ipairs(this.mActors.party) do

        local stats = v.mStats

        local hpBar = ProgressBar:Create
        {
            background = Texture.Find('hpbackground.png'),
            foreground = Texture.Find('hpforeground.png'),
            value = stats:Get('hp_now'),
            maximum = stats:Get('hp_max')
        }

        local mpBar = ProgressBar:Create
        {
            background = Texture.Find('mpbackground.png'),
            foreground = Texture.Find('mpforeground.png'),
            value = stats:Get('mp_now'),
            maximum = stats:Get('mp_max')
        }

        this.mBars[v] =
        {
            mHP = hpBar,
            mMP = mpBar
        }

    end

    this.mStatList = Selection:Create
    {
        data = this.mActors.party,
        columns = 1,
        spacingX = 0,
        spacingY = 19,
        rows = #this.mActors.party,
        RenderItem =
            function(self, renderer, x, y, item)
                this:RenderPartyStats(renderer, x, y, item)
            end,
        OnSelection = this.OnPartyMemberSelect,
    }
    x = layout:Left('right') - 8
    this.mStatList:SetPosition(x, y)
    this.mStatList:HideCursor()


    return this
end

function CombatState:RenderPartyNames(renderer, x, y, item)

    local nameColor = Vector.Create(1,1,1,1)

    if self.mSelectedActor == item then
        nameColor = Vector.Create(1,1,0,1)
    end

    renderer:DrawText2d(x, y, item.mName, nameColor)
end

function CombatState:DrawHP(renderer, x, y, hp, max)

    local hpColor = Vector.Create(1,1,1,1)

    local percent = hp / max

    if percent < 0.2 then
        hpColor = Vector.Create(1,0,0,1)
    elseif percent < 0.45 then
        hpColor = Vector.Create(1,1,0,1)
    end

    local xPos = x
    local hp = string.format('%d', hp)
    renderer:DrawText2d(xPos, y, hp, hpColor)
    local size = renderer:MeasureText(hp)
    xPos = xPos + size:X() + 3
    renderer:DrawText2d(xPos, y, '/')
    size = renderer:MeasureText('/')
    xPos = xPos + size:X() - 1
    renderer:DrawText2d(xPos, y, max)

end

function CombatState:RenderPartyStats(renderer, x, y, item)
    local stats = item.mStats
    local barOffset = 130

    local bars = self.mBars[item]

    self:DrawHP(renderer, x, y,
                stats:Get('hp_now'),
                stats:Get('hp_max'))

    bars.mHP:SetPosition(x + barOffset, y)
    bars.mHP:SetValue(stats:Get('hp_now'))
    bars.mHP:Render(renderer)

    x = x + self.mStatsYCol

    local mpStr = string.format("%d", stats:Get('mp_now'))
    renderer:DrawText2d(x, y, mpStr)
    bars.mMP:SetPosition(x + barOffset * 0.7, y)
    bars.mMP:SetValue(stats:Get('mp_now'))
    bars.mMP:Render(renderer)
end

function CombatState:OnPartyMemberSelect(index, data)

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
        char:SetFacingForCombat()

        -- Change to standby because it's combat time
        char.mController:Change(CSStandby.mName)

    end

end

function CombatState:Enter()

end

function CombatState:Exit()
end

function CombatState:AddTurns(actorList)
    for _, v in ipairs(actorList) do

        local alive = v.mStats:Get("hp_now") > 0

        if alive and not self.mEventQueue:ActorHasEvent(v) then
            local event = CETurn:Create(self, v)
            local tp = event:TimePoints(self.mEventQueue)
            self.mEventQueue:Add(event, tp)
        end

    end
end


function CombatState:HasLiveActors(actorList)

    for _, actor in ipairs(actorList) do
        local stats = actor.mStats
        if stats:Get("hp_now") > 0 then
            return true
        end
    end

    return false
end

function CombatState:EnemyWins()

    return not self:HasLiveActors(self.mActors.party)

end

function CombatState:PartyWins()

    return not self:HasLiveActors(self.mActors.enemy)

end


function CombatState:Update(dt)

    for k, v in ipairs(self.mCharacters['party']) do
        v.mController:Update(dt)
    end

    for k, v in ipairs(self.mCharacters['enemy']) do
        v.mController:Update(dt)
    end

    for i = #self.mDeathList, 1, -1 do
        local character = self.mDeathList[i]
        character.mController:Update(dt)
        local state = character.mController.mCurrent

        if state:IsFinished() then
            table.remove(self.mDeathList, i)
        end

    end

    for i = #self.mEffectList, 1, -1 do
        local v = self.mEffectList[i]
        if v:IsFinished() then
            table.remove(self.mEffectList, i)
        end
        v:Update(dt)
    end



    if self.mStack:Top() ~= nil then

        self.mStack:Update(dt)

    elseif not self.mIsFinishing then
        self.mEventQueue:Update()

        self:AddTurns(self.mActors.enemy)
        self:AddTurns(self.mActors.party)

        if self:PartyWins() then
            self.mEventQueue:Clear()
            self:OnWin()
        elseif self:EnemyWins() then
            self.mEventQueue:Clear()
            self:OnLose()
        end
    end

end

function CombatState:OnWin()
    self.mIsFinishing = true
end

function CombatState:OnLose()
    if self.mGameStack:Top() ~= self then
        return
    end

    local storyboard =
    {
        SOP.UpdateState(self, 1.5),
        SOP.BlackScreen("black", 0),
        SOP.FadeInScreen("black"),
        SOP.ReplaceState(self, GameOverState:Create(self.mGameStack, gWorld)),
        SOP.Wait(2),
        SOP.FadeOutScreen("black"),
    }
    local storyboard = Storyboard:Create(self.mGameStack, storyboard)
    self.mGameStack:Push(storyboard)
    self.mIsFinishing = true
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

    for k, v in ipairs(self.mDeathList) do
        v.mEntity:Render(renderer)
    end

    for k, v in ipairs(self.mEffectList) do
        v:Render(renderer)
    end

    for k, v in ipairs(self.mPanels) do
        v:Render(renderer)
    end


    --self.mTipPanel:Render(renderer)
    --self.mNoticePanel:Render(renderer)


    renderer:ScaleText(0.88, 0.88)
    renderer:AlignText("left", "center")
    for k, v in ipairs(self.mPanelTitles) do
        renderer:DrawText2d(v.x, v.y, v.text)
    end

    renderer:ScaleText(1.25, 1.25)
    renderer:AlignText("left", "center")
    self.mPartyList:Render(renderer)
    self.mStatList:Render(renderer)


    self.mStack:Render(renderer)

    self.mEventQueue:Render(-System.ScreenWidth()/2,
                            System.ScreenHeight()/2,
                            renderer)
end

function CombatState:IsPartyMember(actor)
    for _, v in ipairs(self.mActors.party) do
        if actor == v then
            return true
        end
    end
    return false
end

function CombatState:HandlePartyDeath()
    -- Deal with the actors
    for _, actor in ipairs(self.mActors['party']) do
        local character = self.mActorCharMap[actor]
        local controller = character.mController
        local state = controller.mCurrent
        local stats = actor.mStats

        -- is the character already dead?
        if state.mAnimId ~= 'death' then
            -- Alive

            -- Is the HP above 0?
            local hp = stats:Get("hp_now")
            if hp <= 0 then
                -- Dead party actor we need to deal with
                controller:Change(CSRunAnim.mName, {'death', false})
                self.mEventQueue:RemoveEventsOwnedBy(actor)
            end

        end

    end
end

function CombatState:HandleEnemyDeath()

    -- Reverse through list as we're going to remove
    -- them
    local enemyList = self.mActors['enemy']
    for i = #enemyList, 1, -1 do
        local actor = enemyList[i]
        local character = self.mActorCharMap[actor]
        local controller = character.mController
        local stats = actor.mStats

        local hp = stats:Get("hp_now")
        if hp <= 0 then
            -- Remove from both lists
            table.remove(enemyList, i)
            table.remove(self.mCharacters['enemy'], i)
            self.mActorCharMap[actor] = nil

            controller:Change("cs_die")
            self.mEventQueue:RemoveEventsOwnedBy(actor)

            -- Add to effects
            table.insert(self.mDeathList, character)
        end
    end
end

function CombatState:ApplyDamage(target, damage)
    local stats = target.mStats
    local hp = stats:Get("hp_now") - damage
    stats:Set("hp_now", math.max(0, hp))
    print("hp is", stats:Get("hp_now"))

    -- Change actor's character to hurt state
    local character = self.mActorCharMap[target]
    local controller = character.mController

    if damage > 0 then
        local state = controller.mCurrent
        if state.mName ~= "cs_hurt" then
            controller:Change("cs_hurt", state)
        end
    end

    local entity = character.mEntity
    local x = entity.mX
    local y = entity.mY
    local dmgEffect = JumpingNumbers:Create(x, y, damage)
    self:AddEffect(dmgEffect)
    self:HandleDeath()
end

function CombatState:HandleDeath()

    self:HandlePartyDeath()

    self:HandleEnemyDeath()

end

function CombatState:AddEffect(effect)

    for i = 1, #self.mEffectList do

        local priority = self.mEffectList[i].mPriority

        if effect.mPriority > priority then
            table.insert(self.mEffectList, i, effect)
            return
        end
    end

    table.insert(self.mEffectList, effect)
end