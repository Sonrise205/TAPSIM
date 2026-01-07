return {
    Name = "shrink", 
    Aliases = {
        "shrinkplayers", 
        "small"
    }, 
    Description = "Shrinks all players to 0.5x size.", 
    Group = "Admin", 
    Args = {
        {
            Type = "boolean", 
            Name = "Enabled", 
            Description = "true to shrink, false to restore", 
            Default = true
        }
    }
};