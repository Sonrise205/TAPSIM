local l_HttpService_0 = game:GetService("HttpService");
local l_RunService_0 = game:GetService("RunService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
if not l_ReplicatedStorage_0:FindFirstChild("PostieSent") then
    local l_RemoteEvent_0 = Instance.new("RemoteEvent");
    l_RemoteEvent_0.Name = "PostieSent";
    l_RemoteEvent_0.Parent = l_ReplicatedStorage_0;
end;
if not l_ReplicatedStorage_0:FindFirstChild("PostieReceived") then
    local l_RemoteEvent_1 = Instance.new("RemoteEvent");
    l_RemoteEvent_1.Name = "PostieReceived";
    l_RemoteEvent_1.Parent = l_ReplicatedStorage_0;
end;
local l_PostieSent_0 = l_ReplicatedStorage_0.PostieSent;
local l_PostieReceived_0 = l_ReplicatedStorage_0.PostieReceived;
local v7 = l_RunService_0:IsServer();
local v8 = {};
local v9 = {};
local v27 = {
    invokeClient = function(v10, v11, v12, ...) --[[ Line: 81 ]] --[[ Name: invokeClient ]]
        -- upvalues: v7 (copy), l_HttpService_0 (copy), v9 (copy), l_PostieSent_0 (copy)
        assert(v7, "Postie.invokeClient can only be called from the server");
        local v13 = coroutine.running();
        local v14 = false;
        local v15 = l_HttpService_0:GenerateGUID(false);
        v9[v15] = function(v16, v17, ...) --[[ Line: 89 ]]
            -- upvalues: v11 (copy), v14 (ref), v9 (ref), v15 (copy), v13 (copy)
            if v16 ~= v11 then
                return;
            else
                v14 = true;
                v9[v15] = nil;
                if v17 then
                    task.spawn(v13, true, ...);
                    return;
                else
                    task.spawn(v13, false);
                    return;
                end;
            end;
        end;
        task.delay(v12, function() --[[ Line: 104 ]]
            -- upvalues: v14 (ref), v9 (ref), v15 (copy), v13 (copy)
            if v14 then
                return;
            else
                v9[v15] = nil;
                task.spawn(v13, false);
                return;
            end;
        end);
        l_PostieSent_0:FireClient(v11, v10, v15, ...);
        return coroutine.yield();
    end, 
    invokeServer = function(v18, v19, ...) --[[ Line: 118 ]] --[[ Name: invokeServer ]]
        -- upvalues: v7 (copy), l_HttpService_0 (copy), v9 (copy), l_PostieSent_0 (copy)
        assert(not v7, "Postie.invokeServer can only be called from the client");
        local v20 = coroutine.running();
        local v21 = false;
        local v22 = l_HttpService_0:GenerateGUID(false);
        v9[v22] = function(v23, ...) --[[ Line: 126 ]]
            -- upvalues: v21 (ref), v9 (ref), v22 (copy), v20 (copy)
            v21 = true;
            v9[v22] = nil;
            if v23 then
                task.spawn(v20, true, ...);
                return;
            else
                task.spawn(v20, false);
                return;
            end;
        end;
        task.delay(v19, function() --[[ Line: 137 ]]
            -- upvalues: v21 (ref), v9 (ref), v22 (copy), v20 (copy)
            if v21 then
                return;
            else
                v9[v22] = nil;
                task.spawn(v20, false);
                return;
            end;
        end);
        l_PostieSent_0:FireServer(v18, v22, ...);
        return coroutine.yield();
    end, 
    setCallback = function(v24, v25) --[[ Line: 151 ]] --[[ Name: setCallback ]]
        -- upvalues: v8 (copy)
        v8[v24] = v25;
    end, 
    getCallback = function(v26) --[[ Line: 155 ]] --[[ Name: getCallback ]]
        -- upvalues: v8 (copy)
        return v8[v26];
    end
};
if v7 then
    l_PostieReceived_0.OnServerEvent:Connect(function(v28, v29, v30, ...) --[[ Line: 161 ]]
        -- upvalues: v9 (copy)
        local v31 = v9[v29];
        if not v31 then
            return;
        else
            v31(v28, v30, ...);
            return;
        end;
    end);
    l_PostieSent_0.OnServerEvent:Connect(function(v32, v33, v34, ...) --[[ Line: 170 ]]
        -- upvalues: v8 (copy), l_PostieReceived_0 (copy)
        local v35 = v8[v33];
        if v35 then
            l_PostieReceived_0:FireClient(v32, v34, true, v35(v32, ...));
            return;
        else
            l_PostieReceived_0:FireClient(v32, v34, false);
            return;
        end;
    end);
    return v27;
else
    l_PostieReceived_0.OnClientEvent:Connect(function(v36, v37, ...) --[[ Line: 180 ]]
        -- upvalues: v9 (copy)
        local v38 = v9[v36];
        if not v38 then
            return;
        else
            v38(v37, ...);
            return;
        end;
    end);
    l_PostieSent_0.OnClientEvent:Connect(function(v39, v40, ...) --[[ Line: 189 ]]
        -- upvalues: v8 (copy), l_PostieReceived_0 (copy)
        local v41 = v8[v39];
        if v41 then
            l_PostieReceived_0:FireServer(v40, true, v41(...));
            return;
        else
            l_PostieReceived_0:FireServer(v40, false);
            return;
        end;
    end);
    return v27;
end;