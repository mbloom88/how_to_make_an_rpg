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
        OnSelection = this.OnSelect,
        RenderItem = this.RenderAction,
    }


    local x = -System.ScreenWidth()/2
    local y = -System.ScreenHeight()/2

    local height = this.mSelection:GetHeight() + 18
    local width = this.mSelection:GetWidth() + 16

    y = y + height + 16
    x = x + 100

    this.mTextbox = Textbox:Create
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
        selectionMenu = this.mSelection,
        stack = this.mStack,
    }

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

function CombatChoiceState:RenderAction(renderer, x, y, item)

    local text = Actor.ActionLabels[item] or ""
    renderer:DrawText2d(x, y, text)
end

function CombatChoiceState:OnSelect(index, data)

end

function CombatChoiceState:Enter()
    self.mCombatState.mSelectedActor = self.mActor
end

function CombatChoiceState:Exit()
    self.mCombatState.mSelectedActor = nil
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

