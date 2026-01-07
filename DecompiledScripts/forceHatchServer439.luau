local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_MessagingService_0 = game:GetService("MessagingService");
local v2 = require(l_ReplicatedStorage_0.Game.Eggs);
return function(v3, v4, v5) --[[ Line: 8 ]]
    -- upvalues: v2 (copy), l_MessagingService_0 (copy)
    if not table.find({
        1, 
        3, 
        8
    }, v5) then
        return "Amount must be 1, 3, or 8";
    elseif not v2[v4] then
        return string.format("Invalid egg name: %s", v4);
    else
        local l_status_0, l_result_0 = pcall(function() --[[ Line: 21 ]]
            -- upvalues: l_MessagingService_0 (ref), v4 (copy), v5 (copy), v3 (copy)
            l_MessagingService_0:PublishAsync("GlobalEvents", {
                EventType = "ForceHatch", 
                Data = {
                    EggName = v4, 
                    Amount = v5, 
                    SenderName = v3.Executor.DisplayName
                }
            });
        end);
        if not l_status_0 then
            return "Failed to publish force hatch event: " .. tostring(l_result_0);
        else
            return string.format("Force hatching %s x%d for all players globally!\nExecuted by: %s", v4, v5, v3.Executor.Name);
        end;
    end;
end;