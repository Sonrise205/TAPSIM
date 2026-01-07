return {
    Name = "changemap", 
    Aliases = {
        "setmap", 
        "mapvariant", 
        "wintermap"
    }, 
    Description = "Changes the spawn island map variant across all servers in real-time (e.g., winter, default).", 
    Group = "Admin", 
    Args = {
        {
            Type = "string", 
            Name = "Variant", 
            Description = "The map variant to switch to (see MapVariants config for available variants)"
        }
    }
};