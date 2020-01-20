LoadLibrary("Renderer")
LoadLibrary("Sprite")
LoadLibrary("System")
LoadLibrary("Texture")
LoadLibrary("Vector")
LoadLibrary("Asset")
LoadLibrary("Keyboard")

Asset.Run("Util.lua")
Asset.Run("Tween.lua")
Asset.Run("Panel.lua")
Asset.Run("Textbox.lua")

gRenderer = Renderer.Create()

function CreateFixed(renderer, x, y, width, height, text)

    local padding = 10
    local textScale = 1.5
    local panelTileSize = 3

    local wrap = width - padding * 2

    return Textbox:Create
    {
        wrap = wrap,
        text = text,
        textScale = textScale,
        size =
        {
            left    = x - width / 2,
            right   = x + width / 2,
            top     = y + height / 2,
            bottom  = y - height / 2
        },
        textbounds =
        {
            left = padding,
            right = -padding,
            top = -padding,
            bottom = padding
        },
        panelArgs =
        {
            texture = Texture.Find("gradient_panel.png"),
            size = panelTileSize,
        }
    }
end


local text = "`Twas brillig, and the slithy toves"
local textbox = CreateFixed(gRenderer, 100, -100, 250, 64, text)

function update()
    textbox:Update(GetDeltaTime())
    textbox:Render(gRenderer)
end

