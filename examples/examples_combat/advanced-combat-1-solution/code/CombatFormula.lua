--
-- The calculations for combat
--
Formula = {}

HitResult =
{
    Miss        = 0,
    Dodge       = 1,
    Hit         = 2,
    Critical    = 3
}

function Formula.MeleeAttack(state, attacker, target)

    local stats = attacker.mStats
    local enemyStats = target.mStats

    local damage = 0
    local hitResult = Formula.IsHit(state, attacker, target)

    if hitResult == HitResult.Miss then
        return math.floor(damage), HitResult.Miss
    end

    if Formula.IsDodged(state, attacker, target) then
        return math.floor(damage), HitResult.Dodge
    end

    local damage = Formula.CalcDamage(state, attacker, target)

    if hitResult == HitResult.Hit then
        return math.floor(damage), HitResult.Hit
    end

    -- Critical
    assert(hitResult == HitResult.Critical)

    damage = damage + Formula.BaseAttack(state, attacker, target)
    return math.floor(damage), HitResult.Critical
end


function Formula.IsHit(state, attacker, target)

    local stats = attacker.mStats
    local speed = stats:Get("speed")
    local intelligence = stats:Get("intelligence")

    local cth = 0.7 --Chance to Hit
    local ctc = 0.1 --Chance to Crit

    local bonus = ((speed + intelligence) / 2) / 255
    local cth = cth + (bonus / 2)

    local rand = math.random()
    local isHit = rand <= cth
    local isCrit = rand <= ctc

    if isCrit then
        return HitResult.Critical
    elseif isHit then
        return HitResult.Hit
    else
        return HitResult.Miss
    end
end

function Formula.IsDodged(state, attacker, target)

    local stats = attacker.mStats
    local enemyStats = target.mStats

    local speed = stats:Get("speed")
    local enemySpeed = enemyStats:Get("speed")

    local ctd = 0.03 --Chance to Dodge
    local speedDiff = speed - enemySpeed
    -- clamp speed diff to plus or minus 10%
    speedDiff = Clamp(speedDiff, -10, 10) * 0.01

    ctd = math.max(0, ctd + speedDiff)

    return math.random() <= ctd
end

function Formula.IsCountered(state, attacker, target)
    -- if not assigned 0 is returned, which will mean no chance of countering
    local counter = target.mStats:Get("counter")

    -- I want random to be between 0 and under 1
    -- This means 1 always counters and 0 it never happens

    return math.random()*0.99999 < counter
end

function Formula.BaseAttack(state, attacker, target)
    local stats = attacker.mStats
    local strength = stats:Get("strength")
    local attackStat = stats:Get("attack")

    local attack = (strength / 2) + attackStat

    return math.random(attack, attack * 2)
end

function Formula.CalcDamage(state, attacker, target)
    local targetStats = target.mStats
    local defense = targetStats:Get("defense")

    local attack = Formula.BaseAttack(state, attacker, target)

    return math.floor(math.max(0, attack - defense))
end