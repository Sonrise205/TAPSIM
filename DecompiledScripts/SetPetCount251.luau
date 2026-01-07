return {
    Name = "setpetcount", 
    Aliases = {
        "spc", 
        "setpetexists"
    }, 
    Description = "Manually set the global pet existence count for a specific pet and tier.", 
    Group = "Admin", 
    Args = {
        {
            Type = "string", 
            Name = "petName", 
            Description = "The name of the pet (e.g. Puppy, Lion God)."
        }, 
        {
            Type = "string", 
            Name = "tier", 
            Description = "The tier of the pet (Normal, Golden, Diamond, Rainbow, Galaxy)."
        }, 
        {
            Type = "integer", 
            Name = "count", 
            Description = "The new count to set."
        }
    }
};