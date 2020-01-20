
FrontMenuState = {}
FrontMenuState.__index = FrontMenuState
function FrontMenuState:Create(parent)


    local layout = Layout:Create()
    layout:Contract('screen', 118, 40)
    layout:SplitHorz('screen', "top", "bottom", 0.12, 2)
    layout:SplitVert('bottom', "left", "party", 0.726, 2)
    layout:SplitHorz('left', "menu", "gold", 0.7, 2)

    local this
    this =
    {
        mParent = parent,
        mStack = parent.mStack,
        mStateMachine = parent.mStateMachine,
        mLayout = layout,

        mSelections = Selection:Create
        {
            spacingY = 32,
            data =
            {
                "Items",
                "Status",
                -- "Magic",
                -- "Equipment",
                -- "Save"
            },
            OnSelection = function(...) this:OnMenuClick(...) end
        },

        mPanels =
        {
            layout:CreatePanel("gold"),
            layout:CreatePanel("top"),
            layout:CreatePanel("party"),
            layout:CreatePanel("menu")
        },
        mTopBarText = "Current Map Name",
    }

    setmetatable(this, self)


    this.mSelections.mX = this.mLayout:MidX("menu") - 60
    this.mSelections.mY = this.mLayout:Top("menu") - 24

    this.mPartyMenu = Selection:Create
    {
        spacingY = 90,
        data = this:CreatePartySummaries(),
        columns = 1,
        rows = 3,
        OnSelection = function(...) this:OnPartyMemberChosen(...) end,
        RenderItem = function(menu, renderer, x, y, item)
            if item then
                item:SetPosition(x, y + 35)
                item:Render(renderer)
            end
        end
    }
    this.mPartyMenu:HideCursor()

    return this
end

function FrontMenuState:Enter()

end

function FrontMenuState:Exit()
end

function FrontMenuState:OnMenuClick(index)

    local ITEMS = 1

    if index == ITEMS then
        return self.mStateMachine:Change("items")
    end
end

function FrontMenuState:Update(dt)
    self.mSelections:HandleInput()

    if Keyboard.JustPressed(KEY_BACKSPACE) or
       Keyboard.JustPressed(KEY_ESCAPE) then
        self.mStack:Pop()
    end
end

function FrontMenuState:CreatePartySummaries()

    local partyMembers = gWorld.mParty.mMembers

    local out = {}
    for _, v in pairs(partyMembers) do
        print(_, v, v.mName)
        local summary = ActorSummary:Create(v,
            { showXP = true})
        table.insert(out, summary)
    end

    print("Out size", #out)
    return out
end

function FrontMenuState:Render(renderer)
    for k, v in ipairs(self.mPanels) do
        v:Render(renderer)
    end


    renderer:ScaleText(self.mParent.mTitleSize, self. mParent.mTitleSize)
    renderer:AlignText("left", "center")
    local menuX = self.mLayout:Left("menu") - 16
    local menuY = self.mLayout:Top("menu") - 24
    self.mSelections:SetPosition(menuX, menuY)
    self.mSelections:Render(renderer)

    local nameX = self.mLayout:MidX("top")
    local nameY = self.mLayout:MidY("top")
    renderer:AlignText("center", "center")
    renderer:DrawText2d(nameX, nameY, self.mTopBarText)

    local goldX = self.mLayout:MidX("gold") - 22
    local goldY = self.mLayout:MidY("gold") + 22

    renderer:ScaleText(self.mParent.mLabelSize, self.mParent.mLabelSize)
    renderer:AlignText("right", "top")
    renderer:DrawText2d(goldX, goldY, "GP:")
    renderer:DrawText2d(goldX, goldY - 25, "TIME:")
    renderer:AlignText("left", "top")
    renderer:DrawText2d(goldX + 10, goldY, gWorld:GoldAsString())
    renderer:DrawText2d(goldX + 10, goldY - 25, gWorld:TimeAsString())

    local partyX = self.mLayout:Left("party") - 16
    local partyY = self.mLayout:Top("party") - 45
    self.mPartyMenu:SetPosition(partyX, partyY)
    self.mPartyMenu:Render(renderer)
end