ItemDB =
{
    [-1] =
    {
        name = "",
        description = "",
        special = "",
        stats =
        {
            strength = 0,
            speed = 0,
            intelligence = 0,
            attack = 0,
            defense = 0,
            magic = 0,
            resist = 0
        }
    },
    {
        name = "Mysterious Torque",
        type = "accessory",
        description = "A golden torque that glitters.",
        stats =
        {
            strength = 10,
            speed = 10
        }
    },
    {
        name = "Heal Potion",
        type = "useable",
        description = "Heals a little HP."
    },
    {
        name = "Bronze Sword",
        type = "weapon",
        description = "A short sword with dull blade.",
        stats =
        {
            attack = 10
        }
    },
    {
        name = "Old bone",
        type = "key",
        description = "A calcified human femur"
    },
}

EmptyItem = ItemDB[-1]


-- Give all items an id based on their position
-- in the list.
for id, def in pairs(ItemDB) do
    def.id = id
end
