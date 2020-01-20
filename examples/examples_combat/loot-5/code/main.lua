LoadLibrary('Asset')
Asset.Run('Dependencies.lua')

gRenderer = Renderer.Create()
gStack = StateStack:Create()
gWorld = World:Create()

gWorld.mParty:Add(Actor:Create(gPartyMemberDefs.hero))
gWorld.mParty:Add(Actor:Create(gPartyMemberDefs.mage))
gWorld.mParty:Add(Actor:Create(gPartyMemberDefs.thief))

gCombatDef =
{
    background = "arena_background.png",
    actors =
    {
        party = gWorld.mParty:ToArray(),
        enemy =
        {
            Actor:Create(gEnemyDefs.goblin),
            -- Actor:Create(gEnemyDefs.goblin),
            -- Actor:Create(gEnemyDefs.goblin),
            -- Actor:Create(gEnemyDefs.goblin),
        }
    }
}


gStack:Push(ExploreState:Create(gStack, CreateArenaMap(), Vector.Create(30, 18, 1)))
gStack:Push(CombatState:Create(gStack, gCombatDef))


function update()
    local dt = GetDeltaTime()
    gStack:Update(dt)
    gStack:Render(gRenderer)
    gWorld:Update(dt)
end

-- -- --
-- -- -- Testing the ActorXPSummary
-- -- --
-- local layout = Layout:Create()
-- layout.mPanels['test'] = {x=0,y=41, width=522, height=77}
-- local actorHero = gWorld.mParty.mMembers['hero']
-- local summary = ActorXPSummary:Create(actorHero, layout, 'test')
-- summary:AddPopUp("Level Up!")
-- function update()
--     summary:Update(GetDeltaTime())
--     summary:Render(gRenderer)
-- end

-- --
-- -- Testing the Popup
-- --
-- local popup = nil

-- function update()

--     if(Keyboard.JustPressed(KEY_SPACE)) then
--         popup = XPPopUp:Create("Hello World", 0, 0)
--         popup:TurnOn()
--     end


--     if popup then
--         popup:Update(GetDeltaTime())
--         popup:Render(gRenderer)

--         if popup.mDisplayTime > 2 then
--             popup:TurnOff()
--             if popup:IsFinished() then
--                 popup = nil
--             end
--         end
--     end
-- end