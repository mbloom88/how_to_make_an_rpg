
-- WaitState, MoveState must already be loaded.
assert(WaitState)
assert(MoveState)

gCharacterStates =
{
    wait = WaitState,
    move = MoveState,
    npc_stand = NPCStandState,
    plan_stroll = PlanStrollState,
    follow_path = FollowPathState,
    cs_run_anim = CSRunAnim,
    cs_hurt = CSHurt,
    cs_move = CSMove,
    cs_standby = CSStandby,
    cs_die_enemy = CSEnemyDie,
    cs_hurt_enemy = CSEnemyHurt,
}

gEntities =
{
    hero =
    {
        texture = "walk_cycle.png",
        width = 16,
        height = 24,
        startFrame = 9,
        tileX = 11,
        tileY = 3,
        layer = 1
    },
    thief =
    {
        texture = "walk_cycle.png",
        width = 16,
        height = 24,
        startFrame = 41,
        tileX = 11,
        tileY = 3,
        layer = 1
    },
    mage =
    {
        texture = "walk_cycle.png",
        width = 16,
        height = 24,
        startFrame = 25,
        tileX = 11,
        tileY = 3,
        layer = 1
    },
    combat_hero =
    {
        texture = "combat_hero.png",
        width = 64,
        height = 64,
        startFrame = 37,
    },
    combat_thief =
    {
        texture = "combat_thief.png",
        width = 64,
        height = 64,
        startFrame = 37,
    },
    combat_mage =
    {
        texture = "combat_mage.png",
        width = 64,
        height = 64,
        startFrame = 37,
    },
    goblin =
    {
        texture = "goblin.png",
        startFrame = 1,
        width = 32,
        height = 32,
    },
    chest =
    {
        texture = "chest.png",
        width = 16,
        height = 16,
        startFrame = 1,
        openFrame = 2
    },
}


gCharacters =
{
    hero =
    {
        entity = "hero",
        actorId = "hero",
        combatEntity = "combat_hero",
        anims =
        {
            up      = {1, 2, 3, 4},
            right   = {5, 6, 7, 8},
            down    = {9, 10, 11, 12},
            left    = {13, 14, 15, 16},
            prone   = {19, 20},
            attack  = {5, 4, 3, 2, 1},
            use     = {46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57},
            hurt    = {21, 22, 23, 24},
            standby = {36, 37, 38, 39},
            advance = {36, 37, 38, 39},
retreat = {61, 62, 63, 64},
            death   = {26, 27, 28, 29},
            victory = {6, 7, 8, 9}
        },
        facing = "down",
        controller =
        {
            "wait",
            "move",
            "cs_run_anim",
            "cs_hurt",
            "cs_move",
            "cs_standby",
        },
        state = "wait",
    },
    thief =
    {
        entity = "thief",
        actorId = "thief",
        combatEntity = "combat_thief",
        anims =
        {
            up      = {33, 34, 35, 36},
            right   = {37, 38, 39, 40},
            down    = {41, 42, 43, 44},
            left    = {45, 46, 47, 48},
            prone   = {9, 10},
            attack  = {1, 2, 3, 4, 5, 6, 7, 8},
            use     = {11, 12, 13, 14, 15, 16, 17, 18, 19, 20},
            hurt    = {21, 22, 23, 24, 25, 33, 34},
            standby = {36, 37, 38, 39},
            advance = {36, 37, 38, 39},
retreat = {61, 62, 63, 64},
            death   = {26, 27, 28, 29, 30, 31, 32},
            victory = {56, 57, 58, 59, 60, 40},
        },
        facing = "down",
        controller =
        {
            "npc_stand",
            "cs_run_anim",
            "cs_hurt",
            "cs_move",
            "cs_standby",
        },
        state = "npc_stand",
    },
    mage =
    {
        entity = "mage",
        actorId = "mage",
        combatEntity = "combat_mage",
        anims =
        {
            up      = {17, 18, 19, 20},
            right   = {21, 22, 23, 24},
            down    = {25, 26, 27, 28},
            left    = {29, 30, 31, 32},
            prone   = {51, 52},
            attack  = {1, 2, 3, 4, 5, 6, 7},
            use     = {41, 42, 43, 44, 45, 46, 47, 48},
            hurt    = {8, 9, 10, 21, 22, 23},
            standby = {36, 37, 38, 39},
            advance = {36, 37, 38, 39},
retreat = {61, 62, 63, 64},
            death   = {26, 27, 28, 29, 30, 31, 32, 33, 34},
            victory = {56, 57, 58, 59, 60, 53, 54, 55, 49, 50, 40, 35},
        },
        facing = "down",
        controller =
        {
            "npc_stand",
            "cs_run_anim",
            "cs_hurt",
            "cs_move",
            "cs_standby",
        },
        state = "npc_stand",
    },
    goblin =
    {
        entity = "goblin",
        controller =
        {
            "cs_run_anim",
            "cs_standby",
            "cs_die_enemy",
            "cs_hurt_enemy"
        },
        state = "cs_standby",
    }
}