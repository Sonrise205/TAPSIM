return {
    Name = "kick", 
    Aliases = {
        "boot"
    }, 
    Description = "Kicks a player from all servers using MessagingService.", 
    Group = "Admin", 
    Args = {
        {
            Type = "string", 
            Name = "username", 
            Description = "The username of the player to kick."
        }, 
        {
            Type = "string", 
            Name = "reason", 
            Description = "The reason for kicking the player (optional).", 
            Optional = true, 
            Default = "You have been kicked from the game."
        }
    }
};