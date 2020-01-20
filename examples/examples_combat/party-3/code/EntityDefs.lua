
-- WaitState, MoveState must already be loaded.
assert(WaitState)
assert(MoveState)

gCharacterStates =
{
    wait = WaitState,
    move = MoveState,
    npc_stand = NPCStandState,
    plan_stroll = PlanStrollState,
    follow_path = FollowPathState
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
}

gCharacters =
{
    hero =
    {
        actorId = "hero",
        entity = "hero",
        anims =
        {
            up = {1, 2, 3, 4},
            right = {5, 6, 7, 8},
            down = {9, 10, 11, 12},
            left = {13, 14, 15, 16},
        },
        facing = "down",
        controller = { "wait", "move" },
        state = "wait",
    },
    thief =
    {
        actorId = "thief",
        entity = "thief",
        anims =
        {
            up = {33, 34, 35, 36},
            right = {37, 38, 39, 40},
            down = {41, 42, 43, 44},
            left = {45, 46, 47, 48},
        },
        facing = "down",
        controller = { "wait", "move" },
        state = "wait",
    },
    mage =
    {
        actorId = "mage",
        entity = "mage",
        anims =
        {
            up = {17, 18, 19, 20},
            right = {21, 22, 23, 24},
            down = {25, 26, 27, 28},
            left = {29, 30, 31, 32},
        },
        facing = "down",
        controller = { "wait", "move" },
        state = "wait",
    }
}