local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_ServerStorage_0 = game:GetService("ServerStorage");
local v2 = require(l_ServerStorage_0.Modules.Data);
local _ = require(l_ReplicatedStorage_0.Game.Replication);
local v4 = require(l_ReplicatedStorage_0.Game.Achievements);
local v5 = require(l_ReplicatedStorage_0.Modules.Network);
return function(v6, v7, v8, v9) --[[ Line: 9 ]]
    -- upvalues: v4 (copy), v2 (copy), v5 (copy)
    local l_Executor_0 = v6.Executor;
    v9 = v9 or 0;
    if not v4[v7] then
        local v11 = {};
        for v12, _ in pairs(v4) do
            table.insert(v11, v12);
        end;
        table.sort(v11);
        return "Invalid category: " .. v7 .. ". Valid categories: " .. table.concat(v11, ", ");
    else
        local v14 = v4[v7];
        local v15 = #v14.Tasks;
        if v8 < 0 then
            return "Tier index must be 0 or greater. Use 0 to reset.";
        elseif v15 + 1 < v8 then
            return string.format("Tier index too high. %s has %d tiers (max index: %d, or %d for completed).", v7, v15, v15, v15 + 1);
        else
            local l_v2_Data_0 = v2:GetData(l_Executor_0);
            if not l_v2_Data_0 then
                return "Could not get player data.";
            else
                if not l_v2_Data_0.Achievements[v7] then
                    l_v2_Data_0.Achievements[v7] = {
                        Claimed = {}, 
                        Amount = 0, 
                        Index = 1
                    };
                end;
                local v17 = l_v2_Data_0.Achievements[v7];
                local l_Index_0 = v17.Index;
                local l_Amount_0 = v17.Amount;
                if v8 == 0 then
                    v17.Index = 1;
                    v17.Amount = 0;
                    v17.Finished = false;
                else
                    v17.Index = v8;
                    v17.Amount = v9;
                    v17.Finished = v15 < v8;
                end;
                v5:FireClient(l_Executor_0, "UpdateAchievement", v7, v17);
                local v20 = v17.Finished and " (COMPLETED)" or "";
                local v21 = v14.Tasks[v17.Index] and v14.Tasks[v17.Index].Title or "Max";
                return string.format("Set %s: Tier %d -> %d (%s), Amount %d -> %d%s", v7, l_Index_0, v17.Index, v21, l_Amount_0, v17.Amount, v20);
            end;
        end;
    end;
end;