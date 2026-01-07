return function(_, v1, v2, v3) --[[ Line: 1 ]]
    local v4 = require(game.ServerStorage.Modules.Data);
    local v5 = require(game.ReplicatedStorage.Game.Replication);
    local v6 = require(game.ReplicatedStorage.Game.GemShop);
    v3 = v3 or 1;
    if v3 <= 0 then
        return "Level must be greater than 0";
    else
        local l_v4_Data_0 = v4:GetData(v1);
        if not l_v4_Data_0 then
            return "Could not get player data";
        else
            local v8 = v6[v2];
            if not v8 then
                return string.format("'%s' does not exist as an upgrade", v2);
            elseif v8.Total < v3 then
                return string.format("Level cannot exceed maximum of %d for %s", v8.Total, v8.Title or v2);
            else
                l_v4_Data_0.GemShop[v2] = v3;
                v5:Update(v1, v3, "GemShop", v2);
                if v2 == "RebirthButtons" then
                    l_v4_Data_0.RebirthOptions = 3 + v3;
                    v5:Update(v1, l_v4_Data_0.RebirthOptions, "RebirthOptions");
                    return string.format("Set %s to level %d for %s (Rebirth buttons: %d)", v8.Title or v2, v3, v1.Name, l_v4_Data_0.RebirthOptions);
                else
                    return string.format("Set %s to level %d for %s", v8.Title or v2, v3, v1.Name);
                end;
            end;
        end;
    end;
end;