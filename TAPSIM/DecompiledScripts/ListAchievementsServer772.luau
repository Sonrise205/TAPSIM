local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_ServerStorage_0 = game:GetService("ServerStorage");
local v2 = require(l_ServerStorage_0.Modules.Data);
local v3 = require(l_ReplicatedStorage_0.Game.Achievements);
return function(v4) --[[ Line: 7 ]]
    -- upvalues: v2 (copy), v3 (copy)
    local l_Executor_0 = v4.Executor;
    local l_v2_Data_0 = v2:GetData(l_Executor_0);
    if not l_v2_Data_0 then
        return "Could not get player data.";
    else
        local v7 = {
            "=== Achievement Progress ==="
        };
        local v8 = {};
        for v9, _ in pairs(v3) do
            table.insert(v8, v9);
        end;
        table.sort(v8);
        for _, v12 in ipairs(v8) do
            local v13 = v3[v12];
            local v14 = l_v2_Data_0.Achievements[v12];
            if v14 then
                local v15 = #v13.Tasks;
                local v16 = v13.Tasks[v14.Index] and v13.Tasks[v14.Index].Title or "MAX";
                local v17 = v13.Tasks[v14.Index] and v13.Tasks[v14.Index].Amount or 0;
                local v18 = nil;
                v18 = v14.Finished and "MASTERED" or string.format("%d/%d", v14.Amount, v17);
                table.insert(v7, string.format("[%s] Tier %d/%d (%s) - %s", v12, v14.Index, v15, v16, v18));
            else
                table.insert(v7, string.format("[%s] Not initialized", v12));
            end;
        end;
        return table.concat(v7, "\n");
    end;
end;