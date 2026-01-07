local l_CollectionService_0 = game:GetService("CollectionService");
local l_RunService_0 = game:GetService("RunService");
local v2 = {};
local v3 = false;
local v4 = {};
local v5 = nil;
local v6 = Random.new();
local function v13(v7) --[[ Line: 46 ]] --[[ Name: applyCurrentTransform ]]
    local l_instance_0 = v7.instance;
    if not l_instance_0 or not l_instance_0.Parent then
        return;
    elseif v7.kind == "UI" then
        if v7.rotate then
            l_instance_0.Rotation = (v7.baseRotation or 0) + math.deg(v7.rotate.angle);
        end;
        if v7.raise then
            local v9 = v7.basePosition or l_instance_0.Position;
            local v10 = v7.raise.currentOffset or 0;
            l_instance_0.Position = UDim2.new(v9.X.Scale, v9.X.Offset, v9.Y.Scale, v9.Y.Offset + v10);
        end;
        return;
    else
        local l_baseCFrame_0 = v7.baseCFrame;
        if not l_baseCFrame_0 then
            return;
        else
            local l_l_baseCFrame_0_0 = l_baseCFrame_0;
            if v7.rotate then
                l_l_baseCFrame_0_0 = l_l_baseCFrame_0_0 * CFrame.Angles(v7.rotate.angle, 0, 0);
            end;
            if v7.raise then
                l_l_baseCFrame_0_0 = l_l_baseCFrame_0_0 + Vector3.new(0, v7.raise.currentOffset or 0, 0);
            end;
            if v7.kind == "Model" then
                l_instance_0:PivotTo(l_l_baseCFrame_0_0);
                return;
            else
                l_instance_0.CFrame = l_l_baseCFrame_0_0;
                return;
            end;
        end;
    end;
end;
local function v19(v14, v15) --[[ Line: 95 ]] --[[ Name: destroyEntry ]]
    -- upvalues: v4 (copy), v5 (ref)
    local v16 = v4[v14];
    if not v16 then
        return;
    else
        if v16.ancestryConn then
            v16.ancestryConn:Disconnect();
            v16.ancestryConn = nil;
        end;
        if not v15 then
            if v16.kind == "UI" then
                local l_instance_1 = v16.instance;
                if l_instance_1.Parent then
                    l_instance_1.Rotation = v16.baseRotation or l_instance_1.Rotation;
                    l_instance_1.Position = v16.basePosition or l_instance_1.Position;
                end;
            else
                local l_instance_2 = v16.instance;
                if l_instance_2 and l_instance_2.Parent and v16.baseCFrame then
                    if v16.kind == "Model" then
                        l_instance_2:PivotTo(v16.baseCFrame);
                    else
                        l_instance_2.CFrame = v16.baseCFrame;
                    end;
                end;
            end;
        end;
        v4[v14] = nil;
        if v5 and not next(v4) then
            v5:Disconnect();
            v5 = nil;
        end;
        return;
    end;
end;
local function v24(v20) --[[ Line: 133 ]] --[[ Name: createEntry ]]
    -- upvalues: v4 (copy), v19 (copy)
    if v4[v20] then
        return v4[v20];
    else
        local v21 = nil;
        if v20:IsA("GuiObject") then
            v21 = {
                instance = v20, 
                kind = "UI", 
                basePosition = v20.Position, 
                baseRotation = v20.Rotation
            };
        elseif v20:IsA("Model") then
            v21 = {
                instance = v20, 
                kind = "Model", 
                baseCFrame = v20:GetPivot()
            };
        elseif v20:IsA("BasePart") then
            v21 = {
                instance = v20, 
                kind = "BasePart", 
                baseCFrame = v20.CFrame
            };
        else
            return nil;
        end;
        v21.ancestryConn = v20.AncestryChanged:Connect(function(_, v23) --[[ Line: 163 ]]
            -- upvalues: v19 (ref), v20 (copy)
            if not v23 then
                v19(v20, true);
            end;
        end);
        v4[v20] = v21;
        return v21;
    end;
end;
local function _() --[[ Line: 173 ]] --[[ Name: ensureHeartbeat ]]
    -- upvalues: v5 (ref), l_RunService_0 (copy), v4 (copy), v19 (copy), v13 (copy)
    if v5 then
        return;
    else
        v5 = l_RunService_0.Heartbeat:Connect(function(v25) --[[ Line: 178 ]]
            -- upvalues: v4 (ref), v19 (ref), v13 (ref), v5 (ref)
            for v26, v27 in pairs(v4) do
                if not v26.Parent then
                    v19(v26, true);
                else
                    if v27.rotate then
                        v27.rotate.angle = (v27.rotate.angle + v27.rotate.speed * v25) % 6.283185307179586;
                    end;
                    if v27.raise then
                        local l_raise_0 = v27.raise;
                        l_raise_0.elapsed = l_raise_0.elapsed + v25;
                        l_raise_0 = v27.raise.phase + v27.raise.elapsed * v27.raise.angularSpeed;
                        v27.raise.currentOffset = math.sin(l_raise_0) * v27.raise.amplitude;
                    end;
                    v13(v27);
                end;
            end;
            if v5 and not next(v4) then
                v5:Disconnect();
                v5 = nil;
            end;
        end);
        return;
    end;
end;
local function _(v30) --[[ Line: 204 ]] --[[ Name: getRotateSpeed ]]
    local l_v30_Attribute_0 = v30:GetAttribute("RotateSpeed");
    if typeof(l_v30_Attribute_0) == "number" then
        return (math.rad(l_v30_Attribute_0));
    else
        return 0.7853981633974483;
    end;
end;
local function _(v33, v34) --[[ Line: 213 ]] --[[ Name: getRaiseAmplitude ]]
    local l_v33_Attribute_0 = v33:GetAttribute(v34 and "RaiseOffsetPixels" or "RaiseHeight");
    if typeof(l_v33_Attribute_0) == "number" then
        return l_v33_Attribute_0;
    elseif v34 then
        return 6;
    else
        return 0.35;
    end;
end;
local function _(v37) --[[ Line: 224 ]] --[[ Name: getRaiseSpeed ]]
    local l_v37_Attribute_0 = v37:GetAttribute("RaiseSpeed");
    if typeof(l_v37_Attribute_0) == "number" then
        return l_v37_Attribute_0;
    else
        return 1.5;
    end;
end;
local function v48(v40) --[[ Line: 234 ]] --[[ Name: enableRotation ]]
    -- upvalues: v24 (copy), v6 (copy), v13 (copy), v5 (ref), l_RunService_0 (copy), v4 (copy), v19 (copy)
    local v41 = v24(v40);
    if not v41 then
        return;
    else
        local v42 = {
            angle = v6:NextNumber(0, 6.283185307179586)
        };
        local l_v40_Attribute_0 = v40:GetAttribute("RotateSpeed");
        v42.speed = if typeof(l_v40_Attribute_0) == "number" then math.rad(l_v40_Attribute_0) else 0.7853981633974483;
        v41.rotate = v42;
        v13(v41);
        if v5 then
            return;
        else
            v5 = l_RunService_0.Heartbeat:Connect(function(v44) --[[ Line: 178 ]]
                -- upvalues: v4 (ref), v19 (ref), v13 (ref), v5 (ref)
                for v45, v46 in pairs(v4) do
                    if not v45.Parent then
                        v19(v45, true);
                    else
                        if v46.rotate then
                            v46.rotate.angle = (v46.rotate.angle + v46.rotate.speed * v44) % 6.283185307179586;
                        end;
                        if v46.raise then
                            local l_raise_1 = v46.raise;
                            l_raise_1.elapsed = l_raise_1.elapsed + v44;
                            l_raise_1 = v46.raise.phase + v46.raise.elapsed * v46.raise.angularSpeed;
                            v46.raise.currentOffset = math.sin(l_raise_1) * v46.raise.amplitude;
                        end;
                        v13(v46);
                    end;
                end;
                if v5 and not next(v4) then
                    v5:Disconnect();
                    v5 = nil;
                end;
            end);
            return;
        end;
    end;
end;
local function v52(v49) --[[ Line: 249 ]] --[[ Name: disableRotation ]]
    -- upvalues: v4 (copy), v13 (copy), v19 (copy)
    local v50 = v4[v49];
    if not v50 or not v50.rotate then
        return;
    else
        v50.rotate = nil;
        if v50.kind == "UI" then
            local l_instance_3 = v50.instance;
            if l_instance_3.Parent then
                l_instance_3.Rotation = v50.baseRotation or 0;
            end;
        end;
        v13(v50);
        if not v50.raise then
            v19(v49);
        end;
        return;
    end;
end;
local function v63(v53) --[[ Line: 271 ]] --[[ Name: enableRaise ]]
    -- upvalues: v24 (copy), v6 (copy), v13 (copy), v5 (ref), l_RunService_0 (copy), v4 (copy), v19 (copy)
    local v54 = v24(v53);
    if not v54 then
        return;
    else
        local v55 = v54.kind == "UI";
        local l_v53_Attribute_0 = v53:GetAttribute(v55 and "RaiseOffsetPixels" or "RaiseHeight");
        local v57 = if typeof(l_v53_Attribute_0) == "number" then l_v53_Attribute_0 else v55 and 6 or 0.35;
        l_v53_Attribute_0 = v53:GetAttribute("RaiseSpeed");
        local v58 = if typeof(l_v53_Attribute_0) == "number" then l_v53_Attribute_0 else 1.5;
        v54.raise = {
            amplitude = v57, 
            angularSpeed = v58 * 6.283185307179586, 
            phase = v6:NextNumber(0, 6.283185307179586), 
            elapsed = 0, 
            currentOffset = 0
        };
        v54.raise.currentOffset = math.sin(v54.raise.phase) * v57;
        v13(v54);
        if v5 then
            return;
        else
            v5 = l_RunService_0.Heartbeat:Connect(function(v59) --[[ Line: 178 ]]
                -- upvalues: v4 (ref), v19 (ref), v13 (ref), v5 (ref)
                for v60, v61 in pairs(v4) do
                    if not v60.Parent then
                        v19(v60, true);
                    else
                        if v61.rotate then
                            v61.rotate.angle = (v61.rotate.angle + v61.rotate.speed * v59) % 6.283185307179586;
                        end;
                        if v61.raise then
                            local l_raise_2 = v61.raise;
                            l_raise_2.elapsed = l_raise_2.elapsed + v59;
                            l_raise_2 = v61.raise.phase + v61.raise.elapsed * v61.raise.angularSpeed;
                            v61.raise.currentOffset = math.sin(l_raise_2) * v61.raise.amplitude;
                        end;
                        v13(v61);
                    end;
                end;
                if v5 and not next(v4) then
                    v5:Disconnect();
                    v5 = nil;
                end;
            end);
            return;
        end;
    end;
end;
local function v67(v64) --[[ Line: 295 ]] --[[ Name: disableRaise ]]
    -- upvalues: v4 (copy), v13 (copy), v19 (copy)
    local v65 = v4[v64];
    if not v65 or not v65.raise then
        return;
    else
        v65.raise = nil;
        if v65.kind == "UI" then
            local l_instance_4 = v65.instance;
            if l_instance_4.Parent and v65.basePosition then
                l_instance_4.Position = v65.basePosition;
            end;
        end;
        v13(v65);
        if not v65.rotate then
            v19(v64);
        end;
        return;
    end;
end;
local function v74(v68, v69, v70) --[[ Line: 317 ]] --[[ Name: bindTag ]]
    -- upvalues: l_CollectionService_0 (copy)
    for _, v72 in ipairs(l_CollectionService_0:GetTagged(v68)) do
        v69(v72);
    end;
    l_CollectionService_0:GetInstanceAddedSignal(v68):Connect(v69);
    l_CollectionService_0:GetInstanceRemovedSignal(v68):Connect(function(v73) --[[ Line: 323 ]]
        -- upvalues: v70 (copy)
        v70(v73);
    end);
end;
v2.Init = function(_) --[[ Line: 328 ]] --[[ Name: Init ]]
    -- upvalues: v3 (ref), v74 (copy), v48 (copy), v52 (copy), v63 (copy), v67 (copy)
    if v3 then
        return;
    else
        v3 = true;
        v74("Rotate", v48, v52);
        v74("Raise", v63, v67);
        return;
    end;
end;
return v2;