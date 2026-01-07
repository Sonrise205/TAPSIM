return {
    Name = "resetData", 
    Aliases = {
        "wipe"
    }, 
    Description = "Resets a player's data and kicks them.", 
    Group = "Admin", 
    Args = {
        {
            Type = "player", 
            Name = "Target", 
            Description = "The player to reset. Defaults to yourself.", 
            Default = "Me"
        }
    }
};