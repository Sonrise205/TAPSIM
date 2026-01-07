local l_MessagingService_0 = game:GetService("MessagingService");
local l_Players_0 = game:GetService("Players");
local l_Modules_0 = game:GetService("ReplicatedStorage").Modules;
local v3 = require(l_Modules_0.Network);
return function(v4, v5) --[[ Line: 8 ]]
    -- upvalues: l_Players_0 (copy), v3 (copy), l_MessagingService_0 (copy)
    local l_DisplayName_0 = v4.Executor.DisplayName;
    v5 = v5 ~= false;
    local v7 = {
        EventType = "GrowPlayer", 
        Data = {
            Enabled = v5, 
            SenderName = l_DisplayName_0
        }
    };
    for _, v9 in pairs(l_Players_0:GetPlayers()) do
        v3:FireClient(v9, "Notification", v5 and "\240\159\140\142 Players have been grown!" or "\240\159\140\142 Players restored to normal size!", Color3.fromRGB(100, 200, 255));
    end;
    task.spawn(function() --[[ Line: 29 ]]
        -- upvalues: l_MessagingService_0 (ref), v7 (copy)
        local l_status_0, l_result_0 = pcall(function() --[[ Line: 30 ]]
            -- upvalues: l_MessagingService_0 (ref), v7 (ref)
            l_MessagingService_0:PublishAsync("GlobalEvents", v7);
        end);
        if not l_status_0 then
            warn("Failed to publish Grow Player event:", l_result_0);
        end;
    end);
    return string.format("Players %s across all servers!", v5 and "grown" or "restored to normal size");
end;