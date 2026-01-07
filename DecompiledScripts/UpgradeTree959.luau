return {
    Skins = {
        Default = {
            Cost = 0, 
            Description = "The default skin"
        }, 
        Silver = {
            Cost = 10000, 
            Multiplier = 2, 
            Description = "A silver skin", 
            RequiredUpgrades = {
                Default = true
            }
        }, 
        Gold = {
            Cost = 1000000, 
            Multiplier = 4, 
            Description = "A gold skin", 
            RequiredUpgrades = {
                Silver = true
            }
        }
    }
};