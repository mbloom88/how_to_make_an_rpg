LoadLibrary('Asset')
LoadLibrary('Renderer')
Asset.Run('OddmentTable.lua')

gRenderer = Renderer.Create()

function update()
    gRenderer:AlignText("center", "center")
    gRenderer:DrawText2d(0,0,"Testing the Oddment Table")
end