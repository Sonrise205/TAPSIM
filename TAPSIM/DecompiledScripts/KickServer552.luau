local l_Players_0 = game:GetService("Players");
local l_MessagingService_0 = game:GetService("MessagingService");
l_MessagingService_0:SubscribeAsync("PlayerKickCommand", function(v2) --[[ Line: 7 ]]
    -- upvalues: l_Players_0 (copy)
    local l_Data_0 = v2.Data;
    local l_UserId_0 = l_Data_0.UserId;
    local v5 = l_Data_0.Reason or "You have been kicked from the game.";
    local l_l_Players_0_PlayerByUserId_0 = l_Players_0:GetPlayerByUserId(l_UserId_0);
    if l_l_Players_0_PlayerByUserId_0 then
        l_l_Players_0_PlayerByUserId_0:Kick(v5);
    end;
end);
return function(v7, v8, v9) --[[ Line: 19 ]]
    -- upvalues: l_Players_0 (copy), l_MessagingService_0 (copy)
    local v10 = nil;
    local v11 = nil;
    for _, v13 in ipairs(l_Players_0:GetPlayers()) do
        if v13.Name:lower() == v8:lower() or v13.DisplayName:lower() == v8:lower() then
            v10 = v13;
            v11 = v13.UserId;
            break;
        end;
    end;
    if not v10 then
        local l_status_0, l_result_0 = pcall(function() --[[ Line: 35 ]]
            -- upvalues: l_Players_0 (ref), v8 (copy)
            return l_Players_0:GetUserIdFromNameAsync(v8);
        end);
        if not l_status_0 or not l_result_0 then
            return "Failed to find player with username: " .. v8;
        else
            v11 = l_result_0;
        end;
    end;
    local l_status_1, l_result_1 = pcall(function() --[[ Line: 47 ]]
        -- upvalues: l_MessagingService_0 (ref), v11 (ref), v9 (copy), v7 (copy)
        l_MessagingService_0:PublishAsync("PlayerKickCommand", {
            UserId = v11, 
            Reason = v9, 
            KickedBy = v7.Executor.Name
        });
    end);
    if not l_status_1 then
        return "Failed to broadcast kick message: " .. tostring(l_result_1);
    elseif v10 then
        v10:Kick(v9);
        return string.format("Successfully kicked %s (UserId: %d) from this server. Reason: %s", v10.Name, v11, v9);
    else
        return string.format("Broadcast kick message for %s (UserId: %d) to all servers. Reason: %s", v8, v11, v9);
    end;
end;