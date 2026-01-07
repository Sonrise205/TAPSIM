return {
    Name = "testhatch", 
    Aliases = {
        "hatchtest", 
        "previewhatch"
    }, 
    Description = "Preview the hatch animation for a given rarity and amount.", 
    Group = "Testing", 
    Args = {
        {
            Type = "string", 
            Name = "rarity", 
            Description = "Pet rarity to preview (e.g., Legendary, Mythical)."
        }, 
        {
            Type = "integer", 
            Name = "amount", 
            Description = "How many pets to preview (1-8).", 
            Optional = true, 
            Default = 1
        }
    }
};