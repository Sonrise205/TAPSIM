local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local l_Lighting_0 = game:GetService("Lighting");
local l_CollectionService_0 = game:GetService("CollectionService");
local l_TweenService_0 = game:GetService("TweenService");
local l_SoundService_0 = game:GetService("SoundService");
local v7 = require(l_ReplicatedStorage_0.Modules.Signal);
local v8 = require(l_ReplicatedStorage_0.Modules.Tweens);
local _ = require(l_ReplicatedStorage_0.Modules.Short);
local v10 = require(l_ReplicatedStorage_0.Game.Variables);
local _ = require(l_ReplicatedStorage_0.Modules.spr);
local v12 = require(l_ReplicatedStorage_0.Game.Replication);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_PlayerGui_0 = l_LocalPlayer_0.PlayerGui;
local v15 = nil;
local v16 = nil;
local v17 = nil;
local v18 = nil;
local v19 = nil;
local l_Menus_0 = l_LocalPlayer_0:WaitForChild("PlayerScripts"):WaitForChild("Modules"):WaitForChild("Menus");
local l_Store_0 = l_Lighting_0:WaitForChild("Store");
local v22 = UDim2.new(0.5, 0, 0.65, 0);
local v23 = nil;
local v24 = nil;
local v25 = nil;
local v26 = nil;
local v27 = {};
local v28 = {};
local v29 = nil;
local v30 = nil;
local v31 = nil;
local function v32() --[[ Line: 45 ]] --[[ Name: playExitButtonSound ]]
    -- upvalues: v30 (ref), l_SoundService_0 (copy)
    if not v30 or v30.Parent == nil then
        v30 = Instance.new("Sound");
        v30.Name = "ExitButtonSound";
        v30.SoundId = "rbxassetid://100978270938794";
        v30.PlaybackSpeed = 1.5;
        v30.Volume = 0.45;
        v30.PlayOnRemove = false;
        v30.Parent = l_SoundService_0;
    else
        v30.SoundId = "rbxassetid://100978270938794";
        v30.PlaybackSpeed = 1.5;
    end;
    if v30.IsPlaying then
        v30:Stop();
    end;
    v30:Play();
end;
local function v33() --[[ Line: 63 ]] --[[ Name: playMenuOpenSound ]]
    -- upvalues: v31 (ref), l_SoundService_0 (copy)
    if not v31 or v31.Parent == nil then
        v31 = Instance.new("Sound");
        v31.Name = "MenuOpenSound";
        v31.SoundId = "rbxassetid://72546789484013";
        v31.Volume = 0.4;
        v31.PlayOnRemove = false;
        v31.Parent = l_SoundService_0;
    else
        v31.SoundId = "rbxassetid://72546789484013";
    end;
    v31.PlaybackSpeed = 1.2;
    if v31.IsPlaying then
        v31:Stop();
    end;
    v31:Play();
end;
local _ = {};
local v35 = nil;
local v36 = nil;
Open = function(v37, v38) --[[ Line: 84 ]] --[[ Name: Open ]]
    -- upvalues: v15 (ref), v10 (copy), v23 (ref), v26 (ref), v27 (copy), v25 (ref), l_Store_0 (copy), v8 (copy), v33 (copy), v7 (copy), v16 (ref), l_TweenService_0 (copy)
    local l_v15_FirstChild_0 = v15:FindFirstChild(v37);
    if not l_v15_FirstChild_0 then
        return;
    else
        local l_Menu_0 = l_v15_FirstChild_0.Menu;
        if v10.hatching and v37 ~= "Message" then
            v23 = v37;
            repeat
                task.wait();
            until not v10.hatching;
            if v15.CraftingRoll:GetAttribute("Enabled") == true then
                Close("CraftingRoll", true);
            end;
            if v23 ~= v37 then
                return;
            end;
        end;
        if not l_Menu_0 or l_v15_FirstChild_0:GetAttribute("Enabled") == true then
            return;
        else
            if not v38 then
                for _, v42 in pairs(v15:GetChildren()) do
                    if v42:IsA("ScreenGui") and v42:GetAttribute("Enabled") == true then
                        if l_Menu_0.Name == "Message" then
                            v26 = v42.Name;
                        end;
                        Close(v42.Name, true);
                    end;
                end;
            end;
            local v43 = v27[v37][2];
            local v44 = l_Menu_0.Name == "Store";
            v25.Enabled = true;
            l_v15_FirstChild_0.Enabled = true;
            l_v15_FirstChild_0:SetAttribute("Enabled", true);
            if v44 then
                _G:Play("Magic Open");
                l_Store_0.Enabled = true;
            end;
            v8:Tween(l_Menu_0, 0.3, "Back", "Out", {
                Position = v43
            });
            v33();
            if v27[v37][3] then
                l_Menu_0.Behind.Rotation = -v27[v37][3] * 1.5;
                v8:Tween(l_Menu_0.Behind, 0.7, "Back", "Out", {
                    Rotation = v27[v37][3]
                });
            end;
            if l_Menu_0.Name ~= "Rebirths" and l_Menu_0.Name ~= "Achievements" then
                v7.Fire("ClearNotifications", l_Menu_0.Name);
            end;
            if v37 == "Inventory" then
                v7.Fire("ClearNotifications", "Pets");
                local v45 = v16.Bottom:FindFirstChild("Pets") and v16.Bottom.Pets:FindFirstChild("Notification");
                if v45 and v45.Visible then
                    local l_BackgroundTransparency_0 = v45.BackgroundTransparency;
                    local v47 = 0;
                    local function v48() --[[ Line: 145 ]] --[[ Name: flash ]]
                        -- upvalues: v47 (ref), l_TweenService_0 (ref), v45 (copy), l_BackgroundTransparency_0 (copy), v48 (copy)
                        v47 = v47 + 1;
                        if v47 <= 3 then
                            local v49 = l_TweenService_0:Create(v45, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                                BackgroundTransparency = math.min(l_BackgroundTransparency_0 + 0.5, 1)
                            });
                            v49:Play();
                            v49.Completed:Connect(function() --[[ Line: 153 ]]
                                -- upvalues: l_TweenService_0 (ref), v45 (ref), l_BackgroundTransparency_0 (ref), v47 (ref), v48 (ref)
                                local v50 = l_TweenService_0:Create(v45, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                                    BackgroundTransparency = l_BackgroundTransparency_0
                                });
                                v50:Play();
                                v50.Completed:Connect(function() --[[ Line: 159 ]]
                                    -- upvalues: v47 (ref), v48 (ref), v45 (ref)
                                    if v47 < 3 then
                                        task.wait(0.05);
                                        v48();
                                        return;
                                    else
                                        v45.Visible = false;
                                        local l_Amt_0 = v45:FindFirstChild("Amt");
                                        if l_Amt_0 then
                                            l_Amt_0.Text = "0";
                                        end;
                                        return;
                                    end;
                                end);
                            end);
                        end;
                    end;
                    v48();
                    return;
                elseif v45 then
                    v45.Visible = false;
                    local l_Amt_1 = v45:FindFirstChild("Amt");
                    if l_Amt_1 then
                        l_Amt_1.Text = "0";
                    end;
                end;
            end;
            return;
        end;
    end;
end;
Close = function(v53, v54) --[[ Line: 186 ]] --[[ Name: Close ]]
    -- upvalues: v15 (ref), v7 (copy), v22 (copy), v25 (ref), v26 (ref), l_Store_0 (copy)
    local l_v15_FirstChild_1 = v15:FindFirstChild(v53);
    if not l_v15_FirstChild_1 then
        return;
    else
        local v56 = v53 == "Store";
        local l_Menu_1 = l_v15_FirstChild_1.Menu;
        if v53 == "UpdateLog" and updateLogIcon.enabled then
            updateLogIcon:deselect();
        end;
        if v53 == "Menu" then
            v7.Fire("RemoveTooltip");
        end;
        if not l_Menu_1 or l_Menu_1:GetAttribute("Enabled") == false then
            return;
        else
            l_Menu_1.Position = v22;
            l_v15_FirstChild_1.Enabled = false;
            l_v15_FirstChild_1:SetAttribute("Enabled", false);
            if not v54 then
                _G:Play("Click", 0.9, 0.2);
                _G:Play("Menu");
                v25.Enabled = false;
            end;
            if v53 == "Message" and v26 then
                if not v54 then
                    Open(v26);
                end;
                v26 = nil;
            end;
            if v56 then
                l_Store_0.Enabled = false;
            end;
            return;
        end;
    end;
end;
Toggle = function(v58, v59, _, v61) --[[ Line: 217 ]] --[[ Name: Toggle ]]
    -- upvalues: v15 (ref), v27 (copy)
    local v62 = nil;
    if not v15 or not v27[v58] then
        return;
    else
        v62 = v15:FindFirstChild(v58);
        if not v62 then
            return;
        else
            local _ = v27[v58][1];
            local v64 = v27[v58][2];
            local _ = v58 == "Store";
            if v62:GetAttribute("Enabled") == false and not v59 then
                Open(v58, true);
                return;
            else
                if v59 or v62.Menu.Position == v64 and v62:GetAttribute("Enabled") == true and not v61 then
                    Close(v58, v59);
                end;
                return;
            end;
        end;
    end;
end;
v28.IsOpen = function(_, v67) --[[ Line: 230 ]] --[[ Name: IsOpen ]]
    -- upvalues: v15 (ref)
    local l_v15_FirstChild_2 = v15:FindFirstChild(v67);
    return l_v15_FirstChild_2 and l_v15_FirstChild_2.Enabled or false;
end;
v28.ShowRightHudNotification = function(_, v70) --[[ Line: 235 ]] --[[ Name: ShowRightHudNotification ]]
    -- upvalues: v35 (ref)
    v35(v70);
end;
v28.HideRightHudNotification = function(_, v72) --[[ Line: 239 ]] --[[ Name: HideRightHudNotification ]]
    -- upvalues: v36 (ref)
    v36(v72);
end;
v28.Open = function(_, v74, v75, v76) --[[ Line: 243 ]] --[[ Name: Open ]]
    -- upvalues: v15 (ref), v10 (copy)
    local v77 = nil;
    for _, v79 in pairs(v15:GetChildren()) do
        if v79:IsA("ScreenGui") and v79.Name ~= v74 and v79:GetAttribute("Enabled") == true and not v10.hatching and v79.Name ~= "CraftingRoll" then
            v77 = true;
            Close(v79.Name, true);
        end;
    end;
    Toggle(v74, nil, v75, v76);
end;
v28.Init = function(v80) --[[ Line: 254 ]] --[[ Name: Init ]]
    -- upvalues: v15 (ref), l_PlayerGui_0 (copy), v16 (ref), v17 (ref), v18 (ref), v19 (ref), v27 (copy), v22 (copy), v7 (copy), v32 (copy), v25 (ref), v24 (ref), l_Menus_0 (copy), l_TweenService_0 (copy), v35 (ref), l_CollectionService_0 (copy), v36 (ref), v28 (copy), v12 (copy), v29 (ref)
    v15 = l_PlayerGui_0:WaitForChild("Tabs");
    v16 = l_PlayerGui_0:WaitForChild("Game");
    v17 = l_PlayerGui_0:WaitForChild("RightHud");
    v18 = l_PlayerGui_0:FindFirstChild("RightHudButtons");
    v19 = v15:WaitForChild("Inventory");
    for _, v82 in pairs(v15:GetChildren()) do
        if v82:FindFirstChild("Menu") then
            v27[v82.Name] = {
                v82.Menu.Size, 
                v82.Menu.Position, 
                v82.Menu:FindFirstChild("Behind") and v82.Menu.Behind.Rotation
            };
            v82.Enabled = false;
            v82:SetAttribute("Enabled", false);
            v82.Menu.Position = v22;
            local v83 = v82.Menu:FindFirstChild("Close") or v82.Menu:FindFirstChild("Close", true);
            if v83 then
                v7.Fire("InitButton", v83.Button);
                v83.Button.Activated:Connect(function() --[[ Line: 269 ]]
                    -- upvalues: v32 (ref), v82 (copy)
                    v32();
                    Close(v82.Name);
                end);
            end;
        end;
    end;
    v25 = Instance.new("BlurEffect", workspace.CurrentCamera);
    v25.Size = 0;
    v25.Enabled = false;
    v24 = v16.Background;
    for _, v85 in pairs(l_Menus_0:GetChildren()) do
        local l_v15_FirstChild_3 = v15:FindFirstChild(v85.Name);
        if l_v15_FirstChild_3 then
            require(v85):Init(v16, l_v15_FirstChild_3.Menu, script);
        end;
    end;
    v7.new("ToggleMenu"):Connect(function(...) --[[ Line: 288 ]]
        -- upvalues: v80 (copy)
        v80:Open(...);
    end);
    v7.new("OpenMenu"):Connect(function(...) --[[ Line: 291 ]]
        Open(...);
    end);
    v7.new("CloseMenu"):Connect(function(...) --[[ Line: 294 ]]
        Close(...);
    end);
    v7.new("CloseAllMenus"):Connect(function() --[[ Line: 297 ]]
        -- upvalues: v15 (ref)
        for _, v88 in ipairs(v15:GetChildren()) do
            if v88:IsA("ScreenGui") and v88:GetAttribute("Enabled") == true then
                Close(v88.Name);
            end;
        end;
    end);
    local v89 = nil;
    local function v94(v90) --[[ Line: 306 ]] --[[ Name: createNotificationBadge ]]
        -- upvalues: l_TweenService_0 (ref)
        local l_Frame_0 = Instance.new("Frame");
        l_Frame_0.Name = "Notification";
        l_Frame_0.AnchorPoint = Vector2.new(1, 0);
        l_Frame_0.Position = UDim2.new(1, 0, 0, 0);
        l_Frame_0.Size = UDim2.new(0.3, 0, 0.3, 0);
        l_Frame_0.BackgroundColor3 = Color3.fromRGB(255, 60, 60);
        l_Frame_0.BorderSizePixel = 0;
        l_Frame_0.ZIndex = 10;
        l_Frame_0.Parent = v90;
        local l_UICorner_0 = Instance.new("UICorner");
        l_UICorner_0.CornerRadius = UDim.new(1, 0);
        l_UICorner_0.Parent = l_Frame_0;
        local l_UIScale_0 = Instance.new("UIScale");
        l_UIScale_0.Scale = 1;
        l_UIScale_0.Parent = l_Frame_0;
        l_TweenService_0:Create(l_UIScale_0, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
            Scale = 1.3
        }):Play();
        return l_Frame_0;
    end;
    local function _(v95) --[[ Line: 334 ]] --[[ Name: findNotificationBadge ]]
        if not v95 then
            return nil;
        else
            return v95:FindFirstChild("Notification") or v95:FindFirstChild("NotificationBadge") or v95:FindFirstChild("Noification");
        end;
    end;
    local function _(v97) --[[ Line: 340 ]] --[[ Name: getOrCreateNotificationBadge ]]
        -- upvalues: v94 (copy)
        return (if not v97 then nil else v97:FindFirstChild("Notification") or v97:FindFirstChild("NotificationBadge") or v97:FindFirstChild("Noification")) or v97 and v94(v97);
    end;
    v35 = function(v99) --[[ Line: 347 ]]
        -- upvalues: l_CollectionService_0 (ref), v94 (copy), v17 (ref)
        for _, v101 in pairs(l_CollectionService_0:GetTagged("UIOpenButton")) do
            if v101.Name == v99 then
                local v102 = (if not v101 then nil else v101:FindFirstChild("Notification") or v101:FindFirstChild("NotificationBadge") or v101:FindFirstChild("Noification")) or v101 and v94(v101);
                if v102 then
                    v102.Visible = true;
                end;
            end;
        end;
        if v17 and v17.Main and v17.Main.Buttons then
            local l_FirstChild_0 = v17.Main.Buttons:FindFirstChild(v99);
            if l_FirstChild_0 then
                local v104 = (if not l_FirstChild_0 then nil else l_FirstChild_0:FindFirstChild("Notification") or l_FirstChild_0:FindFirstChild("NotificationBadge") or l_FirstChild_0:FindFirstChild("Noification")) or l_FirstChild_0 and v94(l_FirstChild_0);
                if v104 then
                    v104.Visible = true;
                end;
            end;
        end;
    end;
    v36 = function(v105) --[[ Line: 371 ]]
        -- upvalues: l_CollectionService_0 (ref), v17 (ref)
        for _, v107 in pairs(l_CollectionService_0:GetTagged("UIOpenButton")) do
            if v107.Name == v105 then
                local v108 = if not v107 then nil else v107:FindFirstChild("Notification") or v107:FindFirstChild("NotificationBadge") or v107:FindFirstChild("Noification");
                if v108 then
                    v108.Visible = false;
                end;
            end;
        end;
        if v17 and v17.Main and v17.Main.Buttons then
            local l_FirstChild_1 = v17.Main.Buttons:FindFirstChild(v105);
            if l_FirstChild_1 then
                local v110 = if not l_FirstChild_1 then nil else l_FirstChild_1:FindFirstChild("Notification") or l_FirstChild_1:FindFirstChild("NotificationBadge") or l_FirstChild_1:FindFirstChild("Noification");
                if v110 then
                    v110.Visible = false;
                end;
            end;
        end;
    end;
    v7.new("OpenRainbowCraft"):Connect(function() --[[ Line: 394 ]]
        -- upvalues: l_Menus_0 (ref)
        Open("RainbowMachine");
        local l_RainbowCraft_0 = l_Menus_0:FindFirstChild("RainbowCraft");
        if l_RainbowCraft_0 then
            local v112 = require(l_RainbowCraft_0);
            if v112 then
                v112.CraftMenu();
            end;
        end;
    end);
    v7.new("ShowRightHudNotification"):Connect(function(v113) --[[ Line: 406 ]]
        -- upvalues: v35 (ref)
        v35(v113);
    end);
    v7.new("HideRightHudNotification"):Connect(function(v114) --[[ Line: 409 ]]
        -- upvalues: v36 (ref)
        v36(v114);
    end);
    _G.MenuOpen = function(_, v116) --[[ Line: 412 ]] --[[ Name: MenuOpen ]]
        -- upvalues: v28 (ref)
        return v28:IsOpen(v116);
    end;
    local v122 = {
        Rebirths = function(v117) --[[ Line: 416 ]]
            -- upvalues: v36 (ref), v17 (ref), l_TweenService_0 (ref)
            if v117 then
                v36("Rebirths");
                v17.Main.RightUI.Rebirths.Visible = true;
                v17.Main.RightUI.Rebirths.Position = UDim2.new(1.3, 0, 0.5, 0);
                l_TweenService_0:Create(v17.Main.RightUI.Rebirths, TweenInfo.new(0.2), {
                    Position = UDim2.new(0, 0, 0.5, 0)
                }):Play();
                return;
            else
                v17.Main.RightUI.Rebirths.Visible = false;
                return;
            end;
        end, 
        Quests = function(v118) --[[ Line: 426 ]]
            -- upvalues: v36 (ref), v17 (ref), l_TweenService_0 (ref)
            if v118 then
                v36("Quests");
                v17.Main.RightUI.Quests.Visible = true;
                v17.Main.RightUI.Quests.Position = UDim2.new(1.3, 0, 0.5, 0);
                l_TweenService_0:Create(v17.Main.RightUI.Quests, TweenInfo.new(0.2), {
                    Position = UDim2.new(0, 0, 0.5, 0)
                }):Play();
                return;
            else
                v17.Main.RightUI.Quests.Visible = false;
                return;
            end;
        end, 
        Badges = function(v119) --[[ Line: 436 ]]
            -- upvalues: v36 (ref), v17 (ref), l_TweenService_0 (ref)
            if v119 then
                v36("Badges");
                v17.Main.RightUI.Badges.Visible = true;
                v17.Main.RightUI.Badges.Position = UDim2.new(1.3, 0, 0.5, 0);
                l_TweenService_0:Create(v17.Main.RightUI.Badges, TweenInfo.new(0.2), {
                    Position = UDim2.new(0, 0, 0.5, 0)
                }):Play();
                return;
            else
                v17.Main.RightUI.Badges.Visible = false;
                return;
            end;
        end, 
        Items = function(v120) --[[ Line: 446 ]]
            -- upvalues: v36 (ref), v17 (ref), l_TweenService_0 (ref)
            if v120 then
                v36("Items");
                v17.Main.RightUI.Items.Visible = true;
                v17.Main.RightUI.Items.Position = UDim2.new(1.3, 0, 0.5, 0);
                l_TweenService_0:Create(v17.Main.RightUI.Items, TweenInfo.new(0.2), {
                    Position = UDim2.new(0, 0, 0.5, 0)
                }):Play();
                return;
            else
                v17.Main.RightUI.Items.Visible = false;
                return;
            end;
        end, 
        Hatches = function(v121) --[[ Line: 456 ]]
            -- upvalues: v17 (ref), l_TweenService_0 (ref)
            if v121 then
                v17.Main.RightUI.Hatches.Visible = true;
                v17.Main.RightUI.Hatches.Position = UDim2.new(1.3, 0, 0.5, 0);
                l_TweenService_0:Create(v17.Main.RightUI.Hatches, TweenInfo.new(0.2), {
                    Position = UDim2.new(0, 0, 0.5, 0)
                }):Play();
                return;
            else
                v17.Main.RightUI.Hatches.Visible = false;
                return;
            end;
        end
    };
    local function v124(v123) --[[ Line: 466 ]] --[[ Name: resetButton ]]
        -- upvalues: v122 (copy), v89 (ref)
        v123.Icon.UIScale.Scale = 1;
        if v122[v123.Name] then
            v122[v123.Name](false);
        end;
        v89 = nil;
    end;
    local function _() --[[ Line: 473 ]] --[[ Name: closeRightUI ]]
        -- upvalues: v12 (ref), v17 (ref), v18 (ref)
        if v12.Loaded and not (v12.Data.Onboarding or {}).FirstRebirth then
            return;
        else
            v17.Enabled = false;
            v18.Enabled = true;
            _G:Play("Menu");
            return;
        end;
    end;
    local function _() --[[ Line: 486 ]] --[[ Name: openRightUI ]]
        -- upvalues: v17 (ref), v18 (ref)
        v17.Enabled = true;
        v18.Enabled = false;
        _G:Play("Menu");
    end;
    for _, v128 in pairs(v17.Main.RightUI:GetChildren()) do
        if v128:IsA("Frame") and v128.Visible then
            v89 = v17.Main.Buttons:FindFirstChild(v128.Name);
            v29 = v89;
        end;
    end;
    for _, v130 in pairs(l_CollectionService_0:GetTagged("UIOpenButton")) do
        local l_Button_0 = v130:FindFirstChild("Button");
        local l_Icon_0 = v130:FindFirstChild("Icon");
        if l_Button_0 then
            local v133 = l_Icon_0 and l_Icon_0.UIScale and l_Icon_0.UIScale.Scale or 1;
            local v134 = false;
            do
                local l_v134_0 = v134;
                if l_Button_0:IsA("GuiButton") then
                    l_Button_0.MouseEnter:Connect(function() --[[ Line: 505 ]]
                        -- upvalues: l_v134_0 (ref), l_Icon_0 (copy), l_TweenService_0 (ref), v133 (copy)
                        if not l_v134_0 and l_Icon_0 and l_Icon_0.UIScale then
                            l_v134_0 = true;
                            l_TweenService_0:Create(l_Icon_0.UIScale, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                Scale = v133 * 1.15
                            }):Play();
                        end;
                    end);
                    l_Button_0.MouseLeave:Connect(function() --[[ Line: 513 ]]
                        -- upvalues: l_v134_0 (ref), l_Icon_0 (copy), v89 (ref), v130 (copy), l_TweenService_0 (ref), v133 (copy)
                        if l_v134_0 and l_Icon_0 and l_Icon_0.UIScale and v89 ~= v130 then
                            l_v134_0 = false;
                            l_TweenService_0:Create(l_Icon_0.UIScale, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                                Scale = v133
                            }):Play();
                        end;
                    end);
                end;
                l_Button_0.Activated:Connect(function() --[[ Line: 522 ]]
                    -- upvalues: v89 (ref), v130 (copy), v12 (ref), v17 (ref), v18 (ref), v124 (copy), v122 (copy), v29 (ref), l_TweenService_0 (ref), l_Icon_0 (copy)
                    if v89 then
                        if v89 == v130 then
                            if not v12.Loaded or (v12.Data.Onboarding or {}).FirstRebirth then
                                v17.Enabled = false;
                                v18.Enabled = true;
                                _G:Play("Menu");
                            end;
                            _G:Play("Box");
                            return v124(v89);
                        else
                            local l_v89_0 = v89;
                            l_v89_0.Icon.UIScale.Scale = 1;
                            if v122[l_v89_0.Name] then
                                v122[l_v89_0.Name](false);
                            end;
                            v89 = nil;
                        end;
                    end;
                    if not v17.Main.RightUI.Visible or not v17.Enabled then
                        v17.Enabled = true;
                        v18.Enabled = false;
                        _G:Play("Menu");
                    end;
                    _G:Play("Click2");
                    v17.Main.RightUI.Visible = true;
                    v89 = v17.Main.Buttons:FindFirstChild(v130.Name);
                    if v130.Name ~= "Hatches" then
                        v29 = v89;
                    end;
                    l_TweenService_0:Create(l_Icon_0.UIScale, TweenInfo.new(0.1), {
                        Scale = 1.1
                    }):Play();
                    l_Icon_0.ImageTransparency = 0;
                    if v122[v130.Name] then
                        _G:Play("Menu");
                        v122[v130.Name](true);
                    end;
                end);
            end;
        end;
    end;
    local v137 = require(script.Parent.Parent.Parent.Controllers.HatchController);
    local v138 = require(script.Parent.Parent.BillboardController);
    local l_Hatches_0 = v17.Main.Buttons:FindFirstChild("Hatches");
    local v140 = false;
    l_Hatches_0.Visible = false;
    v138.HatchingStarted:Connect(function(v141) --[[ Line: 560 ]]
        -- upvalues: v140 (ref), l_Hatches_0 (copy), v137 (copy)
        v140 = true;
        if l_Hatches_0 then
            l_Hatches_0.Visible = true;
        end;
        if v141 and typeof(v141) == "table" then
            for _, v143 in ipairs(v141) do
                local v144 = v143[1];
                local v145 = v143[2] or "Normal";
                task.delay(2, function() --[[ Line: 573 ]]
                    -- upvalues: v137 (ref), v144 (copy), v145 (copy)
                    v137.addHatchedPet(v144, v145);
                end);
            end;
        end;
    end);
    v138.HatchingStopped:Connect(function() --[[ Line: 580 ]]
        -- upvalues: v140 (ref), l_Hatches_0 (copy), v89 (ref), v122 (copy), v29 (ref), l_TweenService_0 (ref), v137 (copy)
        v140 = false;
        if l_Hatches_0 then
            l_Hatches_0.Visible = false;
        end;
        if v89 and v89.Name == "Hatches" then
            local l_v89_1 = v89;
            l_v89_1.Icon.UIScale.Scale = 1;
            if v122[l_v89_1.Name] then
                v122[l_v89_1.Name](false);
            end;
            v89 = nil;
        end;
        v122.Hatches(false);
        if v29 and v29.Name ~= "Hatches" then
            local l_v29_0 = v29;
            v89 = l_v29_0;
            local l_Icon_1 = l_v29_0:FindFirstChild("Icon");
            if l_Icon_1 and l_Icon_1:FindFirstChild("UIScale") then
                l_TweenService_0:Create(l_Icon_1.UIScale, TweenInfo.new(0.1), {
                    Scale = 1.1
                }):Play();
            end;
            if v122[l_v29_0.Name] then
                v122[l_v29_0.Name](true);
            end;
        end;
        v29 = nil;
        v137.resetHatchesPanel();
    end);
end;
return v28;