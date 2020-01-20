gEnemyDefs =
{
    goblin =
    {
        id = "goblin",
        stats =
        {
            ["hp_now"] = 100,
            ["hp_max"] = 100,
            ["mp_now"] = 0,
            ["mp_max"] = 0,
            ["strength"] = 15,
            ["speed"] = 6,
            ["intelligence"] = 2,
            ["counter"] = 0,
        },
        name = "Arena Goblin",
        actions = { "attack" },
        steal_item =  10,
        drop =
        {
            xp = 150,
            gold = {5, 15},
            always = nil,
            chance =
            {
                { oddment = 1, item = { id = -1 } },
                { oddment = 3, item = { id = 10 } }
            }
        }
    }
}