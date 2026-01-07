local v0 = {};
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_Players_0 = game:GetService("Players");
local v4 = {};
local v5 = {};
local _ = {};
local v7 = l_RunService_0:IsStudio();
local v8 = l_RunService_0:IsServer();
local v9 = nil;
local function v17(...) --[[ Line: 70 ]] --[[ Name: GetParamString ]]
    local v10 = table.pack(...);
    local v11 = math.min(10, v10.n);
    for v12 = 1, v11 do
        local v13 = v10[v12];
        local v14 = typeof(v10[v12]);
        if v14 == "string" then
            v10[v12] = string.format("%q[%d]", #v13 <= 18 and v13 or v13:sub(1, 15) .. "...", #v13);
        elseif v14 == "Instance" then
            local l_status_0, l_result_0 = pcall(function() --[[ Line: 81 ]]
                -- upvalues: v13 (copy)
                return v13.ClassName;
            end);
            v10[v12] = l_status_0 and string.format("%s<%s>", v14, l_result_0) or v14;
        else
            v10[v12] = v14;
        end;
    end;
    return table.concat(v10, ", ", 1, v11) .. (v11 < v10.n and string.format(", ... (%d more)", v10.n - v11) or "");
end;
local v18 = {};
local v19 = 0;
local v20 = nil;
local v21 = nil;
local v22 = nil;
if v8 then
    v20 = Instance.new("Folder", l_ReplicatedStorage_0);
    v20.Name = game.JobId ~= "" and game.JobId or "Communication";
    v21 = Instance.new("Folder", v20);
    v21.Name = "Functions";
    v22 = Instance.new("Folder", v20);
    v22.Name = "Events";
else
    v20 = l_ReplicatedStorage_0:WaitForChild(game.JobId ~= "00000000-0000-0000-0000-000000000000" and game.JobId or "Communication");
    v21 = v20:WaitForChild("Functions");
    v22 = v20:WaitForChild("Events");
end;
local l_BindableEvent_0 = Instance.new("BindableEvent");
FastSpawn = function(v24, ...) --[[ Line: 114 ]] --[[ Name: FastSpawn ]]
    -- upvalues: l_BindableEvent_0 (copy)
    coroutine.wrap(function(...) --[[ Line: 115 ]]
        -- upvalues: l_BindableEvent_0 (ref), v24 (copy)
        l_BindableEvent_0.Event:Wait();
        v24(...);
    end)(...);
    l_BindableEvent_0:Fire();
end;
YieldThread = function() --[[ Line: 123 ]] --[[ Name: YieldThread ]]
    -- upvalues: l_BindableEvent_0 (copy)
    return (function(...) --[[ Line: 128 ]]
        -- upvalues: l_BindableEvent_0 (ref)
        l_BindableEvent_0.Event:Wait();
        return ...;
    end)(coroutine.yield());
end;
ResumeThread = function(v25, ...) --[[ Line: 131 ]] --[[ Name: ResumeThread ]]
    -- upvalues: l_BindableEvent_0 (copy)
    coroutine.resume(v25, ...);
    l_BindableEvent_0:Fire();
end;
SafeInvokeCallback = function(v26, ...) --[[ Line: 140 ]] --[[ Name: SafeInvokeCallback ]]
    -- upvalues: v8 (copy), l_Players_0 (copy)
    local v27 = false;
    local v28 = nil;
    local v29 = nil;
    local v30 = nil;
    local function v31(...) --[[ Line: 146 ]] --[[ Name: finish ]]
        -- upvalues: v27 (ref), v30 (ref), v29 (ref)
        if not v27 then
            v27 = true;
            v30 = table.pack(...);
            if v29 then
                ResumeThread(v29);
            end;
        end;
    end;
    FastSpawn(function(...) --[[ Line: 157 ]]
        -- upvalues: v28 (ref), v31 (copy), v26 (copy)
        v28 = coroutine.running();
        v31(true, v26.Callback(...));
    end, ...);
    if not v27 then
        local v32 = v8 and ...;
        coroutine.wrap(function() --[[ Line: 165 ]]
            -- upvalues: v27 (ref), v28 (ref), v8 (ref), v32 (copy), l_Players_0 (ref), v31 (copy)
            while not v27 and coroutine.status(v28) ~= "dead" and (not v8 or v32.Parent == l_Players_0) do
                wait(0.5);
            end;
            v31(false);
        end)();
    end;
    if not v27 then
        v29 = coroutine.running();
        YieldThread();
    end;
    return unpack(v30);
end;
SafeInvoke = function(v33, v34, ...) --[[ Line: 186 ]] --[[ Name: SafeInvoke ]]
    -- upvalues: v8 (copy)
    local v35 = coroutine.running();
    local v36 = false;
    local v37 = nil;
    coroutine.wrap(function(...) --[[ Line: 191 ]]
        -- upvalues: v8 (ref), v37 (ref), v34 (copy), v36 (ref), v35 (copy)
        if v8 then
            v37 = table.pack(pcall(function(...) --[[ Line: 193 ]]
                -- upvalues: v34 (ref)
                return v34.Remote:InvokeClient(...);
            end, ...));
        else
            v37 = table.pack(pcall(function(...) --[[ Line: 195 ]]
                -- upvalues: v34 (ref)
                return v34.Remote:InvokeServer(...);
            end, ...));
        end;
        if not v36 then
            v36 = true;
            ResumeThread(v35);
        end;
    end)(...);
    if typeof(v33) == "number" then
        delay(v33, function() --[[ Line: 205 ]]
            -- upvalues: v36 (ref), v35 (copy)
            if not v36 then
                v36 = true;
                ResumeThread(v35);
            end;
        end);
    end;
    YieldThread();
    if v37 and v37[1] == true and v37[2] == true then
        return true, unpack(v37, 3);
    else
        return false;
    end;
end;
SafeFireEvent = function(v38, ...) --[[ Line: 222 ]] --[[ Name: SafeFireEvent ]]
    local l_Callbacks_0 = v38.Callbacks;
    local v40 = #l_Callbacks_0;
    while v40 > 0 do
        local v41 = true;
        do
            local l_v41_0 = v41;
            FastSpawn(function(...) --[[ Line: 229 ]]
                -- upvalues: l_v41_0 (ref), v40 (ref), l_Callbacks_0 (copy)
                while l_v41_0 and v40 > 0 do
                    local v43 = l_Callbacks_0[v40];
                    v40 = v40 - 1;
                    v43(...);
                end;
            end, ...);
            l_v41_0 = false;
        end;
    end;
end;
WaitForChild = function(v44, v45) --[[ Line: 243 ]] --[[ Name: WaitForChild ]]
    local l_v44_FirstChild_0 = v44:FindFirstChild(v45);
    if not l_v44_FirstChild_0 then
        local v47 = coroutine.running();
        local v48 = nil;
        do
            local l_v48_0 = v48;
            l_v48_0 = v44.ChildAdded:Connect(function(v50) --[[ Line: 250 ]]
                -- upvalues: v45 (copy), l_v48_0 (ref), l_v44_FirstChild_0 (ref), v47 (copy)
                if v50.Name == v45 then
                    l_v48_0:Disconnect();
                    l_v44_FirstChild_0 = v50;
                    ResumeThread(v47);
                end;
            end);
            YieldThread();
        end;
    end;
    return l_v44_FirstChild_0;
end;
GetEventHandler = function(v51) --[[ Line: 264 ]] --[[ Name: GetEventHandler ]]
    -- upvalues: v4 (copy), v22 (ref), v8 (copy), v19 (ref), v7 (copy)
    local v52 = v4[v51];
    if v52 then
        return v52;
    else
        local v53 = {
            Name = v51, 
            Folder = v22, 
            Callbacks = {}, 
            IncomingQueueErrored = nil
        };
        v4[v51] = v53;
        if v8 then
            local l_RemoteEvent_0 = Instance.new("RemoteEvent");
            l_RemoteEvent_0.Name = v53.Name;
            l_RemoteEvent_0.Parent = v53.Folder;
            v53.Remote = l_RemoteEvent_0;
            return v53;
        else
            FastSpawn(function() --[[ Line: 287 ]]
                -- upvalues: v53 (copy), v19 (ref), v7 (ref)
                v53.Queue = {};
                local v55 = WaitForChild(v53.Folder, v53.Name);
                v53.Remote = v55;
                if #v53.Callbacks == 0 then
                    v53.IncomingQueue = {};
                end;
                v55.OnClientEvent:Connect(function(...) --[[ Line: 297 ]]
                    -- upvalues: v53 (ref), v55 (copy), v19 (ref)
                    if v53.IncomingQueue then
                        if #v53.IncomingQueue >= 2048 then
                            if not v53.IncomingQueueErrored then
                                v53.IncomingQueueErrored = true;
                                FastSpawn(error, string.format("Exhausted remote invocation queue for %s", v55:GetFullName()), -1);
                                delay(1, function() --[[ Line: 304 ]]
                                    -- upvalues: v53 (ref)
                                    v53.IncomingQueueErrored = nil;
                                end);
                            end;
                            if #v53.IncomingQueue >= 8172 then
                                table.remove(v53.IncomingQueue, 1);
                            end;
                        end;
                        v19 = v19 + 1;
                        table.insert(v53.IncomingQueue, table.pack(v19, v53, ...));
                        return;
                    else
                        SafeFireEvent(v53, ...);
                        return;
                    end;
                end);
                if not v7 then
                    v55.Name = "";
                end;
                for _, v57 in pairs(v53.Queue) do
                    v57();
                end;
                v53.Queue = nil;
            end);
            return v53;
        end;
    end;
end;
GetFunctionHandler = function(v58) --[[ Line: 337 ]] --[[ Name: GetFunctionHandler ]]
    -- upvalues: v5 (copy), v21 (ref), v8 (copy), v19 (ref), v7 (copy)
    local v59 = v5[v58];
    if v59 then
        return v59;
    else
        local v60 = {
            Name = v58, 
            Folder = v21, 
            Callback = nil, 
            IncomingQueueErrored = nil
        };
        v5[v58] = v60;
        if v8 then
            local l_RemoteFunction_0 = Instance.new("RemoteFunction");
            l_RemoteFunction_0.Name = v60.Name;
            l_RemoteFunction_0.Parent = v60.Folder;
            v60.Remote = l_RemoteFunction_0;
            return v60;
        else
            FastSpawn(function() --[[ Line: 360 ]]
                -- upvalues: v60 (copy), v19 (ref), v7 (ref)
                v60.Queue = {};
                local v62 = WaitForChild(v60.Folder, v60.Name);
                v60.Remote = v62;
                v60.IncomingQueue = {};
                v60.OnClientInvoke = function(...) --[[ Line: 367 ]]
                    -- upvalues: v60 (ref), v62 (copy), v19 (ref)
                    if not v60.Callback then
                        if #v60.IncomingQueue >= 2048 then
                            if not v60.IncomingQueueErrored then
                                v60.IncomingQueueErrored = true;
                                FastSpawn(error, string.format("Exhausted remote invocation queue for %s", v62:GetFullName()), -1);
                                delay(1, function() --[[ Line: 374 ]]
                                    -- upvalues: v60 (ref)
                                    v60.IncomingQueueErrored = nil;
                                end);
                            end;
                            if #v60.IncomingQueue >= 8172 then
                                table.remove(v60.IncomingQueue, 1);
                            end;
                        end;
                        v19 = v19 + 1;
                        local v63 = table.pack(v19, v60, coroutine.running());
                        table.insert(v60.IncomingQueue, v63);
                        YieldThread();
                    end;
                    return SafeInvokeCallback(v60, ...);
                end;
                if not v7 then
                    v62.Name = "";
                end;
                for _, v65 in pairs(v60.Queue) do
                    v65();
                end;
                v60.Queue = nil;
            end);
            return v60;
        end;
    end;
end;
AddToQueue = function(v66, v67, v68) --[[ Line: 409 ]] --[[ Name: AddToQueue ]]
    if v66.Remote then
        return v67();
    else
        v66.Queue[#v66.Queue + 1] = v67;
        if v68 then
            delay(5, function() --[[ Line: 417 ]]
                -- upvalues: v66 (copy)
                if not v66.Remote then
                    warn(debug.traceback(("Infinite yield possible on '%s:WaitForChild(\"%s\")'"):format(v66.Folder:GetFullName(), v66.Name)));
                end;
            end);
        end;
        return;
    end;
end;
ExecuteDeferredHandlers = function() --[[ Line: 425 ]] --[[ Name: ExecuteDeferredHandlers ]]
    -- upvalues: v18 (ref)
    local l_v18_0 = v18;
    local v70 = {};
    v18 = {};
    for v71 in pairs(l_v18_0) do
        local l_IncomingQueue_0 = v71.IncomingQueue;
        v71.IncomingQueue = nil;
        table.move(l_IncomingQueue_0, 1, #l_IncomingQueue_0, #v70 + 1, v70);
    end;
    table.sort(v70, function(v73, v74) --[[ Line: 438 ]]
        return v73[1] < v74[1];
    end);
    for _, v76 in ipairs(v70) do
        local v77 = v76[2];
        if v77.Callbacks then
            SafeFireEvent(v77, unpack(v76, 3));
        else
            ResumeThread(v76[3]);
        end;
    end;
end;
local function _(v78) --[[ Line: 453 ]] --[[ Name: NonASCII ]]
    for v79 = 1, #v78 do
        if string.byte(v78, v79) > 127 then
            return true;
        end;
    end;
    return false;
end;
local function v85(v81) --[[ Line: 463 ]] --[[ Name: FormatArgument ]]
    if type(v81) == "string" then
        local v82 = {};
        for v83 = 1, #v81 do
            local v84 = string.byte(v81, v83);
            if v84 >= 32 and v84 <= 126 then
                table.insert(v82, (string.char(v84)));
            else
                table.insert(v82, string.format("\\x%02X", v84));
            end;
        end;
        return table.concat(v82);
    else
        return (tostring(v81));
    end;
end;
local function v95(v86, v87, v88) --[[ Line: 480 ]] --[[ Name: ValidateArgument ]]
    -- upvalues: v85 (copy)
    local v89 = false;
    local function v92(v90) --[[ Line: 481 ]] --[[ Name: WarnAndKick ]]
        -- upvalues: v85 (ref), v86 (copy), v87 (copy), v88 (copy)
        local v91 = v85(v86);
        warn(string.format("[Network] Player %s sent invalid argument to %s (%s): %s", v87.Name, v88, v90, v91));
        task.delay(0.1, function() --[[ Line: 486 ]]
            -- upvalues: v87 (ref), v90 (copy)
            if v87.Parent then
                v87:Kick("Anti Cheat Reason: " .. v90);
            end;
        end);
        return false;
    end;
    if type(v86) == "string" then
        if utf8.len(v86) == nil then
            return (v92("invalid UTF-8"));
        elseif string.len(v86) > 255 then
            return (v92("string too long"));
        else
            local v93;
            for v94 = 1, #v86 do
                if string.byte(v86, v94) > 127 then
                    v93 = true;
                    v89 = true;
                end;
                if v89 then
                    break;
                end;
            end;
            if not v89 then
                v93 = false;
            end;
            v89 = false;
            if v93 then
                return (v92("non-ASCII characters"));
            end;
        end;
    elseif type(v86) == "number" then
        if v86 ~= v86 then
            return (v92("NaN"));
        elseif math.abs(v86) == 1e999 then
            return (v92("infinity"));
        end;
    elseif type(v86) == "userdata" and typeof(v86) ~= "CFrame" and typeof(v86) ~= "Instance" then
        return (v92("userdata"));
    elseif type(v86) == "nil" then
        return true;
    end;
    return true;
end;
local v122 = {
    MatchParams = function(v96, v97) --[[ Line: 528 ]] --[[ Name: MatchParams ]]
        -- upvalues: v8 (copy), v7 (copy)
        v97 = {
            unpack(v97)
        };
        local v98 = 1;
        for v99, v100 in pairs(v97) do
            local v101 = type(v100) == "string" and string.split(v100, "|") or v100;
            local v102 = {};
            local v103 = "";
            for _, v105 in pairs(v101) do
                local v106 = v105:gsub("^%s+", ""):gsub("%s+$", "");
                v103 = v103 .. (#v103 > 0 and " or " or "") .. v106;
                v102[v106:lower()] = true;
            end;
            v102._string = v103;
            v97[v99] = v102;
        end;
        if v8 then
            v98 = 2;
            table.insert(v97, 1, false);
        end;
        return function(v107, ...) --[[ Line: 554 ]] --[[ Name: MatchParams ]]
            -- upvalues: v97 (ref), v7 (ref), v96 (copy), v98 (ref)
            local v108 = table.pack(...);
            if v108.n > #v97 then
                if v7 then
                    warn(("[Network] Invalid number of parameters to %s (%s expected, got %s)"):format(v96, #v97 - v98 + 1, v108.n - v98 + 1));
                end;
                return;
            else
                for v109 = v98, #v97 do
                    local v110 = typeof(v108[v109]);
                    local v111 = v97[v109];
                    if not v111[v110:lower()] and not v111.any then
                        if v7 then
                            warn(("[Network] Invalid parameter %d to %s (%s expected, got %s)"):format(v109 - v98 + 1, v96, v111._string, v110));
                        end;
                        return;
                    end;
                end;
                return v107(...);
            end;
        end;
    end, 
    ValidateInput = function(v112) --[[ Line: 582 ]] --[[ Name: ValidateInput ]]
        -- upvalues: v8 (copy), v95 (copy)
        return function(v113, ...) --[[ Line: 583 ]]
            -- upvalues: v8 (ref), v95 (ref), v112 (copy)
            if v8 then
                local v114 = table.pack(...);
                local v115 = v114[1];
                local function v116(v117, v118) --[[ Line: 589 ]] --[[ Name: ValidateNestedTable ]]
                    -- upvalues: v116 (copy), v95 (ref), v115 (copy), v112 (ref)
                    if v118 > 10 then
                        return false;
                    else
                        if type(v117) == "table" then
                            for _, v120 in pairs(v117) do
                                if not v116(v120, v118 + 1) then
                                    return false;
                                end;
                            end;
                        elseif not v95(v117, v115, v112) then
                            return false;
                        end;
                        return true;
                    end;
                end;
                for v121 = 2, v114.n do
                    if not v116(v114[v121], 0) then
                        return;
                    end;
                end;
            end;
            return v113(...);
        end;
    end
};
combineFn = function(v123, v124, ...) --[[ Line: 622 ]] --[[ Name: combineFn ]]
    -- upvalues: v8 (copy), v122 (copy), v9 (ref), v17 (copy)
    local v125 = {
        ...
    };
    if v8 then
        table.insert(v125, 1, v122.ValidateInput(v123.Name));
    end;
    if typeof(v124) == "table" then
        local l_v124_0 = v124;
        v124 = v124[1];
        if l_v124_0.MatchParams then
            table.insert(v125, v122.MatchParams(v123.Name, l_v124_0.MatchParams));
        end;
    end;
    return function(...) --[[ Line: 639 ]] --[[ Name: NetworkHandler ]]
        -- upvalues: v9 (ref), v123 (copy), v17 (ref), v125 (copy), v124 (ref)
        if v9 then
            table.insert(v9[...][v123.Remote].dataIn, v17(select(2, ...)));
        end;
        local v127 = 1;
        local function v128(v129, ...) --[[ Line: 647 ]] --[[ Name: runMiddleware ]]
            -- upvalues: v127 (ref), v125 (ref), v128 (copy), v124 (ref)
            if v129 ~= v127 then
                return;
            else
                v127 = v127 + 1;
                if v129 <= #v125 then
                    return v125[v129](function(...) --[[ Line: 655 ]]
                        -- upvalues: v128 (ref), v129 (copy)
                        return v128(v129 + 1, ...);
                    end, ...);
                else
                    return v124(...);
                end;
            end;
        end;
        return v128(1, ...);
    end;
end;
v0.BindEvents = function(_, v131, v132) --[[ Line: 667 ]] --[[ Name: BindEvents ]]
    -- upvalues: v8 (copy), v18 (ref)
    if typeof(v131) == "table" then
        local v133 = nil;
        v132 = v131;
        v131 = v133;
    end;
    for v134, v135 in pairs(v132) do
        local v136 = GetEventHandler(v134);
        if not v136 then
            error(("Tried to bind callback to non-existing RemoteEvent %q"):format(v134));
        end;
        v136.Callbacks[#v136.Callbacks + 1] = combineFn(v136, v135, v131);
        if v8 then
            v136.Remote.OnServerEvent:Connect(function(...) --[[ Line: 681 ]]
                -- upvalues: v136 (copy)
                SafeFireEvent(v136, ...);
            end);
        elseif v136.IncomingQueue then
            v18[v136] = true;
        end;
    end;
    ExecuteDeferredHandlers();
end;
v0.BindFunctions = function(_, v138, v139) --[[ Line: 694 ]] --[[ Name: BindFunctions ]]
    -- upvalues: v8 (copy), v18 (ref)
    if typeof(v138) == "table" then
        local v140 = nil;
        v139 = v138;
        v138 = v140;
    end;
    for v141, v142 in pairs(v139) do
        local v143 = GetFunctionHandler(v141);
        if not v143 then
            error(("Tried to bind callback to non-existing RemoteFunction %q"):format(v141));
        end;
        if v143.Callback then
            error(("Tried to bind multiple callbacks to the same RemoteFunction (%s)"):format(v143.Remote:GetFullName()));
        end;
        v143.Callback = combineFn(v143, v142, v138);
        if v8 then
            v143.Remote.OnServerInvoke = function(...) --[[ Line: 712 ]]
                -- upvalues: v143 (copy)
                return SafeInvokeCallback(v143, ...);
            end;
        elseif v143.IncomingQueue then
            v18[v143] = true;
        end;
    end;
    ExecuteDeferredHandlers();
end;
if v8 then
    HandlerFireClient = function(v144, v145, ...) --[[ Line: 729 ]] --[[ Name: HandlerFireClient ]]
        -- upvalues: v9 (ref), v17 (copy)
        if v9 then
            table.insert(v9[v145][v144.Remote].dataOut, v17(...));
        end;
        return v144.Remote:FireClient(v145, ...);
    end;
    v0.GetPlayers = function(_) --[[ Line: 742 ]] --[[ Name: GetPlayers ]]
        -- upvalues: l_Players_0 (copy)
        return l_Players_0:GetPlayers();
    end;
    v0.GetPlayerPosition = function(_, v148) --[[ Line: 746 ]] --[[ Name: GetPlayerPosition ]]
        return v148 and v148.Character and v148.Character.PrimaryPart and v148.Character.PrimaryPart.Position or nil;
    end;
    v0.FireClient = function(_, v150, v151, ...) --[[ Line: 752 ]] --[[ Name: FireClient ]]
        local v152 = GetEventHandler(v151);
        if not v152 then
            error(("'%s' is not a valid RemoteEvent"):format(v151));
        end;
        HandlerFireClient(v152, v150, ...);
    end;
    v0.FireAllClients = function(v153, v154, ...) --[[ Line: 761 ]] --[[ Name: FireAllClients ]]
        local v155 = GetEventHandler(v154);
        if not v155 then
            error(("'%s' is not a valid RemoteEvent"):format(v154));
        end;
        for _, v157 in pairs(v153:GetPlayers()) do
            HandlerFireClient(v155, v157, ...);
        end;
    end;
    v0.FireOtherClients = function(v158, v159, v160, ...) --[[ Line: 772 ]] --[[ Name: FireOtherClients ]]
        local v161 = GetEventHandler(v160);
        if not v161 then
            error(("'%s' is not a valid RemoteEvent"):format(v160));
        end;
        for _, v163 in pairs(v158:GetPlayers()) do
            if v163 ~= v159 then
                HandlerFireClient(v161, v163, ...);
            end;
        end;
    end;
    v0.FireOtherClientsWithinDistance = function(v164, v165, v166, v167, ...) --[[ Line: 785 ]] --[[ Name: FireOtherClientsWithinDistance ]]
        local v168 = GetEventHandler(v167);
        if not v168 then
            error(("'%s' is not a valid RemoteEvent"):format(v167));
        end;
        local l_v164_PlayerPosition_0 = v164:GetPlayerPosition(v165);
        if not l_v164_PlayerPosition_0 then
            return;
        else
            for _, v171 in pairs(v164:GetPlayers()) do
                if v171 ~= v165 then
                    local l_v164_PlayerPosition_1 = v164:GetPlayerPosition(v171);
                    if l_v164_PlayerPosition_1 and (l_v164_PlayerPosition_0 - l_v164_PlayerPosition_1).Magnitude <= v166 then
                        HandlerFireClient(v168, v171, ...);
                    end;
                end;
            end;
            return;
        end;
    end;
    v0.FireAllClientsWithinDistance = function(v173, v174, v175, v176, ...) --[[ Line: 807 ]] --[[ Name: FireAllClientsWithinDistance ]]
        local v177 = GetEventHandler(v176);
        if not v177 then
            error(("'%s' is not a valid RemoteEvent"):format(v176));
        end;
        for _, v179 in pairs(v173:GetPlayers()) do
            local l_v173_PlayerPosition_0 = v173:GetPlayerPosition(v179);
            if l_v173_PlayerPosition_0 and (v174 - l_v173_PlayerPosition_0).Magnitude <= v175 then
                HandlerFireClient(v177, v179, ...);
            end;
        end;
    end;
    v0.InvokeClientWithTimeout = function(_, v182, v183, v184, ...) --[[ Line: 822 ]] --[[ Name: InvokeClientWithTimeout ]]
        local v185 = GetEventHandler(v184);
        if not v185 then
            error(("'%s' is not a valid RemoteEvent"):format(v184));
        end;
        return SafeInvoke(v182, v185, v183, ...);
    end;
    v0.InvokeClient = function(v186, ...) --[[ Line: 831 ]] --[[ Name: InvokeClient ]]
        return v186:InvokeClientWithTimeout(60, ...);
    end;
    v0.LogTraffic = function(v187, ...) --[[ Line: 836 ]] --[[ Name: LogTraffic ]]
        FastSpawn(v187.LogTrafficAsync, v187, ...);
    end;
    v0.LogTrafficAsync = function(_, v189, v190) --[[ Line: 840 ]] --[[ Name: LogTrafficAsync ]]
        -- upvalues: v9 (ref)
        v190 = v190 or warn;
        if v9 then
            return;
        else
            v190("Logging Network Traffic...");
            v9 = setmetatable({}, {
                __index = function(v191, v192) --[[ Line: 846 ]] --[[ Name: __index ]]
                    v191[v192] = setmetatable({}, {
                        __index = function(v193, v194) --[[ Line: 847 ]] --[[ Name: __index ]]
                            v193[v194] = {
                                dataIn = {}, 
                                dataOut = {}
                            };
                            return v193[v194];
                        end
                    });
                    return v191[v192];
                end
            });
            local v195 = os.clock();
            wait(v189);
            local v196 = os.clock() - v195;
            local l_v9_0 = v9;
            v9 = nil;
            for v198, v199 in pairs(l_v9_0) do
                local v200 = 0;
                local v201 = 0;
                for _, v203 in pairs(v199) do
                    v200 = v200 + #v203.dataIn;
                    v201 = v201 + #v203.dataOut;
                end;
                v190(string.format("Player '%s', total received/sent: %d/%d", v198.Name, v200, v201));
                for v204, v205 in pairs(v199) do
                    local l_dataIn_0 = v205.dataIn;
                    if #l_dataIn_0 > 0 then
                        v190(string.format("   %s %s: %d (%.2f/s)", "FireServer", v204.Name, #l_dataIn_0, #l_dataIn_0 / v196));
                        local v207 = math.min(#l_dataIn_0, 3);
                        for v208 = 1, v207 do
                            local v209 = math.floor(1 + (v208 - 1) / math.max(1, v207 - 1) * (#l_dataIn_0 - 1) + 0.5);
                            v190(string.format("      %d: %s", v209, l_dataIn_0[v209]));
                        end;
                    end;
                    local l_dataOut_0 = v205.dataOut;
                    if #l_dataOut_0 > 0 then
                        v190(string.format("   %s %s: %d (%.2f/s)", "FireClient", v204.Name, #l_dataOut_0, #l_dataOut_0 / v196));
                        local v211 = math.min(#l_dataOut_0, 3);
                        for v212 = 1, v211 do
                            local v213 = math.floor(1 + (v212 - 1) / math.max(1, v211 - 1) * (#l_dataOut_0 - 1) + 0.5);
                            v190(string.format("      %d: %s", v213, l_dataOut_0[v213]));
                        end;
                    end;
                end;
            end;
            return;
        end;
    end;
else
    v22.ChildAdded:Connect(function(v214) --[[ Line: 899 ]]
        GetEventHandler(v214.Name);
    end);
    for _, v216 in pairs(v22:GetChildren()) do
        GetEventHandler(v216.Name);
    end;
    v21.ChildAdded:Connect(function(v217) --[[ Line: 902 ]]
        GetFunctionHandler(v217.Name);
    end);
    for _, v219 in ipairs(v21:GetChildren()) do
        GetFunctionHandler(v219.Name);
    end;
    v0.FireServer = function(_, v221, ...) --[[ Line: 907 ]] --[[ Name: FireServer ]]
        local v222 = GetEventHandler(v221);
        if not v222 then
            error(("'%s' is not a valid RemoteEvent"):format(v221));
        end;
        if v222.Remote then
            v222.Remote:FireServer(...);
            return;
        else
            local v223 = table.pack(...);
            AddToQueue(v222, function() --[[ Line: 921 ]]
                -- upvalues: v222 (copy), v223 (copy)
                v222.Remote:FireServer(unpack(v223));
            end, true);
            return;
        end;
    end;
    v0.InvokeServerWithTimeout = function(_, v225, v226, ...) --[[ Line: 927 ]] --[[ Name: InvokeServerWithTimeout ]]
        local v227 = GetFunctionHandler(v226);
        if not v227 then
            error(("'%s' is not a valid RemoteFunction"):format(v226));
        end;
        if not v227.Remote then
            local v228 = coroutine.running();
            local l_v228_0 = v228 --[[ copy: 4 -> 5 ]];
            AddToQueue(v227, function() --[[ Line: 939 ]]
                -- upvalues: l_v228_0 (copy)
                ResumeThread(l_v228_0);
            end, true);
            YieldThread();
        end;
        local v230 = table.pack(SafeInvoke(v225, v227, ...));
        assert(v230[1] == true, "InvokeServer error");
        return unpack(v230, 2);
    end;
    v0.InvokeServer = function(v231, v232, ...) --[[ Line: 952 ]] --[[ Name: InvokeServer ]]
        return v231:InvokeServerWithTimeout(nil, v232, ...);
    end;
end;
local v235 = setmetatable({}, {
    __index = function(v233, v234) --[[ Line: 961 ]] --[[ Name: __index ]]
        v233[v234] = {};
        return v233[v234];
    end, 
    __mode = "k"
});
local v238 = setmetatable({}, {
    __index = function(v236, v237) --[[ Line: 962 ]] --[[ Name: __index ]]
        v236[v237] = {};
        return v236[v237];
    end, 
    __mode = "k"
});
local v239 = {
    "number", 
    "string", 
    "boolean", 
    "nil", 
    "Vector2", 
    "Vector3", 
    "CFrame", 
    "Color3", 
    "BrickColor", 
    "UDim2", 
    "UDim"
};
for _, v241 in ipairs(v239) do
    v239[v241] = true;
end;
local l_v239_0 = v239 --[[ copy: 23 -> 29 ]];
local l_v235_0 = v235 --[[ copy: 21 -> 30 ]];
local function v252(v244, v245) --[[ Line: 975 ]] --[[ Name: addEntry ]]
    -- upvalues: l_v239_0 (copy), l_v235_0 (copy), v8 (copy), v0 (copy)
    local v246 = typeof(v244);
    if not l_v239_0[v246] then
        error(string.format("Invalid value passed to Network:Pack (values of type %s are not supported)", v246));
    end;
    if v246 == "boolean" or v246 == "nil" or v244 == "" then
        return v244;
    elseif v246 == "string" and #v244 > 64 then
        return "\000" .. v244;
    else
        local v247 = l_v235_0[v245];
        local v248 = v247[v244];
        if not v248 then
            if #v247 < 32 then
                local v249 = #v247 + 1;
                v248 = {
                    char = string.char(v249), 
                    value = v244, 
                    last = 0
                };
                v247[v249] = v248;
                v247[v244] = v248;
            else
                for _, v251 in ipairs(v247) do
                    if not v248 or v251.last < v248.last then
                        v248 = v251;
                    end;
                end;
                v247[v248.value] = nil;
                v247[v244] = v248;
                v248.value = v244;
            end;
            if v8 then
                v0:FireClient(v245, "SetPackedValue", v248.char, v248.value);
            else
                v0:FireServer("SetPackedValue", v248.char, v248.value);
            end;
        end;
        v248.last = os.clock();
        return v248.char;
    end;
end;
local l_v238_0 = v238 --[[ copy: 22 -> 31 ]];
local function _(v254, v255) --[[ Line: 1023 ]] --[[ Name: getEntry ]]
    -- upvalues: l_v238_0 (copy)
    if typeof(v254) ~= "string" or v254 == "" then
        return v254;
    else
        local v256 = string.byte(v254, 1);
        if v256 == 0 then
            return (string.sub(v254, 2));
        else
            return l_v238_0[v255][v256];
        end;
    end;
end;
if v8 then
    v0.Pack = function(_, v259, v260) --[[ Line: 1038 ]] --[[ Name: Pack ]]
        -- upvalues: v252 (copy)
        local v261 = false;
        if typeof(v260) == "Instance" then
            v261 = v260:IsA("Player");
        end;
        assert(v261, "client is not a player");
        return (v252(v259, v260));
    end;
    local l_v238_1 = v238 --[[ copy: 22 -> 33 ]];
    v0.Unpack = function(_, v264, v265) --[[ Line: 1043 ]] --[[ Name: Unpack ]]
        -- upvalues: l_v238_1 (copy)
        local v266 = false;
        if typeof(v265) == "Instance" then
            v266 = v265:IsA("Player");
        end;
        assert(v266, "client is not a player");
        if typeof(v264) ~= "string" or v264 == "" then
            return v264;
        else
            local v267 = string.byte(v264, 1);
            if v267 == 0 then
                return (string.sub(v264, 2));
            else
                return l_v238_1[v265][v267];
            end;
        end;
    end;
    local l_v239_1 = v239 --[[ copy: 23 -> 34 ]];
    v0:BindEvents({
        SetPackedValue = function(v269, v270, v271) --[[ Line: 1049 ]] --[[ Name: SetPackedValue ]]
            -- upvalues: l_v239_1 (copy), l_v238_1 (copy)
            if typeof(v270) ~= "string" or #v270 ~= 1 then
                return v269:Kick();
            else
                local v272 = string.byte(v270);
                if v272 < 1 or v272 > 32 then
                    return v269:Kick();
                else
                    local v273 = typeof(v271);
                    if not l_v239_1[v273] or v273 == "string" and #v271 > 64 then
                        return v269:Kick();
                    else
                        l_v238_1[v269][v272] = v271;
                        return;
                    end;
                end;
            end;
        end
    });
else
    v0.Pack = function(_, v275) --[[ Line: 1068 ]] --[[ Name: Pack ]]
        -- upvalues: v252 (copy)
        return (v252(v275, "Server"));
    end;
    local l_v238_2 = v238 --[[ copy: 22 -> 32 ]];
    v0.Unpack = function(_, v278) --[[ Line: 1072 ]] --[[ Name: Unpack ]]
        -- upvalues: l_v238_2 (copy)
        if typeof(v278) ~= "string" or v278 == "" then
            return v278;
        else
            local v279 = string.byte(v278, 1);
            if v279 == 0 then
                return (string.sub(v278, 2));
            else
                return l_v238_2.Server[v279];
            end;
        end;
    end;
    v0:BindEvents({
        SetPackedValue = function(v280, v281) --[[ Line: 1077 ]] --[[ Name: SetPackedValue ]]
            -- upvalues: l_v238_2 (copy)
            l_v238_2.Server[string.byte(v280)] = v281;
        end
    });
end;
v235 = {
    Character = {}, 
    CharacterPart = {}
};
v238 = {};
v239 = {};
for v282, _ in pairs(v235) do
    v238[v282] = {};
    v239[v282] = {};
end;
v0.AddReference = function(_, v285, v286, ...) --[[ Line: 1100 ]] --[[ Name: AddReference ]]
    -- upvalues: v235 (copy), v238 (copy), v239 (copy)
    assert(v235[v286], "Invalid Reference Type");
    local v287 = {
        Type = v286, 
        Reference = v285, 
        Objects = {
            ...
        }, 
        Aliases = {}
    };
    v238[v286][v287.Reference] = v287;
    local v288 = v239[v286];
    for _, v290 in ipairs(v287.Objects) do
        local v291 = v288[v290] or {};
        v288[v290] = v291;
        v288 = v291;
    end;
    v288.__Data = v287;
end;
v0.AddReferenceAlias = function(_, v293, v294, ...) --[[ Line: 1123 ]] --[[ Name: AddReferenceAlias ]]
    -- upvalues: v235 (copy), v238 (copy), v239 (copy)
    assert(v235[v294], "Invalid Reference Type");
    local v295 = v238[v294][v293];
    if not v295 then
        warn("Tried to add an alias to a non-existing reference");
        return;
    else
        local v296 = {
            ...
        };
        v295.Aliases[#v295.Aliases + 1] = v296;
        local v297 = v239[v294];
        for _, v299 in ipairs(v296) do
            local v300 = v297[v299] or {};
            v297[v299] = v300;
            v297 = v300;
        end;
        v297.__Data = v295;
        return;
    end;
end;
v0.RemoveReference = function(_, v302, v303) --[[ Line: 1146 ]] --[[ Name: RemoveReference ]]
    -- upvalues: v235 (copy), v238 (copy), v239 (copy)
    assert(v235[v303], "Invalid Reference Type");
    local v304 = v238[v303][v302];
    if not v304 then
        warn("Tried to remove a non-existing reference");
        return;
    else
        v238[v303][v304.Reference] = nil;
        local function v305(v306, v307, v308) --[[ Line: 1158 ]] --[[ Name: rem ]]
            -- upvalues: v305 (copy), v304 (copy)
            if v308 <= #v307 then
                local v309 = v307[v308];
                local v310 = v306[v309];
                v305(v310, v307, v308 + 1);
                if next(v310) == nil then
                    v306[v309] = nil;
                    return;
                end;
            elseif v306.__Data == v304 then
                v306.__Data = nil;
            end;
        end;
        local v311 = v239[v304.Type];
        local l_Objects_0 = v304.Objects;
        if #l_Objects_0 >= 1 then
            local v313 = l_Objects_0[1];
            local v314 = v311[v313];
            v305(v314, l_Objects_0, 2);
            if next(v314) == nil then
                v311[v313] = nil;
            end;
        elseif v311.__Data == v304 then
            v311.__Data = nil;
        end;
        for _, v316 in ipairs(v304.Aliases) do
            if #v316 >= 1 then
                local v317 = v316[1];
                local v318 = v311[v317];
                v305(v318, v316, 2);
                if next(v318) == nil then
                    v311[v317] = nil;
                end;
            elseif v311.__Data == v304 then
                v311.__Data = nil;
            end;
        end;
        return;
    end;
end;
v0.GetObject = function(_, v320, v321) --[[ Line: 1181 ]] --[[ Name: GetObject ]]
    -- upvalues: v235 (copy), v238 (copy)
    assert(v235[v321], "Invalid Reference Type");
    local v322 = v238[v321][v320];
    if not v322 then
        return nil;
    else
        return unpack(v322.Objects);
    end;
end;
v0.GetReference = function(_, ...) --[[ Line: 1192 ]] --[[ Name: GetReference ]]
    -- upvalues: v235 (copy), v239 (copy)
    local v324 = {
        ...
    };
    local v325 = table.remove(v324);
    assert(v235[v325], "Invalid Reference Type");
    local v326 = v239[v325];
    for _, v328 in ipairs(v324) do
        v326 = v326[v328];
        if not v326 then
            break;
        end;
    end;
    local v329 = v326 and v326.__Data;
    return v329 and v329.Reference or nil;
end;
return v0;