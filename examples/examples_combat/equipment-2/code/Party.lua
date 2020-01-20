Party = {}
Party.__index = Party
function Party:Create()
    local this =
    {
        mMembers = {}
    }

    setmetatable(this, self)
    return this
end

function Party:Add(member)
    self.mMembers[member.mId] = member
end

function Party:RemoveById(id)
    self.mMembers[id] = nil
end

function Party:Remove(member)
    self:RemoveById(member.mId)
end

