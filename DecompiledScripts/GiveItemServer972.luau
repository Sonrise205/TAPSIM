return function(_, v1, v2, v3) --[[ Line: 1 ]]
    local v4 = require(game.ServerStorage.Modules.Data);
    local v5 = require(game.ReplicatedStorage.Game.Replication);
    local v6 = require(game.ReplicatedStorage.Game.Items);
    local v7 = require(game.ReplicatedStorage.Game.Boosts);
    v3 = v3 or 1;
    if v3 <= 0 then
        return "Amount must be greater than 0";
    else
        local l_v4_Data_0 = v4:GetData(v1);
        if not l_v4_Data_0 then
            return "Could not get player data";
        else
            local v9 = v6[v2] ~= nil;
            local v10 = v7[v2] ~= nil;
            if not v9 and not v10 then
                return string.format("'%s' does not exist as an item or boost", v2);
            else
                local v11 = nil;
                local v12 = nil;
                local v13 = nil;
                if v9 then
                    v12 = l_v4_Data_0.Items;
                    v13 = "Items";
                    v11 = v6[v2].Name or v2;
                    if not v12[v2] then
                        v12[v2] = 0;
                    end;
                    v12[v2] = v12[v2] + v3;
                    v5:Update(v1, v12[v2], v13, v2);
                elseif v10 then
                    v12 = l_v4_Data_0.Boosts;
                    v13 = "Boosts";
                    v11 = v7[v2].Name or v2;
                    if not v12[v2] then
                        v12[v2] = 0;
                    end;
                    v12[v2] = v12[v2] + v3;
                    v5:Update(v1, v12[v2], v13, v2);
                end;
                if v3 == 1 then
                    return string.format("Gave %s to %s", v11, v1.Name);
                else
                    return string.format("Gave %dx %s to %s", v3, v11, v1.Name);
                end;
            end;
        end;
    end;
end;