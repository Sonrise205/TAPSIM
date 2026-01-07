local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("ContextActionService");
local l_UserInputService_0 = game:GetService("UserInputService");
local _ = game:GetService("MarketplaceService");
local l_HapticService_0 = game:GetService("HapticService");
local _ = require(l_ReplicatedStorage_0.Game.Marketplace);
local _ = require(l_ReplicatedStorage_0.Game.PetFrames);
local v9 = require(l_ReplicatedStorage_0.Game.EnchantData);
local v10 = require(l_ReplicatedStorage_0.Modules.ScreenSpace);
local v11 = require(l_ReplicatedStorage_0.Modules.Network);
local v12 = require(l_ReplicatedStorage_0.Modules.Rainbow);
local v13 = require(l_ReplicatedStorage_0.Modules.Signal);
local v14 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v15 = require(l_ReplicatedStorage_0.Modules.Short);
local v16 = require(l_ReplicatedStorage_0.Modules.GIF);
local v17 = require(l_ReplicatedStorage_0.Game.Variables);
local v18 = require(l_ReplicatedStorage_0.Game.Replication);
local l_Popups_0 = require(script.Parent:WaitForChild("Popups"));
local v20 = require(l_ReplicatedStorage_0.Game.Skins);
local v21 = require(l_ReplicatedStorage_0.Game.ComboStages);
local v22 = require(script.UIClickLines);
local v23 = require(l_ReplicatedStorage_0.Game.Portals);
local v24 = require(l_ReplicatedStorage_0.Game.Boosts);
v22.new():Enable();
local l_CurrentCamera_0 = workspace.CurrentCamera;
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_UI_0 = l_ReplicatedStorage_0.Content.UI;
local _ = l_UI_0.Circle;
local v29 = l_ReplicatedStorage_0.Content.TapButtonParticles:Clone();
local l_l_LocalPlayer_0_Mouse_0 = l_LocalPlayer_0:GetMouse();
local v31 = false;
local v32 = false;
local v33 = false;
local v34 = false;
local v35 = nil;
local v36 = nil;
local v37 = nil;
local v38 = nil;
local v39 = 0;
local v40 = 1;
local v41 = 0;
if l_UserInputService_0.TouchEnabled then
    local _ = not l_UserInputService_0.KeyboardEnabled;
end;
local _ = {};
local v44 = {};
local v45 = {};
local v46 = nil;
local v47 = 1;
local v48 = 1;
local v49 = 0;
local v50 = 0;
local l_v21_MaxStages_0 = v21:GetMaxStages();
local v52 = nil;
local v53 = {};
local v54 = nil;
local v55 = 0;
local v56 = 0;
local function v71(v57) --[[ Line: 68 ]] --[[ Name: updateComboVisuals ]]
    -- upvalues: v37 (ref), v54 (ref), v31 (ref), v32 (ref), v49 (ref), v55 (ref), v53 (ref), v21 (copy), v14 (copy)
    local l_Combo_0 = v37.Combo;
    if not v54 then
        v54 = l_Combo_0.Size;
    end;
    local v59 = v31 or v32;
    if v57 < 1 or v57 == 1 and v49 <= 0 or not v59 then
        l_Combo_0.Visible = false;
        v55 = 0;
        return;
    else
        l_Combo_0.Visible = true;
        if v55 ~= v57 then
            for _, v61 in pairs(v53) do
                if v61 and v61.Parent then
                    v61:Destroy();
                end;
            end;
            v53 = {};
            local l_v21_StageGradient_0 = v21:GetStageGradient(v57);
            local v63 = nil;
            v63 = if v57 == 1 then v21:GetStageGradient(0) else v21:GetStageGradient(v57 - 1);
            if v63 then
                local v64 = v63:Clone();
                v64.Parent = l_Combo_0;
                table.insert(v53, v64);
                if l_Combo_0:FindFirstChild("UIStroke") then
                    local v65 = v63:Clone();
                    v65.Parent = l_Combo_0.UIStroke;
                    table.insert(v53, v65);
                end;
            end;
            if l_v21_StageGradient_0 then
                if l_Combo_0:FindFirstChild("Glow") then
                    local v66 = l_v21_StageGradient_0:Clone();
                    v66.Parent = l_Combo_0.Glow;
                    table.insert(v53, v66);
                end;
                if l_Combo_0.Amount:FindFirstChild("UIStroke") then
                    local v67 = l_v21_StageGradient_0:Clone();
                    v67.Parent = l_Combo_0.Amount.UIStroke;
                    table.insert(v53, v67);
                end;
                if l_Combo_0:FindFirstChild("Bar") then
                    local v68 = l_v21_StageGradient_0:Clone();
                    v68.Parent = l_Combo_0.Bar;
                    table.insert(v53, v68);
                end;
                if l_Combo_0.Bar:FindFirstChild("UIStroke") then
                    local v69 = l_v21_StageGradient_0:Clone();
                    v69.Parent = l_Combo_0.Bar.UIStroke;
                    table.insert(v53, v69);
                end;
            end;
            local v70 = l_Combo_0.Highlight:Clone();
            v70.Parent = l_Combo_0;
            v70.Visible = true;
            l_Combo_0.Size = UDim2.fromScale(1.7, 0.125);
            v14:Tween(l_Combo_0, 0.4, "Back", "Out", {
                Size = v54
            });
            v14:Tween(v70, 0.4, "Quad", "Out", {
                Size = UDim2.fromScale(1.35, 2.3), 
                BackgroundTransparency = 1
            }, false, nil, function() --[[ Line: 160 ]]
                -- upvalues: v70 (copy)
                v70:Destroy();
            end);
            v55 = v57;
        end;
        return;
    end;
end;
local function v98(v72, v73) --[[ Line: 169 ]] --[[ Name: updateLabel ]]
    -- upvalues: v40 (ref), v18 (copy), v31 (ref), v32 (ref), v21 (copy), v48 (ref), v23 (copy), v24 (copy), v9 (copy), v20 (copy), v34 (ref), v47 (ref), v37 (ref), v15 (copy), v46 (ref), l_RunService_0 (copy)
    local v74 = tonumber(v40) or 0;
    v72 = v72 or v18.Data;
    if not v18.Loaded then
        return;
    else
        local v75 = (v31 or v32) and v21:GetMultiplier(v48) or 1;
        local v76 = 1;
        if v72.Zone and v72.Zone ~= "" and v23[v72.Zone] then
            v76 = v23[v72.Zone].Multi or 1;
        end;
        local v77 = 1;
        if v72.ActiveBoosts and v72.ActiveBoosts.FriendBoost then
            local l_FriendBoost_0 = v72.ActiveBoosts.FriendBoost;
            local v79 = {
                1.1, 
                1.05, 
                1.02, 
                1.02, 
                1.02
            };
            for v80 = 1, math.min(l_FriendBoost_0, 5) do
                v77 = v77 * v79[v80];
            end;
        end;
        local v81 = 1;
        if v72.ActiveBoosts then
            for v82, _ in pairs(v72.ActiveBoosts) do
                local v84 = v24[v82];
                if v84 and v84.Type == "Taps" then
                    v81 = v81 + v84.Multi;
                end;
            end;
        end;
        local v85 = 1;
        if v72.GemShop and v72.GemShop.ClickMultiplier then
            v85 = 1 + v72.GemShop.ClickMultiplier / 20;
        end;
        local v86 = 1;
        if v72.Enchants then
            for v87, v88 in pairs(v72.Enchants) do
                local v89 = v9.Enchants[v87];
                if v89 and v89.Type == "Taps" then
                    v86 = v86 + v89.Multi * v88;
                end;
            end;
        end;
        local v90 = 1;
        if workspace:GetAttribute("Event_Clicks_Active") == true then
            v90 = workspace:GetAttribute("Event_Clicks_Multiplier") or 10;
        end;
        if workspace:GetAttribute("Event_Taco_Active") == true then
            v90 = v90 * (workspace:GetAttribute("Event_Taco_Multiplier") or 2);
        end;
        v40 = 1 * (v72.Statistics.Rebirths + 1) * math.max(v72.PetMultiplier1, 1) * v20[v72.CurrentSkin].Multiplier * v75 * v76 * v77 * v81 * v85 * v86 * v90;
        local l_v40_0 = v40;
        if v34 then
            l_v40_0 = l_v40_0 * 10;
        end;
        if v47 < 1000000 then
            v37.Main.Amount.Text = "+" .. v15:Commas((math.ceil(v47)));
        else
            v37.Main.Amount.Text = "+" .. v15:Abbreviate(v47);
        end;
        v37.Main.Amount.Amount.Text = v37.Main.Amount.Text;
        if l_v40_0 ~= v74 or v73 then
            if not v34 then
                local v92 = tick();
                local v93 = v92 + 0.4;
                local l_v47_0 = v47;
                local v95 = l_v40_0 - l_v47_0;
                if v46 then
                    v46:Disconnect();
                    v46 = nil;
                end;
                v46 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 264 ]]
                    -- upvalues: v92 (copy), v47 (ref), l_v47_0 (copy), v95 (copy), v37 (ref), v15 (ref), v93 (copy), v46 (ref), l_v40_0 (ref)
                    local v96 = tick();
                    local v97 = math.min((v96 - v92) / 0.4, 1);
                    v47 = math.ceil(l_v47_0 + v95 * v97);
                    if v47 < 1000000 then
                        v37.Main.Amount.Text = "+" .. v15:Commas((math.ceil(v47)));
                    else
                        v37.Main.Amount.Text = "+" .. v15:Abbreviate(v47);
                    end;
                    v37.Main.Amount.Amount.Text = v37.Main.Amount.Text;
                    if v93 <= v96 then
                        v46:Disconnect();
                        v46 = nil;
                        v47 = l_v40_0;
                    end;
                end);
            else
                v47 = l_v40_0;
                if v47 < 1000000 then
                    v37.Main.Amount.Text = "+" .. v15:Commas((math.ceil(v47)));
                else
                    v37.Main.Amount.Text = "+" .. v15:Abbreviate(v47);
                end;
                v37.Main.Amount.Amount.Text = v37.Main.Amount.Text;
            end;
        end;
        return;
    end;
end;
local function v102() --[[ Line: 297 ]] --[[ Name: Sparkle ]]
    -- upvalues: v38 (ref), v16 (copy), v36 (ref)
    local v99 = script.Sprite:Clone();
    local v100 = nil;
    local v101 = nil;
    if v38 then
        v100 = v38;
        v101 = v38:Clone();
        v101.Adornee = v99;
        v38 = v101;
    else
        v101 = v16.new();
        v101.FrameRate = 45;
        v101.InheritSpriteSheet = true;
        v101.Looped = false;
        v101.Adornee = v99;
        v101.SpriteSizePixel = Vector2.new(256, 256);
        v101.SpriteCountX = 4;
        v101.SpriteCount = 8;
        v38 = v101;
    end;
    v99.Parent = v36.Tap;
    v101:Play();
    task.delay(1, function() --[[ Line: 319 ]]
        -- upvalues: v100 (ref), v99 (copy)
        if v100 then
            v100:Destroy();
        end;
        v99:Destroy();
    end);
end;
local function v109() --[[ Line: 326 ]] --[[ Name: increaseCombo ]]
    -- upvalues: v31 (ref), v32 (ref), v37 (ref), v48 (ref), v50 (ref), v52 (ref), v44 (copy), v21 (copy), v49 (ref), l_v21_MaxStages_0 (ref), v14 (copy), v71 (copy)
    if not (v31 or v32) then
        return;
    else
        local l_Combo_1 = v37.Combo;
        local v104 = tick();
        local l_v48_0 = v48;
        if v104 - v50 < 0.06 then
            return;
        else
            v50 = v104;
            if not v52 and v44.restartComboDecay then
                v44.restartComboDecay();
            end;
            local l_v21_Difficulty_0 = v21:GetDifficulty(v48);
            v49 = v49 + l_v21_Difficulty_0 / v48;
            if v49 >= 1 and v48 < l_v21_MaxStages_0 then
                v49 = 0;
                v48 = v48 + 1;
            end;
            if l_v21_MaxStages_0 <= v48 then
                v49 = math.min(v49, 1);
            end;
            v14:Tween(l_Combo_1.Bar, 0.04, "Sine", "Out", {
                Size = UDim2.fromScale(v49, 1)
            });
            local l_v21_StageName_0 = v21:GetStageName(v48);
            local l_v21_Multiplier_0 = v21:GetMultiplier(v48);
            l_Combo_1.Amount.Text = string.format("x%.2f %s", l_v21_Multiplier_0, l_v21_StageName_0);
            if l_v48_0 ~= v48 or l_v48_0 == 1 and v49 > 0 then
                v71(v48);
            end;
            return;
        end;
    end;
end;
local function v115(v110, v111) --[[ Line: 379 ]] --[[ Name: tap ]]
    -- upvalues: v17 (copy), v33 (ref), v41 (ref), v39 (ref), v34 (ref), v11 (copy), v109 (copy), l_UserInputService_0 (copy), l_HapticService_0 (copy), v35 (ref), v18 (copy), l_Popups_0 (copy), v40 (ref), l_l_LocalPlayer_0_Mouse_0 (copy), v13 (copy), l_LocalPlayer_0 (copy), v37 (ref), v29 (copy), v98 (copy)
    if v17.loadingScreen then
        return;
    else
        if not v111 then
            if v33 then
                return;
            else
                v33 = true;
                task.delay(0.06, function() --[[ Line: 387 ]]
                    -- upvalues: v33 (ref)
                    v33 = false;
                end);
            end;
        end;
        v41 = v41 + 1;
        v39 = tick();
        local v112 = v34 and not v111;
        v11:FireServer("Tap", true, v111, v112);
        v109();
        if l_UserInputService_0.GamepadEnabled and not v111 then
            pcall(function() --[[ Line: 401 ]]
                -- upvalues: l_HapticService_0 (ref), v112 (copy)
                l_HapticService_0:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Small, v112 and 1 or 0.3);
                task.delay(0.05, function() --[[ Line: 403 ]]
                    -- upvalues: l_HapticService_0 (ref)
                    pcall(function() --[[ Line: 404 ]]
                        -- upvalues: l_HapticService_0 (ref)
                        l_HapticService_0:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Small, 0);
                    end);
                end);
            end);
        end;
        if v35 then
            v35.Click:Emit(not v112 and 2 or 15);
            v35.Lines:Emit(v35.Lines:GetAttribute("EmitCount") or 4);
        end;
        if v112 then
            task.spawn(function() --[[ Line: 421 ]]
                -- upvalues: v18 (ref), l_Popups_0 (ref), v40 (ref), v112 (copy), v110 (copy), l_l_LocalPlayer_0_Mouse_0 (ref), v111 (copy)
                local v113 = 10;
                if v18 and v18.Data and tonumber(v18.Data.CriticalPower) then
                    v113 = v113 * math.max(tonumber(v18.Data.CriticalPower), 0);
                end;
                l_Popups_0:Popup("tap", v40 * v113, v112, v110 and l_l_LocalPlayer_0_Mouse_0, v111, not v112 and not v111 and not v110);
            end);
            task.spawn(function() --[[ Line: 428 ]]
                -- upvalues: v18 (ref), l_Popups_0 (ref), v40 (ref), v112 (copy), v110 (copy), l_l_LocalPlayer_0_Mouse_0 (ref), v111 (copy)
                local v114 = 10;
                if v18 and v18.Data and tonumber(v18.Data.CriticalPower) then
                    v114 = v114 * math.max(tonumber(v18.Data.CriticalPower), 0);
                end;
                l_Popups_0:Popup("critTapArea", v40 * v114, v112, v110 and l_l_LocalPlayer_0_Mouse_0, v111, not v112 and not v111 and not v110);
            end);
            v13.Fire("Particle", "Critical", l_LocalPlayer_0.Character.PrimaryPart);
            v13.Fire("DropTap", 20, true);
            v13.Fire("ScreenGlow", Color3.fromRGB(170, 0, 255), 1, 0.8);
            v37.Main.CriticalIcon.Visible = false;
            v37.Main.Icon.Visible = true;
            v29.Particles.Specs:Emit(15);
            v29.Particles.Specs2:Emit(20);
            v34 = false;
            v98(v18.Data, true);
            _G:Play("Critical");
            return;
        else
            v29.Particles.Taps:Emit(1);
            v29.Particles.Lines:Emit(1);
            if not v110 then
                task.spawn(function() --[[ Line: 457 ]]
                    -- upvalues: l_Popups_0 (ref), v40 (ref), v112 (copy), v110 (copy), l_l_LocalPlayer_0_Mouse_0 (ref), v111 (copy)
                    l_Popups_0:Popup("tapArea", v40, v112, v110 and l_l_LocalPlayer_0_Mouse_0, v111, not v112 and not v111 and not v110);
                end);
            else
                task.spawn(function() --[[ Line: 461 ]]
                    -- upvalues: l_Popups_0 (ref), v40 (ref), v112 (copy), v110 (copy), l_l_LocalPlayer_0_Mouse_0 (ref), v111 (copy)
                    l_Popups_0:Popup("tap", v40, v112, v110 and l_l_LocalPlayer_0_Mouse_0, v111, not v112 and not v111 and not v110);
                end);
            end;
            if not v111 then
                _G:Play("Taps", Random.new():NextNumber(0.94, 1.06));
                _G:Play("Click", Random.new():NextNumber(0.9, 1.1), 0.17);
            end;
            return;
        end;
    end;
end;
local function v116() --[[ Line: 472 ]] --[[ Name: toCrit ]]
    -- upvalues: v102 (copy), v34 (ref), v29 (copy), v98 (copy), v18 (copy), v37 (ref)
    v102();
    _G:Play("Shine");
    v34 = true;
    v29.Particles.Flash:Emit(1);
    v29.Particles.Specs:Emit(5);
    v29.Particles.Specs2:Emit(5);
    task.delay(0.05, function() --[[ Line: 481 ]]
        -- upvalues: v34 (ref), v98 (ref), v18 (ref), v37 (ref)
        if v34 then
            v98(v18.Data);
            v37.Main.CriticalIcon.Visible = true;
            v37.Main.Icon.Visible = false;
        end;
    end);
end;
local function v128(v117, v118, v119) --[[ Line: 489 ]] --[[ Name: toggleAutoClicker ]]
    -- upvalues: v32 (ref), v18 (copy), v31 (ref), v13 (copy), v11 (copy), v36 (ref), v14 (copy), v45 (ref), l_RunService_0 (copy), v71 (copy), v48 (ref), v49 (ref), v37 (ref), v98 (copy)
    local v120 = nil;
    if v117 == "Robux" then
        v32 = v118 or not v32;
        v120 = v32;
    elseif v18.Data.GemShop.FreeAutoClicker and v18.Data.GemShop.FreeAutoClicker > 0 then
        v31 = v118 or not v31;
        v120 = v31;
    else
        v120 = false;
        v31 = false;
        if not v18.Data.ABTests.autoclicker_firstIsland then
            if not v18.Data.Portals.Winter then
                v13.Fire("Notification", "Get to Winter Island first!", Color3.fromRGB(255, 57, 57));
            else
                v13.Fire("Notification", "Unlock Auto Clicker in Upgrade Shop!", Color3.fromRGB(255, 57, 57));
            end;
        elseif not v18.Data.Portals.Forest then
            v13.Fire("Notification", "Get to Forest Island first!", Color3.fromRGB(255, 57, 57));
        else
            v13.Fire("Notification", "Unlock Auto Clicker in Upgrade Shop!", Color3.fromRGB(255, 57, 57));
        end;
    end;
    if not v119 then
        local v121 = v31 or v32;
        v11:FireServer("SetAutoClicker", v121);
    end;
    local v122 = v117 == "Robux" and v36.Auto or v36.Auto;
    local v123 = v122.ClickEffect:Clone();
    v123.Visible = true;
    v123.Parent = v122;
    local v124 = v14:Tween(v123, 0.35, "Sine", "Out", {
        Size = UDim2.fromScale(1.4, 1.4), 
        BackgroundTransparency = 1
    }, false);
    local v125 = nil;
    v125 = v124.Completed:Connect(function() --[[ Line: 533 ]]
        -- upvalues: v123 (copy), v125 (ref)
        v123:Destroy();
        v125:Disconnect();
    end);
    if v120 then
        local v126 = os.clock();
        v45[v117] = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 539 ]]
            -- upvalues: v122 (copy), v126 (copy)
            v122.Main.Icon.On.Rotation = -90 * (os.clock() - v126);
        end);
        v122.Main.Icon.ImageTransparency = 1;
        v122.Main.Icon.On.Visible = true;
        v122.Main.On.Visible = true;
        v122.Main.Off.Visible = false;
    else
        if v45[v117] then
            v45[v117]:Disconnect();
            v45[v117] = nil;
        end;
        v122.Main.Icon.ImageTransparency = 0;
        v122.Main.Icon.On.Visible = false;
        v122.Main.On.Visible = false;
        v122.Main.Off.Visible = true;
        v71(0);
        v48 = 1;
        v49 = 0;
        if v37 and v37.Combo then
            local l_Combo_2 = v37.Combo;
            l_Combo_2.Amount.Text = "x1.0 No Combo";
            v14:Tween(l_Combo_2.Bar, 0.1, "Sine", "Out", {
                Size = UDim2.fromScale(0, 1)
            });
        end;
        v98(v18.Data, true);
    end;
end;
v44.InitTap = function(_) --[[ Line: 570 ]] --[[ Name: InitTap ]]
    -- upvalues: v37 (ref), v115 (copy), v14 (copy), v36 (ref), v18 (copy), v13 (copy), v128 (copy), v12 (copy)
    local l_Button_0 = v37.Button;
    local l_ClickEffect_0 = v37.ClickEffect;
    l_Button_0.MouseButton1Down:Connect(function() --[[ Line: 574 ]]
        -- upvalues: v115 (ref), l_ClickEffect_0 (copy), v37 (ref), v14 (ref)
        v115();
        local v132 = l_ClickEffect_0:Clone();
        v132.Visible = true;
        v132.Parent = v37;
        local v133 = v14:Tween(v132, 0.35, "Sine", "Out", {
            Size = UDim2.fromScale(1.4, 1.4), 
            BackgroundTransparency = 1
        }, false);
        local v134 = nil;
        v134 = v133.Completed:Connect(function() --[[ Line: 583 ]]
            -- upvalues: v132 (copy), v134 (ref)
            v132:Destroy();
            v134:Disconnect();
        end);
    end);
    v36.AutoTap.Button.Activated:Connect(function() --[[ Line: 589 ]]
        -- upvalues: v18 (ref), v13 (ref), v128 (ref)
        if not v18.Data.Gamepasses.AutoClicker then
            v13.Fire("PromptGamepass", "AutoClicker");
            return;
        else
            v128("Robux");
            return;
        end;
    end);
    v36.FreeAutoTap.Button.Activated:Connect(function() --[[ Line: 597 ]]
        -- upvalues: v128 (ref)
        v128("Free");
    end);
    v36.Auto.Button.Activated:Connect(function() --[[ Line: 600 ]]
        -- upvalues: v128 (ref)
        v128("Free");
    end);
    v36.Pets.Button.Activated:Connect(function() --[[ Line: 603 ]]
        -- upvalues: v13 (ref)
        v13.Fire("ToggleMenu", "Inventory");
    end);
    v12:Add(v36.AutoTap.Main.Label.Lgbt);
end;
v44.CharacterAdded = function(_, v136) --[[ Line: 610 ]] --[[ Name: CharacterAdded ]]
    -- upvalues: l_UI_0 (copy), v35 (ref)
    local l_HumanoidRootPart_0 = v136:WaitForChild("HumanoidRootPart");
    local v138 = l_UI_0.Parent.Particles.ClickV2:Clone();
    v138.Parent = l_HumanoidRootPart_0;
    v35 = v138;
end;
v44.SetUnlockedStage = function(_, v140) --[[ Line: 616 ]] --[[ Name: SetUnlockedStage ]]
    -- upvalues: l_v21_MaxStages_0 (ref), v21 (copy), v48 (ref), v49 (ref), v37 (ref), v14 (copy), v98 (copy), v18 (copy)
    l_v21_MaxStages_0 = math.max(1, (math.min(v140, v21:GetMaxStages())));
    if l_v21_MaxStages_0 < v48 then
        v48 = l_v21_MaxStages_0;
        v49 = 1;
        if v37 and v37.Combo then
            local l_Combo_3 = v37.Combo;
            local l_v21_StageName_1 = v21:GetStageName(v48);
            local l_v21_Multiplier_1 = v21:GetMultiplier(v48);
            l_Combo_3.Amount.Text = string.format("x%.2f %s", l_v21_Multiplier_1, l_v21_StageName_1);
            v14:Tween(l_Combo_3.Bar, 0.2, "Sine", "Out", {
                Size = UDim2.fromScale(v49, 1)
            });
            v98(v18.Data, true);
        end;
    end;
end;
v44.GetUnlockedStage = function(_) --[[ Line: 637 ]] --[[ Name: GetUnlockedStage ]]
    -- upvalues: l_v21_MaxStages_0 (ref)
    return l_v21_MaxStages_0;
end;
v44.GetCurrentComboStage = function(_) --[[ Line: 640 ]] --[[ Name: GetCurrentComboStage ]]
    -- upvalues: v48 (ref)
    return v48;
end;
v44.GetCurrentComboProgress = function(_) --[[ Line: 643 ]] --[[ Name: GetCurrentComboProgress ]]
    -- upvalues: v49 (ref)
    return v49;
end;
v44.Cleanup = function(_) --[[ Line: 646 ]] --[[ Name: Cleanup ]]
    -- upvalues: v45 (ref), v52 (ref), v46 (ref), v53 (ref), v38 (ref)
    for _, v149 in pairs(v45) do
        if v149 and v149.Connected then
            v149:Disconnect();
        end;
    end;
    v45 = {};
    if v52 then
        v52:Disconnect();
        v52 = nil;
    end;
    if v46 then
        v46:Disconnect();
        v46 = nil;
    end;
    for _, v151 in pairs(v53) do
        if v151 and v151.Parent then
            v151:Destroy();
        end;
    end;
    v53 = {};
    if v38 then
        v38:Destroy();
        v38 = nil;
    end;
end;
v44.Init = function(_, v153) --[[ Line: 681 ]] --[[ Name: Init ]]
    -- upvalues: l_LocalPlayer_0 (copy), v36 (ref), v37 (ref), v44 (copy), l_Popups_0 (copy), v52 (ref), l_RunService_0 (copy), v50 (ref), v21 (copy), v48 (ref), v49 (ref), v14 (copy), v98 (copy), v18 (copy), v71 (copy), v13 (copy), v115 (copy), v128 (copy), v31 (ref), v20 (copy), v15 (copy), v11 (copy), v116 (copy), l_UserInputService_0 (copy), v56 (ref), v17 (copy), v33 (ref), l_l_LocalPlayer_0_Mouse_0 (copy), v41 (ref), v39 (ref), v29 (copy), l_CurrentCamera_0 (copy), v10 (copy), v32 (ref), v45 (ref)
    local _ = l_LocalPlayer_0.PlayerGui;
    local v155 = 0;
    v36 = v153.Bottom;
    v37 = v36.Tap;
    v44:InitTap();
    l_Popups_0:Init(v153);
    v44.restartComboDecay = function() --[[ Line: 691 ]] --[[ Name: startComboDecay ]]
        -- upvalues: v52 (ref), l_RunService_0 (ref), v50 (ref), v21 (ref), v48 (ref), v49 (ref), v37 (ref), v14 (ref), v98 (ref), v18 (ref), v71 (ref)
        if v52 then
            v52:Disconnect();
        end;
        local v156 = tick();
        v52 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 697 ]]
            -- upvalues: v50 (ref), v156 (ref), v21 (ref), v48 (ref), v49 (ref), v37 (ref), v14 (ref), v98 (ref), v18 (ref), v71 (ref), v52 (ref)
            local v157 = tick();
            local v158 = v157 - v50;
            local v159 = v157 - v156;
            v156 = v157;
            if v21.DecaySettings.decayDelay < v158 then
                local l_v48_1 = v48;
                if v49 > 0 then
                    local v161 = v21:GetProgressDecayRate(v48) * v159;
                    v49 = math.max(0, v49 - v161);
                    local l_Combo_4 = v37.Combo;
                    v14:Tween(l_Combo_4.Bar, 0.1, "Sine", "Out", {
                        Size = UDim2.fromScale(v49, 1)
                    });
                elseif v48 > 1 then
                    local v163 = v21:GetStageDecayRate(v48) * v159;
                    v48 = math.max(1, v48 - v163);
                    if v48 < math.floor(v48) + 1 then
                        v48 = math.floor(v48);
                        v49 = 1;
                    end;
                    local l_Combo_5 = v37.Combo;
                    local l_v21_StageName_2 = v21:GetStageName(v48);
                    local l_v21_Multiplier_2 = v21:GetMultiplier(v48);
                    l_Combo_5.Amount.Text = string.format("x%.2f %s", l_v21_Multiplier_2, l_v21_StageName_2);
                    v98(v18.Data, true);
                end;
                if math.floor(l_v48_1) ~= math.floor(v48) or v48 <= 1 and v49 <= 0 then
                    v71((math.floor(v48)));
                end;
                if v48 <= 1 and v49 <= 0 then
                    v48 = 1;
                    v49 = 0;
                    local l_Combo_6 = v37.Combo;
                    l_Combo_6.Amount.Text = "x1.0 No Combo";
                    v14:Tween(l_Combo_6.Bar, 0.1, "Sine", "Out", {
                        Size = UDim2.fromScale(0, 1)
                    });
                    v98(v18.Data, true);
                    v71(0);
                    if v52 then
                        v52:Disconnect();
                        v52 = nil;
                    end;
                end;
            end;
        end);
    end;
    if v52 then
        v52:Disconnect();
    end;
    local v168 = tick();
    do
        local l_v168_0 = v168;
        v52 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 697 ]]
            -- upvalues: v50 (ref), l_v168_0 (ref), v21 (ref), v48 (ref), v49 (ref), v37 (ref), v14 (ref), v98 (ref), v18 (ref), v71 (ref), v52 (ref)
            local v170 = tick();
            local v171 = v170 - v50;
            local v172 = v170 - l_v168_0;
            l_v168_0 = v170;
            if v21.DecaySettings.decayDelay < v171 then
                local l_v48_2 = v48;
                if v49 > 0 then
                    local v174 = v21:GetProgressDecayRate(v48) * v172;
                    v49 = math.max(0, v49 - v174);
                    local l_Combo_7 = v37.Combo;
                    v14:Tween(l_Combo_7.Bar, 0.1, "Sine", "Out", {
                        Size = UDim2.fromScale(v49, 1)
                    });
                elseif v48 > 1 then
                    local v176 = v21:GetStageDecayRate(v48) * v172;
                    v48 = math.max(1, v48 - v176);
                    if v48 < math.floor(v48) + 1 then
                        v48 = math.floor(v48);
                        v49 = 1;
                    end;
                    local l_Combo_8 = v37.Combo;
                    local l_v21_StageName_3 = v21:GetStageName(v48);
                    local l_v21_Multiplier_3 = v21:GetMultiplier(v48);
                    l_Combo_8.Amount.Text = string.format("x%.2f %s", l_v21_Multiplier_3, l_v21_StageName_3);
                    v98(v18.Data, true);
                end;
                if math.floor(l_v48_2) ~= math.floor(v48) or v48 <= 1 and v49 <= 0 then
                    v71((math.floor(v48)));
                end;
                if v48 <= 1 and v49 <= 0 then
                    v48 = 1;
                    v49 = 0;
                    local l_Combo_9 = v37.Combo;
                    l_Combo_9.Amount.Text = "x1.0 No Combo";
                    v14:Tween(l_Combo_9.Bar, 0.1, "Sine", "Out", {
                        Size = UDim2.fromScale(0, 1)
                    });
                    v98(v18.Data, true);
                    v71(0);
                    if v52 then
                        v52:Disconnect();
                        v52 = nil;
                    end;
                end;
            end;
        end);
    end;
    v71(0);
    v18:Connect("ActiveBoosts", function() --[[ Line: 773 ]]
        -- upvalues: v98 (ref), v18 (ref)
        v98(v18.Data, true);
    end);
    v18:Connect("GemShop", function() --[[ Line: 777 ]]
        -- upvalues: v98 (ref), v18 (ref)
        v98(v18.Data, true);
    end);
    v13.new("Tap"):Connect(function() --[[ Line: 781 ]]
        -- upvalues: v115 (ref)
        v115(nil, false);
    end);
    v13.new("StartAutoClicking"):Connect(function(v181) --[[ Line: 785 ]]
        -- upvalues: v128 (ref)
        v128("Free", v181);
    end);
    _G.GetCurrentAutoClicking = function() --[[ Line: 789 ]]
        -- upvalues: v31 (ref)
        local v182 = true;
        if v31 ~= true then
            v182 = nil;
        end;
        return v182;
    end;
    v13.new("UpdateSkin"):Connect(function(v183) --[[ Line: 794 ]]
        -- upvalues: v98 (ref), v18 (ref), v37 (ref), v20 (ref), v15 (ref), v14 (ref)
        v98(v18.Data, true);
        local v184 = v37.Shockwave:Clone();
        v184.Parent = v37;
        v184.Visible = true;
        v37.Main.Icon.Size = UDim2.fromScale(0.6, 0.6);
        v37.Main.Icon.Image = "rbxassetid://" .. v20[v183].Icon;
        if v37.Main:FindFirstChild("Multi") then
            v37.Main.Multi:Destroy();
        end;
        local v185 = v37.Main.Multiplier:Clone();
        v185.Name = "Multi";
        v185.Parent = v37.Main;
        v185.Visible = true;
        v185.Text = "x" .. v15:Commas(v20[v183].Multiplier);
        task.delay(10, function() --[[ Line: 810 ]]
            -- upvalues: v185 (copy), v14 (ref)
            if v185.Parent then
                v14:Tween(v185, 0.3, "Back", "In", {
                    Size = UDim2.fromScale(0.05, 0.05)
                });
                task.wait(0.2);
                v185:Destroy();
            end;
        end);
        v14:Tween(v37.Main.Icon, 0.3, "Back", "Out", {
            Size = UDim2.fromScale(0.8, 0.8)
        });
        v14:Tween(v184, 0.3, "Sine", "Out", {
            Size = UDim2.fromScale(20, 20), 
            ImageTransparency = 1
        }, nil, nil, function() --[[ Line: 818 ]]
            -- upvalues: v184 (copy)
            v184:Destroy();
        end);
    end);
    v18:Connect("CurrentSkin", function(_) --[[ Line: 822 ]]
        -- upvalues: v37 (ref), v20 (ref), v18 (ref), v15 (ref)
        v37.Main.Icon.Image = "rbxassetid://" .. v20[v18.Data.CurrentSkin].Icon;
        v37.Main.Multiplier.Text = "x" .. v15:Commas(v20[v18.Data.CurrentSkin].Multiplier);
    end);
    v18:Connect("PetMultiplier1", function(v187) --[[ Line: 827 ]]
        -- upvalues: v98 (ref)
        v98(v187);
    end);
    v11:FireServer("RequestMultiRefresh");
    v18:Connect("Gamepasses", function(v188) --[[ Line: 833 ]]
        -- upvalues: v98 (ref)
        v98(v188);
    end);
    v18:Connect("Statistics", function(v189) --[[ Line: 837 ]]
        -- upvalues: v155 (ref), v98 (ref)
        if v189.Statistics.Rebirths ~= v155 then
            v155 = v189.Statistics.Rebirths;
            v98(v189);
        end;
    end);
    v18:Connect("Zone", function(v190) --[[ Line: 843 ]]
        -- upvalues: v98 (ref)
        v98(v190);
    end);
    v13.new("GlobalEventChanged"):Connect(function(_, _) --[[ Line: 848 ]]
        -- upvalues: v98 (ref), v18 (ref)
        v98(v18.Data, true);
    end);
    v11:BindEvents({
        IsCritical = function() --[[ Line: 852 ]]
            -- upvalues: v116 (ref)
            v116();
        end
    });
    task.defer(function() --[[ Line: 857 ]]
        -- upvalues: v18 (ref), v128 (ref), l_UserInputService_0 (ref), v115 (ref), v56 (ref), l_RunService_0 (ref), v17 (ref), v33 (ref), l_l_LocalPlayer_0_Mouse_0 (ref), v13 (ref), v14 (ref), v37 (ref), v41 (ref), v39 (ref), v29 (ref)
        repeat
            task.wait();
        until v18.Loaded;
        if v18.Data.AutoClickerEnabled and v18.Data.GemShop.FreeAutoClicker and v18.Data.GemShop.FreeAutoClicker > 0 then
            v128("Free", true, true);
        end;
        local v193 = false;
        local v194 = nil;
        l_UserInputService_0.InputBegan:Connect(function(v195, v196) --[[ Line: 879 ]]
            -- upvalues: v115 (ref), v193 (ref), v56 (ref), v194 (ref), l_RunService_0 (ref), v17 (ref), v33 (ref)
            if v196 then
                return;
            else
                if v195.KeyCode == Enum.KeyCode.E then
                    v115();
                end;
                if v195.KeyCode == Enum.KeyCode.ButtonR2 or v195.KeyCode == Enum.KeyCode.ButtonL2 then
                    v193 = true;
                    v115();
                    v56 = tick();
                    if v194 then
                        v194:Disconnect();
                    end;
                    v194 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 898 ]]
                        -- upvalues: v193 (ref), v17 (ref), v33 (ref), v56 (ref), v115 (ref)
                        if v193 and not v17.loadingScreen then
                            local v197 = tick();
                            if not v33 and v197 - v56 >= 0.15 then
                                v115();
                                v56 = v197;
                            end;
                        end;
                    end);
                end;
                return;
            end;
        end);
        l_UserInputService_0.InputEnded:Connect(function(v198, _) --[[ Line: 911 ]]
            -- upvalues: v193 (ref), v194 (ref)
            if v198.KeyCode == Enum.KeyCode.ButtonR2 or v198.KeyCode == Enum.KeyCode.ButtonL2 then
                v193 = false;
                if v194 then
                    v194:Disconnect();
                    v194 = nil;
                end;
            end;
        end);
        l_l_LocalPlayer_0_Mouse_0.Button1Down:Connect(function() --[[ Line: 923 ]]
            -- upvalues: v13 (ref), v115 (ref)
            v13.Fire("BurstFX");
            v115(true);
        end);
        v14:Tween(v37.Arrow, 1, "Sine", "InOut", {
            Position = UDim2.fromScale(0.5, -1.2)
        }, true, -1);
        v14:Tween(v37.Arrow, 1, "Sine", "InOut", {
            Size = UDim2.fromScale(0.862, 0.862)
        }, true, -1);
        local v200 = tick();
        while task.wait(1) do
            v41 = 0;
            v18.Data.Total.Time = v18.Data.Total.Time + 1;
            if tick() - v39 > 30 and v18.Data.Total.Time < 300 then
                if tick() - v200 > 3 then
                    v29.Particles.Notice:Emit(1);
                    v200 = tick();
                end;
                v37.Arrow.Visible = true;
            else
                v37.Arrow.Visible = false;
            end;
        end;
    end);
    v14:Tween(v37.Sunburst, 18, "Sine", "InOut", {
        Rotation = 720
    }, true, -1);
    task.delay(1, function() --[[ Line: 951 ]]
        -- upvalues: v29 (ref), l_CurrentCamera_0 (ref), v10 (ref), v36 (ref), v18 (ref), l_RunService_0 (ref), v31 (ref), v115 (ref), v32 (ref), v45 (ref)
        v29.Parent = l_CurrentCamera_0;
        local v201 = v10.ScreenHeightToWorldHeight(v36.Tap.AbsolutePosition.Y, 1.4);
        local v202 = l_CurrentCamera_0:GetPropertyChangedSignal("ViewportSize"):Connect(function() --[[ Line: 958 ]]
            -- upvalues: v201 (ref), v10 (ref), v36 (ref)
            v201 = v10.ScreenHeightToWorldHeight(v36.Tap.AbsolutePosition.Y, 1.4);
        end);
        local v203 = tick();
        local v204 = tick();
        local function v209() --[[ Line: 965 ]] --[[ Name: getIntervals ]]
            -- upvalues: v18 (ref)
            local v205 = 1;
            local v206 = 20;
            if v18 and v18.Data then
                if tonumber(v18.Data.AutoClickerEfficiency) then
                    v205 = math.max(tonumber(v18.Data.AutoClickerEfficiency), 0.01);
                end;
                if tonumber(v18.Data.MaxCPSCap) then
                    v206 = math.max(tonumber(v18.Data.MaxCPSCap), 1);
                end;
                if v18.Loaded and v18.Data.GemShop.AutoClickerSpeed and v18.Data.GemShop.AutoClickerSpeed > 0 then
                    v205 = v205 * (1 + v18.Data.GemShop.AutoClickerSpeed / 4);
                end;
            end;
            local v207 = math.min(v205 * 2.5, v206);
            local v208 = math.min(v205 * 6.6666666667, v206);
            return 1 / v207, 1 / v208;
        end;
        local v210, v211 = v209();
        v18:Connect("AutoClickerEfficiency", function() --[[ Line: 990 ]]
            -- upvalues: v210 (ref), v211 (ref), v209 (copy)
            local v212, v213 = v209();
            v210 = v212;
            v211 = v213;
        end);
        v18:Connect("MaxCPSCap", function() --[[ Line: 993 ]]
            -- upvalues: v210 (ref), v211 (ref), v209 (copy)
            local v214, v215 = v209();
            v210 = v214;
            v211 = v215;
        end);
        v18:Connect("GemShop", function() --[[ Line: 996 ]]
            -- upvalues: v210 (ref), v211 (ref), v209 (copy)
            local v216, v217 = v209();
            v210 = v216;
            v211 = v217;
        end);
        local v218 = CFrame.Angles(-0.3490658503988659, 0, 0);
        local l_CFrame_0 = l_CurrentCamera_0.CFrame;
        local v222 = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 1006 ]]
            -- upvalues: l_CurrentCamera_0 (ref), l_CFrame_0 (ref), v29 (ref), v201 (ref), v218 (copy), v31 (ref), v203 (ref), v210 (ref), v115 (ref), v32 (ref), v204 (ref), v211 (ref)
            local l_CFrame_1 = l_CurrentCamera_0.CFrame;
            if l_CFrame_1 ~= l_CFrame_0 then
                v29.CFrame = (l_CFrame_1 + l_CFrame_1.LookVector * 3) * (CFrame.new(0, v201, 0) * v218);
                l_CFrame_0 = l_CFrame_1;
            end;
            local v221 = tick();
            if v31 and v221 - v203 > v210 then
                v203 = v221;
                v115(nil, true);
            end;
            if v32 and v221 - v204 > v211 then
                v204 = v221;
                v115(nil, true);
            end;
        end);
        table.insert(v45, v222);
        table.insert(v45, v202);
    end);
end;
return v44;