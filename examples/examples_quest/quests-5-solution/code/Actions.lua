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
        print("npcid", tostring(npc.id))
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

    AddChest = function(map, entityId, loot, x, y, layer)

        layer = layer or 1

        return function(trigger, entity, tX, tY, tLayer)

            local entityDef = gEntities[entityId]
            assert(entityDef ~= nil)
            local chest = Entity:Create(entityDef)

            -- Put the chest entity on the map
            chest:SetTilePos(x, y, layer, map)

            -- Define open chest function
            local  OnOpenChest = function()

                if loot == nil or #loot == 0 then
                    gStack:PushFit(gRenderer, 0, 0, "The chest is empty!", 300)
                else

                    gWorld:AddLoot(loot)

                    for _, item in ipairs(loot) do


                        local count = item.count or 1
                        local name = ItemDB[item.id].name
                        local message = string.format("Got %s", name)

                        if count > 1 then
                            message = message .. string.format(" x%d", count)
                        end

                        gStack:PushFit(gRenderer, 0, 0, message, 300)
                    end
                end

                -- Remove the trigger
               map:RemoveTrigger(chest.mTileX, chest.mTileY, chest.mLayer)
               chest:SetFrame(entityDef.openFrame)
            end

            local trigger = Trigger:Create( { OnUse = OnOpenChest } )
            map:AddFullTrigger(trigger,
                               chest.mTileX, chest.mTileY, chest.mLayer)
        end
    end,

    RunScript = function(map, Func)
        return function(trigger, entity, tX, tY, tLayer)
            Func(map, trigger, entity, tX, tY, tLayer)
        end
    end,

    OpenShop = function(map, def)
        return function(trigger, entity, tX, tY, tLayer)
            gStack:Push(ShopState:Create(gStack, gWorld, def))
        end
    end,
}