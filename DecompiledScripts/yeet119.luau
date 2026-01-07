return {
    Name = "yeet", 
    Aliases = {
        "yeetplayers", 
        "launch"
    }, 
    Description = "Yeets all players into the air.", 
    Group = "Admin", 
    Args = {
        {
            Type = "boolean", 
            Name = "Enabled", 
            Description = "true to yeet players", 
            Default = true
        }
    }
};