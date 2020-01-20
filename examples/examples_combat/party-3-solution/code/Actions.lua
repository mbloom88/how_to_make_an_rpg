Actions =
{
    -- Teleport an entity from the current position to the given position
    Teleport = function(map, tileX, tileY, layer)
        layer = layer or 1
        return function(trigger, entity, tX, tY, tLayer)
            entity:SetTilePos(tileX, tileY, layer, map)
        end
    end,

    --
    -- Note this should be used by the Quest manager!
    --
    AddNPC = function(map, npc)
        assert(npc.id ~= "hero")
        return function(trigger, entity, tX, tY, tLayer)

            local charDef = gCharacters[npc.def]
            assert(charDef) -- Character should always exist!
            local char = Character:Create(charDef, map)

            -- Use npc def location by default
            -- Drop back to entities locations if missing
            local x = npc.x or char.mEntity.mTileX
            local y = npc.y or char.mEntity.mTileY
            local layer = npc.layer or char.mEntity.mLayer

            char.mEntity:SetTilePos(x, y, layer, map)

            table.insert(map.mNPCs, char)
            assert(map.mNPCbyId[npc.id] == nil)
            char.mId = npc.id
            map.mNPCbyId[npc.id] = char
        end
    end,

    RemoveNPC = function(map, id)
        return function (trigger, entity, tX, tY, tLayer)
            local npc = map.mNPCbyId[id].mEntity
            assert(npc)
            map:RemoveNPC(npc.mX, npc.mY, npc.mLayer)
        end
    end,

    AddPartyMember = function(actorId)
        return function (trigger, entity, tX, tY, tLayer)
            local actorDef = gPartyMemberDefs[actorId]
            assert(actorDef)
            gWorld.mParty:Add(Actor:Create(actorDef))
        end
    end,

    RunScript = function(map, Func)
        return function(trigger, entity, tX, tY, tLayer)
            Func(map, trigger, entity, tX, tY, tLayer)
        end
    end
}