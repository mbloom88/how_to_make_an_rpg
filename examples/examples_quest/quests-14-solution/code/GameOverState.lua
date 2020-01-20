GameOverState = {}
GameOverState.__index = GameOverState
function GameOverState:Create(stack, world)
    local this =
    {
        mWorld = world,
        mStack = stack,
    }

    setmetatable(this, self)

    this.mMenu = Selection:Create
    {
        data = { "New Game", "Continue" },
        spacingY = 36,
        OnSelection = function(...) this:OnSelect(...) end,
    }
    -- Select continue by default
    this.mMenu.mFocusY = 2
    this.mMenu:SetPosition(-this.mMenu:GetWidth(), 0)


    return this
end

function GameOverState:Enter()
    CaptionStyles["title"].color:SetW(1)
end
function GameOverState:Exit() end
function GameOverState:Update(dt) end

function GameOverState:HandleInput()
    self.mMenu:HandleInput()
end

function GameOverState:Render(renderer)

    renderer:DrawRect2d(System.ScreenTopLeft(),
                        System.ScreenBottomRight(),
                        Vector.Create(0,0,0,1))


    CaptionStyles["title"]:Render(renderer,
        "Game Over")

    renderer:AlignText("left", "center")
    self.mMenu:Render(renderer)
end

function GameOverState:OnSelect(index, data)
    local NEWGAME = 1
    local CONTINUE = 2

    if index == NEWGAME then
        -- For now a hack
        gStack = StateStack:Create()
        gWorld = World:Create()
        gStack:Push(ExploreState:Create(gStack, CreateArenaMap(), Vector.Create(30, 18, 1)))

    elseif index == CONTINUE then
        print("No save system. No continue.")
    end
end


