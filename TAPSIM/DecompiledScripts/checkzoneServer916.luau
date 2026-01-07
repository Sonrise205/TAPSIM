local l_ServerStorage_0 = game:GetService("ServerStorage");
local _ = game:GetService("ReplicatedStorage");
local v2 = require(l_ServerStorage_0.Modules.Data);
return function(v3) --[[ Line: 5 ]]
    -- upvalues: v2 (copy)
    local l_Executor_0 = v3.Executor;
    local l_v2_Data_0 = v2:GetData(l_Executor_0);
    if l_v2_Data_0 then
        local l_Zone_0 = l_v2_Data_0.Zone;
        if not l_Zone_0 or l_Zone_0 == "" then
            return "Current Zone: None (Spawn area)";
        else
            return "Current Zone: " .. l_Zone_0;
        end;
    else
        return "Could not get player data";
    end;
end;