local function AddAnimEffect(state, entity, def, spf)
    local x = entity.mX
    local y = entity.mY + (entity.mHeight * 0.75)

    local effect = AnimEntityFx:Create(x, y, def, def.frames, spf)
    state:AddEffect(effect)
end

local function AddTextNumberEffect(state, entity, num, color)
    local x = entity.mX
    local y = entity.mY

    local text = string.format("+%d", num)
    local textEffect = CombatTextFx:Create(x, y, text, color)
    state:AddEffect(textEffect)
end

local function StatsCharEntity(state, actor)
    local stats = actor.mStats
    local character = state.mActorCharMap[actor]
    local entity = character.mEntity
    return stats, character, entity
end

CombatActions =
{
    ["hp_restore"] =
    function(state, owner, targets, def)

        local restoreAmount = def.use.restore or 250
        local animEffect = gEntities.fx_restore_hp
        local restoreColor = Vector.Create(0, 1, 0, 1)

        for k, v in ipairs(targets) do

            local stats, character, entity = StatsCharEntity(state, v)

            local maxHP = stats:Get("hp_max")
            local nowHP = stats:Get("hp_now")

            if nowHP > 0 then
                AddTextNumberEffect(state, entity, restoreAmount, restoreColor)
                nowHP = math.min(maxHP, nowHP + restoreAmount)
                stats:Set("hp_now", nowHP)
            end

            AddAnimEffect(state, entity, animEffect, 0.1)

        end

    end,

    ['mp_restore'] =
    function(state, owner, targets, def)

        local restoreAmount = def.use.restore or 50
        local animEffect = gEntities.fx_restore_mp
        local restoreColor = Vector.Create(130/255, 200/255, 237/255, 1)

        for k, v in ipairs(targets) do

            local stats, character, entity = StatsCharEntity(state, v)

            local maxMP = stats:Get("mp_max")
            local nowMP = stats:Get("mp_now")
            local nowHP = stats:Get("hp_now")

            if nowHP > 0 then
                AddTextNumberEffect(state, entity, restoreAmount, restoreColor)
                nowMP = math.min(maxMP, nowMP + restoreAmount)
                stats:Set("mp_now", nowMP)
            end

            AddAnimEffect(state, entity, animEffect, 0.1)
        end
    end,

    ['revive'] =
    function(state, owner, targets, def)

        local restoreAmount = def.use.restore or 100
        local animEffect = gEntities.fx_revive
        local restoreColor = Vector.Create(0, 1, 0, 1)

        for k, v in ipairs(targets) do
            local stats, character, entity = StatsCharEntity(state, v)

            local maxHP = stats:Get("hp_max")
            local nowHP = stats:Get("hp_now")

            if nowHP == 0 then

                nowHP = math.min(maxHP, nowHP + restoreAmount)

                -- the character will get a CETurn event automatically
                -- assigned next update
                character.mController:Change(CSStandby.mName)

                stats:Set("hp_now", nowHP)

                AddTextNumberEffect(state, entity, restoreAmount, restoreColor)
            end

            AddAnimEffect(state, entity, animEffect, 0.1)
        end
    end
}

