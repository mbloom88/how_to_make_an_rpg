LoadLibrary("Renderer")

gRenderer = Renderer:Create()
gRenderer:AlignText("center", "center")

Dog = {}
Dog.__index = Dog
function Dog:Create(dogName)
    local this =
    {
        name = dogName
    }
    setmetatable(this, self)
    return this
end

function Dog:Bark()
    print(self.name .. ": Bark!")
end

spot = Dog:Create("spot")
spot:Bark()    -- > "spot: Bark!"

paws = Dog:Create("paws")
paws:Bark()    -- > "paws: Bark!"

function update()
    gRenderer:DrawText2d(0, 0, "Hello World")
end