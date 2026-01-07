return {
    Name = "giveallitems", 
    Aliases = {
        "gai", 
        "allitems"
    }, 
    Description = "Give every defined item and boost to a player.", 
    Group = "Admin", 
    Args = {
        {
            Type = "player", 
            Name = "Player", 
            Description = "Player who should receive every item and boost"
        }, 
        {
            Type = "number", 
            Name = "Amount", 
            Description = "Amount to give for each item and boost (default: 1)", 
            Optional = true, 
            Default = 1
        }
    }
};