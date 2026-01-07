local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local l_Lighting_0 = game:GetService("Lighting");
local l_Workspace_0 = game:GetService("Workspace");
local l_SoundService_0 = game:GetService("SoundService");
local l_CollectionService_0 = game:GetService("CollectionService");
local l_RunService_0 = game:GetService("RunService");
local v8 = require(l_ReplicatedStorage_0.Modules.Network);
local v9 = require(l_ReplicatedStorage_0.Game.Events);
local v10 = require(l_ReplicatedStorage_0.Modules.Short);
local v11 = require(l_ReplicatedStorage_0.Modules.ShootingStars);
local v12 = require(l_ReplicatedStorage_0.Modules.ZoodCameraShake);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v14 = nil;
local v15 = nil;
local v16 = nil;
local v17 = require(l_ReplicatedStorage_0.Modules.Signal);
local v18 = false;
local function _() --[[ Line: 26 ]] --[[ Name: ensureGui ]]
    -- upvalues: v14 (ref), l_LocalPlayer_0 (copy), v15 (ref), l_ReplicatedStorage_0 (copy), v16 (ref)
    if v14 then
        return;
    else
        v14 = l_LocalPlayer_0:WaitForChild("PlayerGui");
        v15 = l_ReplicatedStorage_0:WaitForChild("Content");
        v16 = v14:WaitForChild("Game"):WaitForChild("Active");
        return;
    end;
end;
local v20 = false;
local v21 = nil;
local v22 = {};
local v23 = {};
local v24 = {};
local v25 = {};
local v26 = {};
local v27 = {
    Ambient = l_Lighting_0.Ambient, 
    ColorShift_Top = l_Lighting_0.ColorShift_Top, 
    OutdoorAmbient = l_Lighting_0.OutdoorAmbient
};
local v28 = {
    Taco = true
};
local v29 = false;
local v30 = nil;
local v31 = nil;
local v32 = nil;
local v33 = nil;
local v34 = nil;
local function v36() --[[ Line: 72 ]] --[[ Name: createScreenEffects ]]
    -- upvalues: v14 (ref), l_LocalPlayer_0 (copy), v15 (ref), l_ReplicatedStorage_0 (copy), v16 (ref), v32 (ref), v33 (ref), v34 (ref)
    if not v14 then
        v14 = l_LocalPlayer_0:WaitForChild("PlayerGui");
        v15 = l_ReplicatedStorage_0:WaitForChild("Content");
        v16 = v14:WaitForChild("Game"):WaitForChild("Active");
    end;
    v32 = Instance.new("ScreenGui");
    v32.Name = "EventEffects";
    v32.DisplayOrder = 100;
    v32.ResetOnSpawn = false;
    v32.IgnoreGuiInset = true;
    v32.Enabled = true;
    v32.Parent = v14;
    v33 = Instance.new("Frame");
    v33.Name = "Outline";
    v33.Size = UDim2.fromScale(1, 1);
    v33.Position = UDim2.fromScale(0, 0);
    v33.BackgroundTransparency = 1;
    v33.BorderSizePixel = 0;
    v33.Parent = v32;
    local l_UIStroke_0 = Instance.new("UIStroke");
    l_UIStroke_0.Name = "OutlineStroke";
    l_UIStroke_0.Color = Color3.fromRGB(255, 0, 0);
    l_UIStroke_0.Thickness = 8;
    l_UIStroke_0.Transparency = 1;
    l_UIStroke_0.Parent = v33;
    v34 = Instance.new("Frame");
    v34.Name = "CloverContainer";
    v34.Size = UDim2.fromScale(1, 1);
    v34.Position = UDim2.fromScale(0, 0);
    v34.BackgroundTransparency = 1;
    v34.BorderSizePixel = 0;
    v34.ClipsDescendants = false;
    v34.Parent = v32;
end;
local function _() --[[ Line: 111 ]] --[[ Name: startPartyFOVPulse ]]

end;
local function _() --[[ Line: 115 ]] --[[ Name: stopPartyFOVPulse ]]

end;
local function _() --[[ Line: 119 ]] --[[ Name: pausePartyFOVPulse ]]

end;
local function _() --[[ Line: 123 ]] --[[ Name: resumePartyFOVPulse ]]

end;
local function v50(v41) --[[ Line: 128 ]] --[[ Name: startScreenGlowPulse ]]
    -- upvalues: v14 (ref), l_LocalPlayer_0 (copy), v15 (ref), l_ReplicatedStorage_0 (copy), v16 (ref), v31 (ref), v30 (ref), v29 (ref), l_RunService_0 (copy)
    if not v14 then
        v14 = l_LocalPlayer_0:WaitForChild("PlayerGui");
        v15 = l_ReplicatedStorage_0:WaitForChild("Content");
        v16 = v14:WaitForChild("Game"):WaitForChild("Active");
    end;
    local l_ScreenGlow_0 = v14:FindFirstChild("ScreenGlow");
    if not l_ScreenGlow_0 then
        return;
    else
        local l_Template_0 = l_ScreenGlow_0:FindFirstChild("Template");
        if not l_Template_0 then
            return;
        else
            if v31 then
                v31:Disconnect();
                v31 = nil;
            end;
            if v30 then
                v30:Destroy();
                v30 = nil;
            end;
            local v44 = l_Template_0:Clone();
            v44.Name = "EventGlowPulse";
            v44.Visible = true;
            v44.ImageColor3 = v41;
            v44.ImageTransparency = 0.6;
            v44.Parent = l_ScreenGlow_0;
            v30 = v44;
            v29 = true;
            local v45 = 0;
            v31 = l_RunService_0.RenderStepped:Connect(function(v46) --[[ Line: 164 ]]
                -- upvalues: v29 (ref), v44 (copy), v31 (ref), v45 (ref)
                if not v29 or not v44 or not v44.Parent then
                    if v31 then
                        v31:Disconnect();
                        v31 = nil;
                    end;
                    return;
                else
                    v45 = v45 + v46;
                    local v47 = math.abs((math.sin(v45 * 1.2 * 3.141592653589793)));
                    local v48 = v47 * 0.1 + 1;
                    local v49 = (1 - v48) / 2;
                    v44.Size = UDim2.new(v48, 0, v48, 0);
                    v44.Position = UDim2.new(v49, 0, v49, 0);
                    v44.ImageTransparency = 0.6 - v47 * 0.2;
                    return;
                end;
            end);
            return;
        end;
    end;
end;
local function v52() --[[ Line: 188 ]] --[[ Name: stopScreenGlowPulse ]]
    -- upvalues: v29 (ref), v31 (ref), v30 (ref), l_TweenService_0 (copy)
    v29 = false;
    if v31 then
        v31:Disconnect();
        v31 = nil;
    end;
    if v30 then
        l_TweenService_0:Create(v30, TweenInfo.new(0.5), {
            ImageTransparency = 1
        }):Play();
        local l_v30_0 = v30;
        v30 = nil;
        task.delay(0.5, function() --[[ Line: 205 ]]
            -- upvalues: l_v30_0 (copy)
            if l_v30_0 and l_v30_0.Parent then
                l_v30_0:Destroy();
            end;
        end);
    end;
end;
local function _(v53) --[[ Line: 213 ]] --[[ Name: updateScreenGlowColor ]]
    -- upvalues: v30 (ref)
    if v30 and v30.Parent then
        v30.ImageColor3 = v53;
    end;
end;
local function v62(v55, v56) --[[ Line: 219 ]] --[[ Name: createFallingClover ]]
    -- upvalues: v34 (ref), l_TweenService_0 (copy)
    local l_ImageLabel_0 = Instance.new("ImageLabel");
    l_ImageLabel_0.Name = "Clover";
    l_ImageLabel_0.Size = UDim2.fromOffset(60, 60);
    l_ImageLabel_0.BackgroundTransparency = 1;
    l_ImageLabel_0.ImageColor3 = v55;
    l_ImageLabel_0.Image = v56;
    l_ImageLabel_0.Rotation = math.random(0, 360);
    local v58 = math.random(0, 100) / 100;
    l_ImageLabel_0.Position = UDim2.fromScale(v58, -0.1);
    l_ImageLabel_0.Parent = v34;
    local v59 = math.random(15, 25) / 10;
    local v60 = math.random(-180, 180);
    local v61 = l_TweenService_0:Create(l_ImageLabel_0, TweenInfo.new(v59, Enum.EasingStyle.Linear), {
        Position = UDim2.fromScale(v58, 1.1), 
        Rotation = l_ImageLabel_0.Rotation + v60
    });
    v61:Play();
    v61.Completed:Connect(function() --[[ Line: 246 ]]
        -- upvalues: l_ImageLabel_0 (copy)
        l_ImageLabel_0:Destroy();
    end);
    return l_ImageLabel_0;
end;
local function v70(v63) --[[ Line: 253 ]] --[[ Name: startCloversEffect ]]
    -- upvalues: v9 (copy), v32 (ref), v23 (copy), v62 (copy)
    local v64 = "Green";
    local v65 = "LuckEvent";
    if v63 == "Mythic" then
        v64 = "Red";
        v65 = "MythicEvent";
    elseif v63 == "Taco" then
        v64 = "Orange";
        v65 = "TacoEvent";
    end;
    local v66 = v9[v65];
    if not v66 then
        return;
    else
        local v67 = Color3.fromRGB(255, 255, 255);
        if v64 == "Green" then
            v67 = Color3.fromRGB(100, 255, 100);
        elseif v64 == "Orange" then
            v67 = Color3.fromRGB(255, 255, 255);
        end;
        local l_Image_0 = v66.Image;
        local _ = nil;
        v32.Enabled = true;
        return (task.spawn(function() --[[ Line: 282 ]]
            -- upvalues: v23 (ref), v63 (copy), v62 (ref), v67 (ref), l_Image_0 (copy)
            while v23[v63] do
                v62(v67, l_Image_0);
                task.wait(0.6);
            end;
        end));
    end;
end;
local function _(v71, v72) --[[ Line: 292 ]] --[[ Name: updateLighting ]]
    -- upvalues: v27 (copy), l_TweenService_0 (copy), l_Lighting_0 (copy)
    local v73 = {};
    if v72 then
        if v71 == "Red" then
            v73.Ambient = Color3.fromRGB(math.min(255, v27.Ambient.R * 255 + 30), math.max(0, v27.Ambient.G * 255 - 10), (math.max(0, v27.Ambient.B * 255 - 10)));
            v73.ColorShift_Top = Color3.fromRGB(255, 100, 100);
        elseif v71 == "Green" then
            v73.Ambient = Color3.fromRGB(math.max(0, v27.Ambient.R * 255 - 10), math.min(255, v27.Ambient.G * 255 + 30), (math.max(0, v27.Ambient.B * 255 - 10)));
            v73.ColorShift_Top = Color3.fromRGB(100, 255, 100);
        end;
        v73.OutdoorAmbient = v27.OutdoorAmbient;
    else
        v73 = v27;
    end;
    local v74 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
    l_TweenService_0:Create(l_Lighting_0, v74, {
        Ambient = v73.Ambient, 
        ColorShift_Top = v73.ColorShift_Top, 
        OutdoorAmbient = v73.OutdoorAmbient
    }):Play();
end;
local function v85(v76, v77) --[[ Line: 327 ]] --[[ Name: createEventFrame ]]
    -- upvalues: v14 (ref), l_LocalPlayer_0 (copy), v15 (ref), l_ReplicatedStorage_0 (copy), v16 (ref), v9 (copy), v17 (copy)
    if not v14 then
        v14 = l_LocalPlayer_0:WaitForChild("PlayerGui");
        v15 = l_ReplicatedStorage_0:WaitForChild("Content");
        v16 = v14:WaitForChild("Game"):WaitForChild("Active");
    end;
    local l_Active_0 = v15.UI:FindFirstChild("Active");
    if not l_Active_0 then
        warn("[EventEffects] Active template not found");
        return;
    else
        local v79 = l_Active_0:Clone();
        local v80 = "LuckEvent";
        if v76 == "Mythic" then
            v80 = "MythicEvent";
        elseif v76 == "Luck" then
            v80 = "LuckEvent";
        elseif v76 == "Clicks" then
            v80 = "ClicksEvent";
        elseif v76 == "Taco" then
            v80 = "TacoEvent";
        end;
        local v81 = v9[v80];
        if not v81 then
            return;
        else
            v79.Name = v80;
            v79.Icon.Image = v81.Image;
            v79.Icon.ImageColor3 = Color3.fromRGB(255, 255, 255);
            v79.Label.Text = "--";
            v79.Label.RichText = true;
            local l_Hitbox_0 = v79:FindFirstChild("Hitbox");
            if not l_Hitbox_0 then
                l_Hitbox_0 = Instance.new("TextButton");
                l_Hitbox_0.Name = "Hitbox";
                l_Hitbox_0.Size = UDim2.new(1, 0, 1, 0);
                l_Hitbox_0.Position = UDim2.new(0, 0, 0, 0);
                l_Hitbox_0.BackgroundTransparency = 1;
                l_Hitbox_0.Text = "";
                l_Hitbox_0.ZIndex = 10;
                l_Hitbox_0.Parent = v79;
            end;
            local l_Description_0 = v81.Description;
            if v77 then
                if v76 == "Luck" then
                    l_Description_0 = v77 .. "x Luck on all eggs!";
                elseif v76 == "Mythic" then
                    l_Description_0 = v77 .. "x chance for Mythic pets!";
                elseif v76 == "Clicks" then
                    l_Description_0 = v77 .. "x Clicks on all taps!";
                elseif v76 == "Taco" then
                    l_Description_0 = v77 .. "x All Boosts!";
                end;
            end;
            local v84 = string.format("<font color=\"rgb(255,255,255)\"><b>%s</b></font>\n<font color=\"rgb(200,200,200)\">%s</font>", v81.Name, l_Description_0);
            v17.Fire("Tooltip", l_Hitbox_0, v84);
            v79.Parent = v16;
            return v79;
        end;
    end;
end;
local function v106(v86, v87, v88, v89) --[[ Line: 394 ]] --[[ Name: startEvent ]]
    -- upvalues: v23 (copy), v25 (copy), v26 (copy), v24 (copy), v85 (copy), v17 (copy), v28 (copy), v50 (copy), v33 (ref), l_TweenService_0 (copy), v70 (copy), v11 (copy)
    if v23[v86] then
        return;
    else
        v23[v86] = true;
        v25[v86] = tick();
        v26[v86] = v88;
        if not v24[v86] then
            v24[v86] = v85(v86, v89);
        end;
        v17.Fire("GlobalEventChanged", v86, true);
        local v90 = Color3.fromRGB(0, 255, 0);
        if v87 == "Red" then
            v90 = Color3.fromRGB(255, 0, 0);
        elseif v87 == "Blue" then
            v90 = Color3.fromRGB(0, 150, 255);
        elseif v87 == "Orange" then
            v90 = Color3.fromRGB(255, 200, 0);
        end;
        local v91 = "EVENT STARTED";
        if v86 == "Mythic" then
            v91 = (v89 or 5) .. "X MYTHIC EVENT STARTED";
        elseif v86 == "Luck" then
            v91 = (v89 or 3) .. "X LUCK EVENT STARTED";
        elseif v86 == "Clicks" then
            v91 = (v89 or 10) .. "X CLICKS EVENT STARTED";
        elseif v86 == "Taco" then
            v91 = (v89 or 2) .. "X TACO TUESDAY STARTED";
        end;
        v17.Fire("ScreenGlow", v90, 1.5, 0.5);
        v17.Fire("Notification", v91, v90, nil, 5);
        if v28[v86] then
            v50(v90);
        end;
        local l_OutlineStroke_0 = v33:FindFirstChild("OutlineStroke");
        if l_OutlineStroke_0 then
            l_OutlineStroke_0.Color = v90;
            l_TweenService_0:Create(l_OutlineStroke_0, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Transparency = 0.3
            }):Play();
        end;
        _G:Play("QuestReward");
        if v86 == "Taco" then
            _G:PlayEventMusic("rbxassetid://136984419145860", "TacoBron", {
                volume = 1, 
                looped = false
            });
            task.spawn(function() --[[ Line: 460 ]]
                -- upvalues: v17 (ref)
                local v93 = nil;
                local v94 = false;
                local _ = v17.new("GlobalEventChanged");
                v93 = v17.new("GlobalEventChanged"):Connect(function(v96, v97) --[[ Line: 464 ]]
                    -- upvalues: v94 (ref)
                    if v94 then
                        return;
                    elseif v96 == "Taco" and not v97 then
                        v94 = true;
                        return;
                    else
                        return;
                    end;
                end);
                local v98 = Color3.fromRGB(255, 255, 255);
                local v99 = Color3.fromRGB(255, 255, 0);
                local v100 = string.format("[\238\128\128 %s]: %s", "LeBron", "Hey, what's up y'all? Happy Tuesday.");
                _G.DisplayGlobalMessage(v100, v98, nil, 5, nil);
                task.wait(5);
                if v94 then
                    return;
                else
                    local v101 = string.format("[\238\128\128 %s]: %s", "LeBron", "Um... a lot of things have been going on today, kind of got me down.");
                    _G.DisplayGlobalMessage(v101, v98, nil, 5, nil);
                    task.wait(5);
                    if v94 then
                        return;
                    else
                        local v102 = string.format("[\238\128\128 %s]: %s", "LeBron", "You know, so I don't really know what's going on with me and my energy today, but\226\128\148");
                        _G.DisplayGlobalMessage(v102, v98, nil, 7, nil);
                        task.wait(7);
                        if v94 then
                            return;
                        else
                            local v103 = string.format("[\238\128\128 %s]: %s", "LeBron", "SIKE! Y'all know what today is!");
                            _G.DisplayGlobalMessage(v103, v99, nil, 5, nil);
                            task.wait(5);
                            if v94 then
                                return;
                            else
                                local v104 = string.format("[\238\128\128 %s]: %s", "LeBron", "Today is TACO TUESDAY!");
                                _G.DisplayGlobalMessage(v104, v99, nil, 4, nil);
                                task.wait(4);
                                v94 = true;
                                if v94 then
                                    return;
                                else
                                    return;
                                end;
                            end;
                        end;
                    end;
                end;
            end);
            task.delay(26, function() --[[ Line: 521 ]]
                _G:PlayEventMusic("rbxassetid://142376088", "Taco", {
                    volume = 0.3, 
                    looped = true
                });
            end);
        else
            local l_Sound_0 = Instance.new("Sound");
            l_Sound_0.Name = v86 .. "EventMusic";
            l_Sound_0.SoundId = "rbxassetid://1836032047";
            l_Sound_0.Volume = 0.1;
            l_Sound_0.Looped = true;
            l_Sound_0.Parent = game:GetService("SoundService");
            l_Sound_0:Play();
        end;
        if v86 == "Luck" or v86 == "Mythic" or v86 == "Taco" then
            if v86 == "Taco" then
                task.delay(27, function() --[[ Line: 541 ]]
                    -- upvalues: v70 (ref), v86 (copy)
                    v70(v86);
                end);
            else
                v70(v86);
            end;
        end;
        if v86 == "Mythic" then
            v11.CustomizeShootingStars({
                ColorSequence = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(200, 100, 255)), 
                    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(255, 100, 200)), 
                    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(255, 128, 0)), 
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
                }), 
                GlowColor = Color3.fromRGB(220, 120, 200), 
                GlowBrightness = 4, 
                GlowRange = 8, 
                Brightness = 1, 
                StartWidth = 0.55, 
                Speed = 120, 
                SpawnRadius = 200, 
                SpawnHeight = 100, 
                Direction = Vector3.new(-1.5, -0.5, 0, 0), 
                EnableStarBillboard = true, 
                StarRotationSpeed = 180, 
                StarImageColor = Color3.fromRGB(255, 200, 255)
            });
            v11.EnableShootingStars(true);
        elseif v86 == "Luck" then
            v11.CustomizeShootingStars({
                ColorSequence = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(214, 255, 11)), 
                    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(41, 255, 17)), 
                    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(71, 255, 15)), 
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(29, 255, 63))
                }), 
                GlowColor = Color3.fromRGB(19, 255, 7), 
                GlowBrightness = 4, 
                GlowRange = 8, 
                Brightness = 1, 
                StartWidth = 0.55, 
                Speed = 80, 
                SpawnRadius = 100, 
                SpawnHeight = 80, 
                Direction = Vector3.new(-1.5, -0.5, 0, 0), 
                EnableStarBillboard = true, 
                StarRotationSpeed = 180, 
                StarImageColor = Color3.fromRGB(125, 255, 102)
            });
            v11.EnableShootingStars(true);
        elseif v86 == "Clicks" then
            v11.CustomizeShootingStars({
                ColorSequence = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 200, 255)), 
                    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(0, 150, 255)), 
                    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(100, 100, 255)), 
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 100, 255))
                }), 
                GlowColor = Color3.fromRGB(0, 150, 255), 
                GlowBrightness = 5, 
                GlowRange = 10, 
                Brightness = 1.2, 
                StartWidth = 0.6, 
                Speed = 140, 
                SpawnRadius = 180, 
                SpawnHeight = 120, 
                Direction = Vector3.new(-1.5, -0.5, 0, 0), 
                EnableStarBillboard = true, 
                StarRotationSpeed = 200, 
                StarImageColor = Color3.fromRGB(100, 200, 255)
            });
            v11.EnableShootingStars(true);
        elseif v86 == "Taco" then
            v11.CustomizeShootingStars({
                ColorSequence = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 220, 50)), 
                    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(255, 180, 0)), 
                    ColorSequenceKeypoint.new(0.6, Color3.fromRGB(255, 140, 0)), 
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 100, 50))
                }), 
                GlowColor = Color3.fromRGB(255, 200, 50), 
                GlowBrightness = 4, 
                GlowRange = 8, 
                Brightness = 1.1, 
                StartWidth = 0.5, 
                Speed = 100, 
                SpawnRadius = 150, 
                SpawnHeight = 100, 
                Direction = Vector3.new(-1.5, -0.5, 0, 0), 
                EnableStarBillboard = true, 
                StarRotationSpeed = 150, 
                StarImageColor = Color3.fromRGB(255, 220, 100)
            });
            v11.EnableShootingStars(true);
        end;
        if v28[v86] and v86 == "Taco" then
            task.delay(27, function() --[[ Line: 644 ]]
                -- upvalues: v23 (ref), v86 (copy)
                if v23[v86] then

                end;
            end);
            return;
        else
            return;
        end;
    end;
end;
local function v115(v107, v108) --[[ Line: 658 ]] --[[ Name: endEvent ]]
    -- upvalues: v23 (copy), v25 (copy), v26 (copy), v17 (copy), v24 (copy), v28 (copy), v52 (copy), v11 (copy), v33 (ref), l_TweenService_0 (copy), v34 (ref)
    if not v23[v107] then
        return;
    else
        v23[v107] = false;
        v25[v107] = nil;
        v26[v107] = nil;
        local v109 = Color3.fromRGB(100, 255, 100);
        if v108 == "Red" then
            v109 = Color3.fromRGB(255, 100, 100);
        elseif v108 == "Blue" then
            v109 = Color3.fromRGB(100, 150, 255);
        elseif v108 == "Orange" then
            v109 = Color3.fromRGB(255, 200, 100);
        end;
        local v110 = "EVENT ENDED";
        if v107 == "Mythic" then
            v110 = "MYTHIC EVENT ENDED";
        elseif v107 == "Luck" then
            v110 = "LUCK EVENT ENDED";
        elseif v107 == "Clicks" then
            v110 = "CLICKS EVENT ENDED";
        elseif v107 == "Taco" then
            v110 = "TACO TUESDAY ENDED";
        end;
        v17.Fire("ScreenGlow", v109, 1, 0.3);
        v17.Fire("Notification", v110, v109, nil, 4);
        if v24[v107] then
            v24[v107]:Destroy();
            v24[v107] = nil;
        end;
        v17.Fire("GlobalEventChanged", v107, false);
        if v28[v107] then
            v52();
        end;
        v11.EnableShootingStars(false);
        if v28[v107] then

        end;
        if v107 == "Taco" then
            _G:StopEventMusic(v107);
            _G:StopEventMusic("TacoBron");
        else
            local l_FirstChild_0 = game:GetService("SoundService"):FindFirstChild(v107 .. "EventMusic");
            if l_FirstChild_0 then
                l_FirstChild_0:Stop();
                l_FirstChild_0:Destroy();
            end;
        end;
        local l_OutlineStroke_1 = v33:FindFirstChild("OutlineStroke");
        if l_OutlineStroke_1 then
            l_TweenService_0:Create(l_OutlineStroke_1, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Transparency = 1
            }):Play();
        end;
        task.delay(0.5, function() --[[ Line: 732 ]]
            -- upvalues: v34 (ref), l_TweenService_0 (ref)
            for _, v114 in ipairs(v34:GetChildren()) do
                if v114:IsA("ImageLabel") then
                    l_TweenService_0:Create(v114, TweenInfo.new(0.3), {
                        ImageTransparency = 1
                    }):Play();
                    task.delay(0.3, function() --[[ Line: 738 ]]
                        -- upvalues: v114 (copy)
                        v114:Destroy();
                    end);
                end;
            end;
        end);
        return;
    end;
end;
local function v117(v116) --[[ Line: 753 ]] --[[ Name: setSnowIslandDarkness ]]
    -- upvalues: v20 (ref), l_Workspace_0 (copy), v21 (ref), l_TweenService_0 (copy), l_Lighting_0 (copy), v27 (copy)
    v20 = v116;
    if not (l_Workspace_0:FindFirstChild("Islands") and l_Workspace_0.Islands:FindFirstChild("SnowIsland") or l_Workspace_0:FindFirstChild("SnowIsland")) then
        warn("[Blizzard] Could not find Snow Island for lighting changes");
        return;
    elseif v116 then
        if not v21 then
            v21 = Instance.new("Atmosphere");
            v21.Density = 0.4;
            v21.Offset = 0.5;
            v21.Color = Color3.fromRGB(60, 100, 140);
            v21.Decay = Color3.fromRGB(50, 80, 120);
            v21.Glare = 0.2;
            v21.Haze = 2;
        end;
        l_TweenService_0:Create(l_Lighting_0, TweenInfo.new(2), {
            Ambient = Color3.fromRGB(80, 120, 160), 
            OutdoorAmbient = Color3.fromRGB(60, 100, 140), 
            Brightness = 1.5
        }):Play();
        return;
    else
        l_TweenService_0:Create(l_Lighting_0, TweenInfo.new(2), {
            Ambient = v27.Ambient, 
            OutdoorAmbient = v27.OutdoorAmbient, 
            Brightness = 2
        }):Play();
        return;
    end;
end;
local function v120(v118, v119) --[[ Line: 799 ]] --[[ Name: showChatAnnouncement ]]
    game:GetService("StarterGui"):SetCore("ChatMakeSystemMessage", {
        Text = v118, 
        Color = v119 or Color3.fromRGB(255, 255, 0), 
        Font = Enum.Font.GothamBold, 
        TextSize = 18
    });
end;
local function v130(v121, v122) --[[ Line: 809 ]] --[[ Name: applyShockedEffects ]]
    -- upvalues: l_ReplicatedStorage_0 (copy), l_TweenService_0 (copy)
    if not v121:GetAttribute("Shocked") then
        return;
    else
        local l_v121_Attribute_0 = v121:GetAttribute("ShockedExpiry");
        if not l_v121_Attribute_0 or l_v121_Attribute_0 <= os.time() then
            v121:SetAttribute("Shocked", false);
            return;
        else
            local l_PrimaryPart_0 = v121.PrimaryPart;
            if l_PrimaryPart_0 and not l_PrimaryPart_0:FindFirstChild("ShockedVFX") then
                local l_LightningVFX_0 = l_ReplicatedStorage_0.Content:FindFirstChild("LightningVFX");
                if l_LightningVFX_0 then
                    local v126 = l_LightningVFX_0:Clone();
                    v126.Name = "ShockedVFX";
                    v126.Parent = l_PrimaryPart_0;
                    if v122 then
                        for _, v128 in ipairs(v126:GetDescendants()) do
                            if v128:IsA("ParticleEmitter") then
                                v128:Emit(30);
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
                    task.delay(l_v121_Attribute_0 - os.time(), function() --[[ Line: 859 ]]
                        -- upvalues: v126 (copy)
                        if v126 and v126.Parent then
                            v126:Destroy();
                        end;
                    end);
                end;
            end;
            return;
        end;
    end;
end;
local function v138(v131) --[[ Line: 869 ]] --[[ Name: applyElectrifiedEffects ]]
    -- upvalues: l_ReplicatedStorage_0 (copy)
    if not v131:GetAttribute("Electrified") then
        return;
    else
        for _, v133 in ipairs(v131:GetDescendants()) do
            if v133:IsA("BasePart") then
                if not v133:GetAttribute("OriginalColor") then
                    v133:SetAttribute("OriginalColor", v133.Color);
                end;
                v133.Color = Color3.fromRGB(100, 200, 255);
                v133.Material = Enum.Material.Neon;
            end;
        end;
        local l_PrimaryPart_1 = v131.PrimaryPart;
        if l_PrimaryPart_1 and not l_PrimaryPart_1:FindFirstChild("ElectrifiedVFX") then
            local l_LightningVFX_1 = l_ReplicatedStorage_0.Content:FindFirstChild("LightningVFX");
            if l_LightningVFX_1 then
                local v136 = l_LightningVFX_1:Clone();
                v136.Name = "ElectrifiedVFX";
                v136.Parent = l_PrimaryPart_1;
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
local v139 = {};
local function v144(v140) --[[ Line: 910 ]] --[[ Name: createAttributeBillboard ]]
    -- upvalues: v139 (copy)
    if v139[v140] then
        return;
    else
        local l_BillboardGui_0 = Instance.new("BillboardGui");
        l_BillboardGui_0.Name = "AttributeBillboard";
        l_BillboardGui_0.Size = UDim2.new(0, 200, 0, 30);
        l_BillboardGui_0.StudsOffsetWorldSpace = Vector3.new(0, v140:GetExtentsSize().Y + 1, 0);
        l_BillboardGui_0.AlwaysOnTop = true;
        l_BillboardGui_0.MaxDistance = 50;
        l_BillboardGui_0.Adornee = v140.PrimaryPart;
        local l_Frame_0 = Instance.new("Frame");
        l_Frame_0.Size = UDim2.new(1, 0, 1, 0);
        l_Frame_0.BackgroundTransparency = 1;
        l_Frame_0.Parent = l_BillboardGui_0;
        local l_UIListLayout_0 = Instance.new("UIListLayout");
        l_UIListLayout_0.FillDirection = Enum.FillDirection.Horizontal;
        l_UIListLayout_0.HorizontalAlignment = Enum.HorizontalAlignment.Center;
        l_UIListLayout_0.Padding = UDim.new(0, 3);
        l_UIListLayout_0.Parent = l_Frame_0;
        l_BillboardGui_0.Parent = v140.PrimaryPart;
        v139[v140] = {
            gui = l_BillboardGui_0, 
            container = l_Frame_0
        };
        return l_BillboardGui_0, l_Frame_0;
    end;
end;
local function v152(v145) --[[ Line: 938 ]] --[[ Name: updateAttributeBillboard ]]
    -- upvalues: v144 (copy), v139 (copy), v17 (copy), v10 (copy)
    local _, v147 = v144(v145);
    v147 = v139[v145].container;
    v147:ClearAllChildren();
    local l_UIListLayout_1 = Instance.new("UIListLayout");
    l_UIListLayout_1.FillDirection = Enum.FillDirection.Horizontal;
    l_UIListLayout_1.HorizontalAlignment = Enum.HorizontalAlignment.Center;
    l_UIListLayout_1.Padding = UDim.new(0, 3);
    l_UIListLayout_1.Parent = v147;
    if v145:GetAttribute("Shocked") then
        local l_v145_Attribute_0 = v145:GetAttribute("ShockedExpiry");
        if l_v145_Attribute_0 and os.time() < l_v145_Attribute_0 then
            local l_TextLabel_0 = Instance.new("TextLabel");
            l_TextLabel_0.Name = "ShockedBadge";
            l_TextLabel_0.Size = UDim2.new(0, 30, 0, 30);
            l_TextLabel_0.BackgroundColor3 = Color3.fromRGB(100, 200, 255);
            l_TextLabel_0.BorderSizePixel = 0;
            l_TextLabel_0.Text = "\226\154\161";
            l_TextLabel_0.TextScaled = true;
            l_TextLabel_0.Font = Enum.Font.GothamBold;
            l_TextLabel_0.Parent = v147;
            v17.Fire("Tooltip", l_TextLabel_0, string.format("<b>\226\154\161 Shocked</b>\n+20%% clicks\nTime left: %s", v10:FormatTimeCompressed(l_v145_Attribute_0 - os.time())));
        end;
    end;
    if v145:GetAttribute("Electrified") then
        local l_TextLabel_1 = Instance.new("TextLabel");
        l_TextLabel_1.Name = "ElectrifiedBadge";
        l_TextLabel_1.Size = UDim2.new(0, 30, 0, 30);
        l_TextLabel_1.BackgroundColor3 = Color3.fromRGB(100, 200, 255);
        l_TextLabel_1.BorderSizePixel = 0;
        l_TextLabel_1.Text = "\226\154\161\226\154\161";
        l_TextLabel_1.TextScaled = true;
        l_TextLabel_1.Font = Enum.Font.GothamBold;
        l_TextLabel_1.Parent = v147;
        v17.Fire("Tooltip", l_TextLabel_1, "<b>\226\154\161 Electrified</b>\n3x multiplier\nPermanent");
    end;
end;
local function v158() --[[ Line: 992 ]] --[[ Name: setupPetWatcher ]]
    -- upvalues: l_CollectionService_0 (copy), l_LocalPlayer_0 (copy), v138 (copy), v130 (copy), v152 (copy)
    for _, v154 in ipairs(l_CollectionService_0:GetTagged("Pet")) do
        if v154:GetAttribute("Owner") == l_LocalPlayer_0.UserId then
            v138(v154);
            v130(v154);
            v152(v154);
        end;
    end;
    l_CollectionService_0:GetInstanceAddedSignal("Pet"):Connect(function(v155) --[[ Line: 1003 ]]
        -- upvalues: l_LocalPlayer_0 (ref), v138 (ref), v130 (ref), v152 (ref)
        if v155:GetAttribute("Owner") == l_LocalPlayer_0.UserId then
            task.wait(0.1);
            v138(v155);
            v130(v155);
            v152(v155);
            v155:GetAttributeChangedSignal("Shocked"):Connect(function() --[[ Line: 1011 ]]
                -- upvalues: v130 (ref), v155 (copy), v152 (ref)
                v130(v155);
                v152(v155);
            end);
            v155:GetAttributeChangedSignal("Electrified"):Connect(function() --[[ Line: 1016 ]]
                -- upvalues: v138 (ref), v155 (copy), v152 (ref)
                v138(v155);
                v152(v155);
            end);
        end;
    end);
    task.spawn(function() --[[ Line: 1024 ]]
        -- upvalues: l_CollectionService_0 (ref), l_LocalPlayer_0 (ref), v152 (ref)
        while true do
            task.wait(1);
            for _, v157 in ipairs(l_CollectionService_0:GetTagged("Pet")) do
                if v157:GetAttribute("Owner") == l_LocalPlayer_0.UserId then
                    v152(v157);
                end;
            end;
        end;
    end);
end;
local function v185() --[[ Line: 1037 ]] --[[ Name: initialize ]]
    -- upvalues: v14 (ref), l_LocalPlayer_0 (copy), v15 (ref), l_ReplicatedStorage_0 (copy), v16 (ref), v36 (copy), l_Workspace_0 (copy), v106 (copy), v8 (copy), v115 (copy), v120 (copy), v130 (copy), v152 (copy), v117 (copy), v12 (copy), l_SoundService_0 (copy), l_TweenService_0 (copy), v158 (copy), v17 (copy), v24 (copy), v25 (copy), v9 (copy), v26 (copy), v10 (copy)
    if not v14 then
        v14 = l_LocalPlayer_0:WaitForChild("PlayerGui");
        v15 = l_ReplicatedStorage_0:WaitForChild("Content");
        v16 = v14:WaitForChild("Game"):WaitForChild("Active");
    end;
    v36();
    task.defer(function() --[[ Line: 1042 ]]
        -- upvalues: l_Workspace_0 (ref), v106 (ref)
        task.wait(1);
        if l_Workspace_0:GetAttribute("Event_Mythic_Active") == true then
            local l_l_Workspace_0_Attribute_0 = l_Workspace_0:GetAttribute("Event_Mythic_Duration");
            v106("Mythic", "Red", l_l_Workspace_0_Attribute_0);
        end;
        if l_Workspace_0:GetAttribute("Event_Luck_Active") == true then
            local l_l_Workspace_0_Attribute_1 = l_Workspace_0:GetAttribute("Event_Luck_Duration");
            v106("Luck", "Green", l_l_Workspace_0_Attribute_1);
        end;
        if l_Workspace_0:GetAttribute("Event_Clicks_Active") == true then
            local l_l_Workspace_0_Attribute_2 = l_Workspace_0:GetAttribute("Event_Clicks_Duration");
            v106("Clicks", "Blue", l_l_Workspace_0_Attribute_2);
        end;
    end);
    v8:BindEvents({
        GlobalEventStateChanged = function(v162, v163, v164, v165, v166) --[[ Line: 1067 ]] --[[ Name: GlobalEventStateChanged ]]
            -- upvalues: v106 (ref), v115 (ref)
            if v163 then
                v106(v162, v164, v165, v166);
                return;
            else
                v115(v162, v164);
                return;
            end;
        end, 
        ChatAnnouncement = function(v167, v168) --[[ Line: 1074 ]] --[[ Name: ChatAnnouncement ]]
            -- upvalues: v120 (ref)
            v120(v167, v168);
        end, 
        BlizzardPetStruck = function(v169) --[[ Line: 1077 ]] --[[ Name: BlizzardPetStruck ]]
            -- upvalues: l_LocalPlayer_0 (ref), v130 (ref), v152 (ref)
            if v169 and v169:GetAttribute("Owner") == l_LocalPlayer_0.UserId then
                v130(v169, true);
                v152(v169);
            end;
        end, 
        BlizzardSpawned = function(v170) --[[ Line: 1083 ]] --[[ Name: BlizzardSpawned ]]
            -- upvalues: v117 (ref)
            v117(v170);
        end, 
        MapEvent_CameraShake = function(v171) --[[ Line: 1087 ]] --[[ Name: MapEvent_CameraShake ]]
            -- upvalues: v12 (ref)
            if v171.intensity then
                v12.PlayOnce(v171.intensity, v171.duration, v171.frequency, v171.rampUp);
            end;
        end, 
        MapEvent_PlaySound = function(v172) --[[ Line: 1093 ]] --[[ Name: MapEvent_PlaySound ]]
            -- upvalues: l_SoundService_0 (ref), l_TweenService_0 (ref)
            if v172.soundId then
                task.spawn(function() --[[ Line: 1095 ]]
                    -- upvalues: v172 (copy), l_SoundService_0 (ref), l_TweenService_0 (ref)
                    local v173 = v172.volume or 0.5;
                    local l_Sound_1 = Instance.new("Sound");
                    l_Sound_1.SoundId = v172.soundId;
                    l_Sound_1.Volume = v172.fadeIn and 0 or v173;
                    l_Sound_1.PlaybackSpeed = v172.playbackSpeed or 1;
                    l_Sound_1.Parent = l_SoundService_0;
                    if not l_Sound_1.IsLoaded then
                        l_Sound_1.Loaded:Wait();
                    end;
                    l_Sound_1:Play();
                    if v172.fadeIn and v172.fadeIn > 0 then
                        l_TweenService_0:Create(l_Sound_1, TweenInfo.new(v172.fadeIn, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                            Volume = v173
                        }):Play();
                    end;
                    local v175 = v172.fadeOut or 0;
                    if v175 > 0 then
                        local v176 = math.max(0, l_Sound_1.TimeLength - v175);
                        task.delay(v176, function() --[[ Line: 1124 ]]
                            -- upvalues: l_Sound_1 (copy), l_TweenService_0 (ref), v175 (copy)
                            if l_Sound_1 and l_Sound_1.Parent then
                                local v177 = l_TweenService_0:Create(l_Sound_1, TweenInfo.new(v175, Enum.EasingStyle.Linear), {
                                    Volume = 0
                                });
                                v177:Play();
                                v177.Completed:Connect(function() --[[ Line: 1130 ]]
                                    -- upvalues: l_Sound_1 (ref)
                                    if l_Sound_1 and l_Sound_1.Parent then
                                        l_Sound_1:Stop();
                                        l_Sound_1:Destroy();
                                    end;
                                end);
                            end;
                        end);
                        return;
                    else
                        l_Sound_1.Ended:Connect(function() --[[ Line: 1140 ]]
                            -- upvalues: l_Sound_1 (copy)
                            l_Sound_1:Destroy();
                        end);
                        return;
                    end;
                end);
            end;
        end
    });
    v158();
    (v17:GetSignal("HatchingStarted") or v17.new("HatchingStarted")):Connect(function() --[[ Line: 1154 ]]

    end);
    (v17:GetSignal("HatchingEnded") or v17.new("HatchingEnded")):Connect(function() --[[ Line: 1159 ]]

    end);
    task.spawn(function() --[[ Line: 1164 ]]
        -- upvalues: v24 (ref), v25 (ref), v9 (ref), v26 (ref), v10 (ref)
        while true do
            task.wait(0.1);
            for v178, v179 in pairs(v24) do
                if v179 and v25[v178] then
                    local v180 = tick() - v25[v178];
                    local v181 = "LuckEvent";
                    if v178 == "Mythic" then
                        v181 = "MythicEvent";
                    elseif v178 == "Luck" then
                        v181 = "LuckEvent";
                    elseif v178 == "Clicks" then
                        v181 = "ClicksEvent";
                    elseif v178 == "Taco" then
                        v181 = "TacoEvent";
                    end;
                    local v182 = v9[v181];
                    local v183 = (v26[v178] or v182 and v182.Duration or 15) - v180;
                    if v183 > 0 then
                        local v184 = v10:FormatTimeCompressed(v183);
                        v179.Label.Text = type(v184) == "string" and v184 or tostring((math.floor(v183))) .. "s";
                    else
                        v179.Label.Text = "0s";
                    end;
                end;
            end;
        end;
    end);
end;
v22.Init = function(_) --[[ Line: 1199 ]] --[[ Name: Init ]]
    -- upvalues: v18 (ref), v185 (copy)
    if v18 then
        return;
    else
        v18 = true;
        v185();
        return;
    end;
end;
return v22;