return function(_, v1, v2) --[[ Line: 1 ]]
    local v3 = require(game.ServerStorage.Modules.Data);
    local v4 = require(game.ReplicatedStorage.Game.Quests);
    local v5 = require(game.ServerStorage.Modules["Achievements, Quests"]);
    v2 = v2 or 0;
    if v2 < 0 then
        return "Progress must be 0 or greater";
    else
        local l_v3_Data_0 = v3:GetData(v1);
        if not l_v3_Data_0 then
            return "Could not get player data";
        else
            local v7 = 0;
            local v8 = 0;
            local v9 = {};
            for v10, v11 in pairs(v4) do
                if v10 ~= "Orders" and type(v11) == "table" then
                    table.insert(v9, v10);
                end;
            end;
            table.sort(v9);
            for _, v13 in ipairs(v9) do
                if l_v3_Data_0.Quests[v13] then
                    v8 = v8 + 1;
                else
                    v5:AssignQuest(v1, v13, v2);
                    v7 = v7 + 1;
                end;
            end;
            local v14 = string.format("Gave %d quest(s) to %s", v7, v1.Name);
            if v8 > 0 then
                v14 = v14 .. string.format(" (%d already owned)", v8);
            end;
            if v2 > 0 then
                v14 = v14 .. string.format(" with %d starting progress", v2);
            end;
            return v14;
        end;
    end;
end;