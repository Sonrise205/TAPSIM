local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local _ = game:GetService("PhysicsService");
local l_TweenService_0 = game:GetService("TweenService");
local l_CollectionService_0 = game:GetService("CollectionService");
local _ = game:GetService("UserInputService");
local v7 = require(l_ReplicatedStorage_0.Modules.Network);
local v8 = require(l_ReplicatedStorage_0.Modules.Signal);
local v9 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v10 = require(l_ReplicatedStorage_0.Modules.Short);
local _ = require(l_ReplicatedStorage_0.Modules.Flash);
local v12 = require(l_ReplicatedStorage_0.Modules.FlashUtil);
local v13 = require(l_ReplicatedStorage_0.Game.Replication);
local v14 = require(l_ReplicatedStorage_0.Game.Rebirths);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_Content_0 = l_ReplicatedStorage_0:WaitForChild("Content");
local _ = l_Content_0.UI.RebirthOption;
local l_AutoIndicators_0 = l_Content_0.UI.AutoIndicators;
local _ = script:WaitForChild("Yes");
local _ = script:WaitForChild("No");
local v21 = false;
local v22 = false;
local v23 = false;
local v24 = false;
local v25 = false;
local v26 = 1;
local v27 = 0;
local v28 = 0;
local v29 = 0;
local v30 = 1;
local v31 = nil;
local v32 = nil;
local v33 = nil;
local v34 = nil;
local v35 = nil;
local v36 = nil;
local v37 = nil;
local v38 = {};
local v39 = {};
local v40 = {};
local v41 = false;
local v42 = nil;
local v43 = false;
local v44 = nil;
local v45 = nil;
local v46 = nil;
local v47 = nil;
local v48 = nil;
local v49 = 0;
local v50 = {
    Inactive = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 80, 80)), 
        ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 50, 50))
    }), 
    Active = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 255, 100)), 
        ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 200, 80))
    }), 
    Locked = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(150, 150, 150)), 
        ColorSequenceKeypoint.new(1, Color3.fromRGB(90, 90, 90))
    })
};
local function _(v51) --[[ Line: 76 ]] --[[ Name: setAutoButtonGradient ]]
    -- upvalues: v45 (ref)
    if v45 and v45:FindFirstChild("UIGradient") and v51 then
        v45.UIGradient.Color = v51;
    end;
end;
local function _() --[[ Line: 82 ]] --[[ Name: hasAutoRebirthGamepass ]]
    -- upvalues: v13 (copy)
    return v13.Data and v13.Data.Gamepasses and v13.Data.Gamepasses.AutoRebirth == true or false;
end;
local function v57() --[[ Line: 88 ]] --[[ Name: updateAutoButtonState ]]
    -- upvalues: v45 (ref), v13 (copy), v43 (ref), v46 (ref), v50 (copy), v44 (ref)
    if not v45 or not v45:FindFirstChild("Title") then
        return;
    elseif not (v13.Data and v13.Data.Gamepasses and v13.Data.Gamepasses.AutoRebirth == true or false) then
        v43 = false;
        if v46 then
            v46.Visible = false;
        end;
        v45.Title.Text = "Auto Rebirth";
        return;
    elseif v43 then
        v45.Title.Text = "Cancel";
        local l_Inactive_0 = v50.Inactive;
        if v45 and v45:FindFirstChild("UIGradient") and l_Inactive_0 then
            v45.UIGradient.Color = l_Inactive_0;
        end;
        return;
    else
        if v44 then
            v45.Title.Text = "Auto: " .. v44;
            local l_Active_0 = v50.Active;
            if v45 and v45:FindFirstChild("UIGradient") and l_Active_0 then
                v45.UIGradient.Color = l_Active_0;
                return;
            end;
        else
            v45.Title.Text = "Auto";
            local l_Inactive_1 = v50.Inactive;
            if v45 and v45:FindFirstChild("UIGradient") and l_Inactive_1 then
                v45.UIGradient.Color = l_Inactive_1;
            end;
        end;
        return;
    end;
end;
local function _(v58) --[[ Line: 118 ]] --[[ Name: RemoveAutoIndicators ]]
    -- upvalues: v47 (ref), v48 (ref), v57 (copy)
    if v47 and v47.Parent then
        v47.Parent:Destroy();
    end;
    v47 = nil;
    v48 = nil;
    if not v58 then
        v57();
    end;
end;
local function v64(v60) --[[ Line: 131 ]] --[[ Name: AddAutoIndicators ]]
    -- upvalues: v47 (ref), v48 (ref), v39 (copy), l_AutoIndicators_0 (copy), l_TweenService_0 (copy), v44 (ref), v57 (copy)
    if v47 and v47.Parent then
        v47.Parent:Destroy();
    end;
    v47 = nil;
    v48 = nil;
    local v61 = v39[v60];
    if not v61 then
        return;
    else
        local l_Main_0 = v61[1].Template.Main;
        local v63 = l_AutoIndicators_0:Clone();
        v63.Parent = l_Main_0;
        v47 = v63:FindFirstChild("AutoIcon");
        v48 = v63:FindFirstChild("DisableAutoButton");
        if v47 then
            l_TweenService_0:Create(v47, TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1), {
                Rotation = 360
            }):Play();
        end;
        if v48 then
            v48.Activated:Connect(function() --[[ Line: 159 ]]
                -- upvalues: v44 (ref), v47 (ref), v48 (ref), v57 (ref)
                v44 = nil;
                if v47 and v47.Parent then
                    v47.Parent:Destroy();
                end;
                v47 = nil;
                v48 = nil;
                v57();
                _G:Play("Click");
            end);
        end;
        v57();
        return;
    end;
end;
local function v74(v65, v66, v67, v68) --[[ Line: 170 ]] --[[ Name: TweenNumberText ]]
    -- upvalues: l_RunService_0 (copy)
    local v69 = tonumber(v65.Text:match("%d+")) or 0;
    if v69 == v66 then
        return;
    else
        local v70 = tick();
        local v71 = nil;
        v71 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 180 ]]
            -- upvalues: v70 (copy), v69 (copy), v66 (copy), v65 (copy), v67 (copy), v68 (copy), v71 (ref)
            local v72 = math.min((tick() - v70) / 0.5, 1);
            v72 = 1 - (1 - v72) * (1 - v72);
            local v73 = math.floor(v69 + (v66 - v69) * v72);
            v65.Text = (v67 or "") .. v73 .. (v68 or "");
            if v72 >= 1 then
                v71:Disconnect();
                v65.Text = (v67 or "") .. v66 .. (v68 or "");
            end;
        end);
        return;
    end;
end;
local function v84() --[[ Line: 199 ]] --[[ Name: updateRebirthNotifications ]]
    -- upvalues: v32 (ref), v8 (copy), v40 (copy), v39 (copy), v42 (ref)
    if v32 and v32.Visible or false then
        v8.Fire("HideRightHudNotification", "Rebirths");
        return;
    else
        local v75 = {};
        for v76, v77 in pairs(v40) do
            table.insert(v75, {
                num = v76, 
                price = v77[2]
            });
        end;
        table.sort(v75, function(v78, v79) --[[ Line: 215 ]]
            return v78.price > v79.price;
        end);
        local v80 = {};
        for v81 = 1, math.min(4, #v75) do
            v80[v75[v81].num] = true;
        end;
        local v82 = false;
        for v83 in pairs(v80) do
            if v39[v83] and v39[v83][2] then
                v82 = true;
                break;
            end;
        end;
        if v82 ~= v42 then
            v42 = v82;
            if v82 then
                v8.Fire("ShowRightHudNotification", "Rebirths");
                return;
            else
                v8.Fire("HideRightHudNotification", "Rebirths");
            end;
        end;
        return;
    end;
end;
Rebirth = function(v85, v86, v87, v88) --[[ Line: 246 ]] --[[ Name: Rebirth ]]
    -- upvalues: v41 (ref), v40 (copy), v7 (copy), v30 (ref), v24 (ref), v35 (ref), v8 (copy), l_LocalPlayer_0 (copy), v14 (copy), v26 (ref), v25 (ref), v38 (copy)
    if not v87 and not v88 and v41 then
        return false;
    else
        if not v86 then
            local _ = v40[v85];
        end;
        if not v87 and not v88 then
            v41 = true;
            task.delay(0.5, function() --[[ Line: 257 ]]
                -- upvalues: v41 (ref)
                v41 = false;
            end);
        end;
        local v90 = v7:InvokeServer("Rebirth", v87 and 1 or v85, v87 and v85);
        v30 = v85;
        v24 = true;
        v35.Visible = false;
        v8.Fire("Particle", "Rebirth", l_LocalPlayer_0.Name);
        local v91 = v87 and v85 or v14:fromIndex(v85);
        v8.Fire("Popup", "rebirth", v91);
        for _ = 1, math.random(5, 6) do
            v8.Fire("AddPopup", "Gems", UDim2.fromScale(_G:ConvertOffset(l_LocalPlayer_0:GetMouse().X, "X") - Random.new():NextNumber(0.05, -0.05), _G:ConvertOffset(l_LocalPlayer_0:GetMouse().Y, "Y")), UDim2.fromScale(0.7, Random.new():NextNumber(0.2, 0.8)));
        end;
        _G:Play("Rebirth", v26 / 15 + 1);
        if v25 then
            if v26 == 0 then
                v25 = false;
            else
                v26 = v26 - 5;
            end;
        elseif v26 == 10 then
            v25 = true;
        else
            v26 = v26 + 1;
        end;
        if v90 then
            v38:SpinRebirthIcon();
        end;
        return v90;
    end;
end;
v38.CreateOption = function(v93) --[[ Line: 304 ]] --[[ Name: CreateOption ]]
    -- upvalues: v14 (copy), v40 (copy), l_CollectionService_0 (copy), v10 (copy), v32 (ref), v9 (copy), v43 (ref), v44 (ref), v46 (ref), v39 (copy), v64 (copy), v8 (copy)
    local _ = v14:fromIndex(v93);
    local v95 = v40[v93];
    local v96 = l_CollectionService_0:GetTagged("RebirthTemplate")[1]:Clone();
    local _ = v96.Template.Main.Size;
    local _ = v96.Size;
    v96.Name = v93;
    v96.LayoutOrder = v93;
    if not v95 then
        v96.Template.Main.Amount.Text = "ERROR";
        v96.Template.Main.Cost.Text = "does not exist";
        return v96;
    else
        v96.Template.Main.RebirthsAmount.Amount.Text = "+" .. v10:Abbreviate(v95[1]) .. " Rebirths";
        v96.Template.Main.ClicksAmount.Amount.Text = "Cost: " .. v10:Abbreviate(v95[2]);
        v96.Parent = v32.List;
        local l_UIScale_0 = v96:FindFirstChild("UIScale");
        v96.Template.Button.MouseEnter:Connect(function() --[[ Line: 326 ]]
            -- upvalues: v9 (ref), l_UIScale_0 (copy)
            v9:Tween(l_UIScale_0, 0.2, "Sine", "Out", {
                Scale = 1.03
            });
        end);
        v96.Template.Button.MouseLeave:Connect(function() --[[ Line: 330 ]]
            -- upvalues: v9 (ref), l_UIScale_0 (copy)
            v9:Tween(l_UIScale_0, 0.2, "Sine", "Out", {
                Scale = 1
            });
        end);
        v96.Template.Button.Activated:Connect(function() --[[ Line: 334 ]]
            -- upvalues: v43 (ref), v44 (ref), v93 (copy), v46 (ref), v39 (ref), v64 (ref), v95 (copy), v96 (copy), v9 (ref), v8 (ref)
            if v43 then
                v44 = v93;
                v43 = false;
                if v46 then
                    v46.Visible = false;
                end;
                for _, v101 in pairs(v39) do
                    if v101[2] then
                        v101[1].Template.BackgroundColor3 = Color3.fromRGB(27, 79, 21);
                    else
                        v101[1].Template.BackgroundColor3 = Color3.new(0.30980392156862746, 0.30980392156862746, 0.30980392156862746);
                    end;
                end;
                v64(v93);
                _G:Play("Click");
                return;
            else
                if v39[v93] and v39[v93][2] then
                    if Rebirth(v93, v95) then
                        v96.Template.Main.FillBar.FX.BackgroundTransparency = 0;
                        v96.Template.Main.FillBar.FX.Size = UDim2.fromScale(1, 1);
                        v96.Template.Main.FillBar.FX.Visible = true;
                        v9:Tween(v96.Template.Main.FillBar.FX, 0.3, "Quad", "Out", {
                            Size = UDim2.fromScale(1.1, 1.3), 
                            BackgroundTransparency = 1
                        });
                        v8.Fire("ScreenGlow", Color3.fromRGB(25, 255, 40), 1, 0.8);
                        return;
                    end;
                else
                    v8.Fire("Tap");
                end;
                return;
            end;
        end);
        return v96;
    end;
end;
v38.ChangeStatus = function(v102, v103, v104) --[[ Line: 379 ]] --[[ Name: ChangeStatus ]]
    -- upvalues: v39 (copy)
    local v105 = v39[v103][1];
    if v104 then
        v39[v103][2] = true;
        v105.Template.BackgroundColor3 = Color3.fromRGB(27, 79, 21);
        v105.Template.Main.CanBuy.Enabled = true;
        v105.Template.Main.CantBuy.Enabled = false;
        v105.Template.Main.FillBar.Bar.Visible = false;
        v102:FlashWhite(v105.Template.Main);
        if v105.Template.Main:FindFirstChild("No") then
            v105.Template.Main.No:Destroy();
            return;
        end;
    else
        v39[v103][2] = false;
        v105.Template.BackgroundColor3 = Color3.new(0.30980392156862746, 0.30980392156862746, 0.30980392156862746);
        v105.Template.Main.FillBar.Bar.Visible = true;
        v105.Template.Main.CanBuy.Enabled = false;
        v105.Template.Main.CantBuy.Enabled = true;
    end;
end;
v38.FlashWhite = function(_, v107) --[[ Line: 407 ]] --[[ Name: FlashWhite ]]
    -- upvalues: v12 (copy)
    v12:FlashWhite(v107, {
        Transparency = 0.3, 
        Duration = 0.3, 
        SizeMultiplier = 1.1, 
        CornerRadius = 8, 
        ZIndex = v107.ZIndex + 3
    });
end;
v38.SpinRebirthIcon = function(_) --[[ Line: 418 ]] --[[ Name: SpinRebirthIcon ]]
    -- upvalues: v37 (ref), l_TweenService_0 (copy)
    if v37 then
        l_TweenService_0:Create(v37, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, 0, false, 0), {
            Rotation = v37.Rotation + 360
        }):Play();
    end;
end;
v38.UpdateOptions = function(v109, v110) --[[ Line: 430 ]] --[[ Name: UpdateOptions ]]
    -- upvalues: v39 (copy), v32 (ref), v40 (copy), v14 (copy), v38 (copy), v21 (ref), v44 (ref), v43 (ref), v64 (copy)
    local v111 = 0;
    for v112, _ in pairs(v39) do
        if v111 < v112 then
            v111 = v112;
        end;
    end;
    local v114 = math.max(v111, 0);
    if v110 - v114 > 0 then
        local l_List_0 = v32.List;
        for v116 = v114 + 1, v110 do
            v40[v116] = {
                v14:fromIndex(v116), 
                v14:getPrice(v14:fromIndex(v116))
            };
            local v117 = l_List_0:FindFirstChild(v116) or v38.CreateOption(v116);
            v39[v116] = {
                v117, 
                false
            };
            v109:ChangeStatus(v116, false);
            v117.Visible = true;
        end;
    else
        for v118 = v110 + 1, v114 do
            local v119 = v39[v118];
            v109:ChangeStatus(v118, true);
            v119[1].Visible = false;
            v39[v118] = nil;
        end;
    end;
    v21 = true;
    if v44 and v39[v44] and not v43 then
        task.defer(function() --[[ Line: 469 ]]
            -- upvalues: v64 (ref), v44 (ref)
            v64(v44);
        end);
    end;
end;
v38.RefreshQuickRebirth = function(_, v121, v122) --[[ Line: 475 ]] --[[ Name: RefreshQuickRebirth ]]
    -- upvalues: v35 (ref), v40 (copy), v39 (copy), v10 (copy), v14 (copy), v36 (ref), v9 (copy)
    if v121 == 0 then
        v35.Visible = false;
        return;
    else
        v35.Visible = true;
        local v123 = v40[v121];
        local v124 = v39[v121];
        v35.Visible = true;
        v35.Amount.Text = v124[1].Template.Main.RebirthsAmount.Amount.Text;
        v35.Cost.Text = "-" .. v10:Abbreviate((math.ceil((v14:ClicksPrice(v123[2], v122))))) .. " Clicks";
        v35.Size = UDim2.fromScale(v36.X.Scale * 1.1, v36.Y.Scale * 1.1);
        v9:Tween(v35, 0.4, "Back", "Out", {
            Size = v36
        });
        return;
    end;
end;
v38.Refresh = function(v125, v126) --[[ Line: 495 ]] --[[ Name: Refresh ]]
    -- upvalues: v31 (ref), v13 (copy), v29 (ref), v39 (copy), v40 (copy), v14 (copy), v10 (copy), v27 (ref), v84 (copy), v34 (ref), v28 (ref), v74 (copy)
    local l_List_1 = v31.Main.RightUI.Rebirths.List;
    local _ = l_List_1.AbsolutePosition.Y + l_List_1.AbsoluteSize.Y;
    local v129 = 0;
    local l_Rebirths_0 = v13.Data.Statistics.Rebirths;
    local l_Clicks_0 = v13.Data.Statistics.Clicks;
    if l_Clicks_0 ~= v126 then
        v126 = l_Clicks_0;
    end;
    local _ = v126 ~= v29;
    for v133, v134 in pairs(v39) do
        if v134[2] and v129 < v133 then
            v129 = v133;
        end;
        local v135 = v40[v133];
        local v136 = v14:ClicksPrice(v135[2], l_Rebirths_0);
        local v137 = v126 / v136;
        local v138 = v134[2];
        local _ = v134[1].AbsolutePosition.Y + v134[1].AbsoluteSize.Y;
        v134[1].Template.Main.ClicksAmount.Amount.Text = "Cost: " .. v10:Abbreviate((math.ceil(v136)));
        if v136 <= v126 then
            v134[2] = true;
            if v129 < v133 then
                v129 = v133;
            end;
        else
            v134[2] = false;
        end;
        local v140 = math.clamp(v137, 0.01, 1);
        v134[1].Template.Main.FillBar.Bar.Size = UDim2.fromScale(v140, 1);
        if v138 == v134[2] then

        end;
        v125:ChangeStatus(v133, v134[2]);
    end;
    if v129 ~= v27 then
        v125:RefreshQuickRebirth(v129, l_Rebirths_0);
    end;
    v84();
    v29 = v126;
    v27 = v129;
    if v13.Data.Gamepasses.UnlimitedRebirths then
        local v141 = math.floor((v14:ReverseRebirth(v126, l_Rebirths_0)));
        local l_UnlimitedOwned_0 = v34.Inner.List.UnlimitedOwned;
        if v141 == 0 then
            l_UnlimitedOwned_0.Main.BackgroundColor3 = Color3.fromRGB(109, 109, 109);
        else
            l_UnlimitedOwned_0.Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        end;
        v28 = math.floor(v141);
        v74(l_UnlimitedOwned_0.Main.Amount, v28, "+", "");
        local v143 = v14:ClicksPrice(v14:getPrice(v28), l_Rebirths_0);
        v74(l_UnlimitedOwned_0.Main.Cost, v143, "", "");
    end;
end;
v38.RefreshNoUI = function(v144, v145) --[[ Line: 579 ]] --[[ Name: RefreshNoUI ]]
    -- upvalues: v13 (copy), v29 (ref), v39 (copy), v40 (copy), v14 (copy), v27 (ref), v84 (copy)
    local v146 = 0;
    local l_Rebirths_1 = v13.Data.Statistics.Rebirths;
    local l_Clicks_1 = v13.Data.Statistics.Clicks;
    if l_Clicks_1 ~= v145 then
        v145 = l_Clicks_1;
    end;
    local v149 = v145 ~= v29;
    for v150, v151 in pairs(v39) do
        if v151[2] and v146 < v150 then
            v146 = v150;
        end;
        if v149 or v29 == 0 then
            local v152 = v40[v150];
            if v14:ClicksPrice(v152[2], l_Rebirths_1) <= v145 then
                v151[2] = true;
                if v146 < v150 then
                    v146 = v150;
                end;
            else
                v151[2] = false;
            end;
        end;
    end;
    if v146 ~= v27 then
        v144:RefreshQuickRebirth(v146, l_Rebirths_1);
    end;
    v84();
    v29 = v145;
    v27 = v146;
end;
v38.Init = function(v153, v154, v155) --[[ Line: 625 ]] --[[ Name: Init ]]
    -- upvalues: v31 (ref), l_Players_0 (copy), v32 (ref), v34 (ref), v33 (ref), v35 (ref), v36 (ref), v37 (ref), v45 (ref), v57 (copy), v84 (copy), v46 (ref), v13 (copy), v8 (copy), v43 (ref), v39 (copy), v44 (ref), v64 (copy), v47 (ref), v48 (ref), v27 (ref), v9 (copy), v22 (ref), v23 (ref), v24 (ref), l_RunService_0 (copy), v29 (ref), v40 (copy), v14 (copy), v49 (ref)
    v31 = l_Players_0.LocalPlayer.PlayerGui:WaitForChild("RightHud");
    v32 = v31.Main.RightUI.Rebirths;
    v34 = v155;
    v33 = v154;
    v35 = v33.Left.Rebirths.QuickRebirth;
    v36 = v35.Size;
    v37 = v33.Left.Rebirths.Main.RebirthIcon;
    v45 = v32.Top.TopStuff.AutoButton;
    v45.Visible = true;
    v57();
    v32:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 643 ]]
        -- upvalues: v84 (ref)
        v84();
    end);
    if not v32.Container:FindFirstChild("SelectModeIndicator") then
        v46 = Instance.new("TextLabel");
        v46.Name = "SelectModeIndicator";
        v46.Size = UDim2.fromScale(1, 0.15);
        v46.Position = UDim2.fromScale(0, 0.15);
        v46.BackgroundColor3 = Color3.fromRGB(255, 255, 0);
        v46.BackgroundTransparency = 0.3;
        v46.BorderSizePixel = 0;
        v46.Text = "Select a rebirth button to automatically purchase";
        v46.TextColor3 = Color3.fromRGB(255, 255, 255);
        v46.TextScaled = true;
        v46.Font = Enum.Font.FredokaOne;
        v46.Visible = false;
        v46.ZIndex = 10;
        v46.Parent = v32.List;
        local l_UIPadding_0 = Instance.new("UIPadding");
        l_UIPadding_0.Parent = v46;
        l_UIPadding_0.PaddingTop = UDim.new(0.05, 0);
        l_UIPadding_0.PaddingLeft = UDim.new(0.05, 0);
        l_UIPadding_0.PaddingRight = UDim.new(0.05, 0);
        l_UIPadding_0.PaddingBottom = UDim.new(0.05, 0);
        local l_UIStroke_0 = Instance.new("UIStroke");
        l_UIStroke_0.Color = Color3.fromRGB(0, 0, 0);
        l_UIStroke_0.Thickness = 2;
        l_UIStroke_0.Parent = v46;
        local l_UICorner_0 = Instance.new("UICorner");
        l_UICorner_0.CornerRadius = UDim.new(0, 8);
        l_UICorner_0.Parent = v46;
    else
        v46 = v32.Container:FindFirstChild("SelectModeIndicator");
    end;
    v45.Activated:Connect(function() --[[ Line: 684 ]]
        -- upvalues: v13 (ref), v8 (ref), v43 (ref), v46 (ref), v39 (ref), v44 (ref), v64 (ref), v57 (ref), v47 (ref), v48 (ref)
        if not (v13.Data and v13.Data.Gamepasses and v13.Data.Gamepasses.AutoRebirth == true or false) then
            v8.Fire("PromptGamepass", "AutoRebirth");
            _G:Play("Click");
            return;
        else
            if v43 then
                v43 = false;
                if v46 then
                    v46.Visible = false;
                end;
                for _, v160 in pairs(v39) do
                    if v160[2] then
                        v160[1].Template.BackgroundColor3 = Color3.fromRGB(27, 79, 21);
                    else
                        v160[1].Template.BackgroundColor3 = Color3.new(0.30980392156862746, 0.30980392156862746, 0.30980392156862746);
                    end;
                end;
                if v44 then
                    v64(v44);
                else
                    v57();
                end;
            elseif v44 then
                v44 = nil;
                if v47 and v47.Parent then
                    v47.Parent:Destroy();
                end;
                v47 = nil;
                v48 = nil;
                v57();
                _G:Play("Click");
            else
                v43 = true;
                if v46 then
                    v46.Visible = true;
                end;
                if v47 and v47.Parent then
                    v47.Parent:Destroy();
                end;
                v47 = nil;
                v48 = nil;
                for _, v162 in pairs(v39) do
                    v162[1].Template.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                end;
            end;
            v57();
            _G:Play("Click");
            return;
        end;
    end);
    local v163 = false;
    v35.Button.Activated:Connect(function() --[[ Line: 743 ]]
        -- upvalues: v27 (ref), v163 (ref), v35 (ref)
        if v27 ~= 0 and not v163 then
            v163 = true;
            task.delay(0.1, function() --[[ Line: 746 ]]
                -- upvalues: v163 (ref)
                v163 = false;
            end);
            if Rebirth(v27) then
                v35.Visible = false;
                return;
            else
                _G:Play("Broke");
            end;
        end;
    end);
    v35.Button.MouseEnter:Connect(function() --[[ Line: 759 ]]
        -- upvalues: v9 (ref), v35 (ref), v36 (ref)
        v9:Tween(v35, 0.2, "Sine", "Out", {
            Size = UDim2.fromScale(v36.X.Scale * 1.05, v36.Y.Scale * 1.05)
        });
    end);
    v35.Button.MouseLeave:Connect(function() --[[ Line: 763 ]]
        -- upvalues: v9 (ref), v35 (ref), v36 (ref)
        v9:Tween(v35, 0.3, "Back", "Out", {
            Size = v36
        });
    end);
    v35.Button.MouseButton1Down:Connect(function() --[[ Line: 767 ]]
        -- upvalues: v9 (ref), v35 (ref), v36 (ref), v8 (ref)
        v9:Tween(v35, 0.25, "Quad", "Out", {
            Size = UDim2.fromScale(v36.X.Scale * 0.95, v36.Y.Scale * 0.95)
        });
        v8.Fire("BurstFX");
    end);
    local v164 = 0;
    local v165 = 0;
    local v166 = 0;
    local v167 = false;
    v13:Connect("RebirthOptions", function(v168) --[[ Line: 781 ]]
        -- upvalues: v39 (ref), v153 (copy)
        local v169 = #v39;
        v153:UpdateOptions(v168.RebirthOptions);
        v153:Refresh(v168.Statistics.Clicks);
        if v169 < #v39 then
            v153:SpinRebirthIcon();
        end;
    end);
    v13:Connect("Statistics", function(v170) --[[ Line: 792 ]]
        -- upvalues: v13 (ref), v84 (ref), v166 (ref), v22 (ref), v23 (ref), v165 (ref)
        local v171 = v170.Statistics and v170.Statistics.Clicks or v13.Data.Statistics.Clicks;
        local v172 = v170.Statistics and v170.Statistics.Rebirths or v13.Data.Statistics.Rebirths;
        v84();
        if v166 ~= v172 then
            v166 = v172;
            v22 = true;
            v23 = true;
        end;
        if v171 ~= v165 then
            v165 = v171;
            v22 = true;
        end;
    end);
    v13:Connect("DataLoaded", function(v173) --[[ Line: 801 ]]
        -- upvalues: v153 (copy)
        v153:Refresh(v173.Statistics.Clicks);
        v153:UpdateOptions(v173.RebirthOptions);
    end);
    v13:Connect("Gamepasses", function() --[[ Line: 806 ]]
        -- upvalues: v13 (ref), v44 (ref), v47 (ref), v48 (ref), v43 (ref), v46 (ref), v57 (ref)
        if not (v13.Data and v13.Data.Gamepasses and v13.Data.Gamepasses.AutoRebirth == true or false) then
            if v44 then
                v44 = nil;
            end;
            if v47 and v47.Parent then
                v47.Parent:Destroy();
            end;
            v47 = nil;
            v48 = nil;
            v43 = false;
            if v46 then
                v46.Visible = false;
            end;
        end;
        v57();
    end);
    v31.Main.RightUI.Rebirths:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 821 ]]
        -- upvalues: v31 (ref), v39 (ref), v27 (ref), v32 (ref), v165 (ref), v13 (ref), v22 (ref), v24 (ref)
        if v31.Main.RightUI.Rebirths.Visible then
            if #v39 > 8 and v27 and v39[v27] then
                v32.List.CanvasPosition = Vector2.new(0, v39[v27][1].AbsolutePosition.Y - v32.List.AbsolutePosition.Y + v32.List.CanvasPosition.Y);
            end;
            v165 = v13.Data.Statistics.Clicks;
            v22 = true;
            v24 = true;
        end;
    end);
    v31.Main.RightUI.Rebirths:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 836 ]]
        -- upvalues: v31 (ref), v13 (ref), v153 (copy), v24 (ref), v22 (ref)
        if v31.Main.RightUI.Rebirths.Visible then
            local l_Clicks_2 = v13.Data.Statistics.Clicks;
            v153:Refresh(l_Clicks_2);
            v24 = true;
            v22 = true;
        end;
    end);
    l_RunService_0.Heartbeat:Connect(function() --[[ Line: 847 ]]
        -- upvalues: v22 (ref), v164 (ref), v24 (ref), v13 (ref), v29 (ref), v31 (ref), v153 (copy), v23 (ref), v44 (ref), v43 (ref), v167 (ref), v40 (ref), v39 (ref), v14 (ref), v49 (ref)
        if v22 and (tick() - v164 > 0.5 or v24) then
            v164 = tick();
            v22 = false;
            local l_Clicks_3 = v13.Data.Statistics.Clicks;
            local _ = v13.Data.Statistics.Rebirths;
            if l_Clicks_3 ~= v29 then
                v24 = true;
            end;
            if v31.Main.RightUI.Rebirths.Visible then
                v153:Refresh(l_Clicks_3);
                return;
            else
                v153:RefreshNoUI(l_Clicks_3);
            end;
        end;
        if v23 and tick() - v164 > 0.5 then
            v23 = false;
            local l_Clicks_4 = v13.Data.Statistics.Clicks;
            v153:Refresh(l_Clicks_4);
        end;
        if v44 and not v43 and v13.Loaded and not v167 and (v13.Data and v13.Data.Gamepasses and v13.Data.Gamepasses.AutoRebirth == true or false) then
            local v178 = v40[v44];
            if v178 and v39[v44] then
                local l_Rebirths_3 = v13.Data.Statistics.Rebirths;
                local v180 = v14:ClicksPrice(v178[2], l_Rebirths_3);
                local l_Clicks_5 = v13.Data.Statistics.Clicks;
                local v182 = tick() - v49;
                if v180 <= l_Clicks_5 and v182 >= 1.5 then
                    v167 = true;
                    if Rebirth(v44, v178, false, true) then
                        v49 = tick();
                        v167 = true;
                        v24 = true;
                        v22 = true;
                    end;
                    task.delay(0.2, function() --[[ Line: 900 ]]
                        -- upvalues: v167 (ref)
                        v167 = false;
                    end);
                end;
            end;
        end;
    end);
    _G.GetCurrentAutoRebirth = function() --[[ Line: 926 ]] --[[ Name: GetCurrentAutoRebirth ]]
        -- upvalues: v44 (ref)
        return v44;
    end;
    v8.new("StartAutoRebirthRejoin"):Connect(function(v183) --[[ Line: 930 ]]
        -- upvalues: v13 (ref), v39 (ref), v44 (ref), v64 (ref)
        if not v183 then
            return;
        else
            repeat
                task.wait();
            until v13.Loaded;
            repeat
                task.wait(0.25);
            until v39[v183] and v39[v183][2];
            v44 = v183;
            v64(v183);
            return;
        end;
    end);
end;
return v38;