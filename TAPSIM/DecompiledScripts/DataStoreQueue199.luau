local v0 = {
    QR = true, 
    Queue = {}, 
    Process = 0
};
local v1 = {};
task.spawn(function() --[[ Line: 7 ]]
    -- upvalues: v0 (copy), v1 (copy)
    while v0.QR do
        task.wait();
        if #v0.Queue > 0 then
            local v2 = v0.Queue[1];
            table.remove(v0.Queue, 1);
            if not v1[v2.Key] then
                v1[v2.Key] = 0;
            end;
            local l_v0_0 = v0;
            l_v0_0.Process = l_v0_0.Process + 1;
            l_v0_0 = v2.Delay + v1[v2.Key] - DateTime.now().UnixTimestamp;
            if l_v0_0 <= 0 then
                l_v0_0 = 0;
            end;
            task.delay(l_v0_0, function() --[[ Line: 21 ]]
                -- upvalues: v1 (ref), v2 (copy), v0 (ref)
                local v4 = nil;
                local v5 = nil;
                local v6 = nil;
                while true do
                    v1[v2.Key] = DateTime.now().UnixTimestamp;
                    local v7, v8, v9 = pcall(v2.Func);
                    v4 = v7;
                    v5 = v8;
                    v6 = v9;
                    if not v4 then
                        warn(v5);
                    end;
                    if (not v4 or not v5) and v2.Delay then
                        task.wait(v2.Delay);
                        if v4 and v5 then
                            break;
                        end;
                    else
                        break;
                    end;
                end;
                v2.Event:Fire(v4, v5, v6);
                local l_v0_1 = v0;
                l_v0_1.Process = l_v0_1.Process - 1;
                v1[v2.Key] = DateTime.now().UnixTimestamp;
            end);
        end;
    end;
end);
v0.AddRequest = function(v11, v12, v13) --[[ Line: 40 ]] --[[ Name: AddRequest ]]
    -- upvalues: v0 (copy)
    local l_BindableEvent_0 = Instance.new("BindableEvent");
    table.insert(v0.Queue, {
        Key = v11, 
        Delay = v13, 
        Func = v12, 
        Event = l_BindableEvent_0
    });
    local v15, v16, v17 = l_BindableEvent_0.Event:Wait();
    return v15, v16, v17;
end;
v0.RemoveKey = function(v18) --[[ Line: 54 ]] --[[ Name: RemoveKey ]]
    -- upvalues: v1 (copy)
    v1[v18] = nil;
end;
return v0;