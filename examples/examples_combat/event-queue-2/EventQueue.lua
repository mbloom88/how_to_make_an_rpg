
EventQueue = {}
EventQueue.__index = EventQueue
function EventQueue:Create()
    local this =
    {
        mQueue = {}, -- no because two things could have the same time
    }

    setmetatable(this, self)
    return this
end


-- Need to convert speed into a more useful number!
function EventQueue:Add(event, timePoints)
    local queue = self.mQueue

    -- Instant event
    if timePoints == -1 then
        event.mCountDown = -1
        table.insert(queue, 1, event)
    else
        event.mCountDown = timePoints

        -- loop through events
        for i = 1, #queue do
            local count = queue[i].mCountDown

            if count > event.mCountDown then
                table.insert(queue, i, event)
                return
            end

        end

        table.insert(queue, event)
    end
end

function EventQueue:SpeedToTimePoints(speed)
    local maxSpeed = 255
    speed = math.min(speed, 255)
    local points = maxSpeed - speed
    return math.floor(points)
end

function EventQueue:Clear()
    self.mQueue = {}
    self.mCurrentEvent = nil
end

function EventQueue:IsEmpty()
    return self.mQueue == nil or next(self.mQueue) == nil
end

function EventQueue:ActorHasEvent(actor)

    local current = self.mCurrentEvent or {}

    if current.mOwner == actor then
        return true
    end

    for k, v in ipairs(self.mQueue) do
        if v.mOwner == actor then
            return true
        end
    end

    return false
end

function EventQueue:Print()

    local queue = self.mQueue

    if self:IsEmpty() then
       print("Event Queue is empty.")
       return
    end

    print("Event Queue:")

    local current = self.mCurrentEvent or {}

    print("Current Event: ", current.mName)

    for k, v in ipairs(queue) do
        local out = string.format("[%d] Event: [%d][%s]",
                                  k, v.mCountDown, v.mName)
        print(out)
    end
end