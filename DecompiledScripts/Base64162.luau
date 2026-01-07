local v0 = {};
local v1 = {};
for v2 = 65, 90 do
    table.insert(v0, v2);
end;
for v3 = 97, 122 do
    table.insert(v0, v3);
end;
table.insert(v0, 48);
table.insert(v0, 49);
table.insert(v0, 50);
table.insert(v0, 51);
table.insert(v0, 52);
table.insert(v0, 53);
table.insert(v0, 54);
table.insert(v0, 55);
table.insert(v0, 56);
table.insert(v0, 57);
table.insert(v0, 43);
table.insert(v0, 47);
for v4, v5 in ipairs(v0) do
    v1[v5] = v4;
end;
local v6 = {};
local l_rshift_0 = bit32.rshift;
local l_lshift_0 = bit32.lshift;
local l_band_0 = bit32.band;
v6.Encode = function(v10) --[[ Line: 38 ]] --[[ Name: Encode ]]
    -- upvalues: l_rshift_0 (copy), l_band_0 (copy), l_lshift_0 (copy), v0 (copy)
    local v11 = {};
    local v12 = 0;
    for v13 = 1, #v10, 3 do
        local v14, v15, v16 = string.byte(v10, v13, v13 + 2);
        local v17 = l_rshift_0(v14, 2);
        local v18 = l_lshift_0(l_band_0(v14, 3), 4) + l_rshift_0(v15 or 0, 4);
        local v19 = l_lshift_0(l_band_0(v15 or 0, 15), 2) + l_rshift_0(v16 or 0, 6);
        local v20 = l_band_0(v16 or 0, 63);
        v12 = v12 + 1;
        v11[v12] = v0[v17 + 1];
        v12 = v12 + 1;
        v11[v12] = v0[v18 + 1];
        v12 = v12 + 1;
        v11[v12] = v15 and v0[v19 + 1] or 61;
        v12 = v12 + 1;
        v11[v12] = v16 and v0[v20 + 1] or 61;
    end;
    local v21 = {};
    local v22 = 0;
    local v23 = nil;
    for v24 = 1, v12, 4096 do
        v22 = v22 + 1;
        v23 = v24 + 4096 - 1;
        v21[v22] = string.char(table.unpack(v11, v24, v12 < v23 and v12 or v23));
    end;
    return table.concat(v21);
end;
v6.Decode = function(v25) --[[ Line: 86 ]] --[[ Name: Decode ]]
    -- upvalues: v1 (copy), l_lshift_0 (copy), l_rshift_0 (copy), l_band_0 (copy)
    local v26 = {};
    local v27 = 0;
    for v28 = 1, #v25, 4 do
        local v29, v30, v31, v32 = string.byte(v25, v28, v28 + 3);
        local v33 = v1[v29] - 1;
        local v34 = v1[v30] - 1;
        local v35 = (v1[v31] or 1) - 1;
        local v36 = (v1[v32] or 1) - 1;
        local v37 = l_lshift_0(v33, 2) + l_rshift_0(v34, 4);
        local v38 = l_lshift_0(l_band_0(v34, 15), 4) + l_rshift_0(v35, 2);
        local v39 = l_lshift_0(l_band_0(v35, 3), 6) + v36;
        v27 = v27 + 1;
        v26[v27] = v37;
        if v31 ~= 61 then
            v27 = v27 + 1;
            v26[v27] = v38;
        end;
        if v32 ~= 61 then
            v27 = v27 + 1;
            v26[v27] = v39;
        end;
    end;
    local v40 = {};
    local v41 = 0;
    local v42 = nil;
    for v43 = 1, v27, 4096 do
        v41 = v41 + 1;
        v42 = v43 + 4096 - 1;
        v40[v41] = string.char(table.unpack(v26, v43, v27 < v42 and v27 or v42));
    end;
    return table.concat(v40);
end;
return v6;