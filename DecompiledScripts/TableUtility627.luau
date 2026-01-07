local v0 = {};
local function _(v1) --[[ Line: 3 ]] --[[ Name: ErrorOnIndex ]]
    error(("Readonly index %q"):format((tostring(v1))), 3);
end;
v0.GetArrayFromString = function(v3) --[[ Line: 9 ]] --[[ Name: GetArrayFromString ]]
    return string.split(v3, ",");
end;
v0.ArrayFromDict = function(v4) --[[ Line: 13 ]] --[[ Name: ArrayFromDict ]]
    local v5 = {};
    for _, v7 in pairs(v4) do
        table.insert(v5, v7);
    end;
    return v5;
end;
v0.SearchDict = function(v8, v9) --[[ Line: 23 ]] --[[ Name: SearchDict ]]
    for _, v11 in pairs(v8) do
        if v11 == v9 then
            return v11;
        end;
    end;
    return false;
end;
v0.ReadOnly = function(v12) --[[ Line: 33 ]] --[[ Name: ReadOnly ]]
    return (setmetatable({}, {
        __newindex = function(_, v14) --[[ Line: 35 ]] --[[ Name: __newindex ]]
            error(("Readonly index %q"):format((tostring(v14))), 3);
        end, 
        __index = v12, 
        __metatable = false
    }));
end;
v0.DeepReadOnly = function(v15) --[[ Line: 44 ]] --[[ Name: DeepReadOnly ]]
    for _, v17 in pairs(v15) do
        if type(v17) == "table" then
            v15.DeepReadOnly(v17);
        end;
    end;
    return v15:ReadOnly();
end;
v0.Reverse = function(v18) --[[ Line: 54 ]] --[[ Name: Reverse ]]
    local v19 = #v18;
    local v20 = 1;
    while v20 < v19 do
        local v21 = v18[v19];
        local v22 = v18[v20];
        v18[v20] = v21;
        v18[v19] = v22;
        v20 = v20 + 1;
        v19 = v19 - 1;
    end;
end;
v0.GetOccupied = function(v23) --[[ Line: 65 ]] --[[ Name: GetOccupied ]]
    return next(v23) ~= nil;
end;
v0.GetLength = function(v24) --[[ Line: 69 ]] --[[ Name: GetLength ]]
    local v25 = 0;
    for _ in pairs(v24) do
        v25 = v25 + 1;
    end;
    return v25;
end;
v0.QuickRemove = function(v27, v28, v29) --[[ Line: 79 ]] --[[ Name: QuickRemove ]]
    local v30 = v29 or #v27;
    v27[v28] = v27[v30];
    v27[v30] = nil;
end;
v0.GetLowestValue = function(v31) --[[ Line: 85 ]] --[[ Name: GetLowestValue ]]
    local v32 = 1e999;
    local v33 = nil;
    for v34, v35 in pairs(v31) do
        if v32 >= v35 then
            v32 = v35;
            v33 = v34;
        end;
    end;
    return v32, v33;
end;
v0.ShallowMerge = function(v36, v37) --[[ Line: 99 ]] --[[ Name: ShallowMerge ]]
    -- upvalues: v0 (copy)
    if not v37 then
        return v0.ShallowCopy(v36);
    else
        local v38 = {};
        for v39, v40 in pairs(v36) do
            v38[v39] = v40;
        end;
        for v41, v42 in pairs(v37) do
            v38[v41] = v42;
        end;
        return v38;
    end;
end;
v0.DeepMerge = function(v43, v44) --[[ Line: 117 ]] --[[ Name: DeepMerge ]]
    -- upvalues: v0 (copy)
    for v45, v46 in pairs(v44) do
        if typeof(v46) == "table" then
            if typeof(v43[v45] or false) == "table" then
                v0.DeepMerge(v43[v45] or {}, v44[v45] or {});
            else
                v43[v45] = v46;
            end;
        else
            v43[v45] = v46;
        end;
    end;
    return v43;
end;
v0.ShallowCopy = function(v47) --[[ Line: 133 ]] --[[ Name: ShallowCopy ]]
    local v48 = nil;
    if typeof(v47) == "table" then
        v48 = {};
        for v49, v50 in pairs(v47) do
            v48[v49] = v50;
        end;
        return v48;
    else
        return v47;
    end;
end;
v0.DeepCopy = function(v51, v52) --[[ Line: 149 ]] --[[ Name: DeepCopy ]]
    -- upvalues: v0 (copy)
    local v53 = v52 or {};
    local v54 = nil;
    if typeof(v51) == "table" then
        if v53[v51] then
            return v53[v51];
        else
            v54 = {};
            v53[v51] = v54;
            for v55, v56 in next, v51 do
                v54[v0.DeepCopy(v55, v53)] = v0.DeepCopy(v56, v53);
            end;
            setmetatable(v54, v0.DeepCopy(getmetatable(v51), v53));
            return v54;
        end;
    else
        return v51;
    end;
end;
return v0;