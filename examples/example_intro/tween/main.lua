LoadLibrary("Renderer")
LoadLibrary("Asset")
LoadLibrary("System")

Asset.Run("Tween.lua")

gRenderer = Renderer:Create()
gRenderer:AlignText("center", "center")

function drawLine(x, y, length, caret01, name)
    gRenderer:DrawLine2d(x, y, x + length, y)
    gRenderer:DrawCircle2d(x + (length*caret01), y, 8)
    gRenderer:DrawText2d(x + length*0.5, y - 16, name)
end

gTweensFunctions =
{
    "Linear",
    "EaseInQuad",
    "EaseOutQuad",
    "EaseInCirc",
    "EaseOutCirc",
    "EaseOutInCirc",
    "EaseInOutElastic",
    "EaseOutElastic",
    "EaseInElastic",
    "EaseInExpo",
    "EaseInBounce",
    "EaseOutBounce"
}

function CreateTweenSet(start, finish, duration)
    duration = duration or 3

    list = {}

    for k, v in ipairs(gTweensFunctions) do
        list[k] =
        {
            name = v,
            tween = Tween:Create(start, finish, duration, Tween[v])
        }
    end




    return list
end

gForward = true
gTweens = CreateTweenSet(0, 1)

function update()
    local dt = GetDeltaTime()
    local reset = false


    gRenderer:AlignText("center", "center")
    gRenderer:ScaleText(1, 1)

    local rowWidth = 3
    local padding = 56 -- should be width/itemwidth * 0.5
    local yPadding = 96

    local y = System.ScreenHeight() * 0.5
    local x = System.ScreenWidth() * -0.5
    x = x + padding
    y = y - yPadding*0.75


    local startX = x
    local col = 0

    for k, v in ipairs(gTweens) do


        local t = v.tween

        drawLine(x,y, 100, t:Value(), v.name)

        x = x + 256

        if t:IsFinished() then
            reset = true
        end

        t:Update(dt)

        col = col + 1

        if col >= rowWidth then
            x = startX
            y = y - yPadding
            col = 0
        end

    end

    if reset then
        if gForward then
            gTweens = CreateTweenSet(1, 0)
            gForward = false
        else
            gTweens = CreateTweenSet(0, 1)
            gForward = true
        end
    end


end