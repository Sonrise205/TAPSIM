local l_ServerStorage_0 = game:GetService("ServerStorage");
local v1 = require(l_ServerStorage_0.Modules.GlobalPresents);
return function(_, v3, v4, v5) --[[ Line: 4 ]]
    -- upvalues: v1 (copy)
    v3 = string.lower(v3);
    local v6 = {};
    if v3 == "gems" then
        local v7 = tonumber(v4);
        if not v7 or v7 <= 0 then
            return "Invalid gem amount! Please provide a positive number.";
        else
            v6.Gems = v7;
        end;
    elseif v3 == "clicks" or v3 == "taps" then
        local v8 = tonumber(v4);
        if not v8 or v8 <= 0 then
            return "Invalid clicks amount! Please provide a positive number.";
        else
            v6.Clicks = v8;
        end;
    elseif v3 == "rebirths" then
        local v9 = tonumber(v4);
        if not v9 or v9 <= 0 then
            return "Invalid rebirths amount! Please provide a positive number.";
        else
            v6.Rebirths = v9;
        end;
    elseif v3 == "tokens" then
        local v10 = tonumber(v4);
        if not v10 or v10 <= 0 then
            return "Invalid tokens amount! Please provide a positive number.";
        else
            v6.Tokens = v10;
        end;
    elseif v3 == "item" then
        if not v4 or v4 == "" then
            return "Please provide an item name!";
        else
            v6.Item = v4;
            v6.ItemAmount = v5 or 1;
        end;
    elseif v3 == "boost" or v3 == "potion" then
        if not v4 or v4 == "" then
            return "Please provide a boost name!";
        else
            v6.Boost = v4;
            v6.BoostAmount = v5 or 1;
        end;
    else
        return "Invalid reward type! Use: gems, clicks, rebirths, tokens, item, or boost";
    end;
    if v1:SpawnGiantPresent(v6) then
        local v11 = "";
        if v6.Gems then
            v11 = v6.Gems .. " Gems";
        elseif v6.Clicks then
            v11 = v6.Clicks .. " Clicks";
        elseif v6.Rebirths then
            v11 = v6.Rebirths .. " Rebirths";
        elseif v6.Tokens then
            v11 = v6.Tokens .. " Tokens";
        elseif v6.Item then
            v11 = v6.ItemAmount .. "x " .. v6.Item;
        elseif v6.Boost then
            v11 = v6.BoostAmount .. "x " .. v6.Boost;
        end;
        return "\240\159\142\129 Giant Present spawned across ALL servers! Reward: " .. v11 .. " for everyone!";
    else
        return "Failed to spawn giant present!";
    end;
end;