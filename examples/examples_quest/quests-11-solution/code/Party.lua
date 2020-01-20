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

function Party:ToArray()
    local array = {}

    for k, v in pairs(self.mMembers) do
        table.insert(array, v)
    end

    return array
end

-- Count the number of this item equipped
function Party:EquipCount(itemId)

    local count = 0

    for _,v in pairs(self.mMembers) do
        count = count + v:EquipCount(itemId)
    end

    return count
end

function Party:Rest()

    for _, v in pairs(self.mMembers) do
        local stats = v.mStats
        if stats:Get("hp_now") > 0 then
            stats:Set("hp_now", stats:Get("hp_max"))
            stats:Set("mp_now", stats:Get("mp_max"))
        end
    end

end