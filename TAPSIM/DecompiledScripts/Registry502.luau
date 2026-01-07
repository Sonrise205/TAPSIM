local l_RunService_0 = game:GetService("RunService");
local v1 = require(script.Parent.Util);
local v18 = {
    TypeMethods = v1.MakeDictionary({
        "Transform", 
        "Validate", 
        "Autocomplete", 
        "Parse", 
        "DisplayName", 
        "Listable", 
        "ValidateOnce", 
        "Prefixes", 
        "Default", 
        "ArgumentOperatorAliases"
    }), 
    CommandMethods = v1.MakeDictionary({
        "Name", 
        "Aliases", 
        "AutoExec", 
        "Description", 
        "Args", 
        "Run", 
        "ClientRun", 
        "Data", 
        "Group"
    }), 
    CommandArgProps = v1.MakeDictionary({
        "Name", 
        "Type", 
        "Description", 
        "Optional", 
        "Default"
    }), 
    Types = {}, 
    TypeAliases = {}, 
    Commands = {}, 
    CommandsArray = {}, 
    Cmdr = nil, 
    Hooks = {
        BeforeRun = {}, 
        AfterRun = {}
    }, 
    Stores = setmetatable({}, {
        __index = function(v2, v3) --[[ Line: 20 ]] --[[ Name: __index ]]
            v2[v3] = {};
            return v2[v3];
        end
    }), 
    AutoExecBuffer = {}, 
    RegisterType = function(v4, v5, v6) --[[ Line: 30 ]] --[[ Name: RegisterType ]]
        if not v5 or typeof(v5) ~= "string" then
            error("Invalid type name provided: nil");
        end;
        if not v5:find("^[%d%l]%w*$") then
            error(("Invalid type name provided: \"%s\", type names must be alphanumeric and start with a lower-case letter or a digit."):format(v5));
        end;
        for v7 in pairs(v6) do
            if v4.TypeMethods[v7] == nil then
                error("Unknown key/method in type \"" .. v5 .. "\": " .. v7);
            end;
        end;
        if v4.Types[v5] ~= nil then
            error(("Type \"%s\" has already been registered."):format(v5));
        end;
        v6.Name = v5;
        v6.DisplayName = v6.DisplayName or v5;
        v4.Types[v5] = v6;
        if v6.Prefixes then
            v4:RegisterTypePrefix(v5, v6.Prefixes);
        end;
    end, 
    RegisterTypePrefix = function(v8, v9, v10) --[[ Line: 59 ]] --[[ Name: RegisterTypePrefix ]]
        if not v8.TypeAliases[v9] then
            v8.TypeAliases[v9] = v9;
        end;
        v8.TypeAliases[v9] = ("%s %s"):format(v8.TypeAliases[v9], v10);
    end, 
    RegisterTypeAlias = function(v11, v12, v13) --[[ Line: 67 ]] --[[ Name: RegisterTypeAlias ]]
        assert(v11.TypeAliases[v12] == nil, ("Type alias %s already exists!"):format(v13));
        v11.TypeAliases[v12] = v13;
    end, 
    RegisterTypesIn = function(v14, v15) --[[ Line: 73 ]] --[[ Name: RegisterTypesIn ]]
        for _, v17 in pairs(v15:GetChildren()) do
            if v17:IsA("ModuleScript") then
                v17.Parent = v14.Cmdr.ReplicatedRoot.Types;
                require(v17)(v14);
            else
                v14:RegisterTypesIn(v17);
            end;
        end;
    end
};
v18.RegisterHooksIn = v18.RegisterTypesIn;
v18.RegisterCommandObject = function(v19, v20, _) --[[ Line: 90 ]] --[[ Name: RegisterCommandObject ]]
    -- upvalues: l_RunService_0 (copy)
    for v22 in pairs(v20) do
        if v19.CommandMethods[v22] == nil then
            error("Unknown key/method in command " .. (v20.Name or "unknown command") .. ": " .. v22);
        end;
    end;
    if v20.Args then
        for v23, v24 in pairs(v20.Args) do
            if type(v24) == "table" then
                for v25 in pairs(v24) do
                    if v19.CommandArgProps[v25] == nil then
                        error(("Unknown property in command \"%s\" argument #%d: %s"):format(v20.Name or "unknown", v23, v25));
                    end;
                end;
            end;
        end;
    end;
    if v20.AutoExec and l_RunService_0:IsClient() then
        table.insert(v19.AutoExecBuffer, v20.AutoExec);
        v19:FlushAutoExecBufferDeferred();
    end;
    local v26 = v19.Commands[v20.Name:lower()];
    if v26 and v26.Aliases then
        for _, v28 in pairs(v26.Aliases) do
            v19.Commands[v28:lower()] = nil;
        end;
    elseif not v26 then
        table.insert(v19.CommandsArray, v20);
    end;
    v19.Commands[v20.Name:lower()] = v20;
    if v20.Aliases then
        for _, v30 in pairs(v20.Aliases) do
            v19.Commands[v30:lower()] = v20;
        end;
    end;
end;
v18.RegisterCommand = function(v31, v32, v33, v34) --[[ Line: 135 ]] --[[ Name: RegisterCommand ]]
    -- upvalues: l_RunService_0 (copy)
    local v35 = require(v32);
    assert(typeof(v35) == "table", (("Invalid return value from command script \"%*\" (CommandDefinition expected, got %*)"):format(v32.Name, (typeof(v35)))));
    if v33 then
        assert(l_RunService_0:IsServer(), "The commandServerScript parameter is not valid for client usage.");
        v35.Run = require(v33);
    end;
    if v34 and not v34(v35) then
        return;
    else
        v31:RegisterCommandObject(v35);
        v32.Parent = v31.Cmdr.ReplicatedRoot.Commands;
        return;
    end;
end;
v18.RegisterCommandsIn = function(v36, v37, v38) --[[ Line: 157 ]] --[[ Name: RegisterCommandsIn ]]
    local v39 = {};
    local v40 = {};
    for _, v42 in pairs(v37:GetChildren()) do
        if v42:IsA("ModuleScript") then
            if not v42.Name:find("Server") then
                local l_v37_FirstChild_0 = v37:FindFirstChild(v42.Name .. "Server");
                if l_v37_FirstChild_0 then
                    v40[l_v37_FirstChild_0] = true;
                end;
                v36:RegisterCommand(v42, l_v37_FirstChild_0, v38);
            else
                v39[v42] = true;
            end;
        else
            v36:RegisterCommandsIn(v42, v38);
        end;
    end;
    for v44 in pairs(v39) do
        if not v40[v44] then
            warn("Command script " .. v44.Name .. " was skipped because it has 'Server' in its name, and has no equivalent shared script.");
        end;
    end;
end;
v18.RegisterDefaultCommands = function(v45, v46) --[[ Line: 187 ]] --[[ Name: RegisterDefaultCommands ]]
    -- upvalues: l_RunService_0 (copy), v1 (copy)
    assert(l_RunService_0:IsServer(), "RegisterDefaultCommands cannot be called from the client.");
    local v47 = type(v46) == "table";
    if v47 then
        v46 = v1.MakeDictionary(v46);
    end;
    v45:RegisterCommandsIn(v45.Cmdr.DefaultCommandsFolder, v47 and function(v48) --[[ Line: 196 ]]
        -- upvalues: v46 (ref)
        return v46[v48.Group] or false;
    end or v46);
end;
v18.GetCommand = function(v49, v50) --[[ Line: 202 ]] --[[ Name: GetCommand ]]
    v50 = v50 or "";
    return v49.Commands[v50:lower()];
end;
v18.GetCommands = function(v51) --[[ Line: 208 ]] --[[ Name: GetCommands ]]
    return v51.CommandsArray;
end;
v18.GetCommandNames = function(v52) --[[ Line: 213 ]] --[[ Name: GetCommandNames ]]
    local v53 = {};
    for _, v55 in pairs(v52.CommandsArray) do
        table.insert(v53, v55.Name);
    end;
    return v53;
end;
v18.GetCommandsAsStrings = v18.GetCommandNames;
v18.GetTypeNames = function(v56) --[[ Line: 226 ]] --[[ Name: GetTypeNames ]]
    local v57 = {};
    for v58 in pairs(v56.Types) do
        table.insert(v57, v58);
    end;
    return v57;
end;
v18.GetType = function(v59, v60) --[[ Line: 238 ]] --[[ Name: GetType ]]
    return v59.Types[v60];
end;
v18.GetTypeName = function(v61, v62) --[[ Line: 243 ]] --[[ Name: GetTypeName ]]
    return v61.TypeAliases[v62] or v62;
end;
v18.RegisterHook = function(v63, v64, v65, v66) --[[ Line: 248 ]] --[[ Name: RegisterHook ]]
    if not v63.Hooks[v64] then
        error(("Invalid hook name: %q"):format(v64), 2);
    end;
    table.insert(v63.Hooks[v64], {
        callback = v65, 
        priority = v66 or 0
    });
    table.sort(v63.Hooks[v64], function(v67, v68) --[[ Line: 254 ]]
        return v67.priority < v68.priority;
    end);
end;
v18.AddHook = v18.RegisterHook;
v18.GetStore = function(v69, v70) --[[ Line: 262 ]] --[[ Name: GetStore ]]
    return v69.Stores[v70];
end;
v18.FlushAutoExecBufferDeferred = function(v71) --[[ Line: 267 ]] --[[ Name: FlushAutoExecBufferDeferred ]]
    -- upvalues: l_RunService_0 (copy)
    if v71.AutoExecFlushConnection then
        return;
    else
        v71.AutoExecFlushConnection = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 272 ]]
            -- upvalues: v71 (copy)
            v71.AutoExecFlushConnection:Disconnect();
            v71.AutoExecFlushConnection = nil;
            v71:FlushAutoExecBuffer();
        end);
        return;
    end;
end;
v18.FlushAutoExecBuffer = function(v72) --[[ Line: 280 ]] --[[ Name: FlushAutoExecBuffer ]]
    for _, v74 in ipairs(v72.AutoExecBuffer) do
        for _, v76 in ipairs(v74) do
            v72.Cmdr.Dispatcher:EvaluateAndRun(v76);
        end;
    end;
    v72.AutoExecBuffer = {};
end;
return function(v77) --[[ Line: 290 ]]
    -- upvalues: v18 (copy)
    v18.Cmdr = v77;
    return v18;
end;