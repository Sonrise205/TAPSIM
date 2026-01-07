local v0 = require(game.ReplicatedStorage.Modules.Signal);
local v1 = require(game.ReplicatedStorage.Game.PetStats);
local function v7(v2) --[[ Line: 4 ]] --[[ Name: collectPetNames ]]
    -- upvalues: v1 (copy)
    local v3 = {};
    local v4 = 0;
    for v5, v6 in pairs(v1.Pets) do
        if v6.Hidden ~= true or v2 then
            table.insert(v3, v5);
        else
            v4 = v4 + 1;
        end;
    end;
    table.sort(v3);
    return v3, v4;
end;
return function(_, v9, v10, v11) --[[ Line: 23 ]]
    -- upvalues: v7 (copy), v0 (copy)
    v10 = v10 or "Normal";
    v11 = v11 == true;
    local v12, v13 = v7(v11);
    if #v12 == 0 then
        return "No pets available to give.";
    else
        for _, v15 in ipairs(v12) do
            v0.Fire("GivePet", v9, v15, v10);
        end;
        local v16 = string.format("Gave %d %s-tier pet(s) to %s", #v12, v10, v9.Name);
        if v11 then
            return v16 .. " (including hidden pets)";
        else
            if v13 > 0 then
                v16 = v16 .. string.format(" (%d hidden skipped)", v13);
            end;
            return v16;
        end;
    end;
end;