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
            Actor:Create(gEnemyDefs.goblin),
            Actor:Create(gEnemyDefs.goblin),
            Actor:Create(gEnemyDefs.goblin),
        }
    }
}


gStack:Push(ExploreState:Create(gStack, CreateArenaMap(), Vector.Create(30, 18, 1)))
gStack:Push(CombatState:Create(gStack, gCombatDef))

gWorld:AddItem(1) -- bone blade
gWorld:AddItem(2) -- bone armor
gWorld:AddItem(3) -- Ring of Titan
gWorld:AddItem(10, 2) -- potion
gWorld:AddItem(11, 1) -- heal salve
gWorld:AddItem(12, 1) -- heal salve

function update()
    local dt = GetDeltaTime()
    gStack:Update(dt)
    gStack:Render(gRenderer)
    gWorld:Update(dt)
end
