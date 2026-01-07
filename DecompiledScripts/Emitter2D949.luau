local l_CollectionService_0 = game:GetService("CollectionService");
local _ = game:GetService("ReplicatedStorage");
local l_LocalPlayer_0 = game.Players.LocalPlayer;
local v3 = 0;
local v4 = script:IsA("LocalScript") == false;
local v5 = {};
local v6 = {};
local v7 = nil;
local v8 = nil;
v7 = function(v9, v10) --[[ Line: 28 ]]
    -- upvalues: v3 (ref), v8 (ref)
    if v10.Module:GetAttribute("Enabled") then
        local v11 = v10.EntityList[v9];
        if v11 then
            warn(v10.ClassName .. " client entity for [" .. v9:GetFullName() .. "] already exists (" .. v11.ID .. ")");
            return v11;
        else
            v3 = v3 + 1;
            local v12 = v10.new();
            v12.ID = v3;
            v10.EntityList[v9] = v12;
            v12.Deactivate = function(_) --[[ Line: 45 ]] --[[ Name: Deactivate ]]
                -- upvalues: v8 (ref), v9 (copy), v10 (copy)
                v8(v9, v10);
            end;
            v12.Thread = task.spawn(function() --[[ Line: 49 ]]
                -- upvalues: v10 (copy), v12 (copy), v9 (copy)
                local l_v10_0 = v10;
                l_v10_0.EntityLoadingCount = l_v10_0.EntityLoadingCount + 1;
                v12.Loading = true;
                v12:Initiate(v9);
                v12.Loading = false;
                l_v10_0 = v10;
                l_v10_0.EntityLoadingCount = l_v10_0.EntityLoadingCount - 1;
            end);
        end;
    end;
end;
v8 = function(v15, v16) --[[ Line: 59 ]]
    local v17 = v16.EntityList[v15];
    if v17 then
        v16.EntityList[v15] = nil;
        v17.Destroyed = true;
        if coroutine.status(v17.Thread) ~= "dead" then
            task.cancel(v17.Thread);
            v17.Loading = false;
            v16.EntityLoadingCount = v16.EntityLoadingCount - 1;
        end;
        v17:Destroy();
    end;
end;
for _, v19 in script:GetDescendants() do
    if v19:IsA("ModuleScript") then
        task.spawn(function() --[[ Line: 82 ]]
            -- upvalues: v19 (copy), l_LocalPlayer_0 (copy), v6 (copy), l_CollectionService_0 (copy), v7 (ref), v8 (ref), v5 (copy)
            local l_Name_0 = v19.Name;
            if v19:GetAttribute("Require_UserId") then
                l_Name_0 = l_Name_0 .. "_" .. l_LocalPlayer_0.UserId;
            end;
            local v21 = require(v19);
            v21.Module = v19;
            v21.ClassName = l_Name_0;
            v21.Destroyed = false;
            v21.EntityList = {};
            v21.EntityCount = 0;
            v21.EntityLoadingCount = 0;
            table.insert(v6, l_CollectionService_0:GetInstanceAddedSignal(l_Name_0):Connect(function(v22) --[[ Line: 106 ]]
                -- upvalues: v7 (ref), v21 (copy)
                v7(v22, v21);
            end));
            table.insert(v6, l_CollectionService_0:GetInstanceRemovedSignal(l_Name_0):Connect(function(v23) --[[ Line: 110 ]]
                -- upvalues: v8 (ref), v21 (copy)
                v8(v23, v21);
            end));
            if v19:GetAttribute("Asynchronous") then
                for _, v25 in l_CollectionService_0:GetTagged(l_Name_0) do
                    v7(v25, v21);
                end;
            else
                for _, v27 in l_CollectionService_0:GetTagged(l_Name_0) do
                    task.spawn(v7, v27, v21);
                end;
            end;
            table.insert(v6, v19:GetAttributeChangedSignal("Enabled"):Connect(function() --[[ Line: 124 ]]
                -- upvalues: v19 (ref), l_CollectionService_0 (ref), l_Name_0 (ref), v7 (ref), v21 (copy), v8 (ref)
                if v19:GetAttribute("Enabled") then
                    for _, v29 in l_CollectionService_0:GetTagged(l_Name_0) do
                        task.spawn(v7, v29, v21);
                    end;
                    return;
                else
                    for _, v31 in l_CollectionService_0:GetTagged(l_Name_0) do
                        task.spawn(v8, v31, v21);
                    end;
                    return;
                end;
            end));
            v5[l_Name_0] = v21;
        end);
    end;
end;
if v4 then
    table.insert(v6, script.Parent.Events.Deactivate.Event:Connect(function() --[[ Line: 145 ]]
        -- upvalues: v6 (copy), v5 (copy), v8 (ref)
        for _, v33 in v6 do
            v33:Disconnect();
        end;
        for _, v35 in v5 do
            for v36 in v35.EntityList do
                task.spawn(v8, v36, v35);
            end;
        end;
    end));
end;