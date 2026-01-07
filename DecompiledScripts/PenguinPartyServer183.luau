local l_ServerStorage_0 = game:GetService("ServerStorage");
local v1 = require(l_ServerStorage_0.Modules.GlobalEvents);
return function(_) --[[ Line: 4 ]]
    -- upvalues: v1 (copy)
    local v3 = v1:PlayPenguinPartyGlobal();
    return string.format("\240\159\144\167 Starting GLOBAL Penguin Party for 1 minute! (%d player(s) on this server)", v3);
end;