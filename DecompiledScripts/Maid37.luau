local _ = game:GetService("ReplicatedStorage");
local v1 = {};
v1.__index = v1;
v1.new = function() --[[ Line: 25 ]] --[[ Name: new ]]
    -- upvalues: v1 (copy)
    local v2 = {
        Connections = {}, 
        Instances = {}, 
        Promises = {}, 
        Threads = {}, 
        Objects = {}, 
        signals = {}, 
        Callbacks = {}, 
        Cleaning = false
    };
    setmetatable(v2, v1);
    return v2;
end;
v1.GiveCallback = function(v3, v4) --[[ Line: 42 ]] --[[ Name: GiveCallback ]]
    table.insert(v3.Callbacks, v4);
    return v4;
end;
v1.GiveObject = function(v5, v6) --[[ Line: 48 ]] --[[ Name: GiveObject ]]
    table.insert(v5.Objects, v6);
    return v6;
end;
v1.GiveInstance = function(v7, v8) --[[ Line: 54 ]] --[[ Name: GiveInstance ]]
    table.insert(v7.Instances, v8);
    return v8;
end;
v1.GiveConnection = function(v9, v10) --[[ Line: 60 ]] --[[ Name: GiveConnection ]]
    table.insert(v9.Connections, v10);
    return v10;
end;
v1.GivePromise = function(v11, v12) --[[ Line: 66 ]] --[[ Name: GivePromise ]]
    table.insert(v11.Promises, v12);
    v12:finally(function() --[[ Line: 69 ]]
        -- upvalues: v11 (copy), v12 (copy)
        local v13 = table.find(v11.Promises, v12);
        if v13 then
            table.remove(v11.Promises, v13);
        end;
    end);
    return v12;
end;
v1.GiveThread = function(v14, v15) --[[ Line: 79 ]] --[[ Name: GiveThread ]]
    table.insert(v14.Threads, v15);
    return v15;
end;
v1.Clean = function(v16) --[[ Line: 85 ]] --[[ Name: Clean ]]
    if not v16.Cleaning then
        v16.Cleaning = true;
        while #v16.Promises > 0 or #v16.Connections > 0 or #v16.Threads > 0 or #v16.Instances > 0 or #v16.Objects > 0 or #v16.Callbacks > 0 do
            while #v16.Promises > 0 do
                for v17 = #v16.Promises, 1, -1 do
                    v16.Promises[v17]:cancel();
                    table.remove(v16.Promises, v17);
                end;
            end;
            while #v16.Connections > 0 do
                for v18 = #v16.Connections, 1, -1 do
                    v16.Connections[v18]:Disconnect();
                    table.remove(v16.Connections, v18);
                end;
            end;
            while #v16.Threads > 0 do
                for v19 = #v16.Threads, 1, -1 do
                    local v20 = v16.Threads[v19];
                    local v21 = nil;
                    if coroutine.running() ~= v20 then
                        v21 = pcall(function() --[[ Line: 117 ]]
                            -- upvalues: v20 (copy)
                            task.cancel(v20);
                        end);
                    end;
                    if not v21 then
                        task.defer(function() --[[ Line: 123 ]]
                            -- upvalues: v20 (copy)
                            task.cancel(v20);
                        end);
                    end;
                    table.remove(v16.Threads, v19);
                end;
            end;
            while #v16.Instances > 0 do
                for v22 = #v16.Instances, 1, -1 do
                    v16.Instances[v22]:Destroy();
                    table.remove(v16.Instances, v22);
                end;
            end;
            while #v16.Objects > 0 do
                for v23 = #v16.Objects, 1, -1 do
                    v16.Objects[v23]:Destroy();
                    table.remove(v16.Objects, v23);
                end;
            end;
            while #v16.Callbacks > 0 do
                for v24 = #v16.Callbacks, 1, -1 do
                    v16.Callbacks[v24]();
                    table.remove(v16.Callbacks, v24);
                end;
            end;
        end;
        v16.Cleaning = false;
    end;
end;
v1.Destroy = v1.Clean;
return v1;