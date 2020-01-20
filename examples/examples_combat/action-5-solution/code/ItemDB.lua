ItemDB =
{
    [-1] =
    {
        name = "",
        type = "",
        icon = nil,
        restriction = nil,
        description = "",
        stats =
        {
        },
        use = nil,
        use_restriction = nil,
    },
    {
        name = "Bone Blade",
        type = "weapon",
        icon = "sword",
        restriction = {"hero"},
        description = "A wicked sword made from bone.",
        stats = { add = { attack = 5 } }
    },
    {
        name = "Bone Armor",
        type = "armor",
        icon = "plate",
        restriction = {"hero"},
        description = "Armor made from plates of blackened bone.",
        stats =
        {
            add =
            {
                defense = 5,
                resist = 1,
            }
        }
    },
    {
        name = "Ring of Titan",
        type = "accessory",
        description = "Grants the strength of the Titan.",
        stats = { add = { strength = 10 } }
    },
    {
        name = "World Tree Branch",
        type = "weapon",
        icon = "stave",
        restriction = {"mage"},
        description = "A hard wood branch.",
        stats =
        {
            add =
            {
                attack = 2,
                magic = 5
            }
        }
    },
    {
        name = "Dragon's Cloak",
        type = "armor",
        icon = "robe",
        restriction = {"mage"},
        description = "A cloak of dragon scales.",
        stats =
        {
            add =
            {
                defense = 3,
                resist = 10,
            }
        }
    },
    {
        name = "Singer's Stone",
        type = "accessory",
        description = "The stone's song resists magical attacks.",
        stats = { add = { resist = 10 } }
    },
    {
        name = "Black Dagger",
        type = "weapon",
        icon = "dagger",
        restriction = {"thief"},
        description = "A dagger made out of an unknown material.",
        stats = { add = { attack = 4 } }
    },
    {
        name = "Footpad Leathers",
        type = "armor",
        icon = "leather",
        restriction = {"thief"},
        description = "Light armor for silent movement.",
        stats = { add = { defense = 3 } },
    },
    {
        name = "Swift Boots",
        type = "accessory",
        description = "Increases speed by 25%",
        stats = { mult = { speed = 0.25 } },
    },
}

EmptyItem = ItemDB[-1]

-- Give all items an id based on their position
-- in the list.
for id, def in pairs(ItemDB) do
    def.id = id
end