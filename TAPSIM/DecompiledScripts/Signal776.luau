local function _(v0, v1) --[[ Line: 67 ]] --[[ Name: assert ]]
    if v0 then
        return;
    else
        error(v1, 3);
        return;
    end;
end;
local v3 = {};
local v4 = {};
v4.__index = v4;
local v5 = {};
v5.__index = v5;
v4.new = function(v6) --[[ Line: 89 ]] --[[ Name: new ]]
    -- upvalues: v4 (copy), v3 (ref)
    local v7 = setmetatable({
        _name = typeof(v6) == "string" and v6 or "", 
        _active = true, 
        _head = nil
    }, v4);
    v3[v7._name] = v7;
    return v7;
end;
v4.Fire = function(v8, ...) --[[ Line: 104 ]] --[[ Name: Fire ]]
    -- upvalues: v4 (copy)
    local l_v4_Signal_0 = v4:GetSignal(v8);
    if l_v4_Signal_0 then
        return l_v4_Signal_0:Call(...);
    else
        return;
    end;
end;
v4.GetSignal = function(_, v11) --[[ Line: 111 ]] --[[ Name: GetSignal ]]
    -- upvalues: v3 (ref)
    return v3[v11];
end;
v4.IsActive = function(v12) --[[ Line: 115 ]] --[[ Name: IsActive ]]
    return v12._active == true;
end;
local function v18(v13, v14, v15) --[[ Line: 119 ]] --[[ Name: Connect ]]
    -- upvalues: v5 (copy)
    if v13._active == false then
        return (setmetatable({
            Connected = false
        }, v5));
    else
        local l__head_0 = v13._head;
        local v17 = setmetatable({
            Connected = true, 
            _func = v14, 
            _signal = v13, 
            _next = l__head_0, 
            _prev = nil, 
            _is_wait = v15
        }, v5);
        if l__head_0 ~= nil then
            l__head_0._prev = v17;
        end;
        v13._head = v17;
        return v17;
    end;
end;
v4.Connect = function(v19, v20) --[[ Line: 152 ]] --[[ Name: Connect ]]
    -- upvalues: v18 (copy)
    local v21 = typeof(v20) == "function";
    local v22 = ":Connect must be called with a function -" .. v19._name;
    if not v21 then
        error(v22, 3);
    end;
    return (v18(v19, v20));
end;
v4.ConnectParallel = function(v23, v24) --[[ Line: 161 ]] --[[ Name: ConnectParallel ]]
    -- upvalues: v18 (copy)
    local v25 = typeof(v24) == "function";
    local v26 = ":ConnectParallel must be called with a function -" .. v23._name;
    if not v25 then
        error(v26, 3);
    end;
    return (v18(v23, function(...) --[[ Line: 167 ]]
        -- upvalues: v24 (copy)
        task.desynchronize();
        v24(...);
    end));
end;
v5.Disconnect = function(v27) --[[ Line: 173 ]] --[[ Name: Disconnect ]]
    -- upvalues: v3 (ref)
    if v27.Connected == false then
        return;
    else
        v27.Connected = false;
        local l__signal_0 = v27._signal;
        local l__next_0 = v27._next;
        local l__prev_0 = v27._prev;
        v3[v27._name] = nil;
        if l__next_0 ~= nil then
            l__next_0._prev = l__prev_0;
        end;
        if l__prev_0 ~= nil then
            l__prev_0._next = l__next_0;
        else
            l__signal_0._head = l__next_0;
        end;
        v27._func = nil;
        v27._signal = nil;
        v27._next = nil;
        v27._prev = nil;
        return;
    end;
end;
v4.Wait = function(v31) --[[ Line: 206 ]] --[[ Name: Wait ]]
    -- upvalues: v18 (copy)
    v18(v31, coroutine.running(), true);
    return coroutine.yield();
end;
v4.Call = function(v32, ...) --[[ Line: 216 ]] --[[ Name: Call ]]
    if v32._active == false then
        warn("Tried to :Fire destroyed signal -" .. v32._name);
        return;
    else
        local l__head_1 = v32._head;
        while l__head_1 ~= nil do
            task.defer(l__head_1._func, ...);
            if l__head_1._is_wait then
                local l__next_1 = l__head_1._next;
                l__head_1:Disconnect();
                l__head_1 = l__next_1;
            else
                l__head_1 = l__head_1._next;
            end;
        end;
        return;
    end;
end;
v4.DisconnectAll = function(v35) --[[ Line: 242 ]] --[[ Name: DisconnectAll ]]
    -- upvalues: v3 (ref)
    v3 = {};
    local l__head_2 = v35._head;
    while l__head_2 ~= nil do
        local l__next_2 = l__head_2._next;
        l__head_2:Disconnect();
        l__head_2 = l__next_2;
    end;
end;
v4.Destroy = function(v38) --[[ Line: 254 ]] --[[ Name: Destroy ]]
    if v38._active == false then
        return;
    else
        v38._active = false;
        v38:DisconnectAll();
        return;
    end;
end;
v4.GetName = function(v39) --[[ Line: 263 ]] --[[ Name: GetName ]]
    return v39._name;
end;
v4.SetName = function(v40, v41) --[[ Line: 267 ]] --[[ Name: SetName ]]
    if typeof(v41) ~= "string" then
        error("Name must be a string!", 3);
    end;
    v40._name = v41;
end;
v4.__tostring = function(v42) --[[ Line: 276 ]] --[[ Name: __tostring ]]
    return "Signal " .. v42._name;
end;
v4.__call = function(v43, _, v45) --[[ Line: 284 ]] --[[ Name: __call ]]
    -- upvalues: v5 (copy), v18 (copy)
    local v46 = typeof(v45) == "function";
    local v47 = ":Connect must be called with a function -" .. v43._name;
    if not v46 then
        error(v47, 3);
    end;
    if v43._active == false then
        return (setmetatable({
            Connected = false
        }, v5));
    else
        return (v18(v43, v45));
    end;
end;
return v4;