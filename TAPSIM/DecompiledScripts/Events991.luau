local v0 = {};
local v1 = {};
local v2 = {};
local l_remove_0 = table.remove;
local l_find_0 = table.find;
local v5 = {
    Connected = true, 
    Disconnected = true, 
    Destroying = true
};
v1.__index = v1;
v1.__type = "RBXScriptConnection";
local function _(v6, v7) --[[ Line: 18 ]] --[[ Name: MakeInternalEvent ]]
    -- upvalues: v5 (copy), v0 (copy)
    if not v5[v7] then
        return;
    else
        v6[v7] = v0.new();
        return v6[v7];
    end;
end;
local function v12(v9, v10) --[[ Line: 24 ]] --[[ Name: IndexFunction ]]
    -- upvalues: v2 (copy), v5 (copy), v0 (copy)
    local v11 = v2[v10];
    if not v11 then
        v11 = rawget(v9, v10);
        if not v11 then
            if not v5[v10] then
                return nil;
            else
                v9[v10] = v0.new();
                v11 = v9[v10];
            end;
        end;
    end;
    return v11;
end;
v1.Disconnect = function(v13) --[[ Line: 28 ]] --[[ Name: Disconnect ]]
    -- upvalues: l_remove_0 (copy), l_find_0 (copy)
    local v14 = rawget(v13, "Disconnected");
    if v14 then
        v14:Fire(v13[2]);
    end;
    l_remove_0(v13[1], l_find_0(v13[1], v13[2]));
    if #v13[1] == 0 then
        v13[1]:Destroy();
    end;
end;
v2.Destroy = function(v15) --[[ Line: 42 ]] --[[ Name: Destroy ]]
    local v16 = rawget(v15, "Destroying");
    local v17 = rawget(v15, "Connected");
    local v18 = rawget(v15, "Disconnected");
    if v16 then
        v16:Fire();
        v16:Destroy();
    end;
    if v17 then
        v17:Destroy();
    end;
    if v18 then
        v18:Destroy();
    end;
    table.clear(v15);
end;
v2.Connect = function(v19, v20) --[[ Line: 63 ]] --[[ Name: Connect ]]
    -- upvalues: v1 (copy)
    local v21 = rawget(v19, "Connected");
    if v21 then
        v21:Fire(v20);
    end;
    v19[#v19 + 1] = v20;
    return (setmetatable({
        v19, 
        v20
    }, v1));
end;
v2.Fire = function(v22, ...) --[[ Line: 74 ]] --[[ Name: Fire ]]
    for v23 = 1, #v22 do
        v22[v23](...);
    end;
end;
v0.new = function() --[[ Line: 80 ]] --[[ Name: new ]]
    -- upvalues: v2 (copy)
    return (setmetatable({}, v2));
end;
v0.Get = function() --[[ Line: 84 ]] --[[ Name: Get ]]
    -- upvalues: v2 (copy)
    return v2;
end;
v2.__index = v12;
return v0;