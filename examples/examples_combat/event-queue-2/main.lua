LoadLibrary("System")
LoadLibrary("Renderer")
LoadLibrary("Asset")

-- Asset.Run("CombatScene.lua")
Asset.Run("EventQueue.lua")
-- Asset.Run("CETurn.lua")

-- gRenderer = Renderer.Create()

-- gCombatScene = CombatScene:Create(
--     {
--         -- party actors
--         { speed = 3 },      -- our hero
--     },
--     {
--         -- enemies actors
--         { speed = 2 },      -- goblin
--     })

-- function update()
--     gRenderer:AlignText("center", "center")
--     gRenderer:DrawText2d(0, 0, "Testing Combat")

--     gCombatScene:Update()
-- end

eventQueue = EventQueue:Create()

eventQueue:Add({ mName = "Msg: Welcome to the Arena"}, -1)
eventQueue:Add({ mName = "Take Turn Goblin" }, 5)
eventQueue:Add({ mName = "Take Turn Hero" }, 4)


eventQueue:Print()

function update()
end