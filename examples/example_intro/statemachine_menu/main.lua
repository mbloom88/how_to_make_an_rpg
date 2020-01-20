LoadLibrary("Renderer")
LoadLibrary("Keyboard")
LoadLibrary("Asset")
Asset.Run("StateMachine.lua")


StartMenuState = {}
StartMenuState.__index = StartMenuState
function StartMenuState:Create(statemachine)
    local this =
    {
        mStates = statemachine,
    }
    setmetatable(this, self)
    return this
end

function StartMenuState:Enter() end
function StartMenuState:Exit() end

function StartMenuState:Update(dt)
    if Keyboard.JustPressed(KEY_S) then
        self.mStates:Change("settings")
    end
end

function StartMenuState:Render(renderer)
    renderer:AlignText("center", "center")
    renderer:DrawText2d(0, 0, "START MENU")
end


SettingsMenuState = {}
SettingsMenuState.__index = SettingsMenuState
function SettingsMenuState:Create(statemachine)
    local this =
    {
        mStates = statemachine,
    }
    setmetatable(this, self)
    return this
end

function SettingsMenuState:Enter() end
function SettingsMenuState:Exit() end

function SettingsMenuState:Update(dt)
    if Keyboard.JustPressed(KEY_B) then
        self.mStates:Change("start")
    end
end

function SettingsMenuState:Render(renderer)
    renderer:AlignText("center", "center")
    renderer:DrawText2d(0, 0, "SETTINGS MENU")
end

gRenderer = Renderer:Create()
gRenderer:AlignText("center", "center")

states = StateMachine:Create()
states.mStates =
{
    ["start"] = function() return StartMenuState:Create(states) end,
    ["settings"] = function() return SettingsMenuState:Create(states) end,
}
states:Change("start")


function update()
    states:Update(GetDeltaTime())
    states:Render(gRenderer)
end