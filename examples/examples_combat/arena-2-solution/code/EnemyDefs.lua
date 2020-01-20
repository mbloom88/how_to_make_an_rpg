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
    },
    ogre =
    {
        id = "ogre",
        stats =
        {
            ["hp_now"] = 150,
            ["hp_max"] = 150,
            ["mp_now"] = 0,
            ["mp_max"] = 0,
            ["strength"] = 25,
            ["speed"] = 2,
            ["intelligence"] = 1,
            ["counter"] = 0,
        },
        name = "Ogre",
        actions = { "attack" },
        steal_item =  12,
        drop =
        {
            xp = 200,
            gold = {40, 50},
            always = nil,
            chance =
            {
                { oddment = 1, item = { id = -1 } },
                { oddment = 3, item = { id = 10 } }
            }
        }
    },
    dragon =
    {
        id = "dragon",
        stats =
        {
            ["hp_now"] = 200,
            ["hp_max"] = 200,
            ["mp_now"] = 0,
            ["mp_max"] = 0,
            ["strength"] = 35,
            ["speed"] = 6,
            ["intelligence"] = 20,
            ["counter"] = 0.1,
        },
        name = "Green Dragon",
        actions = { "attack" },
        steal_item =  11,
        drop =
        {
            xp = 350,
            gold = {250, 300},
            always = nil,
            chance =
            {
                { oddment = 1, item = { id = -1 } },
                { oddment = 3, item = { id = 10 } }
            }
        }
    }
}