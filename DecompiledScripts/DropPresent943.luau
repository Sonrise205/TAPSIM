return {
    Name = "droppresent", 
    Aliases = {
        "spawnpresent", 
        "present"
    }, 
    Description = "Drops a present from the sky near a player with random X, Z offset.", 
    Group = "Admin", 
    Args = {
        {
            Type = "player", 
            Name = "target", 
            Description = "The player to drop the present near (defaults to yourself).", 
            Optional = true
        }, 
        {
            Type = "number", 
            Name = "gemReward", 
            Description = "Amount of gems the present gives (optional, default random 50-200).", 
            Optional = true
        }, 
        {
            Type = "number", 
            Name = "radius", 
            Description = "Random spawn radius around the player (optional, default 20 studs).", 
            Optional = true, 
            Default = 20
        }
    }
};