return {
    Name = "luckboost", 
    Aliases = {
        "globalluck", 
        "10xluck"
    }, 
    Description = "Activates a global luck boost across ALL servers.", 
    Group = "Admin", 
    Args = {
        {
            Type = "number", 
            Name = "multiplier", 
            Description = "Luck multiplier (default 10)", 
            Optional = true, 
            Default = 10
        }, 
        {
            Type = "number", 
            Name = "duration", 
            Description = "Duration in minutes (default 5)", 
            Optional = true, 
            Default = 5
        }
    }
};