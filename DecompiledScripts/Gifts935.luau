return {
    Rewards = {
        {
            Type = "Boost", 
            Name = "Festive Rebirths I", 
            Amount = 1, 
            Weight = 18.37
        }, 
        {
            Type = "Boost", 
            Name = "Festive Luck I", 
            Amount = 1, 
            Weight = 12.25
        }, 
        {
            Type = "Boost", 
            Name = "Festive Tap I", 
            Amount = 1, 
            Weight = 5.1
        }, 
        {
            Type = "Boost", 
            Name = "Octo Incubator", 
            Amount = 1, 
            Weight = 5
        }, 
        {
            Type = "Item", 
            Name = "ChristmasSpins", 
            Amount = 5, 
            Weight = 10.2
        }, 
        {
            Type = "Item", 
            Name = "EnchantCrystal", 
            Amount = 50, 
            Weight = 10.2
        }, 
        {
            Type = "Item", 
            Name = "New Years Gift", 
            Amount = 1, 
            Weight = 10.2
        }, 
        {
            Type = "Item", 
            Name = "Tokens", 
            Amount = 15, 
            Weight = 10.2
        }, 
        {
            Type = "Pet", 
            Name = "Disco Lord", 
            Tier = "Normal", 
            Amount = 1, 
            Weight = 0.01
        }
    }, 
    GetTotalWeight = function(v0) --[[ Line: 26 ]] --[[ Name: GetTotalWeight ]]
        local v1 = 0;
        for _, v3 in ipairs(v0.Rewards) do
            v1 = v1 + v3.Weight;
        end;
        return v1;
    end, 
    Roll = function(v4) --[[ Line: 35 ]] --[[ Name: Roll ]]
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
    GetReward = function(v10, v11) --[[ Line: 51 ]] --[[ Name: GetReward ]]
        return v10.Rewards[v11];
    end, 
    GetAllRewards = function(v12) --[[ Line: 56 ]] --[[ Name: GetAllRewards ]]
        return v12.Rewards;
    end, 
    GetChance = function(v13, v14) --[[ Line: 61 ]] --[[ Name: GetChance ]]
        local v15 = v13.Rewards[v14];
        if not v15 then
            return 0;
        else
            local l_v13_TotalWeight_0 = v13:GetTotalWeight();
            return v15.Weight / l_v13_TotalWeight_0 * 100;
        end;
    end
};