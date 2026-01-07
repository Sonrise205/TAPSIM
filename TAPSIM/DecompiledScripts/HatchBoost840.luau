return {
    Name = "hatchspeedboost", 
    Aliases = {
        "globalhatch", 
        "2xhatch", 
        "hatchboost"
    }, 
    Description = "Activates a global hatch speed boost across ALL servers.", 
    Group = "Admin", 
    Args = {
        {
            Type = "number", 
            Name = "multiplier", 
            Description = "Speed multiplier (default 2)", 
            Optional = true, 
            Default = 2
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