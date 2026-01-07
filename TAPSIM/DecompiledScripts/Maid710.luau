local _ = game:GetService("ReplicatedStorage");
local v1 = require(script.Parent.Promise);
local v2 = {};
v2.__index = v2;
v2.ClassName = "Maid";
v2.new = function() --[[ Line: 10 ]] --[[ Name: new ]]
    -- upvalues: v2 (copy)
    return (setmetatable({
        _connections = {}, 
        _instances = {}, 
        _promises = {}, 
        _threads = {}, 
        _objects = {}, 
        _callbacks = {}, 
        _isCleaning = false
    }, v2));
end;
v2.GiveCallback = function(v3, v4) --[[ Line: 22 ]] --[[ Name: GiveCallback ]]
    assert(typeof(v4) == "function");
    table.insert(v3._callbacks, v4);
end;
v2.TakeCallback = function(v5, v6) --[[ Line: 27 ]] --[[ Name: TakeCallback ]]
    local v7 = table.find(v5._callbacks, v6);
    if v7 then
        table.remove(v5._callbacks, v7);
    end;
end;
v2.GiveObject = function(v8, v9) --[[ Line: 34 ]] --[[ Name: GiveObject ]]
    assert(typeof(v9) == "table");
    assert(v9.Destroy);
    table.insert(v8._objects, v9);
end;
v2.TakeObject = function(v10, v11) --[[ Line: 40 ]] --[[ Name: TakeObject ]]
    local v12 = table.find(v10._objects, v11);
    if v12 then
        table.remove(v10._objects, v12);
    end;
end;
v2.GiveConnection = function(v13, v14) --[[ Line: 47 ]] --[[ Name: GiveConnection ]]
    assert(typeof(v14) == "RBXScriptConnection");
    table.insert(v13._connections, v14);
end;
v2.TakeConnection = function(v15, v16) --[[ Line: 52 ]] --[[ Name: TakeConnection ]]
    local v17 = table.find(v15._connections, v16);
    if v17 then
        table.remove(v15._connections, v17);
    end;
end;
v2.GivePromise = function(v18, v19) --[[ Line: 59 ]] --[[ Name: GivePromise ]]
    -- upvalues: v1 (copy)
    assert(v1.is(v19));
    table.insert(v18._promises, v19);
    v19:finally(function() --[[ Line: 63 ]]
        -- upvalues: v18 (copy), v19 (copy)
        local v20 = table.find(v18._promises, v19);
        if v20 then
            table.remove(v18._promises, v20);
        end;
    end);
end;
v2.TakePromise = function(v21, v22) --[[ Line: 71 ]] --[[ Name: TakePromise ]]
    local v23 = table.find(v21._promises, v22);
    if v23 then
        table.remove(v21._promises, v23);
    end;
end;
v2.GiveThread = function(v24, v25) --[[ Line: 78 ]] --[[ Name: GiveThread ]]
    assert(typeof(v25) == "thread");
    table.insert(v24._threads, v25);
end;
v2.TakeThread = function(v26, v27) --[[ Line: 83 ]] --[[ Name: TakeThread ]]
    local v28 = table.find(v26._threads, v27);
    if v28 then
        table.remove(v26._threads, v28);
    end;
end;
v2.GiveInstance = function(v29, v30) --[[ Line: 90 ]] --[[ Name: GiveInstance ]]
    assert(typeof(v30) == "Instance");
    table.insert(v29._instances, v30);
end;
v2.TakeInstance = function(v31, v32) --[[ Line: 95 ]] --[[ Name: TakeInstance ]]
    local v33 = table.find(v31._instances, v32);
    if v33 then
        table.remove(v31._instances, v33);
    end;
end;
v2.Take = function(v34, v35) --[[ Line: 102 ]] --[[ Name: Take ]]
    -- upvalues: v1 (copy)
    if typeof(v35) == "table" then
        if v1.is(v35) then
            v34:TakePromise(v35);
            return;
        else
            v34:TakeObject(v35);
            return;
        end;
    elseif typeof(v35) == "RBXScriptConnection" then
        v34:TakeConnection(v35);
        return;
    elseif typeof(v35) == "Instance" then
        v34:TakeInstance(v35);
        return;
    elseif typeof(v35) == "thread" then
        v34:TakeThread(v35);
        return;
    else
        if type(v35) == "function" then
            v34:TakeCallback(v35);
        end;
        return;
    end;
end;
v2.Give = function(v36, v37) --[[ Line: 120 ]] --[[ Name: Give ]]
    -- upvalues: v1 (copy)
    if typeof(v37) == "table" then
        if v1.is(v37) then
            v36:GivePromise(v37);
            return;
        else
            v36:GiveObject(v37);
            return;
        end;
    elseif typeof(v37) == "RBXScriptConnection" then
        v36:GiveConnection(v37);
        return;
    elseif typeof(v37) == "Instance" then
        v36:GiveInstance(v37);
        return;
    elseif typeof(v37) == "thread" then
        v36:GiveThread(v37);
        return;
    else
        if type(v37) == "function" then
            v36:GiveCallback(v37);
        end;
        return;
    end;
end;
v2.DoCleaning = function(v38) --[[ Line: 149 ]] --[[ Name: DoCleaning ]]
    if not v38._isCleaning then
        v38._isCleaning = true;
        while #v38._promises > 0 or #v38._connections > 0 or #v38._threads > 0 or #v38._instances > 0 or #v38._objects > 0 or #v38._callbacks > 0 do
            while #v38._promises > 0 do
                local v39, v40 = next(v38._promises);
                if v40 then
                    v40:cancel();
                    table.remove(v38._promises, v39);
                end;
            end;
            while #v38._connections > 0 do
                local v41, v42 = next(v38._connections);
                if v42 then
                    v42:Disconnect();
                    table.remove(v38._connections, v41);
                end;
            end;
            while #v38._threads > 0 do
                local v43, v44 = next(v38._threads);
                if v44 then
                    local v45 = nil;
                    if coroutine.running() ~= v44 then
                        v45 = pcall(function() --[[ Line: 181 ]]
                            -- upvalues: v44 (copy)
                            task.cancel(v44);
                        end);
                    end;
                    if not v45 then
                        task.defer(function() --[[ Line: 187 ]]
                            -- upvalues: v44 (copy)
                            task.cancel(v44);
                        end);
                    end;
                    table.remove(v38._threads, v43);
                end;
            end;
            while #v38._instances > 0 do
                local v46, v47 = next(v38._instances);
                if v47 then
                    v47:Destroy();
                    table.remove(v38._instances, v46);
                end;
            end;
            while #v38._objects > 0 do
                local v48, v49 = next(v38._objects);
                if v49 then
                    v49:Destroy();
                    table.remove(v38._objects, v48);
                end;
            end;
            while #v38._callbacks > 0 do
                local v50, v51 = next(v38._callbacks);
                if v51 then
                    v51();
                    table.remove(v38._callbacks, v50);
                end;
            end;
        end;
        v38._isCleaning = false;
    end;
end;
v2.Destroy = v2.DoCleaning;
return v2;