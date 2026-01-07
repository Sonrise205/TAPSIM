return {
    Name = "grow", 
    Aliases = {
        "growplayers", 
        "big"
    }, 
    Description = "Grows all players to 2x size.", 
    Group = "Admin", 
    Args = {
        {
            Type = "boolean", 
            Name = "Enabled", 
            Description = "true to grow, false to restore", 
            Default = true
        }
    }
};