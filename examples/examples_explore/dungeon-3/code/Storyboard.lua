
Storyboard = {}
Storyboard.__index = Storyboard
function Storyboard:Create(stack, events)
    local this =
    {
        mStack = stack,
        mEvents = events,
        mStates = {},
        mSubStack = StateStack:Create()
    }

    setmetatable(this, self)
    return this
end

function Storyboard:Enter()
end

function Storyboard:Exit()
end

function Storyboard:CleanUp()

end

function Storyboard:Update(dt)

    self.mSubStack:Update(dt)

    if #self.mEvents == 0 then
        self.mStack:Pop()
    end

    local deleteIndex = nil
    for k, v in ipairs(self.mEvents) do

        if type(v) == "function" then
            self.mEvents[k] = v(self)
            v = self.mEvents[k]
        end

        v:Update(dt, self)
        if v:IsFinished() then
            deleteIndex = k
            break
        end

        if v:IsBlocking() then
            break
        end
    end

    if deleteIndex then
        table.remove(self.mEvents, deleteIndex)
    end

end

function Storyboard:Render(renderer)
    self.mSubStack:Render(renderer)
    --local debugText = string.format("Events Stack: %d", #self.mEvents)
    --renderer:DrawText2d(0, 0, debugText)
end

function Storyboard:HandleInput()
end

function Storyboard:PushState(id, state)
    -- push a State on the stack but keep a reference here.
    assert(self.mStates[id] == nil)
    self.mStates[id] = state
    self.mSubStack:Push(state)
end

function Storyboard:RemoveState(id)
    local state = self.mStates[id]
    self.mStates[id] = nil
    for i = #self.mSubStack.mStates, 1, -1 do
        local v = self.mSubStack.mStates[i]
        if v == state then
            table.remove(self.mSubStack.mStates, i)
        end
    end
end