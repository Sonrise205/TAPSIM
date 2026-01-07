local l_CollectionService_0 = game:GetService("CollectionService");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("TweenService");
local l_Players_0 = game:GetService("Players");
local v4 = 2;
local v5 = 1.1;
local v6 = 1;
local v7 = 100;
local v8 = (v5 - v6) / 2;
local v9 = (v5 + v6) / 2;
local v10 = {};
local v11 = {};
local v12 = 0;
v10.Init = function(v13) --[[ Line: 24 ]] --[[ Name: Init ]]
    -- upvalues: v12 (ref), l_CollectionService_0 (copy)
    v12 = tick();
    for _, v15 in pairs(l_CollectionService_0:GetTagged("Grow")) do
        v13:RegisterModel(v15);
    end;
    l_CollectionService_0:GetInstanceAddedSignal("Grow"):Connect(function(v16) --[[ Line: 34 ]]
        -- upvalues: v13 (copy)
        v13:RegisterModel(v16);
    end);
    l_CollectionService_0:GetInstanceRemovedSignal("Grow"):Connect(function(v17) --[[ Line: 39 ]]
        -- upvalues: v13 (copy)
        v13:StopGrowing(v17);
    end);
    v13:StartOscillationLoop();
end;
v10.RegisterModel = function(v18, v19) --[[ Line: 48 ]] --[[ Name: RegisterModel ]]
    -- upvalues: v11 (ref)
    if not v19:IsA("Model") then
        return;
    elseif v11[v19] then
        return;
    else
        local l_v19_Attribute_0 = v19:GetAttribute("OriginalScale");
        if not l_v19_Attribute_0 then
            l_v19_Attribute_0 = 1;
            v19:SetAttribute("OriginalScale", l_v19_Attribute_0);
        end;
        v11[v19] = {
            originalScale = l_v19_Attribute_0, 
            currentScale = l_v19_Attribute_0, 
            isGrowing = false, 
            startTime = tick(), 
            parts = {}, 
            originalSizes = {}
        };
        v18:StoreModelParts(v19);
        return;
    end;
end;
v10.StartGrowing = function(_, v22) --[[ Line: 81 ]] --[[ Name: StartGrowing ]]
    -- upvalues: v11 (ref)
    local v23 = v11[v22];
    if not v23 or v23.isGrowing then
        return;
    else
        v23.isGrowing = true;
        v23.startTime = tick();
        return;
    end;
end;
v10.StopGrowingDistance = function(_, v25) --[[ Line: 92 ]] --[[ Name: StopGrowingDistance ]]
    -- upvalues: v11 (ref)
    local v26 = v11[v25];
    if not v26 or not v26.isGrowing then
        return;
    else
        v26.isGrowing = false;
        return;
    end;
end;
v10.StopGrowing = function(_, v28) --[[ Line: 102 ]] --[[ Name: StopGrowing ]]
    -- upvalues: v11 (ref)
    if not v11[v28] then
        return;
    else
        v11[v28] = nil;
        return;
    end;
end;
v10.StoreModelParts = function(_, v30) --[[ Line: 112 ]] --[[ Name: StoreModelParts ]]
    -- upvalues: v11 (ref)
    local v31 = v11[v30];
    if not v31 then
        return;
    else
        v31.parts = {};
        v31.originalSizes = {};
        for _, v33 in pairs(v30:GetDescendants()) do
            if v33:IsA("BasePart") then
                table.insert(v31.parts, v33);
                v31.originalSizes[v33] = v33.Size;
            end;
        end;
        return;
    end;
end;
v10.CalculateOscillationScale = function(_, v35) --[[ Line: 132 ]] --[[ Name: CalculateOscillationScale ]]
    -- upvalues: v4 (ref), v9 (ref), v8 (ref)
    local v36 = math.sin((tick() - v35.startTime) * v4 * 2 * 3.141592653589793);
    return v9 + v36 * v8;
end;
v10.ApplyScaleToModel = function(_, v38, v39) --[[ Line: 144 ]] --[[ Name: ApplyScaleToModel ]]
    -- upvalues: v11 (ref)
    local v40 = v11[v38];
    if not v40 or not v40.parts then
        return;
    else
        for _, v42 in pairs(v40.parts) do
            if v42.Parent and v40.originalSizes[v42] then
                v42.Size = v40.originalSizes[v42] * v39;
            end;
        end;
        v40.currentScale = v39;
        return;
    end;
end;
v10.ResetScale = function(v43, v44) --[[ Line: 162 ]] --[[ Name: ResetScale ]]
    -- upvalues: v11 (ref)
    if not v11[v44] then
        return;
    else
        v43:ApplyScaleToModel(v44, v11[v44].originalScale);
        return;
    end;
end;
v10.GetGrowthData = function(_, v46) --[[ Line: 174 ]] --[[ Name: GetGrowthData ]]
    -- upvalues: v11 (ref)
    return v11[v46];
end;
v10.SetGrowthSpeed = function(_, v48) --[[ Line: 179 ]] --[[ Name: SetGrowthSpeed ]]
    -- upvalues: v4 (ref), v8 (ref), v5 (ref), v6 (ref), v9 (ref)
    v4 = math.max(0.01, v48);
    v8 = (v5 - v6) / 2;
    v9 = (v5 + v6) / 2;
end;
v10.SetMaxScale = function(_, v50) --[[ Line: 187 ]] --[[ Name: SetMaxScale ]]
    -- upvalues: v5 (ref), v8 (ref), v6 (ref), v9 (ref)
    v5 = math.max(1, v50);
    v8 = (v5 - v6) / 2;
    v9 = (v5 + v6) / 2;
end;
v10.SetMinScale = function(_, v52) --[[ Line: 195 ]] --[[ Name: SetMinScale ]]
    -- upvalues: v6 (ref), v8 (ref), v5 (ref), v9 (ref)
    v6 = math.max(0.1, v52);
    v8 = (v5 - v6) / 2;
    v9 = (v5 + v6) / 2;
end;
v10.SetMaxDistance = function(_, v54) --[[ Line: 203 ]] --[[ Name: SetMaxDistance ]]
    -- upvalues: v7 (ref)
    v7 = math.max(1, v54);
end;
v10.IsPlayerNearModel = function(_, v56) --[[ Line: 208 ]] --[[ Name: IsPlayerNearModel ]]
    -- upvalues: l_Players_0 (copy), v7 (ref)
    local l_Position_0 = v56:GetBoundingBox().Position;
    for _, v59 in pairs(l_Players_0:GetPlayers()) do
        if v59.Character and v59.Character:FindFirstChild("HumanoidRootPart") and (v59.Character.HumanoidRootPart.Position - l_Position_0).Magnitude <= v7 then
            return true;
        end;
    end;
    return false;
end;
v10.StartOscillationLoop = function(v60) --[[ Line: 224 ]] --[[ Name: StartOscillationLoop ]]
    -- upvalues: l_RunService_0 (copy), v11 (ref)
    l_RunService_0.Heartbeat:Connect(function() --[[ Line: 225 ]]
        -- upvalues: v11 (ref), v60 (copy)
        for v61, v62 in pairs(v11) do
            if v61.Parent then
                local v63 = v60:IsPlayerNearModel(v61);
                if v63 and not v62.isGrowing then
                    v60:StartGrowing(v61);
                elseif not v63 and v62.isGrowing then
                    v60:StopGrowingDistance(v61);
                end;
                if v62.isGrowing then
                    local v64 = v60:CalculateOscillationScale(v62);
                    v60:ApplyScaleToModel(v61, v64);
                end;
            else
                v11[v61] = nil;
            end;
        end;
    end);
end;
v10.Cleanup = function(v65) --[[ Line: 252 ]] --[[ Name: Cleanup ]]
    -- upvalues: v11 (ref)
    for v66, _ in pairs(v11) do
        v65:StopGrowing(v66);
    end;
    v11 = {};
end;
return v10;