gPartyMemberDefs =
{
    hero =
    {

        id = "hero",
        stats =
        {
            ["hp_now"] = 3,
            ["hp_max"] = 3,
            ["mp_now"] = 300,
            ["mp_max"] = 300,
            ["strength"] = 10,
            ["speed"] = 10,
            ["intelligence"] = 10,
        },
        statGrowth =
        {
            ["hp_max"] = Dice:Create("4d50+100"),
            ["mp_max"] = Dice:Create("2d50+100"),
            ["strength"] = gStatGrowth.fast,
            ["speed"] = gStatGrowth.fast,
            ["intelligence"] = gStatGrowth.med,
        },
        portrait = "hero_portrait.png",
        name = "Seven",
        actions = { "attack", "item" }
    },
    thief =
    {

        id = "thief",
        stats =
        {
            ["hp_now"] = 280,
            ["hp_max"] = 280,
            ["mp_now"] = 150,
            ["mp_max"] = 150,
            ["strength"] = 10,
            ["speed"] = 15,
            ["intelligence"] = 10,
        },
        statGrowth =
        {
            ["hp_max"] = Dice:Create("3d40+100"),
            ["mp_max"] = Dice:Create("4d50+100"),
            ["strength"] = gStatGrowth.med,
            ["speed"] = gStatGrowth.med,
            ["intelligence"] = gStatGrowth.fast,
        },
        portrait = "thief_portrait.png",
        name = "Jude",
        actions = { "attack", "item"}
    },
    mage =
    {

        id = "mage",
        stats =
        {
            ["hp_now"] = 200,
            ["hp_max"] = 200,
            ["mp_now"] = 250,
            ["mp_max"] = 250,
            ["strength"] = 8,
            ["speed"] = 10,
            ["intelligence"] = 20,
        },
        statGrowth =
        {
            ["hp_max"] = Dice:Create("3d40+100"),
            ["mp_max"] = Dice:Create("4d50+100"),
            ["strength"] = gStatGrowth.med,
            ["speed"] = gStatGrowth.med,
            ["intelligence"] = gStatGrowth.fast,
        },
        portrait = "mage_portrait.png",
        name = "Ermis",
        actions = { "attack", "item"}
    },
}