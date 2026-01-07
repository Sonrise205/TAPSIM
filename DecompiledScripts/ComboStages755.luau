local v0 = {};
local l_script_0 = script;
v0.Stages = {
    [1] = {
        multiplier = 1.05, 
        difficulty = 0.05, 
        name = "Rookie"
    }, 
    [2] = {
        multiplier = 1.1, 
        difficulty = 0.045, 
        name = "Noob"
    }, 
    [3] = {
        multiplier = 1.15, 
        difficulty = 0.04, 
        name = "Beginner"
    }, 
    [4] = {
        multiplier = 1.2, 
        difficulty = 0.035, 
        name = "Novice"
    }, 
    [5] = {
        multiplier = 1.25, 
        difficulty = 0.03, 
        name = "Apprentice"
    }, 
    [6] = {
        multiplier = 1.3, 
        difficulty = 0.027, 
        name = "Trainee"
    }, 
    [7] = {
        multiplier = 1.35, 
        difficulty = 0.024, 
        name = "Skilled"
    }, 
    [8] = {
        multiplier = 1.4, 
        difficulty = 0.021, 
        name = "Adept"
    }, 
    [9] = {
        multiplier = 1.5, 
        difficulty = 0.018, 
        name = "Warrior"
    }, 
    [10] = {
        multiplier = 1.6, 
        difficulty = 0.015, 
        name = "Expert"
    }, 
    [11] = {
        multiplier = 1.7, 
        difficulty = 0.012, 
        name = "Veteran"
    }, 
    [12] = {
        multiplier = 1.8, 
        difficulty = 0.01, 
        name = "Powerful"
    }, 
    [13] = {
        multiplier = 1.9, 
        difficulty = 0.008, 
        name = "Champion"
    }, 
    [14] = {
        multiplier = 2, 
        difficulty = 0.0065, 
        name = "Elite"
    }, 
    [15] = {
        multiplier = 2.1, 
        difficulty = 0.005, 
        name = "Ascended"
    }, 
    [16] = {
        multiplier = 2.2, 
        difficulty = 0.004, 
        name = "Divine"
    }, 
    [17] = {
        multiplier = 2.3, 
        difficulty = 0.003, 
        name = "Mythic"
    }, 
    [18] = {
        multiplier = 2.4, 
        difficulty = 0.0025, 
        name = "Celestial"
    }, 
    [19] = {
        multiplier = 2.45, 
        difficulty = 0.002, 
        name = "Transcendent"
    }, 
    [20] = {
        multiplier = 2.5, 
        difficulty = 0.0015, 
        name = "God"
    }
};
v0.DecaySettings = {
    decayDelay = 1, 
    baseProgressDecayRate = 0.5, 
    baseStageDecayRate = 0.3, 
    difficultyDecayMultiplier = 0.7
};
v0.GetStage = function(v2, v3) --[[ Line: 44 ]] --[[ Name: GetStage ]]
    return v2.Stages[v3];
end;
v0.GetMultiplier = function(v4, v5) --[[ Line: 49 ]] --[[ Name: GetMultiplier ]]
    local l_v4_Stage_0 = v4:GetStage(v5);
    return l_v4_Stage_0 and l_v4_Stage_0.multiplier or 1;
end;
v0.GetDifficulty = function(v7, v8) --[[ Line: 55 ]] --[[ Name: GetDifficulty ]]
    local l_v7_Stage_0 = v7:GetStage(v8);
    return l_v7_Stage_0 and l_v7_Stage_0.difficulty or 0.04;
end;
v0.GetStageName = function(v10, v11) --[[ Line: 61 ]] --[[ Name: GetStageName ]]
    local l_v10_Stage_0 = v10:GetStage(v11);
    return l_v10_Stage_0 and l_v10_Stage_0.name or "No Combo";
end;
v0.GetMaxStages = function(v13) --[[ Line: 67 ]] --[[ Name: GetMaxStages ]]
    return #v13.Stages;
end;
v0.IsValidStage = function(v14, v15) --[[ Line: 72 ]] --[[ Name: IsValidStage ]]
    return v14.Stages[v15] ~= nil;
end;
v0.GetProgressDecayRate = function(v16, v17) --[[ Line: 77 ]] --[[ Name: GetProgressDecayRate ]]
    local l_v16_Stage_0 = v16:GetStage(v17);
    if not l_v16_Stage_0 then
        return v16.DecaySettings.baseProgressDecayRate;
    else
        local v19 = 0.04 / l_v16_Stage_0.difficulty * v16.DecaySettings.difficultyDecayMultiplier;
        return v16.DecaySettings.baseProgressDecayRate * v19;
    end;
end;
v0.GetStageDecayRate = function(v20, v21) --[[ Line: 90 ]] --[[ Name: GetStageDecayRate ]]
    local l_v20_Stage_0 = v20:GetStage(v21);
    if not l_v20_Stage_0 then
        return v20.DecaySettings.baseStageDecayRate;
    else
        local v23 = 0.04 / l_v20_Stage_0.difficulty * v20.DecaySettings.difficultyDecayMultiplier;
        return v20.DecaySettings.baseStageDecayRate * v23;
    end;
end;
v0.GetStageGradient = function(v24, v25) --[[ Line: 103 ]] --[[ Name: GetStageGradient ]]
    -- upvalues: l_script_0 (copy)
    local v26 = tostring(v25);
    local l_l_script_0_FirstChild_0 = l_script_0:FindFirstChild(v26);
    if l_l_script_0_FirstChild_0 and l_l_script_0_FirstChild_0:IsA("UIGradient") then
        return l_l_script_0_FirstChild_0:Clone();
    else
        local l_v24_Stage_0 = v24:GetStage(v25);
        if l_v24_Stage_0 then
            local v29 = l_script_0:FindFirstChild(l_v24_Stage_0.name) or l_script_0:FindFirstChild("0");
            if v29 and v29:IsA("UIGradient") then
                return v29:Clone();
            end;
        end;
        return nil;
    end;
end;
return v0;