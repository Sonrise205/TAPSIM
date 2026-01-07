return {
    Name = "lowgrav", 
    Aliases = {
        "lowgravity", 
        "gravity"
    }, 
    Description = "Sets low gravity for all players.", 
    Group = "Admin", 
    Args = {
        {
            Type = "number", 
            Name = "Duration", 
            Description = "How long low gravity should last (seconds)", 
            Default = 30
        }
    }
};