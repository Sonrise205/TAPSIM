local l_ServerStorage_0 = game:GetService("ServerStorage");
local v1 = require(l_ServerStorage_0.Modules.Trading);
return function(v2) --[[ Line: 4 ]]
    -- upvalues: v1 (copy)
    local l_Executor_0 = v2.Executor;
    if v1:ToggleDebugMode(l_Executor_0) then
        return "Debug trading mode ENABLED. A 'TradeBot' player will appear in your trade list and auto-accept trades.";
    else
        return "Debug trading mode DISABLED.";
    end;
end;