return {
    FREE_SPIN_INTERVAL = 9000, 
    Rewards = {
        {
            Type = "Currency", 
            Name = "Gems", 
            Amount = 5000000, 
            Weight = 25, 
            Display = "5M+ Gems"
        }, 
        {
            Type = "Currency", 
            Name = "Gems", 
            Amount = 70000000, 
            Weight = 20, 
            Display = "70M+ Gems"
        }, 
        {
            Type = "Currency", 
            Name = "Gems", 
            Amount = 140000000, 
            Weight = 15, 
            Display = "140M+ Gems"
        }, 
        {
            Type = "Boost", 
            Name = "Festive Rebirths I", 
            Amount = 1, 
            Duration = 4, 
            Weight = 18, 
            Display = "Festive Rebirths I"
        }, 
        {
            Type = "Boost", 
            Name = "Festive Luck I", 
            Amount = 1, 
            Duration = 5, 
            Weight = 12, 
            Display = "Festive Luck I"
        }, 
        {
            Type = "Boost", 
            Name = "Festive Tap I", 
            Amount = 1, 
            Duration = 5, 
            Weight = 5, 
            Display = "Festive Tap I"
        }, 
        {
            Type = "Boost", 
            Name = "Octo Incubator", 
            Amount = 1, 
            Duration = 15, 
            Weight = 4.9, 
            Display = "Octo Incubator"
        }, 
        {
            Type = "Pet", 
            Name = "Hooded Krampus", 
            Tier = "Normal", 
            Amount = 1, 
            Weight = 0.1, 
            Display = "Hooded Krampus"
        }
    }, 
    GetTotalWeight = function(v0) --[[ Line: 28 ]] --[[ Name: GetTotalWeight ]]
        local v1 = 0;
        for _, v3 in ipairs(v0.Rewards) do
            v1 = v1 + v3.Weight;
        end;
        return v1;
    end, 
    Roll = function(v4) --[[ Line: 37 ]] --[[ Name: Roll ]]
        local l_v4_TotalWeight_0 = v4:GetTotalWeight();
        local v6 = 0;
        local v7 = Random.new():NextNumber(0, l_v4_TotalWeight_0);
        for v8, v9 in ipairs(v4.Rewards) do
            v6 = v6 + v9.Weight;
            if v7 <= v6 then
                return v8;
            end;
        end;
        return 1;
    end, 
    GetReward = function(v10, v11) --[[ Line: 53 ]] --[[ Name: GetReward ]]
        return v10.Rewards[v11];
    end, 
    GetAllRewards = function(v12) --[[ Line: 58 ]] --[[ Name: GetAllRewards ]]
        return v12.Rewards;
    end, 
    GetChance = function(v13, v14) --[[ Line: 63 ]] --[[ Name: GetChance ]]
        local v15 = v13.Rewards[v14];
        if not v15 then
            return 0;
        else
            local l_v13_TotalWeight_0 = v13:GetTotalWeight();
            return v15.Weight / l_v13_TotalWeight_0 * 100;
        end;
    end
};