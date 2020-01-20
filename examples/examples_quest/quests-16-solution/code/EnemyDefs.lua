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
    goblin_field =
    {
        id = "goblin_field",
        stats =
        {
            ["hp_now"] = 75,
            ["hp_max"] = 75,
            ["mp_now"] = 0,
            ["mp_max"] = 0,
            ["strength"] = 12,
            ["speed"] = 8,
            ["intelligence"] = 8,
            ["counter"] = 0,
        },
        name = "Field Goblin",
        actions = { "attack" },
        steal_item =  10,
        drop =
        {
            xp = 50,
            gold = {5, 15},
            always = nil,
            chance =
            {
                { oddment = 1, item = { id = -1 } },
                { oddment = 3, item = { id = 10 } }
            }
        }
    },
    goblin_forest =
    {
        id = "goblin_forest",
        stats =
        {
            ["hp_now"] = 100,
            ["hp_max"] = 100,
            ["mp_now"] = 0,
            ["mp_max"] = 0,
            ["strength"] = 11,
            ["speed"] = 9,
            ["intelligence"] = 9,
            ["counter"] = 0,
        },
        name = "Forest Goblin",
        actions = { "attack" },
        steal_item =  10,
        drop =
        {
            xp = 75,
            gold = {15, 20},
            always = nil,
            chance =
            {
                { oddment = 1, item = { id = -1 } },
                { oddment = 1, item = { id = 10 } }
            }
        }
    },
    cave_drake =
    {
        id = "cave_drake",
        stats =
        {
            ["hp_now"] = 1,
            ["hp_max"] = 1,
            ["mp_now"] = 0,
            ["mp_max"] = 0,
            ["strength"] = 20,
            ["speed"] = 13,
            ["intelligence"] = 20,
            ["counter"] = 0,
        },
        name = "Cave Drake",
        actions = { "attack" },
        steal_item =  10,
        drop =
        {
            xp = 750,
            gold = {15, 20},
            always = nil,
            chance =
            {
                { oddment = 1, item = { id = -1 } },
                { oddment = 1, item = { id = 10 } }
            }
        }
    },
    cave_bat =
    {
        id = "cave_bat",
        stats =
        {
            ["hp_now"] = 100,
            ["hp_max"] = 100,
            ["strength"] = 9,
            ["speed"] = 16,
            ["intelligence"] = 3,
        },
        name = "Bat",
        actions = { "attack" },
        drop = { xp = 50 }
    },
    cave_shade =
    {
        id = "cave_shade",
        stats =
        {
            ["hp_now"] = 200,
            ["hp_max"] = 200,
            ["strength"] = 20,
            ["speed"] = 5,
            ["intelligence"] = 5,
        },
        name = "Shade",
        actions = { "attack" },
        drop =
        {
            xp = 100,
            gold = {5, 50},
            chance =
             {
                { oddment = 3, item = { id = -1 } },
                { oddment = 1, item = { id = 12 } }
            }
        }
    }
}