local _ = game:GetService("Players");
local _ = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_CollectionService_0 = game:GetService("CollectionService");
local _ = game:GetService("TweenService");
local v5 = false;
local v6 = 0;
local v7 = {
    activeObjects = {}, 
    Loop = nil
};
v7.__index = v7;
v7.new = function(v8) --[[ Line: 26 ]] --[[ Name: new ]]
    -- upvalues: v7 (copy), l_CollectionService_0 (copy)
    local v9 = setmetatable({}, v7);
    v9.gameObject = v8;
    if v8:IsA("ImageLabel") or v8:IsA("ImageButton") then
        v9.originalColor = v8.ImageColor3;
    elseif v8:IsA("MeshPart") or v8:IsA("Part") then
        v9.originalColor = v8.Color;
    elseif v8:IsA("Frame") or v8:IsA("TextButton") then
        v9.originalColor = v8.BackgroundColor3;
    end;
    v7.activeObjects[v8] = v9;
    if not l_CollectionService_0:HasTag(v8, "Flash") then
        l_CollectionService_0:AddTag(v8, "Flash");
    end;
    v9.progress = 0;
    return v9;
end;
v7.update = function(v10) --[[ Line: 51 ]] --[[ Name: update ]]
    local v11 = (math.sin(tick() / 0.25) + 1) / 2;
    local v12 = 1;
    if v10.gameObject:GetAttribute("FlashIntensity") then
        v12 = v10.gameObject:GetAttribute("FlashIntensity");
    end;
    local function v17(v13) --[[ Line: 61 ]] --[[ Name: brightenColor ]]
        -- upvalues: v11 (copy), v12 (ref)
        local l_r_0 = v13.r;
        local l_g_0 = v13.g;
        local l_b_0 = v13.b;
        l_r_0 = math.clamp(l_r_0 + (1 - l_r_0) * v11 * v12 * 0.7, 0, 1);
        l_g_0 = math.clamp(l_g_0 + (1 - l_g_0) * v11 * v12 * 0.7, 0, 1);
        l_b_0 = math.clamp(l_b_0 + (1 - l_b_0) * v11 * v12 * 0.7, 0, 1);
        return Color3.new(l_r_0, l_g_0, l_b_0);
    end;
    if v10.gameObject:IsA("ImageLabel") or v10.gameObject:IsA("ImageButton") then
        v10.gameObject.ImageColor3 = v17(v10.originalColor);
    elseif v10.gameObject:IsA("MeshPart") or v10.gameObject:IsA("Part") then
        v10.gameObject.Color = v17(v10.originalColor);
    elseif (v10.gameObject:IsA("Frame") or v10.gameObject:IsA("TextButton")) and v10.gameObject.Visible then
        v10.gameObject.BackgroundColor3 = v17(v10.originalColor);
    end;
end;
v7.updateClassless = function(v18) --[[ Line: 79 ]] --[[ Name: updateClassless ]]
    local v19 = (math.sin(tick() / 0.25) + 1) / 2;
    if v18:IsA("ImageLabel") or v18:IsA("ImageButton") then
        local l_ImageColor3_0 = v18.ImageColor3;
        local l_r_1 = l_ImageColor3_0.r;
        local l_g_1 = l_ImageColor3_0.g;
        local l_b_1 = l_ImageColor3_0.b;
        l_r_1 = math.clamp(l_r_1 + (1 - l_r_1) * v19 * 0.7, 0, 1);
        l_g_1 = math.clamp(l_g_1 + (1 - l_g_1) * v19 * 0.7, 0, 1);
        l_b_1 = math.clamp(l_b_1 + (1 - l_b_1) * v19 * 0.7, 0, 1);
        v18.ImageColor3 = Color3.new(l_r_1, l_g_1, l_b_1);
    end;
end;
v7.run = function() --[[ Line: 93 ]] --[[ Name: run ]]
    -- upvalues: v6 (ref), v7 (copy), l_CollectionService_0 (copy)
    if tick() - v6 >= 0.01 then
        v6 = tick();
        for _, v25 in pairs(v7.activeObjects) do
            v25:update();
        end;
        for _, v27 in pairs(l_CollectionService_0:GetTagged("Flash")) do
            if not v7.activeObjects[v27] then
                v7.updateClassless(v27);
            end;
        end;
    end;
end;
v7.removeObject = function(v28) --[[ Line: 108 ]] --[[ Name: removeObject ]]
    -- upvalues: v7 (copy), l_CollectionService_0 (copy), v5 (ref)
    if v7.activeObjects and v7.activeObjects[v28] then
        if v28:IsA("ImageLabel") or v28:IsA("ImageButton") then
            v28.ImageColor3 = v7.activeObjects[v28].originalColor;
        elseif v28:IsA("MeshPart") or v28:IsA("Part") then
            v28.Color = v7.activeObjects[v28].originalColor;
        elseif v28:IsA("Frame") or v28:IsA("TextButton") then
            v28.BackgroundColor3 = v7.activeObjects[v28].originalColor;
        end;
        v7.activeObjects[v28] = nil;
        if #l_CollectionService_0:GetTagged("Flash") == 0 then
            v5 = false;
            v7.Loop:Disconnect();
        end;
    end;
end;
l_CollectionService_0:GetInstanceAddedSignal("Flash"):Connect(function(v29) --[[ Line: 127 ]]
    -- upvalues: v7 (copy), v5 (ref), l_RunService_0 (copy)
    if not v7.activeObjects[v29] then
        v7.new(v29);
    end;
    if not v5 then
        v5 = true;
        v7.Loop = l_RunService_0.Heartbeat:Connect(v7.run);
    end;
end);
l_CollectionService_0:GetInstanceRemovedSignal("Flash"):Connect(v7.removeObject);
if #l_CollectionService_0:GetTagged("Flash") >= 1 then
    for _, v31 in pairs(l_CollectionService_0:GetTagged("Flash")) do
        if not v7.activeObjects[v31] then
            v7.new(v31);
        end;
        if not v5 then
            v5 = true;
            v7.Loop = l_RunService_0.Heartbeat:Connect(v7.run);
        end;
    end;
end;
return v7;