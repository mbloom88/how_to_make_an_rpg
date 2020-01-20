
ArenaState = {}
ArenaState.__index = ArenaState
function ArenaState:Create(world, stack)
    local this =
    {
        mWorld = world,
        mStack = stack,
        mRounds =
        {
            {
                mName = "Round 1",
                mLocked = false,
            },
            {
                mName = "Round 2",
                mLocked = true,
            },
            {
                mName = "Round 3",
                mLocked = true,
            },
            {
                mName = "Round 4",
                mLocked = true
            },
            {
                mName = "Round 5",
                mLocked = true
            },
        },
    }


    local layout = Layout:Create()
    layout:Contract('screen', 118, 40)
    layout:SplitHorz('screen', 'top', 'bottom', 0.15, 0)
    layout:SplitVert('bottom', '', 'bottom', 2/3, 0)
    layout:SplitVert('bottom', 'bottom', '', 0.5, 0)
    layout:Contract('bottom', -20, 40)
    layout:SplitHorz('bottom', 'header', 'bottom', 0.18, 2)
    this.mPanels =
    {
        layout:CreatePanel('top'),
        layout:CreatePanel('bottom'),
        layout:CreatePanel('header'),
    }
    this.mLayout = layout

    this.mSelection = Selection:Create
    {
        data = this.mRounds,
        spacingY = 25,
        rows = #this.mRounds,
        RenderItem =
            function(self, renderer, x, y, item)
                this:RenderRoundItem(renderer, x, y, item)
            end,
        OnSelection =
            function(index, item)
                this:OnRoundSelected(index, item)
            end,

    }

    this.mSelection.mY = 18
    -- Center align horizontally w/o cursor width
    gRenderer:ScaleText(1.25, 1.25)
    local txtSize = gRenderer:MeasureText(": Locked")
    local xPos = -this.mSelection:GetWidth() / 2
    xPos = xPos + this.mSelection.mCursorWidth / 2
    print(txtSize:X())
    xPos = xPos - txtSize:X() / 2
    this.mSelection.mX = xPos

    setmetatable(this, self)
    return this
end

function ArenaState:RenderRoundItem(renderer, x, y, item)

    local lockLabel = "Open"
    if item.mLocked then
        lockLabel = "Locked"
    end
    local label = string.format('%s: %s', item.mName, lockLabel)
    renderer:DrawText2d(x, y, label)
end

function ArenaState:OnRoundSelected(index)
    print(index)
end

function ArenaState:Enter()
end

function ArenaState:Exit()
end

function ArenaState:Update(dt)
end

function ArenaState:Render(renderer)

    renderer:AlignText("center", "center")
    renderer:ScaleText(1.5, 1.5)

    renderer:DrawRect2d(-System.ScreenWidth() / 2,
                        -System.ScreenHeight() / 2,
                        System.ScreenWidth() / 2,
                        System.ScreenHeight() / 2,
                        Vector.Create(0, 0, 0, 1))
    for k, v in ipairs(self.mPanels) do
        v:Render(renderer)
    end

    local titleX = self.mLayout:MidX("top")
    local titleY = self.mLayout:MidY("top")
    renderer:DrawText2d(titleX, titleY, "Welcome to the Arena")

    renderer:ScaleText(1.25, 1.25)

    local headerX = self.mLayout:MidX("header")
    local headerY = self.mLayout:MidY("header")
    renderer:DrawText2d(headerX, headerY, "Choose Round")

    renderer:AlignText("left", "center")
    self.mSelection:Render(renderer)
end

function ArenaState:HandleInput()
    if  Keyboard.JustReleased(KEY_BACKSPACE) or
        Keyboard.JustReleased(KEY_ESCAPE) then
        self.mStack:Pop()
    end

    self.mSelection:HandleInput()
end