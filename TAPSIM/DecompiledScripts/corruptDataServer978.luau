local v0 = require(game.ServerStorage.Modules.Data);
return function(_, v2) --[[ Line: 4 ]]
    -- upvalues: v0 (copy)
    if game:GetService("Players"):GetPlayerByUserId(v2) then
        local l_PlayerByUserId_0 = game:GetService("Players"):GetPlayerByUserId(v2);
        local l_v0_Data_0 = v0:GetData(l_PlayerByUserId_0);
        if not l_v0_Data_0 then
            return "Could not get player data";
        else
            l_v0_Data_0.CorruptSlot = "\255";
        end;
    end;
    return "corrupted data";
end;