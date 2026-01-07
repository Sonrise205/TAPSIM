return {
    Name = "incachievement", 
    Aliases = {
        "incach", 
        "addachievement"
    }, 
    Description = "Increment achievement progress to trigger tier completion and rewards.", 
    Group = "Admin", 
    Args = {
        {
            Type = "string", 
            Name = "category", 
            Description = "Achievement category (Clicking, Eggs, Mythics, Collection, GoldenCrafts, QuestBadges, Rebirths, PetTrainer)."
        }, 
        {
            Type = "integer", 
            Name = "amount", 
            Description = "Amount to increment by (use large numbers to skip tiers)."
        }
    }
};