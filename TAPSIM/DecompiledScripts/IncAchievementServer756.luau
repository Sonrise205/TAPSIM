local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_ServerStorage_0 = game:GetService("ServerStorage");
local v2 = require(l_ServerStorage_0.Modules.Data);
local v3 = require(l_ReplicatedStorage_0.Game.Achievements);
local v4 = require(l_ServerStorage_0.Modules["Achievements, Quests"]);
return function(v5, v6, v7) --[[ Line: 8 ]]
    -- upvalues: v3 (copy), v2 (copy), v4 (copy)
    local l_Executor_0 = v5.Executor;
    if not v3[v6] then
        local v9 = {};
        for v10, _ in pairs(v3) do
            table.insert(v9, v10);
        end;
        table.sort(v9);
        return "Invalid category: " .. v6 .. ". Valid categories: " .. table.concat(v9, ", ");
    elseif v7 <= 0 then
        return "Amount must be greater than 0.";
    else
        local l_v2_Data_0 = v2:GetData(l_Executor_0);
        if not l_v2_Data_0 then
            return "Could not get player data.";
        else
            local v13 = l_v2_Data_0.Achievements[v6];
            if not v13 then
                return "Achievement data not initialized for " .. v6;
            else
                local l_Index_0 = v13.Index;
                local _ = v13.Amount;
                v4:Inc(l_Executor_0, v6, v7, l_v2_Data_0);
                local l_Index_1 = v13.Index;
                local l_Amount_1 = v13.Amount;
                local v18 = l_Index_1 - l_Index_0;
                local v19 = v3[v6];
                local v20 = v19.Tasks[l_Index_1] and v19.Tasks[l_Index_1].Title or "Max";
                local v21 = v13.Finished and " (MASTERY COMPLETE!)" or "";
                if v18 > 0 then
                    return string.format("Incremented %s by %d: Completed %d tier(s)! Now at Tier %d (%s), Amount: %d%s", v6, v7, v18, l_Index_1, v20, l_Amount_1, v21);
                else
                    return string.format("Incremented %s by %d: Now at Tier %d (%s), Amount: %d/%d%s", v6, v7, l_Index_1, v20, l_Amount_1, v19.Tasks[l_Index_1] and v19.Tasks[l_Index_1].Amount or 0, v21);
                end;
            end;
        end;
    end;
end;