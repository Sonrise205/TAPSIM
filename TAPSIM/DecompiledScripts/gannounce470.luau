return {
    Name = "gannounce", 
    Aliases = {
        "globalannounce", 
        "gmessage"
    }, 
    Description = "Sends a global announcement to all players.", 
    Group = "Admin", 
    Args = {
        {
            Type = "string", 
            Name = "Message", 
            Description = "The message to send"
        }, 
        {
            Type = "number", 
            Name = "Duration", 
            Description = "How long the message should display (seconds)", 
            Optional = true, 
            Default = 5
        }
    }
};