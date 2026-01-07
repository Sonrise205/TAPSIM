return {
    Name = "resettimers", 
    Aliases = {
        "rt", 
        "resetpotiontimers"
    }, 
    Description = "Reset all PotionMachine timers for a player.", 
    Group = "Admin", 
    Args = {
        {
            Type = "player", 
            Name = "Player", 
            Description = "The player to reset timers for"
        }
    }
};