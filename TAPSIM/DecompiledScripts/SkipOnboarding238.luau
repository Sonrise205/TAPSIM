return {
    Name = "skiponboarding", 
    Aliases = {
        "skip", 
        "skipintro", 
        "completeonboarding"
    }, 
    Description = "Skip/complete the onboarding tutorial for a player.", 
    Group = "Admin", 
    Args = {
        {
            Type = "player", 
            Name = "Player", 
            Description = "The player to skip onboarding for"
        }
    }
};