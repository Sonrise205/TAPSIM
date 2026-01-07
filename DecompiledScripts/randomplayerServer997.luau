local l_MessagingService_0 = game:GetService("MessagingService");
local l_HttpService_0 = game:GetService("HttpService");
local l_Players_0 = game:GetService("Players");
return function(v3) --[[ Line: 6 ]]
    -- upvalues: l_HttpService_0 (copy), l_MessagingService_0 (copy), l_Players_0 (copy)
    local l_DisplayName_0 = v3.Executor.DisplayName;
    local v5 = l_HttpService_0:GenerateGUID(false);
    local v6 = {
        EventType = "RandomPlayer", 
        Data = {
            RequestId = v5, 
            SenderJobId = game.JobId, 
            SenderName = l_DisplayName_0
        }
    };
    task.spawn(function() --[[ Line: 21 ]]
        -- upvalues: l_MessagingService_0 (ref), v6 (copy)
        local l_status_0, l_result_0 = pcall(function() --[[ Line: 22 ]]
            -- upvalues: l_MessagingService_0 (ref), v6 (ref)
            l_MessagingService_0:PublishAsync("GlobalEvents", v6);
        end);
        if not l_status_0 then
            warn("Failed to publish Random Player event:", l_result_0);
        end;
    end);
    task.wait(3);
    local v9 = {};
    for _, v11 in pairs(l_Players_0:GetPlayers()) do
        table.insert(v9, v11);
    end;
    if #v9 > 0 then
        local v12 = v9[math.random(1, #v9)];
        return string.format("Random player selected: %s", v12.DisplayName);
    else
        return "No players found.";
    end;
end;