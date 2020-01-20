LoadLibrary("System")
LoadLibrary("Renderer")
LoadLibrary("Asset")

Asset.Run("dice.lua")
Asset.Run("stats.lua")

gRenderer = Renderer.Create()

-- Let's roll some dice!

print("1D6:" .. Dice.RollDie(1, 6))

local r1d6 = Dice:Create("1d6")

print("precreated roll")
print(r1d6:Roll())
print(r1d6:Roll())

local roll = Dice:Create("1d6 1d8+10")

print("1d6 1d8+10:" .. roll:Roll())

function update()
    gRenderer:DrawText2d(0, 0, "Let's make a level class!")
end