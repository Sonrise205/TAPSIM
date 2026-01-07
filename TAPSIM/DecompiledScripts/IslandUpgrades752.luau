local v4 = {
    IslandBoost = {
        Title = "Island Boost", 
        Description = "Increases your click multiplier while on this island", 
        Total = 10, 
        BasePrice = 500, 
        PriceFunction = function(v0) --[[ Line: 17 ]] --[[ Name: PriceFunction ]]
            return v0 ^ 2;
        end, 
        BonusPerLevel = 0.1, 
        GetMultiplier = function(v1) --[[ Line: 25 ]] --[[ Name: GetMultiplier ]]
            return 1 + v1 * 0.1;
        end, 
        Image = "rbxassetid://80544974840973", 
        Color = Color3.fromRGB(0, 200, 100)
    }, 
    IslandLuck = {
        Title = "Island Luck", 
        Description = "Increases your hatching luck while on this island", 
        Total = 10, 
        BasePrice = 750, 
        PriceFunction = function(v2) --[[ Line: 46 ]] --[[ Name: PriceFunction ]]
            return v2 ^ 2;
        end, 
        BonusPerLevel = 0.1, 
        GetMultiplier = function(v3) --[[ Line: 54 ]] --[[ Name: GetMultiplier ]]
            return 1 + v3 * 0.1;
        end, 
        Image = "rbxassetid://99783720056712", 
        Color = Color3.fromRGB(180, 100, 255)
    }, 
    GoldenMachine = {
        Title = "Spawn Golden Machine", 
        Description = "Spawns a Golden Machine that converts normal pets into golden pets", 
        IsCooldownUpgrade = true, 
        Total = 1, 
        BasePrice = 5000, 
        SpawnDuration = 900, 
        Image = "rbxassetid://77603427436693", 
        Color = Color3.fromRGB(255, 200, 0), 
        ModelPath = "ServerStorage.Assets.Meepo"
    }, 
    RainbowMachine = {
        Title = "Spawn Rainbow Machine", 
        Description = "Spawns a Rainbow Machine that converts golden pets into rainbow pets", 
        IsCooldownUpgrade = true, 
        Total = 1, 
        BasePrice = 10000, 
        SpawnDuration = 1800, 
        Image = "rbxassetid://96461894553728", 
        Color = Color3.fromRGB(255, 100, 255), 
        ModelPath = "ServerStorage.Assets.Deemo"
    }, 
    GoldenMachineSpawns = {
        Spawn = CFrame.new(-1042, 28, 520) * CFrame.Angles(0, 0, 0), 
        Forest = CFrame.new(-500, 30, 200) * CFrame.Angles(0, 0, 0), 
        Winter = CFrame.new(-300, 35, 400) * CFrame.Angles(0, 0, 0), 
        Desert = CFrame.new(-200, 32, 300) * CFrame.Angles(0, 0, 0), 
        Jungle = CFrame.new(-400, 30, 500) * CFrame.Angles(0, 0, 0), 
        Heaven = CFrame.new(-350, 40, 350) * CFrame.Angles(0, 0, 0), 
        Dojo = CFrame.new(-450, 28, 450) * CFrame.Angles(0, 0, 0), 
        Volcano = CFrame.new(-380, 35, 380) * CFrame.Angles(0, 0, 0), 
        Candy = CFrame.new(-93.7286224, 10637.7705, 291.926453, -0.993599594, 5.75472601E-4, 0.112958118, -2.86622264E-4, 0.999970973, -0.00761559838, -0.112959221, -0.00759923179, -0.993570566), 
        Atlantis = CFrame.new(-360, 25, 360) * CFrame.Angles(0, 0, 0)
    }, 
    RainbowMachineSpawns = {
        Spawn = CFrame.new(-1050, 28, 530) * CFrame.Angles(0, 0, 0), 
        Forest = CFrame.new(-510, 30, 210) * CFrame.Angles(0, 0, 0), 
        Winter = CFrame.new(-310, 35, 410) * CFrame.Angles(0, 0, 0), 
        Desert = CFrame.new(-210, 32, 310) * CFrame.Angles(0, 0, 0), 
        Jungle = CFrame.new(-410, 30, 510) * CFrame.Angles(0, 0, 0), 
        Heaven = CFrame.new(-360, 40, 360) * CFrame.Angles(0, 0, 0), 
        Dojo = CFrame.new(-460, 28, 460) * CFrame.Angles(0, 0, 0), 
        Volcano = CFrame.new(-390, 35, 390) * CFrame.Angles(0, 0, 0), 
        Candy = CFrame.new(-100, 10637.7705, 300) * CFrame.Angles(0, 0, 0), 
        Atlantis = CFrame.new(-370, 25, 370) * CFrame.Angles(0, 0, 0)
    }
};
v4.GetPrice = function(v5, v6) --[[ Line: 147 ]] --[[ Name: GetPrice ]]
    -- upvalues: v4 (copy)
    local v7 = v4[v5];
    if not v7 then
        return 0;
    elseif v7.IsCooldownUpgrade then
        return v7.BasePrice or 5000;
    else
        local v8 = v7.BasePrice or 500;
        local l_PriceFunction_0 = v7.PriceFunction;
        if l_PriceFunction_0 then
            return math.round(l_PriceFunction_0(v6) * v8 / 10) * 10;
        else
            return v8 * v6;
        end;
    end;
end;
v4.IsCooldownReady = function(v10, v11) --[[ Line: 167 ]] --[[ Name: IsCooldownReady ]]
    -- upvalues: v4 (copy)
    local v12 = v4[v10];
    if not v12 or not v12.IsCooldownUpgrade then
        return true;
    elseif not v11 or v11 == 0 then
        return true;
    else
        return (v12.CooldownDuration or 900) <= os.time() - v11;
    end;
end;
v4.GetRemainingCooldown = function(v13, v14) --[[ Line: 182 ]] --[[ Name: GetRemainingCooldown ]]
    -- upvalues: v4 (copy)
    local v15 = v4[v13];
    if not v15 or not v15.IsCooldownUpgrade then
        return 0;
    elseif not v14 or v14 == 0 then
        return 0;
    else
        return (math.max(0, (v15.CooldownDuration or 900) - (os.time() - v14)));
    end;
end;
v4.FormatTime = function(v16) --[[ Line: 198 ]] --[[ Name: FormatTime ]]
    local v17 = math.floor(v16 / 3600);
    local v18 = math.floor(v16 % 3600 / 60);
    local v19 = v16 % 60;
    return string.format("%02d:%02d:%02d", v17, v18, v19);
end;
v4.GetBonusText = function(v20, v21) --[[ Line: 207 ]] --[[ Name: GetBonusText ]]
    -- upvalues: v4 (copy)
    local v22 = v4[v20];
    if not v22 then
        return "";
    else
        local v23 = v21 * (v22.BonusPerLevel or 0.1);
        local v24 = (v21 + 1) * (v22.BonusPerLevel or 0.1);
        local v25 = math.floor(v23 * 100);
        local v26 = math.floor(v24 * 100) - v25;
        if v22.Total <= v21 then
            return v25 .. "% (MAX)";
        else
            return v25 .. "% <font color=\"#00FF00\">(+" .. v26 .. "%)</font>";
        end;
    end;
end;
return v4;