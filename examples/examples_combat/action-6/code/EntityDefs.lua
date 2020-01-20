
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
}

gEntities =
{
    hero =
    {
        texture = "hero.png",
        width = 16,
        height = 18,
        startFrame = 23,
        tileX = 11,
        tileY = 3,
        layer = 1
    },
    thief =
    {
        texture = "thief.png",
        width = 16,
        height = 18,
        startFrame = 23,
        tileX = 11,
        tileY = 3,
        layer = 1
    },
    mage =
    {
        texture = "mage.png",
        width = 16,
        height = 18,
        startFrame = 23,
        tileX = 11,
        tileY = 3,
        layer = 1
    },
    grunt =
    {
        texture = "enemy.png",
        startFrame = 1,
        width = 24,
        height = 32,
    },
    chest =
    {
        texture = "chest.png",
        width = 16,
        height = 16,
        startFrame = 1,
        openFrame = 2
    }
}

local standard_anims =
{
    left = {28, 29, 30},
    up = {1, 2, 3},
    right = {10, 11, 12},
    down = {19, 20, 21},
    prone =
    {
        left = {28},
        right = {10},
    },
    attack =
    {
        left = {28, 29, 31, 30},
        right = {11, 12, 13, 14},
    },
    use =
    {
        left = {30, 28, 32, 33, 34},
        right = {14, 15, 16, 17, 18}
    },
    hurt =
    {
        left = {35, 32},
        right = {15, 18}
    },
    standby =
    {
        left = {28, 29, 30},
        right = {10, 11, 12},
    },
    death =
    {
        left = {37},
        right = {38}
    },
    victory = {16, 17, 32, 26},
}

gCharacters =
{
    hero =
    {
        entity = "hero",
        actorId = "hero",
        anims = standard_anims,
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
        anims = standard_anims,
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
        anims = standard_anims,
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
    grunt =
    {
        entity = "grunt",
        controller =
        {
            "cs_run_anim",
            "cs_hurt",
            "cs_standby",
            "cs_die_enemy",
        },
        state = "cs_standby",
    }
}