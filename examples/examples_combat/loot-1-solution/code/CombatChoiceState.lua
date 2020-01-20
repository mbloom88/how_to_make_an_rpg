CombatChoiceState = {}
CombatChoiceState.__index = CombatChoiceState
function CombatChoiceState:Create(context, actor)
    local this =
    {
        mStack = context.mStack,
        mCombatState = context,
        mActor = actor,
        mCharacter = context.mActorCharMap[actor],
        mUpArrow = gWorld.mIcons:Get('uparrow'),
        mDownArrow = gWorld.mIcons:Get('downarrow'),
        mMarker = Sprite.Create(),
    }

    this.mMarker:SetTexture(Texture.Find('continue_caret.png'))
    this.mMarkPos = this.mCharacter.mEntity:GetSelectPosition()
    this.mTime = 0


    setmetatable(this, self)

    this.mSelection = Selection:Create
    {
        data = this.mActor.mActions,
        columns = 1,
        displayRows = 3,
        spacingX = 0,
        spacingY = 19,
        OnSelection = function(...) this:OnSelect(...) end,
        RenderItem = this.RenderAction,
    }

    this:CreateChoiceDialog()

    return this
end

function CombatChoiceState:SetArrowPosition()
    local x = self.mTextbox.mSize.left
    local y = self.mTextbox.mSize.top
    local width = self.mTextbox.mWidth
    local height = self.mTextbox.mHeight

    local arrowPad = 9
    local arrowX = x + width - arrowPad
    self.mUpArrow:SetPosition(arrowX, y - arrowPad)
    self.mDownArrow:SetPosition(arrowX, y - height + arrowPad)
end

function CombatChoiceState:CreateChoiceDialog()
    local x = -System.ScreenWidth()/2
    local y = -System.ScreenHeight()/2

    local height = self.mSelection:GetHeight() + 18
    local width = self.mSelection:GetWidth() + 16

    y = y + height + 16
    x = x + 100

    self.mTextbox = Textbox:Create
    {
        textScale = 1.2,
        text = "",
        size =
        {
            left = x,
            right = x + width,
            top = y,
            bottom = y - height
        },
        textbounds =
        {
            left = -20,
            right = 0,
            top = 0,
            bottom = 2
        },
        panelArgs =
        {
            texture = Texture.Find("gradient_panel.png"),
            size = 3,
        },
        selectionMenu = self.mSelection,
        stack = self.mStack,
    }
end

function CombatChoiceState:RenderAction(renderer, x, y, item)

    local text = Actor.ActionLabels[item] or ""
    renderer:DrawText2d(x, y, text)
end

function CombatChoiceState:OnSelect(index, data)

    print("on select", index, data)

    if data == "attack" then
        self.mSelection:HideCursor()
        local state = CombatTargetState:Create(
            self.mCombatState,
            {
                targetType = CombatTargetType.One,
                --switchSides = false,
                OnSelect = function(targets)
                   self:TakeAction(data, targets)
                end,
                OnExit = function()
                    self.mSelection:ShowCursor()
                end
            })
        self.mStack:Push(state)
    end
end

function CombatChoiceState:TakeAction(id, targets)
    self.mStack:Pop() -- select state
    self.mStack:Pop() -- action state

    local queue = self.mCombatState.mEventQueue

    if id == "attack" then
        print("Entered attack state")
        local attack = CEAttack:Create(self.mCombatState,
                                       self.mActor,
                                       {player = true},
                                       targets)
        local speed = self.mActor.mStats:Get("speed")
        local tp = queue:SpeedToTimePoints(speed)
        queue:Add(attack, tp)



    end

end

function CombatChoiceState:Enter()
    self.mCombatState.mSelectedActor = self.mActor
end

function CombatChoiceState:Exit()
    self.mCombatState.mSelectedActor = nil
    self.mTextbox:Exit()
end


function CombatChoiceState:Update(dt)

    self.mTextbox:Update(dt)

    -- Make the selection cursor bounce
    self.mTime = self.mTime + dt
    local bounce = self.mMarkPos + Vector.Create(0, math.sin(self.mTime * 5))
    self.mMarker:SetPosition(bounce)

end

function CombatChoiceState:Render(renderer)
    self.mTextbox:Render(renderer)

    self:SetArrowPosition()
    if self.mSelection:CanScrollUp() then
        renderer:DrawSprite(self.mUpArrow)
    end
    if self.mSelection:CanScrollDown() then
        renderer:DrawSprite(self.mDownArrow)
    end

    renderer:DrawSprite(self.mMarker)
end

function CombatChoiceState:HandleInput()
    self.mSelection:HandleInput()
end

