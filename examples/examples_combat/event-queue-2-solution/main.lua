LoadLibrary("System")
LoadLibrary("Renderer")
LoadLibrary("Asset")

Asset.Run("CombatScene.lua")
Asset.Run("EventQueue.lua")
Asset.Run("CETurn.lua")
Asset.Run("CEAttack.lua")
Asset.Run("EventQueue.lua")

gRenderer = Renderer.Create()

gCombatScene = CombatScene:Create(
    {
        -- our hero
        {
            mName = "hero",
            mSpeed = 3,
            mAttack = 2,
            mHP = 5,
            IsPlayer = function() return true end,
            IsKOed = function(self) return self.mHP <= 0 end,
        },
    },
    {
        -- enemies goblin
        {
            mName = "goblin",
            mSpeed = 2,
            mAttack = 2,
            mHP = 5,
            IsPlayer = function() return false end,
            IsKOed = function(self) return self.mHP <= 0 end,
        },
    })


print("--start--")

local turnNum = 36

for i = 1, turnNum do
    --gCombatScene.mEventQueue:Print()
    gCombatScene:Update()
end

--
-- There has to be an enter combat function that
-- puts the players on the stack according to turn
--

function update()
    gRenderer:AlignText("center", "center")
    gRenderer:DrawText2d(0, 0, "Testing Combat")


end