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

math.randomseed( os.time() )

function update()
    local dt = GetDeltaTime()
    gStack:Update(dt)
    gStack:Render(gRenderer)
    gWorld:Update(dt)
end

print("---Fight---")
local hero = Actor:Create(gPartyMemberDefs.hero)
local goblin = Actor:Create(gEnemyDefs.goblin)
print(string.format("%s v. %s", hero.mName, goblin.mName))

function MeleeAttack(state, attacker, target)
    local hitResult = Formula.IsHit(null, attacker, target)
    if HitResult.Miss == hitResult then
        print(string.format("%s Misses", attacker.mName))
    else

        -- Otherwise it's a hit
        local isCrit = hitResult == HitResult.Critical
        print(string.format("%s's strike is true.", attacker.mName))

        local isDodged = Formula.IsDodged(null, attacker, target)

        if isDodged then
            print(string.format("%s's dodges the attack.", target.mName))
        else
            local attack = Formula.CalcDamage(null, attacker, target)

            if isCrit then
                attack = attack + Formula.BaseAttack(null, attacker, target)
            end

            print(string.format("%s is hit for %d damage", target.mName, attack))
            print(string.format("%d -> %d", target.mStats:Get("hp_now"), target.mStats:Get("hp_now") - attack))

            target.mStats:Set("hp_now", target.mStats:Get("hp_now") - attack)

        end

    end
end

for i = 1, 5 do

    print(string.format("Round %d\n", i))

    MeleeAttack(null, hero, goblin)
    if goblin.mStats:Get("hp_now") > 0 then
        print(string.format("%s survives to counter", goblin.mName))
        MeleeAttack(null, goblin, hero)
    end

end

