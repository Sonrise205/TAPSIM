local l_ServerStorage_0 = game:GetService("ServerStorage");
local v1 = require(l_ServerStorage_0.Modules.Eggs);
return function(v2, v3, v4) --[[ Line: 5 ]]
    -- upvalues: v1 (copy)
    local l_Executor_0 = v2.Executor;
    local v6, v7 = v1:TriggerTestHatch(l_Executor_0, v3, v4);
    if v6 then
        return v7;
    else
        return v7 or "Failed to start hatch preview.";
    end;
end;