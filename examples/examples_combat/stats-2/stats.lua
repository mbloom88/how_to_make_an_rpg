Stats = {}
Stats.__index = Stats
function Stats:Create(stats)
    local this =
    {
        mBase = {},
        mModifiers = {}
    }

    -- Shallow copy
    for k, v in pairs(stats) do
        this.mBase[k] = v
    end

    setmetatable(this, self)
    return this
end

function Stats:GetBase(id)
    return self.mBase[id]
end