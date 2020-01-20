LoadLibrary('Asset')
Asset.Run('Dependencies.lua')

gRenderer = Renderer.Create()
gStack = StateStack:Create()
gWorld = World:Create()
--local startPos = Vector.Create(27, 26, 1)
--local startPos = Vector.Create(41, 57, 1)
local startPos = Vector.Create(12, 111, 1)

local hero = Actor:Create(gPartyMemberDefs.hero)
local thief = Actor:Create(gPartyMemberDefs.thief)
local mage = Actor:Create(gPartyMemberDefs.mage)
gWorld.mParty:Add(hero)
gWorld.mParty:Add(thief)
gWorld.mParty:Add(mage)

do
    local cavemap = CreateCaveMap(gWorld.mGameState)
    gStack:Push(ExploreState:Create(gStack, cavemap, startPos))
end

gWorld.mGold = 5
gWorld:AddItem(1, 3)
gWorld:AddItem(2, 3)
gWorld:AddItem(10, 5)

-- Equip the sword (from inventory)
hero:Equip(Actor.EquipSlotId[1], {id = 1, count = 2})
--hero.mStats:Set("hp_now", 1)
--thief.mStats:Set("hp_now", 0)

-- gStack:Push(ShopState:Create(gStack, gWorld, shopDef))
local sayDef = { textScale = 1.3 }
local intro =
{
    SOP.BlackScreen(),
    SOP.RunAction("AddNPC",
        {"handin", { def = "thief", id="thief", x = 4, y = 10}},
        {GetMapRef}),
    SOP.RunAction("AddNPC",
        {"handin", { def = "mage", id="mage", x = 6, y = 11}},
        {GetMapRef}),
    SOP.FadeOutScreen(),
    SOP.MoveNPC("major", "handin",
        {
            "right",
            "right",
            "left",
            "left",
            "down"
        }),
    SOP.Say("handin", "major", "So, in conclusion...", 2.3,sayDef),
    SOP.Wait(0.75),
    SOP.Say("handin", "major", "Head north to the mine.", 2.3,sayDef),
    SOP.Wait(2),
    SOP.Say("handin", "major", "Find the skull ruby.", 2.3,sayDef),
    SOP.Wait(2),
    SOP.Say("handin", "major", "Bring it back here to me.", 2.5, sayDef),
    SOP.Wait(1.75),
    SOP.Say("handin", "major", "Then I'll give you the second half of your fee.", 3.5, sayDef),
    SOP.Wait(1.75),
    SOP.Say("handin", "major", "Do we have an agreement?", 3.0, sayDef),
    SOP.Wait(1),
    SOP.Say("handin", "hero", "Yes.", 1.0, sayDef),
    SOP.Wait(0.5),
    SOP.Say("handin", "major", "Good.", 1.0, sayDef),
    SOP.Wait(0.5),
    SOP.Say("handin", "major", "Here's the first half of the fee...", 3.0, sayDef),
    SOP.Wait(1),
    SOP.Say("handin", "major", "Now get going.", 2.5, sayDef),
    -- Party members can walk into the hero and
    -- return control to the player.
    SOP.NoBlock(
        SOP.MoveNPC("thief", "handin",
        {
            "right",
            "up",
        })),
    SOP.FadeOutChar("handin", "thief"),
    SOP.RunAction("RemoveNPC", {"handin", "thief"},
        {GetMapRef}),
    SOP.NoBlock(
        SOP.MoveNPC("mage", "handin",
        {
            "left",
            "up",
            "up",
        })),
    SOP.FadeOutChar("handin", "mage"),
    SOP.RunAction("RemoveNPC", {"handin", "mage"},
        {GetMapRef}),
    SOP.Wait(0.1),
    SOP.HandOff("handin")
}

-- Teleport write a teleport icon on the detail layer
function update()
    local dt = GetDeltaTime()
    gStack:Update(dt)
    gStack:Render(gRenderer)
    gWorld:Update(dt)

    if Keyboard.JustPressed(KEY_S) then
        Save:Save()
    end

    if Keyboard.JustPressed(KEY_L) then
        Save:Load()
    end

    if Keyboard.JustPressed(KEY_P) then
        --PrintTable(gWorld.mParty)
    end
end
