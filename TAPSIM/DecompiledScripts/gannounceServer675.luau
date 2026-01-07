local l_MessagingService_0 = game:GetService("MessagingService");
return function(v1, v2, v3) --[[ Line: 4 ]]
    -- upvalues: l_MessagingService_0 (copy)
    local l_DisplayName_0 = v1.Executor.DisplayName;
    v3 = v3 or 5;
    local v5 = {
        EventType = "GlobalAnnouncement", 
        Data = {
            Message = v2, 
            Duration = v3, 
            SenderName = l_DisplayName_0
        }
    };
    task.spawn(function() --[[ Line: 19 ]]
        -- upvalues: l_MessagingService_0 (ref), v5 (copy)
        local l_status_0, l_result_0 = pcall(function() --[[ Line: 20 ]]
            -- upvalues: l_MessagingService_0 (ref), v5 (ref)
            l_MessagingService_0:PublishAsync("GlobalEvents", v5);
        end);
        if not l_status_0 then
            warn("Failed to publish Global Announcement event:", l_result_0);
        end;
    end);
    return string.format("Global announcement sent: %s", v2);
end;