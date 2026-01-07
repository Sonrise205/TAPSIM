return {
    Config = {
        PackId = "ChristmasDayBundle", 
        ProductId = 12345678, 
        Price = 99, 
        StartTime = 1703462400, 
        Duration = 259200, 
        MaxPurchases = 3, 
        SecretRewardPurchaseAmount = 2, 
        Rewards = {
            {
                Type = "Currency", 
                Name = "Tokens", 
                Amount = 500
            }, 
            {
                Type = "Pet", 
                PetId = "Christmas Dog", 
                Amount = 1, 
                Tier = "Rainbow"
            }
        }, 
        SecretReward = {
            Type = "Pet", 
            PetId = "Secret Santa", 
            Amount = 1, 
            Tier = "Shiny"
        }
    }
};