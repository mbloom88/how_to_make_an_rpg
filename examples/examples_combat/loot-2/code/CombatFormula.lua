--
-- The calculations for combat
--
Formula = {}
function Formula.MeleeAttack(state, attacker, target)

    local stats = attacker.mStats
    local enemyStats = target.mStats

    -- Simple attack get
    local attack = stats:Get("attack")
    attack = attack + stats:Get("strength")
    local defense = enemyStats:Get("defense")

    local damage = math.max(0, attack - defense)

    return damage
end