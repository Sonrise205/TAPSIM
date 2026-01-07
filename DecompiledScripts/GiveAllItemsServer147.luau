return function(_, v1, v2) --[[ Line: 1 ]]
    local v3 = require(game.ServerStorage.Modules.Data);
    local v4 = require(game.ReplicatedStorage.Game.Replication);
    local v5 = require(game.ReplicatedStorage.Game.Items);
    local v6 = require(game.ReplicatedStorage.Game.Boosts);
    v2 = v2 or 1;
    if v2 <= 0 then
        return "Amount must be greater than 0";
    else
        local l_v3_Data_0 = v3:GetData(v1);
        if not l_v3_Data_0 then
            return "Could not get player data";
        else
            l_v3_Data_0.Items = l_v3_Data_0.Items or {};
            l_v3_Data_0.Boosts = l_v3_Data_0.Boosts or {};
            local v8 = 0;
            local v9 = 0;
            for v10 in pairs(v5) do
                l_v3_Data_0.Items[v10] = (l_v3_Data_0.Items[v10] or 0) + v2;
                v4:Update(v1, l_v3_Data_0.Items[v10], "Items", v10);
                v8 = v8 + 1;
            end;
            for v11 in pairs(v6) do
                l_v3_Data_0.Boosts[v11] = (l_v3_Data_0.Boosts[v11] or 0) + v2;
                v4:Update(v1, l_v3_Data_0.Boosts[v11], "Boosts", v11);
                v9 = v9 + 1;
            end;
            return string.format("Gave %dx each of %d item(s) and %d boost(s) to %s", v2, v8, v9, v1.Name);
        end;
    end;
end;