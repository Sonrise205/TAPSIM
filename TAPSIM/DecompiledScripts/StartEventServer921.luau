return function(_, v1, v2) --[[ Line: 1 ]]
    local _ = require(game.ServerStorage.Modules.GlobalEvents);
    local _ = require(game.ReplicatedStorage.Modules.Network);
    v2 = v2 or 15;
    if v2 <= 0 then
        return "Duration must be greater than 0";
    elseif v2 > 7200 then
        return "Duration cannot exceed 7200 seconds (2 hours)";
    else
        local l_ServerStorage_0 = game:GetService("ServerStorage");
        local v6 = require(l_ServerStorage_0.Modules.GlobalEvents);
        local v7 = v6.GetEventData(v1);
        if not v7 then
            return string.format("Invalid event type: %s", v1);
        elseif v7.active then
            return string.format("%s event is already active! Time remaining: %d seconds", v1, (math.ceil(v7.timeRemaining)));
        else
            local _ = require(l_ServerStorage_0.Modules.GlobalEvents);
            local l_status_0, l_result_0 = pcall(function() --[[ Line: 38 ]]
                -- upvalues: v6 (copy), v1 (copy), v2 (ref)
                v6.ManuallyStartEvent(v1, v2);
            end);
            if not l_status_0 then
                return "Failed to start event: " .. tostring(l_result_0);
            else
                return string.format("Started %s event for %d seconds!", v7.name, v2);
            end;
        end;
    end;
end;