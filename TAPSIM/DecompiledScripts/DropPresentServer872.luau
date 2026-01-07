local l_ServerStorage_0 = game:GetService("ServerStorage");
local v1 = require(l_ServerStorage_0.Modules.Presents);
return function(v2, v3, v4, v5) --[[ Line: 4 ]]
    -- upvalues: v1 (copy)
    local v6 = v3 or v2.Executor;
    local l_Character_0 = v6.Character;
    if not l_Character_0 or not l_Character_0.PrimaryPart then
        return "Target player has no character!";
    else
        local v8 = nil;
        if v4 then
            v8 = {
                Type = "Gems", 
                Amount = v4
            };
        end;
        local v9 = v5 or 20;
        local v10 = v1:SpawnNearPlayer(v6, v8, v9);
        if v10 then
            local v11 = v4 and v4 .. " gems" or "random gems";
            local l_Position_0 = v10:GetPivot().Position;
            return string.format("Dropped a present near %s at (%.1f, %.1f, %.1f) with %s reward! (radius: %d)", v6.Name, l_Position_0.X, l_Position_0.Y, l_Position_0.Z, v11, v9);
        else
            return "Failed to spawn present - could not find ground!";
        end;
    end;
end;