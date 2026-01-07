local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_TweenService_0 = game:GetService("TweenService");
local l_SoundService_0 = game:GetService("SoundService");
local l_Debris_0 = game:GetService("Debris");
local v6 = require(l_ReplicatedStorage_0.Modules.Signal);
local v7 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v8 = require(l_ReplicatedStorage_0.Modules.Short);
local v9 = require(l_ReplicatedStorage_0.Modules.Network);
local v10 = require(l_ReplicatedStorage_0.Game.Replication);
local v11 = require(l_ReplicatedStorage_0.Game.Chests);
local _ = game.Lighting.ClockTime;
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v14 = l_LocalPlayer_0.Character or l_LocalPlayer_0.CharacterAdded:Wait();
local _ = script:WaitForChild("Orb Burst");
local _ = l_ReplicatedStorage_0.Content.Particles.ChestParticles;
local l_Particle_0 = script:WaitForChild("Particle");
local v18 = Instance.new("Folder", workspace);
v18.Name = "_Destroying";
local v19 = {};
quadBezier = function(v20, v21, v22, v23) --[[ Line: 32 ]] --[[ Name: quadBezier ]]
    return (v21:Lerp(v22, v20):Lerp(v22:Lerp(v23, v20), v20));
end;
local function _(v24, v25) --[[ Line: 39 ]] --[[ Name: darken ]]
    local v26, v27, v28 = v24:ToHSV();
    if v28 == 0 then
        return Color3.fromRGB(255, 255, 255);
    else
        return Color3.fromHSV(v26, v27, (math.clamp(v28 * v25, 0, 1)));
    end;
end;
local function _(v30, v31) --[[ Line: 47 ]] --[[ Name: saturate ]]
    local v32, v33, v34 = v30:ToHSV();
    return Color3.fromHSV(v32, math.clamp(v33 + v31, 0, 1), v34);
end;
local function _(v36, v37) --[[ Line: 52 ]] --[[ Name: hue_change ]]
    local v38, v39, v40 = v36:ToHSV();
    return Color3.fromHSV(math.clamp(v38 + v37, 0, 1), v39, v40);
end;
local function v71(v42, v43, v44) --[[ Line: 58 ]] --[[ Name: fireFirework ]]
    -- upvalues: l_RunService_0 (copy), l_TweenService_0 (copy), l_Particle_0 (copy), v18 (copy), l_Debris_0 (copy)
    local v45 = script.Fireball[v44 == "Event" and "Event" or "Attachment"]:Clone();
    v45.Parent = v42.PrimaryPart;
    v45.Drops:Emit(v45.Drops:GetAttribute("EmitCount"));
    local l_v42_Pivot_0 = v42:GetPivot();
    local v47, _, v49 = l_v42_Pivot_0:ToOrientation();
    local v50 = l_v42_Pivot_0 + (l_v42_Pivot_0 * (v43 and CFrame.Angles(v47 * 4, 0, v49 * 4) or CFrame.Angles(0, 0, 0))).UpVector * math.random(19, 24);
    local v51 = v42:FindFirstChild("Colored") and v42.Colored.Color or nil;
    local v52 = l_v42_Pivot_0:Lerp(v50, 0.5) + Vector3.new(0, 4, 0, 0);
    local v53 = tick();
    local v54 = v53 + Random.new():NextNumber(0.8, 1.1);
    local v55 = nil;
    local l_Position_0 = l_v42_Pivot_0.Position;
    v55 = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 74 ]]
        -- upvalues: v54 (copy), v53 (copy), l_TweenService_0 (ref), l_v42_Pivot_0 (copy), v52 (copy), v50 (copy), v42 (copy), l_Position_0 (ref)
        if tick() < v54 then
            local v57 = (tick() - v53) / (v54 - v53);
            v57 = l_TweenService_0:GetValue(v57, Enum.EasingStyle.Sine, Enum.EasingDirection.In);
            local v58 = quadBezier(v57, l_v42_Pivot_0.Position, v52.Position, v50.Position);
            v42:PivotTo(CFrame.lookAt(l_Position_0, v58, (Vector3.new(0, 1, 0, 0))) * CFrame.Angles(-1.5707963267948966, 0, 0));
            l_Position_0 = v58;
        end;
    end);
    task.wait(v54 - v53 - 0.2);
    v55:Disconnect();
    local v59 = l_Particle_0:Clone();
    v59.Position = v50.Position;
    v59.Parent = v18;
    if v51 then
        local v60, v61, v62 = v51:ToHSV();
        v60, v61, v62 = Color3.fromHSV(v60, math.clamp(v61 + 0.2, 0, 1), v62):ToHSV();
        local v63 = if v62 == 0 then Color3.fromRGB(255, 255, 255) else Color3.fromHSV(v60, v61, (math.clamp(v62 * 1.3, 0, 1)));
        local v64, v65;
        v62, v64, v65 = v51:ToHSV();
        v62, v64, v65 = Color3.fromHSV(math.clamp(v62 + 0.1, 0, 1), v64, v65):ToHSV();
        v61, v62, v64 = (if v65 == 0 then Color3.fromRGB(255, 255, 255) else Color3.fromHSV(v62, v64, (math.clamp(v65 * 0.3, 0, 1)))):ToHSV();
        local v66 = Color3.fromHSV(v61, math.clamp(v62 + 0.5, 0, 1), v64);
        v60 = ColorSequence.new({
            ColorSequenceKeypoint.new(0, v63), 
            ColorSequenceKeypoint.new(1, v66)
        });
        for _, v68 in ipairs(v59.Attachment:GetChildren()) do
            if v68:IsA("ParticleEmitter") and not v68:GetAttribute("Lock") then
                if v68.Color.Keypoints[1].Value == v68.Color.Keypoints[2].Value then
                    v68.Color = ColorSequence.new(v63);
                else
                    v68.Color = v60;
                end;
            end;
        end;
    end;
    for _, v70 in ipairs(v59:GetDescendants()) do
        if v70:IsA("ParticleEmitter") then
            v70:Emit(v70:GetAttribute("EmitCount"));
        end;
    end;
    l_Debris_0:AddItem(v59, 3);
end;
v19.Open = function(v72, v73, v74, v75, v76) --[[ Line: 118 ]] --[[ Name: Open ]]
    -- upvalues: v14 (copy), v6 (copy), l_ReplicatedStorage_0 (copy), v18 (copy), l_LocalPlayer_0 (copy), v71 (copy), v7 (copy)
    if not v14 or not v14.PrimaryPart then
        return;
    else
        v6.Fire("DeleteAuto");
        if v73 then
            v73:SetAttribute("Done", true);
        end;
        if v73:FindFirstChild("Hitbox") then
            if v73.Hitbox:FindFirstChild("Spark") then
                v73.Hitbox.Spark.Parent = script.Ignore;
            end;
            if (v14.HumanoidRootPart.Position - v73.Hitbox.Position).Magnitude > 600 then
                v73:Destroy();
                return;
            end;
        end;
        local l_Name_0 = v73.Name;
        local v78 = string.find(l_Name_0, "Gem");
        if v73:FindFirstChild("SCircle") then
            v73.SCircle.Parent = l_ReplicatedStorage_0;
        end;
        if v73.Name == "Huge Chest" or v73.Name == "TEST_HUGE" then
            return v72:OpenHuge(v73, v74, v75);
        else
            if v73:GetAttribute("Firework") then
                local v79 = v73:Clone();
                v79.Parent = v18;
                v73:Destroy();
                if v74 == l_LocalPlayer_0 then
                    _G:Play("SFX/FireworkExplode", nil, true);
                end;
                if v79:FindFirstChild("Firework") then
                    local v80 = false;
                    do
                        local l_v80_0 = v80;
                        for _, v83 in ipairs(v79:GetDescendants()) do
                            if v83.Name == "Firework" then
                                task.spawn(function() --[[ Line: 162 ]]
                                    -- upvalues: v71 (ref), v83 (copy), v75 (copy), l_v80_0 (ref), v74 (copy), l_LocalPlayer_0 (ref)
                                    v71(v83, true, v75);
                                    l_v80_0 = true;
                                    if v74 == l_LocalPlayer_0 then
                                        _G:Play("SFX/FireworkExplode2", nil, true);
                                    end;
                                end);
                            elseif v83:IsA("BasePart") and v83.Parent.Name ~= "Firework" then
                                v7:Tween(v83, 0.3, "Sine", "Out", {
                                    Transparency = 1, 
                                    Color = Color3.fromRGB(255, 255, 255)
                                });
                            end;
                        end;
                        repeat
                            task.wait();
                        until l_v80_0;
                    end;
                else
                    v71(v79, nil, v75);
                    if v74 == l_LocalPlayer_0 then
                        _G:Play("SFX/FireworkExplode2", nil, true);
                    end;
                end;
                v79:Destroy();
            end;
            if not v78 and v73:FindFirstChild("Lid") then
                if v74 == l_LocalPlayer_0 and not _G.NoBreakDisable then
                    _G.ListenForBreak = false;
                end;
                return v72:OpenNew(v73, v74, v75, v76);
            else
                if v74 == l_LocalPlayer_0 then
                    if v78 then
                        local l_Highlight_0 = Instance.new("Highlight");
                        l_Highlight_0.DepthMode = Enum.HighlightDepthMode.Occluded;
                        l_Highlight_0.OutlineTransparency = 1;
                        l_Highlight_0.FillTransparency = 1;
                        l_Highlight_0.FillColor = Color3.fromRGB(600, 600, 600);
                        l_Highlight_0.Parent = v73;
                        local v85 = l_ReplicatedStorage_0.Components.Particles.GemParticles:Clone();
                        v85.Parent = v73.Hitbox;
                        for _, v87 in ipairs(v85:GetChildren()) do
                            if v87:IsA("ParticleEmitter") then
                                v87:Emit(v87:GetAttribute("EmitCount") or 4);
                            end;
                        end;
                        v85.Drops.Enabled = true;
                        v85.Shards.Enabled = true;
                        v85.Stars.Enabled = true;
                        v7:Tween(l_Highlight_0, 1.3, "Circular", "Out", {
                            FillTransparency = 0
                        });
                        task.spawn(function() --[[ Line: 218 ]]
                            -- upvalues: v7 (ref), v73 (copy)
                            v7:TweenModelSize(v73, 1.3, 0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
                        end);
                        task.wait(1.3);
                        v85.Flash:Emit(1);
                        for _, v89 in pairs(v73:GetDescendants()) do
                            if v89:IsA("MeshPart") or v89:IsA("BasePart") then
                                v89.Transparency = 1;
                            elseif v89:IsA("ParticleEmitter") then
                                v89.Enabled = false;
                            end;
                        end;
                        l_Highlight_0:Destroy();
                    else
                        task.spawn(function() --[[ Line: 236 ]]
                            -- upvalues: v7 (ref), v73 (copy)
                            v7:TweenModelSize(v73, 0.3, 1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
                        end);
                        for _, v91 in pairs(v73:GetDescendants()) do
                            if v91:IsA("MeshPart") or v91:IsA("BasePart") then
                                v7:Tween(v91, 0.3, "Sine", "Out", {
                                    Transparency = 1
                                });
                            end;
                        end;
                    end;
                end;
                task.wait(0.4);
                v73:Destroy();
                return;
            end;
        end;
    end;
end;
v19.OpenWorldChest = function(_, v93, v94, _) --[[ Line: 251 ]] --[[ Name: OpenWorldChest ]]
    -- upvalues: v7 (copy), l_LocalPlayer_0 (copy), l_ReplicatedStorage_0 (copy)
    local _ = v93.Name;
    local l_v93_Pivot_0 = v93:GetPivot();
    local l_Highlight_1 = Instance.new("Highlight");
    l_Highlight_1.DepthMode = Enum.HighlightDepthMode.Occluded;
    l_Highlight_1.OutlineTransparency = 1;
    l_Highlight_1.FillTransparency = 1;
    l_Highlight_1.FillColor = Color3.fromRGB(600, 600, 600);
    l_Highlight_1.Parent = v93;
    local l_Earthquake_0 = game.SoundService.Sounds.Earthquake;
    l_Earthquake_0:Play();
    local v100 = Instance.new("NumberValue", v93);
    v100.Name = "Shake";
    v100.Value = 0;
    if _G.Shake then
        _G.camShake:ShakeSustain(_G.presets.Earthquake);
        v7:Tween(l_LocalPlayer_0, 0.3, "Sine", "InOut", {
            CameraMinZoomDistance = 95
        }, true);
    end;
    v7:Tween(v100, 0.3, "Sine", "Out", {
        Value = 3
    });
    v7:Tween(l_Highlight_1, 0.8, "Quad", "Out", {
        FillTransparency = 0
    });
    v7:TweenModel(v93, 0.3, "Sine", "InOut", l_v93_Pivot_0 * CFrame.Angles(0, 0, -0.10471975511965978) + Vector3.new(0, 2, 0, 0));
    task.wait(0.5);
    v7:Tween(v100, 0.15, "Quad", "Out", {
        Value = 0
    });
    v7:Tween(l_Highlight_1, 0.3, "Quad", "Out", {
        FillTransparency = 1
    });
    v7:TweenModel(v93, 0.5, "Quad", "Out", l_v93_Pivot_0);
    l_Earthquake_0:Stop();
    if _G.Shake then
        _G.camShake:StopSustained(2);
        _G.camShake:Shake(_G.presets.Explosion);
    end;
    task.delay(0.15, function() --[[ Line: 295 ]]
        _G:Play("CoinBoom");
    end);
    if l_LocalPlayer_0 == v94 then
        _G:Play("ChestOpen");
    end;
    local v101 = l_ReplicatedStorage_0.Content.Particles.SmallChestParticles:Clone();
    v101.Parent = v93.PrimaryPart;
    for _, v103 in ipairs(v101:GetChildren()) do
        if v103:IsA("ParticleEmitter") then
            v103:Emit(v103:GetAttribute("EmitCount") or 4);
        end;
    end;
    v101.Drops.Enabled = true;
    task.wait(1);
    _G:Play("OpenGift");
    l_Highlight_1:Destroy();
    v101:Destroy();
    if v93 then
        for _, v105 in pairs(v93:GetDescendants()) do
            if v105:IsA("MeshPart") or v105:IsA("BasePart") or v105:IsA("Texture") then
                v7:Tween(v105, 0.6, "Sine", "Out", {
                    Transparency = 1
                });
            end;
        end;
    end;
end;
v19.OpenHuge = function(_, v107, v108, _) --[[ Line: 329 ]] --[[ Name: OpenHuge ]]
    -- upvalues: v14 (copy), l_LocalPlayer_0 (copy), l_SoundService_0 (copy), v7 (copy), l_ReplicatedStorage_0 (copy)
    local l_Lid_0 = v107.Lid;
    if not v14 or not v14.PrimaryPart then
        return;
    else
        local l_Name_2 = v107.Name;
        local v112 = string.find(l_Name_2, "Box");
        local v113 = string.find(l_Name_2, "Gem");
        local l_v107_Pivot_0 = v107:GetPivot();
        if not v112 and not v113 and v108 == l_LocalPlayer_0 then
            l_SoundService_0.Sounds.Chest.PlaybackSpeed = 1 * (math.random(120, 160) / 100);
            _G:Play("HUGE_CHEST");
        end;
        local l_Highlight_2 = Instance.new("Highlight");
        l_Highlight_2.DepthMode = Enum.HighlightDepthMode.Occluded;
        l_Highlight_2.OutlineTransparency = 1;
        l_Highlight_2.FillTransparency = 1;
        l_Highlight_2.FillColor = Color3.fromRGB(600, 600, 600);
        l_Highlight_2.Parent = v107;
        local l_Earthquake_1 = game.SoundService.Sounds.Earthquake;
        l_Earthquake_1:Play();
        local v117 = Instance.new("NumberValue", v107);
        v117.Name = "Shake";
        v117.Value = 0;
        if _G.Shake then
            _G.camShake:ShakeSustain(_G.presets.Earthquake);
            v7:Tween(l_LocalPlayer_0, 1.6, "Sine", "InOut", {
                CameraMinZoomDistance = 95
            }, true);
        end;
        v7:Tween(v117, 1, "Sine", "Out", {
            Value = 3
        });
        v7:Tween(l_Highlight_2, 0.8, "Quad", "Out", {
            FillTransparency = 0
        });
        v7:TweenModel(v107, 1.45, "Sine", "InOut", l_v107_Pivot_0 * CFrame.Angles(0, 0, -0.10471975511965978) + Vector3.new(0, 2, 0, 0));
        task.wait(1.45);
        v7:Tween(v117, 0.15, "Quad", "Out", {
            Value = 0
        });
        v7:Tween(l_Highlight_2, 0.3, "Quad", "Out", {
            FillTransparency = 1
        });
        v7:TweenModel(v107, 0.5, "Quad", "Out", l_v107_Pivot_0);
        v7:TweenModel(l_Lid_0, 0.6, "Bounce", "Out", l_Lid_0:GetPivot() * CFrame.Angles(0, 0, -1.5707963267948966), nil, nil, true);
        l_Earthquake_1:Stop();
        if _G.Shake then
            _G.camShake:StopSustained(2);
            _G.camShake:Shake(_G.presets.Explosion);
        end;
        task.delay(0.15, function() --[[ Line: 384 ]]
            _G:Play("CoinBoom");
        end);
        if l_LocalPlayer_0 == v108 then
            _G:Play("ChestOpen");
        end;
        local v118 = l_ReplicatedStorage_0.Content.Particles.Test:Clone();
        v118.Parent = v107.PrimaryPart;
        for _, v120 in ipairs(v118:GetChildren()) do
            if v120:IsA("ParticleEmitter") then
                v120:Emit(v120:GetAttribute("EmitCount") or 4);
            end;
        end;
        v118.Drops.Enabled = true;
        v118.Specs.Enabled = true;
        task.wait(6);
        l_Highlight_2:Destroy();
        v118:Destroy();
        if l_Lid_0 then
            v7:TweenModel(l_Lid_0, 0.55, "Bounce", "Out", l_Lid_0:GetPivot() * CFrame.Angles(0, 0, 1.5707963267948966), nil, nil, true);
        end;
        if v107 then
            v7:TweenModel(v107, 0.5, "Back", "In", l_v107_Pivot_0 - Vector3.new(0, 6, 0, 0));
        end;
        if v107 then
            for _, v122 in pairs(v107:GetDescendants()) do
                if v122:IsA("MeshPart") or v122:IsA("BasePart") or v122:IsA("Texture") then
                    v7:Tween(v122, 0.6, "Sine", "Out", {
                        Transparency = 1
                    });
                end;
            end;
        end;
        task.wait(2);
        if v107 then
            v107:Destroy();
        end;
        return;
    end;
end;
v19.OpenNew = function(_, v124, v125, v126, _) --[[ Line: 424 ]] --[[ Name: OpenNew ]]
    -- upvalues: v14 (copy), l_ReplicatedStorage_0 (copy), v6 (copy), l_LocalPlayer_0 (copy), l_SoundService_0 (copy), v7 (copy)
    local l_Lid_1 = v124.Lid;
    if not v14 or not v14.PrimaryPart then
        return;
    else
        local l_Name_3 = v124.Name;
        local v130 = string.find(l_Name_3, "Box");
        local v131 = string.find(l_Name_3, "Gem");
        local l_v124_Pivot_0 = v124:GetPivot();
        if (v124.Name == "Chest1" or v124.Name == "Chest2") and not v124:FindFirstChild("Coin1") and l_ReplicatedStorage_0.Components.Models[v126][v124.Name]:FindFirstChild("Coin1") then
            local v133 = l_ReplicatedStorage_0.Components.Models[v126][v124.Name];
            local v134 = v133:FindFirstChild("Coin1"):Clone();
            local v135 = v133:FindFirstChild("Coin2"):Clone();
            v134.Parent = v124;
            v135.Parent = v124;
            local v136 = v133.Hitbox.Position - v133.Coin1.Position;
            local v137 = v133.Hitbox.Position - v133.Coin2.Position;
            local _ = v133.Hitbox.Orientation - v133.Coin1.Orientation;
            local _ = v133.Hitbox.Orientation - v133.Coin2.Orientation;
            if v124:FindFirstChild("Hitbox") then
                v134.Position = v124.Hitbox.Position - v136;
                v135.Position = v124.Hitbox.Position - v137;
                v134.Orientation = v134.Orientation + v124.Hitbox.Orientation - v133.Hitbox.Orientation;
                v135.Orientation = v135.Orientation + v124.Hitbox.Orientation - v133.Hitbox.Orientation;
            end;
        end;
        task.defer(function() --[[ Line: 456 ]]
            -- upvalues: v6 (ref)
            v6.Fire("DesClick");
        end);
        if not v130 and not v131 and v125 == l_LocalPlayer_0 then
            l_SoundService_0.SFX.Chest.PlaybackSpeed = 1 * (math.random(120, 160) / 100);
            _G:Play("SFX/Chest", nil, true);
        end;
        local l_Highlight_3 = Instance.new("Highlight");
        l_Highlight_3.DepthMode = Enum.HighlightDepthMode.Occluded;
        l_Highlight_3.OutlineTransparency = 1;
        l_Highlight_3.FillColor = Color3.fromRGB(600, 600, 600);
        l_Highlight_3.Parent = v124;
        local v141 = Instance.new("NumberValue", v124);
        v141.Name = "Shake";
        v141.Value = 0;
        v7:Tween(v141, 0.08, "Quad", "Out", {
            Value = 0.6
        });
        v7:Tween(l_Highlight_3, 0.1, "Quad", "Out", {
            FillTransparency = 0
        });
        v7:TweenModel(v124, 0.15, "Sine", "InOut", l_v124_Pivot_0 * CFrame.Angles(0, 0, -0.10471975511965978) + Vector3.new(0, 0.6000000238418579, 0, 0));
        task.wait(0.15);
        v7:Tween(v141, 0.2, "Quad", "Out", {
            Value = 0
        });
        v7:Tween(l_Highlight_3, 0.3, "Quad", "Out", {
            FillTransparency = 1
        });
        v7:TweenModel(v124, 0.1, "Quad", "Out", l_v124_Pivot_0);
        v7:TweenModel(l_Lid_1, 0.35, "Bounce", "Out", l_Lid_1:GetPivot() * CFrame.Angles(0, 0, -1.5707963267948966), nil, nil, true);
        if l_LocalPlayer_0 == v125 then
            _G:Play("SFX/ChestOpen", nil, true);
        end;
        if not v124:FindFirstChild("Hitbox") then
            l_Highlight_3:Destroy();
            v124:Destroy();
            return;
        else
            local v142 = l_ReplicatedStorage_0.Components.Particles.ChestParticles2:Clone();
            v142.Parent = v124.Hitbox;
            for _, v144 in ipairs(v142:GetChildren()) do
                if v144:IsA("ParticleEmitter") then
                    v144:Emit(v144:GetAttribute("EmitCount") or 4);
                end;
            end;
            v142.Drops.Enabled = true;
            v142.Lines.Enabled = true;
            if (v125.UserId == 63531881 or v125.UserId == 530072717) and v125.Character:FindFirstChild("Developer") then
                _G:Play("SFX/CoinBoom");
                local v145 = l_ReplicatedStorage_0.Components.Particles.DOBDEV:Clone();
                v145.Parent = v124.Hitbox;
                for _, v147 in ipairs(v145:GetChildren()) do
                    if v147:IsA("ParticleEmitter") then
                        v147:Emit(v147:GetAttribute("EmitCount") or 4);
                    end;
                end;
            end;
            task.wait(1);
            l_Highlight_3:Destroy();
            if l_Lid_1 then
                v7:TweenModel(l_Lid_1, 0.55, "Bounce", "Out", l_Lid_1:GetPivot() * CFrame.Angles(0, 0, 1.5707963267948966), nil, nil, true);
            end;
            if v124 then
                v7:TweenModel(v124, 0.5, "Back", "In", l_v124_Pivot_0 - Vector3.new(0, 6, 0, 0));
            end;
            if v124 then
                for _, v149 in pairs(v124:GetDescendants()) do
                    if v149:IsA("MeshPart") or v149:IsA("BasePart") or v149:IsA("Texture") then
                        v7:Tween(v149, 0.6, "Sine", "Out", {
                            Transparency = 1
                        });
                    end;
                end;
            end;
            task.wait(0.7);
            if v124 then
                v124:Destroy();
            end;
            return;
        end;
    end;
end;
v19.Init = function(v150) --[[ Line: 551 ]] --[[ Name: Init ]]
    -- upvalues: v9 (copy), l_RunService_0 (copy), v10 (copy), v11 (copy), v8 (copy)
    v9:BindEvents({
        FinishChest = function(...) --[[ Line: 554 ]]
            -- upvalues: v150 (copy)
            v150:Open(...);
        end
    });
    _G.Chest = function(...) --[[ Line: 559 ]]
        -- upvalues: v150 (copy)
        v150:Open(...);
    end;
    local _ = workspace.InteractionPoints;
    local v152 = tick();
    l_RunService_0.Heartbeat:Connect(function() --[[ Line: 568 ]]
        -- upvalues: v152 (ref), v10 (ref), v11 (ref), v8 (ref)
        if v152 + 1 >= tick() then
            return;
        else
            if v10.Loaded then
                v152 = tick();
                for _, v154 in ipairs(game:GetService("CollectionService"):GetTagged("ChestInteraction")) do
                    local l_v154_Attribute_0 = v154:GetAttribute("Chest");
                    local v156 = v11[l_v154_Attribute_0];
                    local v157 = v10.Data.Chests[l_v154_Attribute_0];
                    if v156 then
                        local l_Attachment_0 = v154:FindFirstChild("Attachment");
                        local l_TimeLeft_0 = l_Attachment_0:FindFirstChild("TimeLeft");
                        local v160 = not v157 or os.time() - v157 >= v156.Cooldown;
                        if v160 then
                            l_TimeLeft_0.Enabled = false;
                        else
                            l_TimeLeft_0.Enabled = true;
                        end;
                        if l_Attachment_0 and l_TimeLeft_0 then
                            local l_TextUpper_0 = l_TimeLeft_0:FindFirstChild("TextUpper");
                            local l_TextInner_0 = l_TextUpper_0:FindFirstChild("TextInner");
                            if l_TextUpper_0 and l_TextInner_0 then
                                local v163 = v160 and "" or v8:FormatTimeStr(v157 + v156.Cooldown - os.time(), true);
                                l_TextUpper_0.Text = v163;
                                l_TextInner_0.Text = v163;
                            end;
                        end;
                    end;
                end;
            end;
            return;
        end;
    end);
end;
return v19;