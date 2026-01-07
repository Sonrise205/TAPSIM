local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local v3 = require(l_ReplicatedStorage_0.Modules.Network);
local v4 = require(l_ReplicatedStorage_0.Modules.Signal);
local v5 = l_RunService_0:IsServer();
local v6 = {};
local v7 = {};
local function v17(v8) --[[ Line: 14 ]] --[[ Name: createValueInstance ]]
    local v9 = typeof(v8);
    if v9 == "number" then
        local l_NumberValue_0 = Instance.new("NumberValue");
        l_NumberValue_0.Value = v8;
        return l_NumberValue_0;
    elseif v9 == "string" then
        local l_StringValue_0 = Instance.new("StringValue");
        l_StringValue_0.Value = v8;
        return l_StringValue_0;
    elseif v9 == "boolean" then
        local l_BoolValue_0 = Instance.new("BoolValue");
        l_BoolValue_0.Value = v8;
        return l_BoolValue_0;
    elseif v9 == "Vector3" then
        local l_Vector3Value_0 = Instance.new("Vector3Value");
        l_Vector3Value_0.Value = v8;
        return l_Vector3Value_0;
    elseif v9 == "Color3" then
        local l_Color3Value_0 = Instance.new("Color3Value");
        l_Color3Value_0.Value = v8;
        return l_Color3Value_0;
    elseif v9 == "Instance" then
        local l_ObjectValue_0 = Instance.new("ObjectValue");
        l_ObjectValue_0.Value = v8;
        return l_ObjectValue_0;
    elseif v9 == "table" then
        return (Instance.new("Folder"));
    else
        local l_StringValue_1 = Instance.new("StringValue");
        l_StringValue_1.Value = tostring(v8);
        return l_StringValue_1;
    end;
end;
local function v18(v19, v20) --[[ Line: 52 ]] --[[ Name: buildInstanceTree ]]
    -- upvalues: v17 (copy), v18 (copy)
    for v21, v22 in pairs(v19) do
        local v23 = v17(v22);
        v23.Name = tostring(v21);
        if typeof(v22) == "table" then
            v18(v22, v23);
        end;
        v23.Parent = v20;
    end;
end;
local function v32(v24, v25, v26, v27) --[[ Line: 66 ]] --[[ Name: updateInstanceValue ]]
    -- upvalues: v18 (copy), v17 (copy)
    local v28 = nil;
    if v26 then
        local l_v24_FirstChild_0 = v24:FindFirstChild((tostring(v25)));
        if l_v24_FirstChild_0 then
            v28 = l_v24_FirstChild_0:FindFirstChild((tostring(v26)));
        end;
    else
        v28 = v24:FindFirstChild((tostring(v25)));
    end;
    if v28 then
        if v28:IsA("ValueBase") then
            v28.Value = v27;
            return;
        elseif typeof(v27) == "table" then
            v28:ClearAllChildren();
            v18(v27, v28);
            return;
        end;
    else
        local v30 = v17(v27);
        v30.Name = tostring(v26 or v25);
        if typeof(v27) == "table" then
            v18(v27, v30);
        end;
        if v26 then
            local l_v24_FirstChild_1 = v24:FindFirstChild((tostring(v25)));
            if l_v24_FirstChild_1 then
                v30.Parent = l_v24_FirstChild_1;
                return;
            end;
        else
            v30.Parent = v24;
        end;
    end;
end;
if v5 then
    local v33 = {};
    v7.UpdateFull = function(_, v35, v36) --[[ Line: 108 ]] --[[ Name: UpdateFull ]]
        -- upvalues: v3 (copy), v33 (copy), v18 (copy)
        v3:FireClient(v35, "UpdateFullData", v36);
        if v33[v35] then
            v33[v35]:ClearAllChildren();
            v18(v36, v33[v35]);
            return;
        else
            local l_Folder_0 = Instance.new("Folder");
            l_Folder_0.Name = "Data";
            v18(v36, l_Folder_0);
            l_Folder_0.Parent = v35;
            v33[v35] = l_Folder_0;
            return;
        end;
    end;
    v7.Update = function(_, v39, ...) --[[ Line: 125 ]] --[[ Name: Update ]]
        -- upvalues: v33 (copy), v32 (copy), v3 (copy)
        local v40 = {
            ...
        };
        local v41 = v40[1];
        local v42 = v40[2];
        local v43 = v40[3];
        if v33[v39] then
            v32(v33[v39], v42, v43, v41);
        end;
        v3:FireClient(v39, "UpdateSpecific", ...);
    end;
    l_Players_0.PlayerRemoving:Connect(function(v44) --[[ Line: 141 ]]
        -- upvalues: v33 (copy)
        v33[v44] = nil;
    end);
    return v7;
else
    v7.Data = {};
    v7.Loaded = false;
    v7.Connect = function(_, v46, v47) --[[ Line: 150 ]] --[[ Name: Connect ]]
        -- upvalues: v7 (copy), v6 (copy), v4 (copy)
        if v7.Loaded then
            task.defer(v47, v7.Data);
        end;
        if not v6[v46] then
            v6[v46] = v4.new();
        end;
        v6[v46]:Connect(v47);
    end;
    v7.Fire = function(_, v49, ...) --[[ Line: 161 ]] --[[ Name: Fire ]]
        -- upvalues: v6 (copy)
        if v6[v49] then
            v6[v49]:Call(...);
        end;
    end;
    v7.GetDataFolder = function(_) --[[ Line: 168 ]] --[[ Name: GetDataFolder ]]
        -- upvalues: l_Players_0 (copy)
        return l_Players_0.LocalPlayer:WaitForChild("Data", 10);
    end;
    v3:BindEvents({
        UpdateFullData = function(v51) --[[ Line: 174 ]] --[[ Name: UpdateFullData ]]
            -- upvalues: v7 (copy), v6 (copy)
            v7.Data = v51;
            if not v7.Loaded then
                v7.Loaded = true;
                v7:Fire("DataLoaded", v51);
            end;
            for v52, v53 in pairs(v6) do
                if v52 ~= "DataLoaded" then
                    v53:Call(v51);
                end;
            end;
        end, 
        UpdateSpecific = function(v54, v55, v56, ...) --[[ Line: 188 ]] --[[ Name: UpdateSpecific ]]
            -- upvalues: v7 (copy)
            if v7.Loaded then
                if not v56 then
                    v7.Data[v55] = v54;
                else
                    v7.Data[v55][v56] = v54;
                end;
                v7:Fire(v55, v7.Data, ...);
            end;
        end
    });
    return v7;
end;