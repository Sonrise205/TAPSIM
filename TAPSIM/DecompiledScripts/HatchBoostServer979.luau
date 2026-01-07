local l_ServerStorage_0 = game:GetService("ServerStorage");
local v1 = require(l_ServerStorage_0.Modules.GlobalBoosts);
return function(_, v3, v4) --[[ Line: 4 ]]
    -- upvalues: v1 (copy)
    v3 = v3 or 2;
    v4 = v4 or 5;
    local v5 = v4 * 60;
    if v3 <= 0 then
        return "Invalid multiplier! Must be greater than 0.";
    elseif v4 <= 0 then
        return "Invalid duration! Must be greater than 0 minutes.";
    elseif v1:ActivateHatchSpeedBoost(v3, v5) then
        return string.format("\240\159\165\154 Activated %dx Hatch Speed Boost across ALL servers for %d minutes!", v3, v4);
    else
        return "Failed to activate hatch speed boost!";
    end;
end;