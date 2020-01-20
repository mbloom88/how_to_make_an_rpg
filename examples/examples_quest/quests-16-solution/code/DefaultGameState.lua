function GetDefaultGameState()
    return
    {
        defeated_cave_drake = false,
        maps =
        {
            town = {},
            world = {},
            cave =
            {
                completed_puzzle = false,
                chests_looted = {}
            }
        }
    }
end