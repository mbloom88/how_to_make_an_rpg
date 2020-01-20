LoadLibrary('Asset')
LoadLibrary('Renderer')
Asset.Run('OddmentTable.lua')

gRenderer = Renderer.Create()

local ot = OddmentTable:Create
{
    { oddment = 1, item = "sword" },
    { oddment = 1, item = "book" }
}

for i = 0, 50 do
    print(ot:Pick())
end

function update()
    gRenderer:AlignText("center", "center")
    gRenderer:DrawText2d(0,0,"Testing the Oddment Table")
end