local v0 = {};
local v1 = {};
v1.__index = function(v2, v3) --[[ Line: 4 ]]
    -- upvalues: v1 (copy)
    return v1[v3] or v2._Tasks[v3];
end;
v1.__newindex = function(v4, v5, v6) --[[ Line: 8 ]]
    -- upvalues: v1 (copy), v0 (copy)
    if v1[v5] then
        error(("'%s' is reserved"):format((tostring(v5))), 2);
    end;
    local v7 = v4._Tasks[v5];
    v0.CheckValidTask(v6);
    v0.Clean(v7);
    v4._Tasks[v5] = v6;
    if v6 ~= nil then
        v4._TaskCount = v4._TaskCount + 1;
    end;
end;
v1.GiveCustomTask = function(v8, v9, v10, ...) --[[ Line: 23 ]] --[[ Name: GiveCustomTask ]]
    local l__TaskCount_0 = v8._TaskCount;
    v8._TaskCount = v8._TaskCount + 1;
    v8._Tasks[l__TaskCount_0] = {
        [1] = v9, 
        [2] = v10, 
        [3] = {
            ...
        }, 
        __type = "MaidCustomTask"
    };
    return l__TaskCount_0;
end;
v1.Give = function(v12, ...) --[[ Line: 38 ]] --[[ Name: Give ]]
    -- upvalues: v0 (copy)
    local v13 = {
        ...
    };
    for _, v15 in pairs(v13) do
        local l__TaskCount_1 = v12._TaskCount;
        v12._TaskCount = v12._TaskCount + 1;
        v0.CheckValidTask(v15);
        v12._Tasks[l__TaskCount_1] = v15;
    end;
    return table.unpack(v13);
end;
v1.Remove = function(v17, ...) --[[ Line: 53 ]] --[[ Name: Remove ]]
    for _, v19 in pairs({
        ...
    }) do
        v17._Tasks[v19] = nil;
        v17._TaskCount = v17._TaskCount + 1;
    end;
end;
v1.Clean = function(v20, ...) --[[ Line: 60 ]] --[[ Name: Clean ]]
    -- upvalues: v0 (copy)
    for _, v22 in pairs({
        ...
    }) do
        if v20._Tasks[v22] then
            v0.Clean(v20._Tasks[v22]);
            v20._Tasks[v22] = nil;
        end;
    end;
end;
v1.Cleanup = function(v23) --[[ Line: 69 ]] --[[ Name: Cleanup ]]
    -- upvalues: v0 (copy)
    local l__Tasks_0 = v23._Tasks;
    for v25, v26 in pairs(l__Tasks_0) do
        if typeof(v26) == "RBXScriptConnection" then
            l__Tasks_0[v25] = nil;
            v26:Disconnect();
        end;
    end;
    local v27, v28 = next(l__Tasks_0);
    while v28 ~= nil do
        l__Tasks_0[v27] = nil;
        v0.Clean(v28);
        local v29, v30 = next(l__Tasks_0);
        v27 = v29;
        v28 = v30;
    end;
end;
v0.Clean = function(v31) --[[ Line: 89 ]] --[[ Name: Clean ]]
    if not v31 then
        return;
    else
        local v32 = typeof(v31);
        if v32 == "table" and v31.__type then
            v32 = v31.__type;
        end;
        if v32 == "function" then
            v31();
            return;
        elseif v32 == "RBXScriptConnection" then
            v31:Disconnect();
            return;
        elseif v31.Destroy then
            v31:Destroy();
            return;
        elseif v32 == "MaidCustomTask" then
            v31[1][v31[2]](table.unpack(v31[3]));
            return;
        else
            warn("Unsure how to clean up task", v31);
            return;
        end;
    end;
end;
v0.CheckValidTask = function(v33) --[[ Line: 111 ]] --[[ Name: CheckValidTask ]]
    if typeof(v33) == "table" and not v33.Destroy and v33.__type ~= "MaidCustomTask" and v33.__type ~= "RBXScriptConnection" and v33.__type ~= "function" then
        warn("[Maid.GiveTask] - Gave table task without :Destroy() \n" .. debug.traceback("", 2));
    end;
end;
v0.new = function(...) --[[ Line: 119 ]] --[[ Name: new ]]
    -- upvalues: v1 (copy)
    local v34 = setmetatable({
        _Tasks = {}, 
        _TaskCount = 0
    }, v1);
    if ... then
        v34:Give(...);
    end;
    return v34;
end;
v1.Destroy = v1.Cleanup;
return v0;