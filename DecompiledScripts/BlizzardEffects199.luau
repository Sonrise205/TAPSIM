local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("Workspace");
local l_CollectionService_0 = game:GetService("CollectionService");
local l_TweenService_0 = game:GetService("TweenService");
local v5 = require(l_ReplicatedStorage_0.Modules.Network);
local v6 = require(l_ReplicatedStorage_0.Modules.Signal);
local v7 = require(l_ReplicatedStorage_0.Modules.Short);
local v8 = require(l_ReplicatedStorage_0.Modules.StormParticles);
local v9 = require(l_ReplicatedStorage_0.Game.Replication);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v11 = {};
local v12 = false;
local v13 = {};
local v14 = false;
local v15 = false;
local v16 = "";
local function _(v17, v18) --[[ Line: 27 ]] --[[ Name: showChatAnnouncement ]]
    local l_status_0, l_result_0 = pcall(function() --[[ Line: 29 ]]
        -- upvalues: v17 (copy), v18 (copy)
        game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
            Text = v17, 
            Color = v18 or Color3.fromRGB(100, 200, 255), 
            Font = Enum.Font.GothamBold, 
            TextSize = 18
        });
    end);
    if not l_status_0 then
        warn("[BlizzardEffects] Failed to show chat message:", l_result_0);
    end;
end;
local function v36(v22, v23, v24) --[[ Line: 44 ]] --[[ Name: applyShockedEffects ]]
    -- upvalues: l_ReplicatedStorage_0 (copy), l_TweenService_0 (copy)
    local v25 = v24 or v22:GetAttribute("ShockedExpiry");
    if not v25 then
        return;
    elseif v25 <= os.time() then
        return;
    else
        local l_PrimaryPart_0 = v22.PrimaryPart;
        if not l_PrimaryPart_0 then
            return;
        else
            local l_ShockedVFX_0 = l_PrimaryPart_0:FindFirstChild("ShockedVFX");
            if l_ShockedVFX_0 then
                l_ShockedVFX_0:Destroy();
            end;
            local l_LightningVFX_0 = l_ReplicatedStorage_0.Content:FindFirstChild("LightningVFX");
            if l_LightningVFX_0 then
                local v29 = l_LightningVFX_0:Clone();
                v29.Name = "ShockedVFX";
                for _, v31 in ipairs(v29:GetDescendants()) do
                    if v31:IsA("ParticleEmitter") then
                        v31.Enabled = true;
                    end;
                end;
                v29.Parent = l_PrimaryPart_0;
                if v23 then
                    for _, v33 in ipairs(v29:GetDescendants()) do
                        if v33:IsA("ParticleEmitter") then
                            v33:Emit(30);
                        end;
                    end;
                    local l_Part_0 = Instance.new("Part");
                    l_Part_0.Anchored = true;
                    l_Part_0.CanCollide = false;
                    l_Part_0.Size = Vector3.new(4, 4, 4, 0);
                    l_Part_0.Position = l_PrimaryPart_0.Position;
                    l_Part_0.Transparency = 0.5;
                    l_Part_0.Material = Enum.Material.Neon;
                    l_Part_0.Color = Color3.fromRGB(100, 200, 255);
                    l_Part_0.Shape = Enum.PartType.Ball;
                    l_Part_0.Parent = workspace;
                    l_TweenService_0:Create(l_Part_0, TweenInfo.new(0.5), {
                        Transparency = 1, 
                        Size = Vector3.new(8, 8, 8, 0)
                    }):Play();
                    game:GetService("Debris"):AddItem(l_Part_0, 0.5);
                end;
                local v35 = math.max(0, v25 - os.time());
                task.delay(v35, function() --[[ Line: 117 ]]
                    -- upvalues: v29 (copy)
                    if v29 and v29.Parent then
                        v29:Destroy();
                    end;
                end);
                return;
            else
                return;
            end;
        end;
    end;
end;
local function v44(v37) --[[ Line: 127 ]] --[[ Name: applyElectrifiedEffects ]]
    -- upvalues: l_ReplicatedStorage_0 (copy)
    if not v37:GetAttribute("Electrified") then
        return;
    else
        for _, v39 in ipairs(v37:GetDescendants()) do
            if v39:IsA("BasePart") then
                if not v39:GetAttribute("OriginalColor") then
                    v39:SetAttribute("OriginalColor", v39.Color);
                end;
                v39.Color = Color3.fromRGB(100, 200, 255);
                v39.Material = Enum.Material.Neon;
            end;
        end;
        local l_PrimaryPart_1 = v37.PrimaryPart;
        if l_PrimaryPart_1 and not l_PrimaryPart_1:FindFirstChild("ElectrifiedVFX") then
            local l_LightningVFX_1 = l_ReplicatedStorage_0.Content:FindFirstChild("LightningVFX");
            if l_LightningVFX_1 then
                local v42 = l_LightningVFX_1:Clone();
                v42.Name = "ElectrifiedVFX";
                v42.Parent = l_PrimaryPart_1;
                local l_PointLight_0 = Instance.new("PointLight");
                l_PointLight_0.Name = "ElectrifiedLight";
                l_PointLight_0.Color = Color3.fromRGB(100, 200, 255);
                l_PointLight_0.Brightness = 2;
                l_PointLight_0.Range = 8;
                l_PointLight_0.Parent = l_PrimaryPart_1;
            end;
        end;
        return;
    end;
end;
local function v49(v45) --[[ Line: 167 ]] --[[ Name: createAttributeBillboard ]]
    -- upvalues: v13 (copy)
    if v13[v45] then
        return v13[v45].gui, v13[v45].container;
    else
        local l_BillboardGui_0 = Instance.new("BillboardGui");
        l_BillboardGui_0.Name = "AttributeBillboard";
        l_BillboardGui_0.Size = UDim2.new(0, 200, 0, 30);
        l_BillboardGui_0.StudsOffsetWorldSpace = Vector3.new(0, v45:GetExtentsSize().Y + 1.5, 0);
        l_BillboardGui_0.AlwaysOnTop = true;
        l_BillboardGui_0.MaxDistance = 100;
        l_BillboardGui_0.Adornee = v45.PrimaryPart;
        local l_Frame_0 = Instance.new("Frame");
        l_Frame_0.Size = UDim2.new(1, 0, 1, 0);
        l_Frame_0.BackgroundTransparency = 1;
        l_Frame_0.Parent = l_BillboardGui_0;
        local l_UIListLayout_0 = Instance.new("UIListLayout");
        l_UIListLayout_0.FillDirection = Enum.FillDirection.Horizontal;
        l_UIListLayout_0.HorizontalAlignment = Enum.HorizontalAlignment.Center;
        l_UIListLayout_0.Padding = UDim.new(0, 3);
        l_UIListLayout_0.Parent = l_Frame_0;
        l_BillboardGui_0.Parent = v45.PrimaryPart;
        v13[v45] = {
            gui = l_BillboardGui_0, 
            container = l_Frame_0
        };
        return l_BillboardGui_0, l_Frame_0;
    end;
end;
local function v59(v50) --[[ Line: 196 ]] --[[ Name: updateAttributeBillboard ]]
    -- upvalues: v49 (copy), v13 (copy), v6 (copy), v7 (copy)
    local _, v52 = v49(v50);
    v52 = v13[v50].container;
    v52:ClearAllChildren();
    local l_UIListLayout_1 = Instance.new("UIListLayout");
    l_UIListLayout_1.FillDirection = Enum.FillDirection.Horizontal;
    l_UIListLayout_1.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    l_UIListLayout_1.Padding = UDim.new(0, 3);
    l_UIListLayout_1.Parent = v52;
    local v54 = false;
    if v50:GetAttribute("Shocked") then
        local l_v50_Attribute_0 = v50:GetAttribute("ShockedExpiry");
        if l_v50_Attribute_0 and os.time() < l_v50_Attribute_0 then
            local l_TextLabel_0 = Instance.new("TextLabel");
            l_TextLabel_0.Name = "ShockedBadge";
            l_TextLabel_0.Size = UDim2.new(0, 35, 0, 35);
            l_TextLabel_0.BackgroundColor3 = Color3.fromRGB(100, 200, 255);
            l_TextLabel_0.BorderSizePixel = 2;
            l_TextLabel_0.BorderColor3 = Color3.fromRGB(255, 255, 255);
            l_TextLabel_0.Text = "\226\154\161";
            l_TextLabel_0.TextScaled = true;
            l_TextLabel_0.TextColor3 = Color3.fromRGB(255, 255, 255);
            l_TextLabel_0.Font = Enum.Font.GothamBold;
            l_TextLabel_0.Parent = v52;
            local v57 = math.max(0, l_v50_Attribute_0 - os.time());
            v6.Fire("Tooltip", l_TextLabel_0, string.format("<b>\226\154\161 Shocked</b>\n+20%% clicks\nTime left: %s", v7:FormatTimeCompressed(v57)));
            v54 = true;
        end;
    end;
    if v50:GetAttribute("Electrified") then
        local l_TextLabel_1 = Instance.new("TextLabel");
        l_TextLabel_1.Name = "ElectrifiedBadge";
        l_TextLabel_1.Size = UDim2.new(0, 35, 0, 35);
        l_TextLabel_1.BackgroundColor3 = Color3.fromRGB(100, 200, 255);
        l_TextLabel_1.BorderSizePixel = 2;
        l_TextLabel_1.BorderColor3 = Color3.fromRGB(255, 255, 255);
        l_TextLabel_1.Text = "\226\154\161\226\154\161";
        l_TextLabel_1.TextScaled = true;
        l_TextLabel_1.TextColor3 = Color3.fromRGB(255, 255, 255);
        l_TextLabel_1.Font = Enum.Font.GothamBold;
        l_TextLabel_1.Parent = v52;
        v6.Fire("Tooltip", l_TextLabel_1, "<b>\226\154\161 Electrified</b>\n3x multiplier\nPermanent");
        v54 = true;
    end;
    if v13[v50] and v13[v50].gui then
        v13[v50].gui.Enabled = v54;
    end;
end;
local function v70(v60) --[[ Line: 266 ]] --[[ Name: setBlizzardEffects ]]
    -- upvalues: v14 (ref), v15 (ref), v16 (ref), v8 (copy), l_ReplicatedStorage_0 (copy)
    v14 = v60;
    if not v60 then
        v15 = false;
    end;
    local v61 = v16 == "Winter";
    if v60 and v15 and v61 then
        local l_Lighting_0 = game:GetService("Lighting");
        _G.BlizzardLightingActive = true;
        l_Lighting_0.Ambient = Color3.fromRGB(80, 100, 140);
        l_Lighting_0.OutdoorAmbient = Color3.fromRGB(75, 95, 130);
        l_Lighting_0.ColorShift_Bottom = Color3.fromRGB(60, 80, 120);
        l_Lighting_0.ColorShift_Top = Color3.fromRGB(90, 110, 160);
        l_Lighting_0.Brightness = 1.5;
        l_Lighting_0.ClockTime = 16;
        l_Lighting_0.Atmosphere.Density = 0.2;
        l_Lighting_0.Atmosphere.Color = Color3.fromRGB(100, 140, 180);
        l_Lighting_0.Atmosphere.Decay = Color3.fromRGB(90, 120, 160);
        v8.CustomizeStorm({
            SpawnRate = 0.15, 
            ParticlesPerSpawn = 4, 
            UpwardSpeed = 10, 
            CircularSpeed = 1.5, 
            SpiralTightness = -0.2, 
            SpiralDirection = -1, 
            MaxHeight = 50, 
            RandomVelocity = 32, 
            ColorSequence = ColorSequence.new({
                ColorSequenceKeypoint.new(0, Color3.fromRGB(84, 84, 84)), 
                ColorSequenceKeypoint.new(0.3, Color3.fromRGB(88, 88, 88)), 
                ColorSequenceKeypoint.new(0.6, Color3.fromRGB(41, 152, 255)), 
                ColorSequenceKeypoint.new(1, Color3.fromRGB(16, 31, 49))
            }), 
            EnableGlow = false, 
            GlowColor = Color3.fromRGB(32, 177, 255), 
            GlowBrightness = 2, 
            GlowRange = 12, 
            Brightness = 0.5, 
            TrailLifetime = 0.8, 
            SpawnRadius = 60, 
            WindSpiralChance = 0.1, 
            Texture = "rbxassetid://8773907951"
        });
        local _, _ = pcall(function() --[[ Line: 320 ]]
            -- upvalues: v8 (ref)
            v8.EnableStorm(true);
        end);
        return;
    else
        if not v60 or not v15 or not v61 then
            if _G.BlizzardLightingActive then
                _G.BlizzardLightingActive = false;
                local l_Lighting_1 = game:GetService("Lighting");
                local v66 = require(l_ReplicatedStorage_0.Game.Lighting);
                local v67 = v66[v16 == "" and "Spawn" or v16] or v66.Spawn;
                if v67 then
                    if v67.Lighting and v67.Lighting.ClockTime then
                        l_Lighting_1.ClockTime = v67.Lighting.ClockTime;
                    end;
                    if v67.Atmosphere then
                        if v67.Atmosphere.Density then
                            l_Lighting_1.Atmosphere.Density = v67.Atmosphere.Density;
                        end;
                        if v67.Atmosphere.Color then
                            l_Lighting_1.Atmosphere.Color = v67.Atmosphere.Color;
                        end;
                        if v67.Atmosphere.Decay then
                            l_Lighting_1.Atmosphere.Decay = v67.Atmosphere.Decay;
                        end;
                    end;
                    l_Lighting_1.Ambient = Color3.fromRGB(150, 150, 150);
                    l_Lighting_1.OutdoorAmbient = Color3.fromRGB(127, 127, 127);
                    l_Lighting_1.ColorShift_Bottom = Color3.fromRGB(0, 0, 0);
                    l_Lighting_1.ColorShift_Top = Color3.fromRGB(0, 0, 0);
                    l_Lighting_1.Brightness = 2;
                end;
            end;
            local l_status_2, l_result_2 = pcall(function() --[[ Line: 367 ]]
                -- upvalues: v8 (ref)
                v8.EnableStorm(false);
            end);
            if not l_status_2 then
                warn("[BlizzardEffects] Error disabling storm:", l_result_2);
            end;
        end;
        return;
    end;
end;
local function _() --[[ Line: 378 ]] --[[ Name: onBlizzardWakeUp ]]
    -- upvalues: v15 (ref), v70 (copy), v14 (ref)
    v15 = true;
    v70(v14);
end;
local _ = function() --[[ Line: 384 ]] --[[ Name: updateZone ]]
    -- upvalues: v9 (copy), v16 (ref), v70 (copy), v14 (ref)
    if v9.Loaded and v9.Data then
        local v72 = v9.Data.Zone or "";
        if v72 ~= v16 then
            local _ = v16 == "" and "None/Spawn" or v16;
            v16 = v72;
            local _ = v16 == "" and "None/Spawn" or v16;
            v70(v14);
        end;
    end;
end;
local function v81(v76, v77) --[[ Line: 399 ]] --[[ Name: showStrikeHitbox ]]
    -- upvalues: l_TweenService_0 (copy)
    local l_Part_1 = Instance.new("Part");
    l_Part_1.Name = "LightningStrikeHitbox";
    l_Part_1.Size = Vector3.new(60, 0.5, 60, 0);
    l_Part_1.Position = v77 + Vector3.new(0, 0.25, 0, 0);
    l_Part_1.Anchored = true;
    l_Part_1.CanCollide = false;
    l_Part_1.Transparency = 0.5;
    l_Part_1.Material = Enum.Material.Neon;
    l_Part_1.Color = Color3.fromRGB(100, 200, 255);
    l_Part_1.Shape = Enum.PartType.Cylinder;
    l_Part_1.Orientation = Vector3.new(0, 0, 90, 0);
    l_Part_1.Parent = workspace;
    l_TweenService_0:Create(l_Part_1, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Size = Vector3.new(70, 0.5, 70, 0), 
        Transparency = 1
    }):Play();
    game:GetService("Debris"):AddItem(l_Part_1, 1);
    local l_Part_2 = Instance.new("Part");
    l_Part_2.Name = "LightningBeam";
    local v80 = (v76 + v77) / 2;
    l_Part_2.Size = Vector3.new(2, (v76 - v77).Magnitude, 2);
    l_Part_2.CFrame = CFrame.lookAt(v80, v77) * CFrame.Angles(1.5707963267948966, 0, 0);
    l_Part_2.Anchored = true;
    l_Part_2.CanCollide = false;
    l_Part_2.Transparency = 0.3;
    l_Part_2.Material = Enum.Material.Neon;
    l_Part_2.Color = Color3.fromRGB(150, 220, 255);
    l_Part_2.Parent = workspace;
    l_TweenService_0:Create(l_Part_2, TweenInfo.new(0.4), {
        Transparency = 1
    }):Play();
    game:GetService("Debris"):AddItem(l_Part_2, 0.5);
end;
local function v90(v82, v83) --[[ Line: 450 ]] --[[ Name: applyElectricEggEffects ]]
    -- upvalues: l_ReplicatedStorage_0 (copy)
    local v84 = v82:IsA("Model") and v82.PrimaryPart or v82;
    if not v84 then
        return;
    else
        local l_ElectricVFX_0 = v84:FindFirstChild("ElectricVFX");
        if l_ElectricVFX_0 then
            l_ElectricVFX_0:Destroy();
        end;
        local l_LightningVFX_2 = l_ReplicatedStorage_0.Content:FindFirstChild("LightningVFX");
        if l_LightningVFX_2 then
            local v87 = l_LightningVFX_2:Clone();
            v87.Name = "ElectricVFX";
            for _, v89 in ipairs(v87:GetDescendants()) do
                if v89:IsA("ParticleEmitter") then
                    v89.Enabled = true;
                end;
            end;
            v87.Parent = v84;
            task.delay(math.max(0, v83 - os.time()), function() --[[ Line: 479 ]]
                -- upvalues: v87 (copy)
                if v87 and v87.Parent then
                    v87:Destroy();
                end;
            end);
            return;
        else
            warn("[BlizzardEffects] \226\157\140 LightningVFX not found");
            return;
        end;
    end;
end;
local function v96() --[[ Line: 493 ]] --[[ Name: setupPetWatcher ]]
    -- upvalues: l_CollectionService_0 (copy), l_LocalPlayer_0 (copy), v44 (copy), v36 (copy), v59 (copy)
    for _, v92 in ipairs(l_CollectionService_0:GetTagged("Pet")) do
        if v92:GetAttribute("Owner") == l_LocalPlayer_0.UserId then
            v44(v92);
            v36(v92, false);
            v59(v92);
        end;
    end;
    l_CollectionService_0:GetInstanceAddedSignal("Pet"):Connect(function(v93) --[[ Line: 505 ]]
        -- upvalues: l_LocalPlayer_0 (ref), v44 (ref), v36 (ref), v59 (ref)
        if v93:GetAttribute("Owner") == l_LocalPlayer_0.UserId then
            task.wait(0.1);
            v44(v93);
            v36(v93, false);
            v59(v93);
            v93:GetAttributeChangedSignal("Shocked"):Connect(function() --[[ Line: 513 ]]
                -- upvalues: v36 (ref), v93 (copy), v59 (ref)
                v36(v93, false);
                v59(v93);
            end);
            v93:GetAttributeChangedSignal("Electrified"):Connect(function() --[[ Line: 518 ]]
                -- upvalues: v44 (ref), v93 (copy), v59 (ref)
                v44(v93);
                v59(v93);
            end);
        end;
    end);
    task.spawn(function() --[[ Line: 526 ]]
        -- upvalues: l_CollectionService_0 (ref), l_LocalPlayer_0 (ref), v59 (ref)
        while true do
            task.wait(1);
            for _, v95 in ipairs(l_CollectionService_0:GetTagged("Pet")) do
                if v95:GetAttribute("Owner") == l_LocalPlayer_0.UserId then
                    v59(v95);
                end;
            end;
        end;
    end);
end;
local _ = function() --[[ Line: 539 ]] --[[ Name: initialize ]]
    -- upvalues: v9 (copy), v16 (ref), v5 (copy), l_LocalPlayer_0 (copy), v36 (copy), v59 (copy), v70 (copy), v15 (ref), v14 (ref), v81 (copy), v90 (copy), v96 (copy)
    _G.BlizzardLightingActive = false;
    task.defer(function() --[[ Line: 545 ]]
        -- upvalues: v9 (ref), v16 (ref)
        repeat
            task.wait();
        until v9.Loaded;
        if v9.Data then
            v16 = v9.Data.Zone or "";
        end;
    end);
    v5:BindEvents({
        ChatAnnouncement = function(v97, v98) --[[ Line: 554 ]] --[[ Name: ChatAnnouncement ]]
            local l_status_3, l_result_3 = pcall(function() --[[ Line: 29 ]]
                -- upvalues: v97 (copy), v98 (copy)
                game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
                    Text = v97, 
                    Color = v98 or Color3.fromRGB(100, 200, 255), 
                    Font = Enum.Font.GothamBold, 
                    TextSize = 18
                });
            end);
            if not l_status_3 then
                warn("[BlizzardEffects] Failed to show chat message:", l_result_3);
            end;
        end, 
        BlizzardPetStruck = function(v101, v102) --[[ Line: 558 ]] --[[ Name: BlizzardPetStruck ]]
            -- upvalues: l_LocalPlayer_0 (ref), v36 (ref), v59 (ref)
            if v101 and v101:GetAttribute("Owner") == l_LocalPlayer_0.UserId then
                v36(v101, true, v102);
                v59(v101);
                return;
            else
                return;
            end;
        end, 
        BlizzardSpawned = function(v103) --[[ Line: 566 ]] --[[ Name: BlizzardSpawned ]]
            -- upvalues: v70 (ref)
            if v103 then

            end;
            v70(v103);
        end, 
        BlizzardWokeUp = function() --[[ Line: 572 ]] --[[ Name: BlizzardWokeUp ]]
            -- upvalues: v15 (ref), v70 (ref), v14 (ref)
            v15 = true;
            v70(v14);
        end, 
        ShowLightningStrike = function(v104, v105) --[[ Line: 576 ]] --[[ Name: ShowLightningStrike ]]
            -- upvalues: v81 (ref)
            v81(v104, v105);
        end, 
        EggElectrified = function(v106, v107) --[[ Line: 580 ]] --[[ Name: EggElectrified ]]
            -- upvalues: v90 (ref)
            if v106 and v106.Parent then
                v90(v106, v107);
            end;
        end
    });
    v96();
    task.spawn(function() --[[ Line: 591 ]]
        -- upvalues: v9 (ref), v16 (ref), v70 (ref), v14 (ref)
        while true do
            if v9.Loaded and v9.Data then
                local v108 = v9.Data.Zone or "";
                if v108 ~= v16 then
                    local _ = v16 == "" and "None/Spawn" or v16;
                    v16 = v108;
                    local _ = v16 == "" and "None/Spawn" or v16;
                    v70(v14);
                end;
            end;
            task.wait(1);
        end;
    end);
    v9:Connect("Zone", function(_) --[[ Line: 599 ]]
        -- upvalues: v9 (ref), v16 (ref), v70 (ref), v14 (ref)
        if v9.Loaded and v9.Data then
            local v112 = v9.Data.Zone or "";
            if v112 ~= v16 then
                local _ = v16 == "" and "None/Spawn" or v16;
                v16 = v112;
                local _ = v16 == "" and "None/Spawn" or v16;
                v70(v14);
            end;
        end;
    end);
end;
v11.Init = function(_) --[[ Line: 605 ]] --[[ Name: Init ]]
    -- upvalues: v12 (ref)
    if v12 then
        return;
    else
        v12 = true;
        return;
    end;
end;
return v11;