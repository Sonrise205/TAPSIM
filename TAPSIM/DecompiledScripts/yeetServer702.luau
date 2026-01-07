local l_MessagingService_0 = game:GetService("MessagingService");
local l_Players_0 = game:GetService("Players");
local l_Modules_0 = game:GetService("ReplicatedStorage").Modules;
local v3 = require(l_Modules_0.Network);
return function(v4, v5) --[[ Line: 8 ]]
    -- upvalues: l_Players_0 (copy), v3 (copy), l_MessagingService_0 (copy)
    local l_DisplayName_0 = v4.Executor.DisplayName;
    v5 = v5 ~= false;
    local v7 = {
        EventType = "YeetPlayers", 
        Data = {
            Enabled = v5, 
            SenderName = l_DisplayName_0
        }
    };
    if v5 then
        for _, v9 in pairs(l_Players_0:GetPlayers()) do
            v3:FireClient(v9, "Notification", "\240\159\140\142 Players have been YEETED! \240\159\154\128", Color3.fromRGB(100, 200, 255));
        end;
    end;
    task.spawn(function() --[[ Line: 31 ]]
        -- upvalues: l_MessagingService_0 (ref), v7 (copy)
        local l_status_0, l_result_0 = pcall(function() --[[ Line: 32 ]]
            -- upvalues: l_MessagingService_0 (ref), v7 (ref)
            l_MessagingService_0:PublishAsync("GlobalEvents", v7);
        end);
        if not l_status_0 then
            warn("Failed to publish Yeet Players event:", l_result_0);
        end;
    end);
    return string.format("Players %s across all servers! \240\159\154\128", v5 and "YEETED" or "not yeeted");
end;