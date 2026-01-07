local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_Players_0 = game:GetService("Players");
local v2 = require(l_ReplicatedStorage_0.Modules.Network);
return function(v3, v4) --[[ Line: 5 ]]
    -- upvalues: l_Players_0 (copy), v2 (copy)
    local l_Executor_0 = v3.Executor;
    local v6 = v4 or l_Executor_0.UserId;
    local l_Name_0 = l_Executor_0.Name;
    if v6 ~= l_Executor_0.UserId then
        local l_l_Players_0_PlayerByUserId_0 = l_Players_0:GetPlayerByUserId(v6);
        if l_l_Players_0_PlayerByUserId_0 then
            l_Name_0 = l_l_Players_0_PlayerByUserId_0.Name;
        else
            local l_status_0, l_result_0 = pcall(function() --[[ Line: 19 ]]
                -- upvalues: l_Players_0 (ref), v6 (copy)
                return l_Players_0:GetNameFromUserIdAsync(v6);
            end);
            l_Name_0 = l_status_0 and l_result_0 or "User " .. v6;
        end;
    end;
    v2:FireClient(l_Executor_0, "OpenTradeHistory", v6);
    if v6 == l_Executor_0.UserId then
        return "Opening your trade history...";
    else
        return string.format("Opening trade history for %s...", l_Name_0);
    end;
end;