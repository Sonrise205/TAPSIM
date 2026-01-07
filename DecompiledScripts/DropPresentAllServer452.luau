local l_ServerStorage_0 = game:GetService("ServerStorage");
local l_Players_0 = game:GetService("Players");
local v2 = require(l_ServerStorage_0.Modules.GlobalPresents);
return function(_, v4, v5, v6, v7) --[[ Line: 5 ]]
    -- upvalues: v2 (copy), l_Players_0 (copy)
    v4 = string.lower(v4 or "random");
    v6 = v6 or 1;
    v7 = v7 or 30;
    local v8 = nil;
    if v4 == "gems" then
        if not v5 or v5 <= 0 then
            return "Invalid gem amount! Please provide a positive number.";
        else
            v8 = {
                Type = "Gems", 
                Amount = v5
            };
        end;
    elseif v4 == "clicks" or v4 == "taps" then
        if not v5 or v5 <= 0 then
            return "Invalid clicks amount! Please provide a positive number.";
        else
            v8 = {
                Type = "Clicks", 
                Amount = v5
            };
        end;
    elseif v4 == "random" then
        v8 = nil;
    else
        return "Invalid reward type! Use: gems, clicks, or random";
    end;
    if v2:DropPresentsAll(v8, v6, v7) then
        local v9 = #l_Players_0:GetPlayers() * v6;
        local v10 = v8 and v8.Amount .. " " .. v8.Type or "random gems";
        return string.format("\240\159\142\129 Dropping %d presents across ALL servers! (%d per player, radius %d, reward: %s)", v9, v6, v7, v10);
    else
        return "Failed to drop presents!";
    end;
end;