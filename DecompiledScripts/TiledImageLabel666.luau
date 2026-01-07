local l_RunService_0 = game:GetService("RunService");
local l_CollectionService_0 = game:GetService("CollectionService");
local v2 = {};
local v3 = {};
local v4 = false;
local v5 = nil;
local v6 = 0;
local function _(v7) --[[ Line: 28 ]] --[[ Name: getAnimationProperties ]]
    local l_v7_Attribute_0 = v7:GetAttribute("TiledSpeed");
    if l_v7_Attribute_0 then
        l_v7_Attribute_0 = tonumber(l_v7_Attribute_0) or 50;
    else
        l_v7_Attribute_0 = 50;
    end;
    local v9 = v7:GetAttribute("TiledDirection") or "Horizontal";
    local l_v7_Attribute_1 = v7:GetAttribute("TiledTileSize");
    if l_v7_Attribute_1 then
        l_v7_Attribute_1 = tonumber(l_v7_Attribute_1);
    end;
    return l_v7_Attribute_0, v9, l_v7_Attribute_1;
end;
v2.RegisterLabel = function(_, v13) --[[ Line: 46 ]] --[[ Name: RegisterLabel ]]
    -- upvalues: v3 (copy), v4 (ref), v6 (ref), v5 (ref), l_RunService_0 (copy), v2 (copy)
    if not v13:IsA("ImageLabel") and not v13:IsA("ImageButton") then
        warn("[TiledImageLabel] Object is not an ImageLabel or ImageButton:", v13);
        return;
    elseif v3[v13] then
        return;
    else
        local l_v13_Attribute_0 = v13:GetAttribute("TiledSpeed");
        if l_v13_Attribute_0 then
            l_v13_Attribute_0 = tonumber(l_v13_Attribute_0) or 50;
        else
            l_v13_Attribute_0 = 50;
        end;
        local v15 = v13:GetAttribute("TiledDirection") or "Horizontal";
        local l_v13_Attribute_1 = v13:GetAttribute("TiledTileSize");
        if l_v13_Attribute_1 then
            l_v13_Attribute_1 = tonumber(l_v13_Attribute_1);
        end;
        local l_l_v13_Attribute_0_0 = l_v13_Attribute_0;
        local l_v15_0 = v15;
        local l_l_v13_Attribute_1_0 = l_v13_Attribute_1;
        l_v13_Attribute_0 = v13.Position;
        if not l_l_v13_Attribute_1_0 then
            l_l_v13_Attribute_1_0 = if l_v15_0 == "Horizontal" then if v13.Size.X.Scale > 0 then nil else v13.Size.X.Offset else if v13.Size.Y.Scale > 0 then nil else v13.Size.Y.Offset;
        end;
        v3[v13] = {
            originalPosition = l_v13_Attribute_0, 
            speed = l_l_v13_Attribute_0_0, 
            direction = l_v15_0, 
            tileSize = l_l_v13_Attribute_1_0, 
            currentOffset = 0
        };
        if not v4 then
            v4 = true;
            v6 = tick();
            v5 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 93 ]]
                -- upvalues: v2 (ref)
                v2:Update();
            end);
        end;
        return;
    end;
end;
v2.Update = function(_) --[[ Line: 100 ]] --[[ Name: Update ]]
    -- upvalues: v6 (ref), v3 (copy), v2 (copy)
    local v21 = tick();
    local v22 = v21 - v6;
    v6 = v21;
    for v23, v24 in pairs(v3) do
        if not v23.Parent then
            v2:UnregisterLabel(v23);
        else
            local l_tileSize_0 = v24.tileSize;
            if not l_tileSize_0 then
                if v24.direction == "Horizontal" then
                    l_tileSize_0 = v23.AbsoluteSize.X;
                    if l_tileSize_0 == 0 then
                        l_tileSize_0 = v23.Size.X.Offset;
                    end;
                else
                    l_tileSize_0 = v23.AbsoluteSize.Y;
                    if l_tileSize_0 == 0 then
                        l_tileSize_0 = v23.Size.Y.Offset;
                    end;
                end;
                if l_tileSize_0 ~= 0 then
                    v24.tileSize = l_tileSize_0;
                else
                    continue;
                end;
            end;
            local v26 = v24.speed * v22;
            v24.currentOffset = v24.currentOffset + v26;
            if l_tileSize_0 <= v24.currentOffset then
                v24.currentOffset = v24.currentOffset % l_tileSize_0;
            end;
            local l_originalPosition_0 = v24.originalPosition;
            if v24.direction == "Horizontal" then
                v23.Position = UDim2.new(l_originalPosition_0.X.Scale, l_originalPosition_0.X.Offset - v24.currentOffset, l_originalPosition_0.Y.Scale, l_originalPosition_0.Y.Offset);
            else
                v23.Position = UDim2.new(l_originalPosition_0.X.Scale, l_originalPosition_0.X.Offset, l_originalPosition_0.Y.Scale, l_originalPosition_0.Y.Offset - v24.currentOffset);
            end;
        end;
    end;
end;
v2.UnregisterLabel = function(_, v29) --[[ Line: 166 ]] --[[ Name: UnregisterLabel ]]
    -- upvalues: v3 (copy), v4 (ref), v5 (ref)
    local v30 = v3[v29];
    if v30 then
        if v29.Parent then
            v29.Position = v30.originalPosition;
        end;
        v3[v29] = nil;
    end;
    if next(v3) == nil and v4 then
        v4 = false;
        if v5 then
            v5:Disconnect();
            v5 = nil;
        end;
    end;
end;
for _, v32 in pairs(l_CollectionService_0:GetTagged("TiledImageLabel")) do
    v2:RegisterLabel(v32);
end;
l_CollectionService_0:GetInstanceAddedSignal("TiledImageLabel"):Connect(function(v33) --[[ Line: 193 ]]
    -- upvalues: v2 (copy)
    v2:RegisterLabel(v33);
end);
l_CollectionService_0:GetInstanceRemovedSignal("TiledImageLabel"):Connect(function(v34) --[[ Line: 198 ]]
    -- upvalues: v2 (copy)
    v2:UnregisterLabel(v34);
end);
return v2;