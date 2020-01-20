gEnemyDefs =
{
    goblin =
    {
        id = "goblin",
        stats =
        {
            ["hp_now"] = 30,
            ["hp_max"] = 30,
            ["mp_now"] = 0,
            ["mp_max"] = 0,
            ["strength"] = 8,
            ["speed"] = 5,
            ["intelligence"] = 2,
            ["counter"] = 0.5,
        },
        name = "Arena Goblin",
        actions = { "attack" },
        steal_item =  10,
        drop =
        {
            xp = 5,
            gold = {0, 5},
            always = {11},
            chance =
            {
                { oddment = 1, item = { id = -1 } },
                { oddment = 3, item = { id = 10 } }
            }
        }
    }
}