return {
    Name = "giveallquests", 
    Aliases = {
        "gaq", 
        "allquests"
    }, 
    Description = "Give all quests to a player.", 
    Group = "Admin", 
    Args = {
        {
            Type = "player", 
            Name = "Player", 
            Description = "The player to give all quests to"
        }, 
        {
            Type = "number", 
            Name = "Progress", 
            Description = "Starting progress for all quests (default: 0)", 
            Optional = true, 
            Default = 0
        }
    }
};