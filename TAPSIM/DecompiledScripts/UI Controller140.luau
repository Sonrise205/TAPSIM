local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local l_CollectionService_0 = game:GetService("CollectionService");
local v4 = require(l_ReplicatedStorage_0.Modules.Rainbow);
local v5 = require(l_ReplicatedStorage_0.Modules.Network);
local v6 = require(l_ReplicatedStorage_0.Modules.Signal);
local v7 = require(l_ReplicatedStorage_0.Modules.Tweens);
local _ = require(l_ReplicatedStorage_0.Modules.Short);
local _ = require(l_ReplicatedStorage_0.Modules.UIBurst);
local _ = require(l_ReplicatedStorage_0.Modules.GIF);
local v11 = require(l_ReplicatedStorage_0.Modules.Tooltip);
local l_TapButton_0 = require(script:WaitForChild("TapButton"));
local l_Menus_0 = require(script:WaitForChild("Menus"));
local l_Currency_0 = require(script:WaitForChild("Currency"));
local l_UIStroke_0 = require(script:WaitForChild("UIStroke"));
local l_Notifications_0 = require(script:WaitForChild("Notifications"));
local l_Transaction_0 = require(script:WaitForChild("Transaction"));
local l_BuyMenu_0 = require(script.Parent.Parent.Menus:WaitForChild("BuyMenu"));
local l_PlayerGui_0 = l_Players_0.LocalPlayer:WaitForChild("PlayerGui");
local l_Game_0 = l_PlayerGui_0:WaitForChild("Game");
local l_ScreenGlow_0 = l_PlayerGui_0:WaitForChild("ScreenGlow");
local l_UI_0 = l_ReplicatedStorage_0.Content.UI;
local l_Left_0 = l_Game_0:WaitForChild("Left");
local l_RightHud_0 = l_PlayerGui_0:WaitForChild("RightHud");
local l_Bottom_0 = l_Game_0:WaitForChild("Bottom");
local l_Tabs_0 = l_PlayerGui_0:WaitForChild("Tabs");
local v27 = {};
local _ = {};
local function v30(v29) --[[ Line: 47 ]] --[[ Name: tagPattern ]]
    -- upvalues: l_CollectionService_0 (copy)
    if v29:IsA("ImageLabel") and v29.Name == "Pattern" and not l_CollectionService_0:HasTag(v29, "TiledImageLabel") then
        l_CollectionService_0:AddTag(v29, "TiledImageLabel");
    end;
end;
local _ = function(v31) --[[ Line: 53 ]] --[[ Name: trackPatternImages ]]
    -- upvalues: l_CollectionService_0 (copy), v30 (copy)
    if not v31 then
        return;
    else
        local function v32(v33) --[[ Line: 58 ]] --[[ Name: scan ]]
            -- upvalues: l_CollectionService_0 (ref), v32 (copy)
            if v33:IsA("ImageLabel") and v33.Name == "Pattern" and not l_CollectionService_0:HasTag(v33, "TiledImageLabel") then
                l_CollectionService_0:AddTag(v33, "TiledImageLabel");
            end;
            for _, v35 in ipairs(v33:GetChildren()) do
                v32(v35);
            end;
        end;
        if v31:IsA("ImageLabel") and v31.Name == "Pattern" and not l_CollectionService_0:HasTag(v31, "TiledImageLabel") then
            l_CollectionService_0:AddTag(v31, "TiledImageLabel");
        end;
        for _, v37 in ipairs(v31:GetChildren()) do
            v32(v37);
        end;
        v31.DescendantAdded:Connect(v30);
        return;
    end;
end;
local function v47(v39, v40) --[[ Line: 71 ]] --[[ Name: initButton ]]
    -- upvalues: v7 (copy), v6 (copy)
    local l_Main_0 = v39.Parent.Main;
    local l_Position_0 = l_Main_0.Position;
    local l_Size_0 = l_Main_0.Size;
    local l_Size_1 = v39.Parent.Size;
    local l_Icon_0 = l_Main_0:FindFirstChild("Icon");
    local v46 = nil;
    if l_Icon_0 then
        v46 = l_Icon_0.Rotation;
    end;
    v39.MouseEnter:Connect(function() --[[ Line: 87 ]]
        -- upvalues: v7 (ref), l_Main_0 (copy), l_Position_0 (copy), l_Size_0 (copy), l_Icon_0 (copy), v46 (ref)
        v7:Tween(l_Main_0, 0.2, "Sine", "Out", {
            Position = l_Position_0 - UDim2.fromScale(0, 0.02), 
            Size = l_Size_0 + UDim2.fromScale(0, 0.01)
        });
        if l_Icon_0 then
            v7:Tween(l_Icon_0, 0.2, "Sine", "Out", {
                Rotation = v46 + 5
            });
            if l_Main_0:FindFirstChild("IconShadow") then
                v7:Tween(l_Main_0.IconShadow, 0.2, "Sine", "Out", {
                    Rotation = v46 + 5
                });
            end;
        end;
    end);
    v39.MouseLeave:Connect(function() --[[ Line: 97 ]]
        -- upvalues: v7 (ref), l_Main_0 (copy), l_Position_0 (copy), l_Size_0 (copy), v39 (copy), l_Size_1 (copy), l_Icon_0 (copy), v46 (ref)
        v7:Tween(l_Main_0, 0.3, "Sine", "Out", {
            Position = l_Position_0, 
            Size = l_Size_0
        });
        v7:Tween(v39.Parent, 0.3, "Back", "Out", {
            Size = l_Size_1
        });
        if l_Icon_0 then
            v7:Tween(l_Icon_0, 0.3, "Sine", "Out", {
                Rotation = v46
            });
            if l_Main_0:FindFirstChild("IconShadow") then
                v7:Tween(l_Main_0.IconShadow, 0.2, "Sine", "Out", {
                    Rotation = v46
                });
            end;
        end;
    end);
    v39.MouseButton1Down:Connect(function() --[[ Line: 109 ]]
        -- upvalues: v7 (ref), l_Main_0 (copy), v39 (copy), l_Size_1 (copy), v6 (ref), v40 (copy)
        v7:Tween(l_Main_0, 0.15, "Sine", "Out", {
            Position = UDim2.fromScale(0.5, 0.015), 
            Size = UDim2.fromScale(0.99, 0.97)
        });
        v7:Tween(v39.Parent, 0.15, "Back", "Out", {
            Size = l_Size_1 - UDim2.fromScale(l_Size_1.X.Scale * 0.045, l_Size_1.Y.Scale * 0.045)
        });
        v6.Fire("BurstFX");
        if not v40 then
            _G:Play("Click", 1, 0.4);
        end;
    end);
    v39.Activated:Connect(function() --[[ Line: 118 ]]
        -- upvalues: v7 (ref), l_Main_0 (copy), l_Position_0 (copy), l_Size_0 (copy), v39 (copy), l_Size_1 (copy), v40 (copy)
        v7:Tween(l_Main_0, 0.2, "Back", "Out", {
            Position = l_Position_0 - UDim2.fromScale(0, 0.02), 
            Size = l_Size_0 + UDim2.fromScale(0, 0.01)
        });
        v7:Tween(v39.Parent, 0.15, "Back", "Out", {
            Size = l_Size_1
        });
        if not v40 then
            _G:Play("Click2");
        end;
    end);
end;
local v48 = {};
local function _(v49) --[[ Line: 131 ]] --[[ Name: cleanupTooltip ]]
    -- upvalues: v48 (copy)
    if not v49 then
        return;
    else
        local v50 = v48[v49];
        if not v50 then
            return;
        else
            if v50.tooltip then
                v50.tooltip.Destroy();
            end;
            if v50.destroyConn then
                v50.destroyConn:Disconnect();
            end;
            v48[v49] = nil;
            return;
        end;
    end;
end;
setupTooltip = function(v52, v53) --[[ Line: 152 ]] --[[ Name: setupTooltip ]]
    -- upvalues: v48 (copy), v11 (copy)
    if typeof(v52) ~= "Instance" or not v52:IsA("GuiObject") then
        return;
    elseif v53 == nil then
        if not v52 then
            return;
        else
            local v54 = v48[v52];
            if not v54 then
                return;
            else
                if v54.tooltip then
                    v54.tooltip.Destroy();
                end;
                if v54.destroyConn then
                    v54.destroyConn:Disconnect();
                end;
                v48[v52] = nil;
                return;
            end;
        end;
    else
        if typeof(v53) ~= "string" then
            v53 = tostring(v53);
        end;
        if v52 then
            local v55 = v48[v52];
            if v55 then
                if v55.tooltip then
                    v55.tooltip.Destroy();
                end;
                if v55.destroyConn then
                    v55.destroyConn:Disconnect();
                end;
                v48[v52] = nil;
            end;
        end;
        local v56 = v11.new(v52, v53);
        local v59 = v52.Destroying:Connect(function() --[[ Line: 169 ]]
            -- upvalues: v52 (copy), v48 (ref)
            local l_v52_0 = v52;
            if not l_v52_0 then
                return;
            else
                local v58 = v48[l_v52_0];
                if not v58 then
                    return;
                else
                    if v58.tooltip then
                        v58.tooltip.Destroy();
                    end;
                    if v58.destroyConn then
                        v58.destroyConn:Disconnect();
                    end;
                    v48[l_v52_0] = nil;
                    return;
                end;
            end;
        end);
        v48[v52] = {
            tooltip = v56, 
            destroyConn = v59
        };
        return;
    end;
end;
removeTooltip = function(v60) --[[ Line: 179 ]] --[[ Name: removeTooltip ]]
    -- upvalues: v48 (copy)
    if v60 == nil then
        return;
    elseif not v60 then
        return;
    else
        local v61 = v48[v60];
        if not v61 then
            return;
        else
            if v61.tooltip then
                v61.tooltip.Destroy();
            end;
            if v61.destroyConn then
                v61.destroyConn:Disconnect();
            end;
            v48[v60] = nil;
            return;
        end;
    end;
end;
v27.CharacterAdded = function(_, ...) --[[ Line: 188 ]] --[[ Name: CharacterAdded ]]
    -- upvalues: l_TapButton_0 (copy)
    l_TapButton_0:CharacterAdded(...);
end;
v27.Init = function(_) --[[ Line: 192 ]] --[[ Name: Init ]]
    -- upvalues: l_PlayerGui_0 (copy), l_CollectionService_0 (copy), v30 (copy), l_Left_0 (copy), l_Tabs_0 (copy), l_RightHud_0 (copy), v47 (copy), v6 (copy), l_Menus_0 (copy), l_Bottom_0 (copy), v5 (copy), l_ScreenGlow_0 (copy), v4 (copy), v7 (copy), l_UI_0 (copy), l_UIStroke_0 (copy), l_Game_0 (copy), l_TapButton_0 (copy), l_Currency_0 (copy), l_Notifications_0 (copy), l_Transaction_0 (copy), l_BuyMenu_0 (copy)
    local l_l_PlayerGui_0_0 = l_PlayerGui_0;
    if l_l_PlayerGui_0_0 then
        local function v65(v66) --[[ Line: 58 ]] --[[ Name: scan ]]
            -- upvalues: l_CollectionService_0 (ref), v65 (copy)
            if v66:IsA("ImageLabel") and v66.Name == "Pattern" and not l_CollectionService_0:HasTag(v66, "TiledImageLabel") then
                l_CollectionService_0:AddTag(v66, "TiledImageLabel");
            end;
            for _, v68 in ipairs(v66:GetChildren()) do
                v65(v68);
            end;
        end;
        if l_l_PlayerGui_0_0:IsA("ImageLabel") and l_l_PlayerGui_0_0.Name == "Pattern" and not l_CollectionService_0:HasTag(l_l_PlayerGui_0_0, "TiledImageLabel") then
            l_CollectionService_0:AddTag(l_l_PlayerGui_0_0, "TiledImageLabel");
        end;
        for _, v70 in ipairs(l_l_PlayerGui_0_0:GetChildren()) do
            v65(v70);
        end;
        l_l_PlayerGui_0_0.DescendantAdded:Connect(v30);
    end;
    l_l_PlayerGui_0_0 = l_Left_0.Buttons:FindFirstChild("Trading");
    if l_l_PlayerGui_0_0 then
        local l_Main_1 = l_l_PlayerGui_0_0:FindFirstChild("Main");
        if l_Main_1 then
            local l_ComingSoon_0 = l_Main_1:FindFirstChild("ComingSoon");
            if l_ComingSoon_0 then
                l_ComingSoon_0:Destroy();
            end;
        end;
    end;
    local v73 = {
        l_Left_0.Buttons, 
        l_Tabs_0:WaitForChild("Menu").Menu.Inner
    };
    local l_Main_2 = l_RightHud_0:FindFirstChild("Main");
    if l_Main_2 then
        local l_ButtonsVertical_0 = l_Main_2:FindFirstChild("ButtonsVertical");
        if l_ButtonsVertical_0 then
            table.insert(v73, l_ButtonsVertical_0);
        end;
    end;
    local v76 = nil;
    local function _(v77) --[[ Line: 219 ]] --[[ Name: resetButton ]]
        -- upvalues: v76 (ref)
        v77.Parent.Main.Icon.UIScale.Scale = 1;
        v76 = nil;
    end;
    for _, v80 in pairs(l_CollectionService_0:GetTagged("Button")) do
        local l_Button_0 = v80:FindFirstChild("Button");
        if l_Button_0 then
            v47(l_Button_0);
        end;
    end;
    for _, v83 in pairs(v73) do
        for _, v85 in ipairs(v83:GetDescendants()) do
            if v85:IsA("TextButton") and v85.Parent:FindFirstChild("Main") then
                v47(v85);
                local v86 = string.split(v85.Parent.Name, "/");
                local l_l_Tabs_0_FirstChild_0 = l_Tabs_0:FindFirstChild(v86[1]);
                v85.Activated:Connect(function() --[[ Line: 240 ]]
                    -- upvalues: v85 (copy), v6 (ref), v76 (ref), l_l_Tabs_0_FirstChild_0 (copy), l_Menus_0 (ref)
                    if v85.Parent.Main:FindFirstChild("ComingSoon") then
                        v6.Fire("Notification", "Coming Soon!", Color3.new(0, 0, 0));
                    end;
                    if v76 then
                        v76.Parent.Main.Icon.UIScale.Scale = 1;
                        v76 = nil;
                    end;
                    v76 = v85;
                    game.TweenService:Create(v85.Parent.UIScale, TweenInfo.new(0.15, Enum.EasingStyle.Back), {
                        Scale = 1.2
                    }):Play();
                    if l_l_Tabs_0_FirstChild_0 then
                        if l_Menus_0 then
                            v6.Fire("OpenStore");
                        else
                            v6.Fire("ToggleMenu", l_l_Tabs_0_FirstChild_0.Name);
                        end;
                        removeTooltip(v85);
                    end;
                end);
                if not v86[2] then
                    setupTooltip(v85, v85.Parent.Name);
                end;
            end;
        end;
    end;
    for _, v89 in ipairs(l_Bottom_0:GetChildren()) do
        if v89:IsA("Frame") then
            v47(v89.Button);
        end;
    end;
    v5:BindEvents({
        ScreenGlow = function(...) --[[ Line: 277 ]] --[[ Name: ScreenGlow ]]
            -- upvalues: v6 (ref)
            v6.Fire("ScreenGlow", ...);
        end
    });
    v6.new("ScreenGlow"):Connect(function(v90, v91, v92, v93, v94) --[[ Line: 282 ]]
        -- upvalues: l_ScreenGlow_0 (ref), v4 (ref), v7 (ref), l_UI_0 (ref)
        local v95 = nil;
        local v96 = l_ScreenGlow_0.Template:Clone();
        v96.Name = "dobdev :)";
        v96.ImageTransparency = 1;
        v96.Visible = true;
        v96.Parent = v94 or l_ScreenGlow_0;
        if typeof(v90) == "Color3" then
            v96.ImageColor3 = v90;
        end;
        if typeof(v90) == "Instance" then
            v96.UIGradient:Destroy();
            v95 = v90:Clone();
            v95.Parent = v96;
            if v90.Parent.Name == "Rainbow" or v90:GetAttribute("Rainbow") == true then
                v95.Rotation = 45;
                v4:Add(v95);
            else
                v7:Tween(v95, (v91 or 1) + (v93 or 0.4), "Sine", "In", {
                    Rotation = v95.Rotation + 360
                });
            end;
        end;
        if v90 == "Rainbow" then
            v96.UIGradient:Destroy();
            v95 = l_UI_0.OverlayTags.Rainbow.UIGradient:Clone();
            v95.Rotation = 45;
            v95.Enabled = true;
            v95.Parent = v96;
            v4:Add(v95);
        end;
        v7:Tween(v96, v93 or 0.4, "Quad", "InOut", {
            ImageTransparency = v92 or 0.2
        }, nil, nil, function() --[[ Line: 318 ]]
            -- upvalues: v7 (ref), v96 (copy), v91 (copy), v95 (ref), v4 (ref)
            v7:Tween(v96, v91 or 1, "Sine", "Out", {
                ImageTransparency = 1
            });
            task.wait(v91 or 1);
            v96:Destroy();
            if v95 then
                v4:Remove(v95);
            end;
        end);
    end);
    v6.new("InitButtonList"):Connect(function(v97) --[[ Line: 331 ]]
        -- upvalues: v7 (ref)
        local v98 = nil;
        local v99 = nil;
        local v100 = nil;
        for _, v102 in ipairs(v97:GetChildren()) do
            if v102:IsA("Frame") then
                if v102.ZIndex >= 2 then
                    v99 = v102.Size;
                    v98 = v102;
                else
                    v100 = v102.Size;
                end;
                v102.Button.Activated:Connect(function() --[[ Line: 344 ]]
                    -- upvalues: v98 (ref), v102 (copy), v7 (ref), v99 (ref), v100 (ref)
                    if v98 ~= v102 then
                        v102.ZIndex = 2;
                        v102.Shape2.ZIndex = 2;
                        v7:Tween(v102, 0.15, "Quad", "Out", {
                            Size = v99
                        });
                        v102.BackgroundColor3 = v102:GetAttribute("Selected") or Color3.fromRGB(49, 175, 255);
                        v102.Shape2.BackgroundColor3 = v102.BackgroundColor3;
                        v98.ZIndex = 0;
                        v98.Shape2.ZIndex = 0;
                        v7:Tween(v98, 0.2, "Sine", "Out", {
                            Size = v100
                        });
                        v98.BackgroundColor3 = Color3.fromRGB(40, 153, 239);
                        v98.Shape2.BackgroundColor3 = v98.BackgroundColor3;
                        v98 = v102;
                    end;
                end);
            end;
        end;
    end);
    v6.new("InitButton"):Connect(function(...) --[[ Line: 367 ]]
        -- upvalues: v47 (ref)
        v47(...);
    end);
    v6.new("Tooltip"):Connect(function(...) --[[ Line: 371 ]]
        setupTooltip(...);
    end);
    v6.new("RemoveTooltip"):Connect(function(...) --[[ Line: 375 ]]
        removeTooltip(...);
    end);
    l_UIStroke_0:Init(l_Game_0);
    l_TapButton_0:Init(l_Game_0);
    l_Menus_0:Init();
    l_Currency_0:Init(l_Left_0);
    l_Notifications_0:Init(l_Game_0);
    l_Transaction_0:Init(l_PlayerGui_0);
    l_BuyMenu_0:Init();
end;
return v27;