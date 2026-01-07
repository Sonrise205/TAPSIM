local l_Players_0 = game:GetService("Players");
local l_RunService_0 = game:GetService("RunService");
local l_TweenService_0 = game:GetService("TweenService");
local v3 = require(script.VfxUtility);
local v4 = Color3.fromRGB(255, 255, 255);
local l_Neon_0 = Enum.Material.Neon;
local _ = 0.05;
local v7 = {
    TimeScale = 0.2, 
    Speed = 0.15, 
    Edge = 0.15, 
    StretchZ = 0.3, 
    DragMin = 0.1, 
    DragMax = 0.1
};
local v8 = {
    Grow = "Tail", 
    Stretch = "Tail", 
    Hold = "Tail", 
    Unstretch = "Front", 
    Shrink = "Front"
};
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v10 = Random.new();
local v11 = {};
local v12 = nil;
local function _(v13, v14) --[[ Line: 59 ]] --[[ Name: clampMin ]]
    return v13 < v14 and v14 or v13;
end;
local function _(v16, v17) --[[ Line: 60 ]] --[[ Name: jitter ]]
    -- upvalues: v10 (copy)
    return v17 == 0 and v16 or v16 * (1 + v10:NextNumber(-v17, v17));
end;
local function _() --[[ Line: 62 ]] --[[ Name: folder ]]
    -- upvalues: v12 (ref)
    if v12 and v12.Parent then
        return v12;
    else
        v12 = workspace:FindFirstChild("ClickBurstFX") or Instance.new("Folder");
        local l_v12_0 = v12;
        local l_v12_1 = v12;
        local v21 = "ClickBurstFX";
        local l_workspace_0 = workspace;
        l_v12_0.Name = v21;
        l_v12_1.Parent = l_workspace_0;
        return v12;
    end;
end;
local function _() --[[ Line: 69 ]] --[[ Name: randUnitVec ]]
    -- upvalues: v10 (copy)
    local v24 = v10:NextNumber(-1, 1);
    local v25 = v10:NextNumber(0, 6.283185307179586);
    local v26 = math.sqrt(1 - v24 * v24);
    return (Vector3.new(v26 * math.cos(v25), v24, v26 * math.sin(v25)));
end;
local function _(v28, v29) --[[ Line: 75 ]] --[[ Name: randRadius ]]
    -- upvalues: v10 (copy)
    local v30 = v28 ^ 3;
    return (v30 + (v29 ^ 3 - v30) * v10:NextNumber()) ^ 0.3333333333333333;
end;
local function v38(v32, v33, v34, v35, v36) --[[ Line: 80 ]] --[[ Name: tweenSize ]]
    -- upvalues: l_TweenService_0 (copy)
    local v37 = TweenInfo.new(v34, v35 or Enum.EasingStyle.Sine, v36 or Enum.EasingDirection.Out);
    return l_TweenService_0:Create(v32, v37, {
        Size = v33
    });
end;
local function v47(v39, v40, v41) --[[ Line: 85 ]] --[[ Name: animateShape ]]
    -- upvalues: v4 (copy), v38 (copy), l_TweenService_0 (copy)
    v39.Size = v41.eps;
    local v42 = nil;
    v42 = Instance.new("PointLight");
    v42.Color = v4;
    v42.Range = 5;
    v42.Brightness = 0;
    v42.Shadows = false;
    v42.Parent = v39;
    coroutine.wrap(function() --[[ Line: 99 ]]
        -- upvalues: v39 (copy), v38 (ref), v41 (copy), v40 (copy), v42 (ref), l_TweenService_0 (ref)
        if not v39.Parent then
            return;
        else
            local v43 = v38(v39, v41.cube, v40.Grow);
            v43:Play();
            if v42 then
                l_TweenService_0:Create(v42, TweenInfo.new(v40.Grow, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Brightness = 0.1
                }):Play();
            end;
            v43.Completed:Wait();
            if not v39.Parent then
                return;
            else
                local v44 = v38(v39, v41.longZ, v40.Stretch);
                v44:Play();
                if v42 then
                    l_TweenService_0:Create(v42, TweenInfo.new(v40.Stretch, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                        Brightness = 0.1
                    }):Play();
                end;
                v44.Completed:Wait();
                if not v39.Parent then
                    return;
                else
                    task.wait(v40.Hold);
                    if not v39.Parent then
                        return;
                    else
                        local v45 = v38(v39, v41.cube, v40.Unstretch);
                        v45:Play();
                        if v42 then
                            l_TweenService_0:Create(v42, TweenInfo.new(v40.Unstretch, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                                Brightness = 0.1
                            }):Play();
                        end;
                        v45.Completed:Wait();
                        if not v39.Parent then
                            return;
                        else
                            local v46 = v38(v39, v41.eps, v40.Shrink, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
                            v46:Play();
                            if v42 then
                                l_TweenService_0:Create(v42, TweenInfo.new(v40.Shrink, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                                    Brightness = 0
                                }):Play();
                            end;
                            v46.Completed:Wait();
                            if not v39.Parent then
                                return;
                            else
                                task.wait(v40.Dwell);
                                if v39.Parent then
                                    v39:Destroy();
                                end;
                                return;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end)();
end;
local function v50(v48, v49) --[[ Line: 129 ]] --[[ Name: phaseForAge ]]
    if v48 < v49.Grow then
        return "Grow";
    elseif v48 < v49.Grow + v49.Stretch then
        return "Stretch";
    elseif v48 < v49.Grow + v49.Stretch + v49.Hold then
        return "Hold";
    elseif v48 < v49.Grow + v49.Stretch + v49.Hold + v49.Unstretch then
        return "Unstretch";
    elseif v48 < v49.Grow + v49.Stretch + v49.Hold + v49.Unstretch + v49.Shrink then
        return "Shrink";
    else
        return "Dwell";
    end;
end;
local function v70(v51) --[[ Line: 139 ]] --[[ Name: spawnAtPosition ]]
    -- upvalues: v10 (copy), v7 (copy), l_Neon_0 (copy), v4 (copy), v12 (ref), v47 (copy), v11 (copy)
    for _ = 1, 5 do
        local v53 = v10:NextNumber(-1, 1);
        local v54 = v10:NextNumber(0, 6.283185307179586);
        local v55 = math.sqrt(1 - v53 * v53);
        local v56 = Vector3.new(v55 * math.cos(v54), v53, v55 * math.sin(v54));
        v53 = v51 + v56 * (0.125 + 1.6029999999999998 * v10:NextNumber()) ^ 0.3333333333333333;
        v55 = v7.TimeScale;
        v54 = v55 == 0 and 1 or 1 * (1 + v10:NextNumber(-v55, v55));
        v55 = {};
        local v57 = 0.1 * v54 / 1;
        v55.Grow = v57 < 0.001 and 0.001 or v57;
        v57 = 0.1 * v54 / 1;
        v55.Stretch = v57 < 0.001 and 0.001 or v57;
        v55.Hold = math.max(0 * v54 / 1, 0);
        v57 = 0.1 * v54 / 1;
        v55.Unstretch = v57 < 0.001 and 0.001 or v57;
        v57 = 0.14 * v54 / 1;
        v55.Shrink = v57 < 0.001 and 0.001 or v57;
        v55.Dwell = math.max(0.08 * v54 / 1, 0);
        local l_Edge_0 = v7.Edge;
        v57 = l_Edge_0 == 0 and 0.12 or 0.12 * (1 + v10:NextNumber(-l_Edge_0, l_Edge_0));
        local v59 = v57 < 0.05 and 0.05 or v57;
        local l_StretchZ_0 = v7.StretchZ;
        l_Edge_0 = l_StretchZ_0 == 0 and 2 or 2 * (1 + v10:NextNumber(-l_StretchZ_0, l_StretchZ_0));
        v57 = l_Edge_0 < 0.05 and 0.05 or l_Edge_0;
        local l_Speed_0 = v7.Speed;
        l_StretchZ_0 = l_Speed_0 == 0 and 20 or 20 * (1 + v10:NextNumber(-l_Speed_0, l_Speed_0));
        l_Edge_0 = l_StretchZ_0 < 0 and 0 or l_StretchZ_0;
        l_StretchZ_0 = v7.DragMin;
        l_Speed_0 = v7.DragMax;
        if l_Speed_0 < l_StretchZ_0 then
            local l_l_Speed_0_0 = l_Speed_0;
            l_Speed_0 = l_StretchZ_0;
            l_StretchZ_0 = l_l_Speed_0_0;
        end;
        local v63 = math.max(0, 7 * (1 + (l_StretchZ_0 == 0 and l_Speed_0 == 0 and 0 or v10:NextNumber(l_StretchZ_0, l_Speed_0))));
        local l_Part_0 = Instance.new("Part");
        local v65 = true;
        local v66 = false;
        local l_l_Neon_0_0 = l_Neon_0;
        l_Part_0.Anchored = v65;
        l_Part_0.CanCollide = v66;
        l_Part_0.Material = l_l_Neon_0_0;
        v65 = v4;
        v66 = 0.05;
        l_Part_0.Color = v65;
        l_Part_0.Transparency = v66;
        l_Part_0.Size = Vector3.new(0.05000000074505806, 0.05000000074505806, 0.05000000074505806, 0);
        if v12 and v12.Parent then
            v65 = v12;
        else
            v12 = workspace:FindFirstChild("ClickBurstFX") or Instance.new("Folder");
            v66 = v12;
            l_l_Neon_0_0 = v12;
            local v68 = "ClickBurstFX";
            local l_workspace_1 = workspace;
            v66.Name = v68;
            l_l_Neon_0_0.Parent = l_workspace_1;
            v65 = v12;
        end;
        l_Part_0.Parent = v65;
        v65 = v53 + v56 * 0.025;
        l_Part_0.CFrame = CFrame.lookAt(v65, v65 + v56);
        v66 = {
            eps = Vector3.new(0.05000000074505806, 0.05000000074505806, 0.05000000074505806, 0), 
            cube = Vector3.new(v59, v59, v59), 
            longZ = Vector3.new(v59, v59, v57)
        };
        v47(l_Part_0, v55, v66);
        table.insert(v11, {
            Part = l_Part_0, 
            Dir = v56, 
            Tail = v53, 
            Front = v53 + v56 * 0.05, 
            Center = v65, 
            Speed = l_Edge_0, 
            Drag = v63, 
            T = v55, 
            Age = 0
        });
    end;
end;
local function v77(v71) --[[ Line: 195 ]] --[[ Name: VfxPartBurst ]]
    -- upvalues: v3 (copy)
    local l_VfxClickPart_0 = script:FindFirstChild("VfxClickPart");
    if not l_VfxClickPart_0 or not l_VfxClickPart_0:IsA("BasePart") then
        return;
    else
        local v73 = l_VfxClickPart_0:Clone();
        v73.Parent = workspace:FindFirstChild("Debris") or workspace;
        v73.CFrame = v71.CFrame * CFrame.new(0, 0, -0.2);
        local v74 = false;
        local v75 = false;
        local v76 = true;
        v73.Anchored = v74;
        v73.CanCollide = v75;
        v73.Massless = v76;
        v74 = Instance.new("WeldConstraint");
        v74.Part0 = v73;
        v74.Part1 = v71;
        v74.Parent = v73;
        v3.ParticleEmitter(v73);
        task.delay(1, function() --[[ Line: 208 ]]
            -- upvalues: v73 (copy)
            if v73 and v73.Parent then
                v73:Destroy();
            end;
        end);
        return;
    end;
end;
l_RunService_0.RenderStepped:Connect(function(v78) --[[ Line: 212 ]]
    -- upvalues: v11 (copy), v50 (copy), v8 (copy)
    local v79 = v78 * 1;
    for v80 = #v11, 1, -1 do
        local v81 = v11[v80];
        local l_Part_1 = v81.Part;
        if not l_Part_1 or not l_Part_1.Parent then
            table.remove(v11, v80);
        else
            v81.Age = v81.Age + v78;
            if v81.Drag > 0 then
                v81.Speed = v81.Speed * math.exp(-v81.Drag * v79);
            end;
            local v83 = v81.Dir * (v81.Speed * v79);
            local v84 = math.max(l_Part_1.Size.Z, 0.05);
            local v85 = v8[v50(v81.Age, v81.T)] or "Tail";
            if v85 == "Front" then
                v81.Front = v81.Front + v83;
                v81.Tail = v81.Front - v81.Dir * v84;
                v81.Center = v81.Tail + v81.Dir * (v84 * 0.5);
            elseif v85 == "None" then
                v81.Center = v81.Center + v83;
                v81.Tail = v81.Center - v81.Dir * (v84 * 0.5);
                v81.Front = v81.Center + v81.Dir * (v84 * 0.5);
            else
                v81.Tail = v81.Tail + v83;
                v81.Front = v81.Tail + v81.Dir * v84;
                v81.Center = v81.Tail + v81.Dir * (v84 * 0.5);
            end;
            l_Part_1.CFrame = CFrame.lookAt(v81.Center, v81.Center + v81.Dir);
        end;
    end;
end);
if l_LocalPlayer_0 then
    l_LocalPlayer_0.CharacterAdded:Connect(function() --[[ Line: 242 ]]
        local l_ClickBurstFX_0 = workspace:FindFirstChild("ClickBurstFX");
        if l_ClickBurstFX_0 then
            l_ClickBurstFX_0:ClearAllChildren();
        end;
    end);
end;
return {
    Emit = function(v87) --[[ Line: 251 ]] --[[ Name: Emit ]]
        -- upvalues: v70 (copy), v77 (copy)
        if not v87 then
            return;
        else
            v70(v87.Position);
            v77(v87);
            return;
        end;
    end, 
    EmitAtCFrame = function(v88) --[[ Line: 257 ]] --[[ Name: EmitAtCFrame ]]
        -- upvalues: v70 (copy)
        v70(v88.Position);
    end
};