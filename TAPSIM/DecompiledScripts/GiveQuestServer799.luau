return function(_, v1, v2, v3) --[[ Line: 1 ]]
    local v4 = require(game.ServerStorage.Modules.Data);
    local _ = require(game.ReplicatedStorage.Game.Replication);
    local v6 = require(game.ReplicatedStorage.Game.Quests);
    local v7 = require(game.ServerStorage.Modules["Achievements, Quests"]);
    v3 = v3 or 0;
    if v3 < 0 then
        return "Progress must be 0 or greater";
    else
        local l_v4_Data_0 = v4:GetData(v1);
        if not l_v4_Data_0 then
            return "Could not get player data";
        else
            local v9 = v6[v2];
            if not v9 then
                return string.format("'%s' is not a valid quest name", v2);
            elseif l_v4_Data_0.Quests[v2] then
                return string.format("%s already has the quest '%s'", v1.Name, v2);
            else
                v7:AssignQuest(v1, v2, v3);
                local v10 = string.format("Gave quest '%s' to %s", v2, v1.Name);
                if v3 > 0 then
                    v10 = v10 .. string.format(" (with %d/%d progress)", v3, v9.Goal);
                    if v9.Goal <= v3 then
                        v10 = v10 .. " - Quest completed!";
                    end;
                end;
                return v10;
            end;
        end;
    end;
end;