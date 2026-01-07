return function(_, v1, v2, v3) --[[ Line: 1 ]]
    local v4 = require(game.ServerStorage.Modules.Data);
    local v5 = require(game.ReplicatedStorage.Game.Replication);
    local l_v4_Data_0 = v4:GetData(v1);
    if not l_v4_Data_0 then
        return "Failed to get player data";
    else
        v3 = v3 or "Main";
        v2 = math.max(1, (math.floor(v2)));
        if not l_v4_Data_0.DoubleJumps[v3] then
            l_v4_Data_0.DoubleJumps[v3] = 1;
        end;
        l_v4_Data_0.DoubleJumps[v3] = v2;
        task.defer(function() --[[ Line: 25 ]]
            -- upvalues: v5 (copy), v1 (copy), l_v4_Data_0 (copy), v3 (ref)
            v5:Update(v1, l_v4_Data_0.DoubleJumps[v3], "DoubleJumps", v3);
        end);
        return string.format("Set %s's double jumps to %d in world '%s'", v1.Name, v2, v3);
    end;
end;