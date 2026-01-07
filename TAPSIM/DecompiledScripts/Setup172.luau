local v0 = {
    PerRow = 4, 
    SpacingX = 2.85, 
    SpacingZ = 3.3, 
    HugeSpacingX = 9, 
    HugeSpacingZ = 6
};
local v1 = {
    [0] = 2, 
    [5] = 3, 
    [6] = 4, 
    [16] = 4, 
    [20] = 5, 
    [40] = 6, 
    [50] = 6, 
    [65] = 7, 
    [80] = 8, 
    [100] = 10
};
local v2 = {};
perRow = function(v3) --[[ Line: 25 ]] --[[ Name: perRow ]]
    -- upvalues: v1 (copy)
    local v4 = 0;
    for v5, _ in pairs(v1) do
        if v5 <= v3 and v4 < v5 then
            v4 = v5;
        end;
    end;
    return v1[v4];
end;
v2.Get = function(_, v8) --[[ Line: 35 ]] --[[ Name: Get ]]
    -- upvalues: v0 (copy)
    local v9 = {};
    v8 = table.clone(v8);
    table.sort(v8, function(v10, v11) --[[ Line: 39 ]]
        return v10.Multi1 > v11.Multi1;
    end);
    local v12 = 0;
    for v13 = 1, #v8 do
        local v14 = v8[v13 - v12];
        if v14.Huge then
            table.insert(v9, v14);
            table.remove(v8, v13 - v12);
            v12 = v12 + 1;
        end;
    end;
    local v15 = {};
    local v16 = #v8;
    local v17 = perRow(v16);
    local v18 = math.ceil(#v8 / v17);
    local v19 = {};
    local v20 = 0;
    local v21 = 0;
    for v22, v23 in ipairs(v8) do
        if v23.Huge then
            v20 = v20 + 1;
        else
            local v24 = math.ceil((v22 - v20) / v17);
            if v19[v24] then
                v19[v24] = v19[v24] + 1;
            else
                v19[v24] = 1;
            end;
        end;
    end;
    for v25, v26 in ipairs(v8) do
        if v26.Huge then
            v21 = v21 + 1;
        else
            local v27 = v25 - v21;
            local v28 = math.ceil(v27 / v17);
            local v29 = v19[v28];
            local v30 = ((v27 - 1) % v17 + 1 - v29 / 2) * v0.SpacingX;
            local v31 = v28 * v0.SpacingZ;
            v15[v26.Id] = Vector3.new(v30 - v0.SpacingX / 2, 0, v31 + 1.5);
        end;
    end;
    if #v9 > 0 then
        v16 = #v9;
        v17 = 2;
        if v16 > 5 then
            v17 = 3;
        end;
        if v16 > 9 then
            v17 = 4;
        end;
        if v16 > 20 then
            v17 = 5;
        end;
        local _ = math.ceil(v16 / v17);
        v19 = {};
        for v33, _ in ipairs(v9) do
            local v35 = math.ceil(v33 / v17);
            if v19[v35] then
                v19[v35] = v19[v35] + 1;
            else
                v19[v35] = 1;
            end;
        end;
        for v36, v37 in ipairs(v9) do
            local v38 = math.ceil(v36 / v17);
            local v39 = v19[v38];
            local v40 = ((v36 - 1) % v17 + 1 - v39 / 2) * v0.HugeSpacingX;
            local v41 = (v38 - 1) * v0.HugeSpacingZ + v18 * v0.SpacingZ;
            v15[v37.Id] = Vector3.new(v40 - v0.HugeSpacingX / 2, 0, v41 + 6);
        end;
    end;
    return v15;
end;
return v2;