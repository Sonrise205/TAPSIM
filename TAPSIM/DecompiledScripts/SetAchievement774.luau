return {
    Name = "setachievement", 
    Aliases = {
        "setach", 
        "achievement"
    }, 
    Description = "Set your achievement progress for a specific category to test rewards.", 
    Group = "Admin", 
    Args = {
        {
            Type = "string", 
            Name = "category", 
            Description = "Achievement category (Clicking, Eggs, Mythics, Collection, GoldenCrafts, QuestBadges, Rebirths, PetTrainer)."
        }, 
        {
            Type = "integer", 
            Name = "tierIndex", 
            Description = "The tier index to set (1, 2, 3, etc.). Use 0 to reset."
        }, 
        {
            Type = "integer", 
            Name = "amount", 
            Description = "Amount of progress within the current tier (optional, defaults to 0).", 
            Optional = true
        }
    }
};