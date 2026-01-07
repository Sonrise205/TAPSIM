return {
    Name = "speedup", 
    Aliases = {
        "walkspeed", 
        "speed"
    }, 
    Description = "Sets the walkspeed for all players.", 
    Group = "Admin", 
    Args = {
        {
            Type = "number", 
            Name = "Speed", 
            Description = "Walkspeed value (0 to reset to default)", 
            Default = 32
        }
    }
};