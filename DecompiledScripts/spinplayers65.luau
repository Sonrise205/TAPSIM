return {
    Name = "spinplayers", 
    Aliases = {
        "spin", 
        "rotate"
    }, 
    Description = "Makes all players spin.", 
    Group = "Admin", 
    Args = {
        {
            Type = "boolean", 
            Name = "Enabled", 
            Description = "true to enable spinning, false to disable", 
            Default = true
        }
    }
};