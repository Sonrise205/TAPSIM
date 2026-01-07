local _ = game:GetService("ReplicatedStorage");
local l_ServerStorage_0 = game:GetService("ServerStorage");
local v2 = require(l_ServerStorage_0.Modules.Data);
return function(_, v4) --[[ Line: 4 ]]
    -- upvalues: v2 (copy)
    local l_v4_0 = v4;
    if type(v4) == "table" then
        l_v4_0 = v4[1];
    end;
    if not l_v4_0 then
        return "No player found.";
    else
        local l_status_0, l_result_0 = pcall(function() --[[ Line: 15 ]]
            -- upvalues: v2 (ref), l_v4_0 (ref)
            v2:ResetData(l_v4_0);
        end);
        if l_status_0 then
            return "Successfully reset data for " .. l_v4_0.Name;
        else
            return "Error resetting data: " .. tostring(l_result_0);
        end;
    end;
end;