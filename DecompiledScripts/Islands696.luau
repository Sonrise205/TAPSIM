local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_CollectionService_0 = game:GetService("CollectionService");
local v4 = require(l_ReplicatedStorage_0.Modules.Network);
local v5 = require(l_ReplicatedStorage_0.Modules.Signal);
local v6 = require(l_ReplicatedStorage_0.Game.Replication);
local v7 = require(l_ReplicatedStorage_0.Game.Portals);
local _ = l_Players_0.LocalPlayer;
local v9 = nil;
local v10 = nil;
local _ = {};
local v12 = {};
local v13 = {};
local function _(v14) --[[ Line: 27 ]] --[[ Name: canAttemptUnlock ]]
    -- upvalues: v12 (copy)
    return tick() - (v12[v14] or 0) >= 3;
end;
local function v17(v16) --[[ Line: 33 ]] --[[ Name: attemptUnlockIsland ]]
    -- upvalues: v6 (copy), v12 (copy), v4 (copy), v5 (copy)
    if not v6.Loaded or not v6.Data then
        return;
    elseif v6.Data.Portals and v6.Data.Portals[v16] then
        return;
    elseif not (tick() - (v12[v16] or 0) >= 3) then
        return;
    else
        v12[v16] = tick();
        if v4:InvokeServer("UnlockZone", v16) then
            _G:Play("PowerUp");
            v5.Fire("Notification", v16 .. " island unlocked!", Color3.fromRGB(70, 255, 41));
            v5.Fire("ScreenGlow", Color3.fromRGB(70, 255, 41), 1, 0.5);
            if v6.Data.Portals then
                v6.Data.Portals[v16] = true;
                return;
            end;
        end;
        return;
    end;
end;
local function v21(v18) --[[ Line: 69 ]] --[[ Name: setupIslandDetection ]]
    -- upvalues: v7 (copy), v9 (ref), v17 (copy)
    if not v18 or not v18:IsA("BasePart") then
        return;
    else
        local l_Name_0 = v18.Name;
        if not v7[l_Name_0] then
            return;
        else
            v18.Touched:Connect(function(v20) --[[ Line: 82 ]]
                -- upvalues: v9 (ref), v17 (ref), l_Name_0 (copy)
                if not v9 or not v20.Parent then
                    return;
                else
                    if v20.Parent == v9 or v20.Parent.Parent == v9 then
                        task.defer(function() --[[ Line: 90 ]]
                            -- upvalues: v17 (ref), l_Name_0 (ref)
                            v17(l_Name_0);
                        end);
                    end;
                    return;
                end;
            end);
            return;
        end;
    end;
end;
local _ = function() --[[ Line: 97 ]] --[[ Name: setupProximityCheck ]]
    -- upvalues: l_RunService_0 (copy), v9 (ref), v6 (copy), l_CollectionService_0 (copy), v7 (copy), v17 (copy)
    local v22 = 0;
    l_RunService_0.Heartbeat:Connect(function() --[[ Line: 104 ]]
        -- upvalues: v22 (ref), v9 (ref), v6 (ref), l_CollectionService_0 (ref), v7 (ref), v17 (ref)
        local v23 = tick();
        if v23 - v22 < 2 then
            return;
        else
            v22 = v23;
            if not v9 or not v9.PrimaryPart or not v6.Loaded then
                return;
            else
                local l_Position_0 = v9.PrimaryPart.Position;
                for _, v26 in ipairs(l_CollectionService_0:GetTagged("IslandPart")) do
                    if v26 and v26.Parent and v7[v26.Name] and (l_Position_0 - v26.Position).Magnitude <= 50 and (not v6.Data.Portals or not v6.Data.Portals[v26.Name]) then
                        v17(v26.Name);
                    end;
                end;
                return;
            end;
        end;
    end);
end;
v13.CharacterAdded = function(_, v29) --[[ Line: 133 ]] --[[ Name: CharacterAdded ]]
    -- upvalues: v9 (ref), v10 (ref), l_CollectionService_0 (copy), v7 (copy), v17 (copy)
    v9 = v29;
    v10 = v9:WaitForChild("Humanoid");
    task.delay(1, function() --[[ Line: 138 ]]
        -- upvalues: v9 (ref), l_CollectionService_0 (ref), v7 (ref), v17 (ref)
        if v9 and v9.PrimaryPart then
            local l_Position_1 = v9.PrimaryPart.Position;
            for _, v32 in ipairs(l_CollectionService_0:GetTagged("IslandPart")) do
                if v32 and v32.Parent and v7[v32.Name] and (l_Position_1 - v32.Position).Magnitude <= 100 then
                    v17(v32.Name);
                end;
            end;
        end;
    end);
end;
v13.Init = function(_) --[[ Line: 157 ]] --[[ Name: Init ]]
    -- upvalues: v6 (copy), l_CollectionService_0 (copy), v21 (copy), l_RunService_0 (copy), v9 (ref), v7 (copy), v17 (copy)
    task.defer(function() --[[ Line: 159 ]]
        -- upvalues: v6 (ref), l_CollectionService_0 (ref), v21 (ref), l_RunService_0 (ref), v9 (ref), v7 (ref), v17 (ref)
        repeat
            task.wait();
        until v6.Loaded;
        for _, v35 in ipairs(l_CollectionService_0:GetTagged("IslandPart")) do
            v21(v35);
        end;
        l_CollectionService_0:GetInstanceAddedSignal("IslandPart"):Connect(function(v36) --[[ Line: 168 ]]
            -- upvalues: v21 (ref)
            v21(v36);
        end);
        local v37 = 0;
        do
            local l_v37_0 = v37;
            l_RunService_0.Heartbeat:Connect(function() --[[ Line: 104 ]]
                -- upvalues: l_v37_0 (ref), v9 (ref), v6 (ref), l_CollectionService_0 (ref), v7 (ref), v17 (ref)
                local v39 = tick();
                if v39 - l_v37_0 < 2 then
                    return;
                else
                    l_v37_0 = v39;
                    if not v9 or not v9.PrimaryPart or not v6.Loaded then
                        return;
                    else
                        local l_Position_2 = v9.PrimaryPart.Position;
                        for _, v42 in ipairs(l_CollectionService_0:GetTagged("IslandPart")) do
                            if v42 and v42.Parent and v7[v42.Name] and (l_Position_2 - v42.Position).Magnitude <= 50 and (not v6.Data.Portals or not v6.Data.Portals[v42.Name]) then
                                v17(v42.Name);
                            end;
                        end;
                        return;
                    end;
                end;
            end);
        end;
        v6:Connect("Portals", function(_) --[[ Line: 176 ]]

        end);
    end);
end;
return v13;