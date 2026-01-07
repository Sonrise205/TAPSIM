return {
    Name = "droppresentsall", 
    Aliases = {
        "dpa", 
        "globalpresents", 
        "presentstorm"
    }, 
    Description = "Drops presents near ALL players across ALL servers.", 
    Group = "Admin", 
    Args = {
        {
            Type = "string", 
            Name = "rewardType", 
            Description = "Type of reward: gems, clicks, or random", 
            Optional = true, 
            Default = "random"
        }, 
        {
            Type = "number", 
            Name = "amount", 
            Description = "Amount of reward (for gems/clicks)", 
            Optional = true
        }, 
        {
            Type = "number", 
            Name = "presentsPerPlayer", 
            Description = "Number of presents per player (default 1)", 
            Optional = true, 
            Default = 1
        }, 
        {
            Type = "number", 
            Name = "radius", 
            Description = "Spawn radius around each player (default 30)", 
            Optional = true, 
            Default = 30
        }
    }
};