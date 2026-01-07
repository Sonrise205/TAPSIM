local v0 = {};
local v1 = {};
v1.__index = v1;
v1.new = function(v2) --[[ Line: 12 ]] --[[ Name: new ]]
    -- upvalues: v1 (copy)
    local v3 = setmetatable({}, v1);
    v3.Randomizer = Random.new(v2 or tick() % 1 * 10000000000);
    v3.Loot = {};
    v3.LootList = {};
    v3.LootCount = 0;
    v3.TotalChance = 0;
    return v3;
end;
v1._updateLootList = function(v4) --[[ Line: 22 ]] --[[ Name: _updateLootList ]]
    local v5 = {};
    for _, v7 in v4.Loot do
        table.insert(v5, v7);
    end;
    table.sort(v5, function(v8, v9) --[[ Line: 29 ]]
        return v8.chance < v9.chance;
    end);
    v4.LootList = v5;
end;
v1.AddLoot = function(v10, v11, v12) --[[ Line: 36 ]] --[[ Name: AddLoot ]]
    local v13 = {
        name = v11, 
        chance = v12
    };
    v10.Loot[v11] = v13;
    v10.LootCount = v10.LootCount + 1;
    v10.TotalChance = v10.TotalChance + v12;
    v10:_updateLootList();
    return v13;
end;
v1.AddLootFromTable = function(v14, v15) --[[ Line: 48 ]] --[[ Name: AddLootFromTable ]]
    for v16, v17 in v15 do
        v14:AddLoot(v16, v17);
    end;
    return v14;
end;
v1.GetLootChance = function(v18, v19) --[[ Line: 55 ]] --[[ Name: GetLootChance ]]
    local v20 = v18.Loot[v19];
    if v20 then
        return v20.chance;
    else
        error("Loot with name '" .. tostring(v19) .. "' does not exist");
        return;
    end;
end;
v1.GetTrueLootChance = function(v21, v22) --[[ Line: 64 ]] --[[ Name: GetTrueLootChance ]]
    local v23 = v21.Loot[v22];
    if v23 then
        return v23.chance / v21.TotalChance * 100;
    else
        error("Loot with name '" .. tostring(v22) .. "' does not exist");
        return;
    end;
end;
v1.RemoveLoot = function(v24, v25) --[[ Line: 73 ]] --[[ Name: RemoveLoot ]]
    local v26 = v24.Loot[v25];
    if v26 then
        v24.TotalChance = v24.TotalChance - v26.chance;
        v24.LootCount = v24.LootCount - 1;
        v24.Loot[v25] = nil;
        v24:_updateLootList();
    end;
end;
v1.ChangeLootChance = function(v27, v28, v29) --[[ Line: 83 ]] --[[ Name: ChangeLootChance ]]
    local v30 = v27.Loot[v28];
    if v30 then
        v27.TotalChance = v27.TotalChance + (v29 - v30.chance);
        v30.chance = v29;
        v27:_updateLootList();
        return v30;
    else
        error("Loot with name '" .. tostring(v28) .. "' does not exist");
        return;
    end;
end;
v1.GetRandomLoot = function(v31, v32) --[[ Line: 95 ]] --[[ Name: GetRandomLoot ]]
    local v33 = v32 or 1;
    if v33 >= 1 then
        local v34 = v31.Randomizer:NextNumber();
        local v35 = 0;
        for _, v37 in v31.LootList do
            local v38 = v37.chance * v33;
            if v34 < (v38 + v35) / v31.TotalChance then
                return v37.name;
            else
                v35 = v35 + v38;
            end;
        end;
        return;
    else
        local v39 = 1 / v33;
        local v40 = v31.Randomizer:NextNumber();
        local v41 = 0;
        for v42 = v31.LootCount, 1, -1 do
            local v43 = v31.LootList[v42];
            local v44 = v43.chance * v39;
            if v40 < (v44 + v41) / v31.TotalChance then
                return v43.name;
            else
                v41 = v41 + v44;
            end;
        end;
        return;
    end;
end;
local v45 = {};
v45.__index = v45;
v45.new = function(v46) --[[ Line: 127 ]] --[[ Name: new ]]
    -- upvalues: v45 (copy)
    local v47 = setmetatable({}, v45);
    v47.Randomizer = Random.new(v46 or tick() % 1 * 10000000000);
    v47.Loot = {};
    return v47;
end;
v45.AddLoot = function(v48, v49, v50) --[[ Line: 134 ]] --[[ Name: AddLoot ]]
    local v51 = {
        name = v49, 
        chance = v50
    };
    v48.Loot[v49] = v51;
    return v51;
end;
v45.AddLootFromTable = function(v52, v53) --[[ Line: 143 ]] --[[ Name: AddLootFromTable ]]
    for v54, v55 in v53 do
        v52:AddLoot(v54, v55);
    end;
end;
v45.GetLootChance = function(v56, v57) --[[ Line: 149 ]] --[[ Name: GetLootChance ]]
    local v58 = v56.Loot[v57];
    if v58 then
        return v58.chance;
    else
        error("Loot with name '" .. tostring(v57) .. "' does not exist");
        return;
    end;
end;
v45.RemoveLoot = function(v59, v60) --[[ Line: 158 ]] --[[ Name: RemoveLoot ]]
    v59.Loot[v60] = nil;
end;
v45.ChangeLootChance = function(v61, v62, v63) --[[ Line: 162 ]] --[[ Name: ChangeLootChance ]]
    local v64 = v61.Loot[v62];
    if v64 then
        v64.chance = v63;
        return;
    else
        error("Loot with name '" .. tostring(v62) .. "' does not exist");
        return;
    end;
end;
v45.GetRandomLoot = function(v65, v66, v67) --[[ Line: 171 ]] --[[ Name: GetRandomLoot ]]
    local v68 = {};
    for _ = 1, v66 or 1 do
        for v70, v71 in v65.Loot do
            if v65.Randomizer:NextNumber() < v71.chance / 100 * (v67 or 1) then
                v68[v70] = v68[v70] and v68[v70] + 1 or 1;
            end;
        end;
    end;
    return v68;
end;
v0.new = function(v72, v73) --[[ Line: 187 ]] --[[ Name: new ]]
    -- upvalues: v45 (copy), v1 (copy)
    if v72 == "multi" then
        return v45.new(v73);
    else
        return v1.new(v73);
    end;
end;
return v0;