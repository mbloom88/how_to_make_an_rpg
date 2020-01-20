LoadLibrary("Renderer")
LoadLibrary("Sprite")
LoadLibrary("System")
LoadLibrary("Texture")
LoadLibrary("Asset")
LoadLibrary("Keyboard")


Asset.Run("Map.lua")
Asset.Run("Util.lua")
Asset.Run("larger_map.lua")

local gMap = Map:Create(CreateMap1())
gRenderer = Renderer:Create()

gMap:Goto(1984, 832)
-- This will get it centered
--gMap:Goto(1984 - System.ScreenWidth()/2, 832 - System.ScreenHeight()/2)
function update()
    gRenderer:Translate(-gMap.mCamX, -gMap.mCamY)
    gMap:Render(gRenderer)

    if Keyboard.Held(KEY_LEFT) then
        gMap.mCamX = gMap.mCamX - 1

    elseif Keyboard.Held(KEY_RIGHT) then
        gMap.mCamX = gMap.mCamX + 1
    end

    if Keyboard.Held(KEY_UP) then
        gMap.mCamY = gMap.mCamY + 1
    elseif Keyboard.Held(KEY_DOWN) then
        gMap.mCamY = gMap.mCamY - 1
    end
end