local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local l_SoundService_0 = game:GetService("SoundService");
local l_Modules_0 = l_ReplicatedStorage_0.Modules;
local v5 = require(l_Modules_0.Network);
local v6 = require(l_Modules_0.Tweens);
local v7 = require(l_ReplicatedStorage_0.Game.Maid);
local v8 = require(l_Modules_0.AdminRoles);
local v9 = {};
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v11 = v7.new();
local v12 = require(script.Events);
local l_Sound_0 = Instance.new("Sound");
l_Sound_0.SoundId = "rbxassetid://133946740322185";
l_Sound_0.Volume = 0.3;
l_Sound_0.Parent = l_SoundService_0;
v9.AnnoucementSound = l_Sound_0;
v9.SetupUi = function(_, v15) --[[ Line: 28 ]] --[[ Name: SetupUi ]]
    -- upvalues: v8 (copy), l_LocalPlayer_0 (copy), v11 (copy), v5 (copy)
    if not v8.isDeveloper(l_LocalPlayer_0) then
        return;
    else
        if not v15 then
            v15 = script.AdminAbuseConsole:Clone();
            v15.Parent = l_LocalPlayer_0.PlayerGui;
            v15.Enabled = true;
            v15.Menu.Visible = false;
            v11:GiveInstance(v15);
            v11:GiveConnection(v15.Menu.Close.Button.Activated:Connect(function() --[[ Line: 38 ]]
                -- upvalues: v15 (ref)
                v15.Menu.Visible = false;
            end));
            local l_Buttons_0 = l_LocalPlayer_0.PlayerGui:WaitForChild("Game"):WaitForChild("Left"):WaitForChild("Buttons");
            if not l_Buttons_0:FindFirstChild("AdminAbuseButton") then
                local v17 = script.AdminAbuseButton:Clone();
                v17.Parent = l_Buttons_0;
                v17.Visible = true;
                v11:GiveInstance(v17);
                v11:GiveConnection(v17.Button.Activated:Connect(function() --[[ Line: 50 ]]
                    -- upvalues: v15 (ref)
                    v15.Menu.Visible = not v15.Menu.Visible;
                end));
            end;
        end;
        local v18 = v5:InvokeServer("AdminAbuse_GetAllCommands");
        if not v18 then
            return;
        else
            local l_List_0 = v15.Menu.Categories:FindFirstChild("Commands").List;
            if not l_List_0 then
                warn("CommandsList not found in AdminAbuseConsole UI!");
                return;
            else
                local l_List_1 = v15.Menu.Categories:FindFirstChild("Options").List;
                if not l_List_1 then
                    warn("OptionsList not found in AdminAbuseConsole UI!");
                    return;
                else
                    local v21 = nil;
                    local v22 = {};
                    local v23 = nil;
                    local function v62(v24, v25, v26, v27, v28) --[[ Line: 69 ]] --[[ Name: DisplayCommandOptions ]]
                        -- upvalues: l_List_1 (copy), v21 (ref), v22 (ref), v23 (ref)
                        for _, v30 in l_List_1:GetChildren() do
                            if (v30:IsA("TextBox") or v30:IsA("Frame")) and v30.Name ~= "Title" and v30.Name ~= "Templates" then
                                v30:Destroy();
                            end;
                        end;
                        v21 = v24;
                        v22 = v25;
                        v23 = v26;
                        local l_Title_0 = l_List_1:FindFirstChild("Title");
                        if l_Title_0 then
                            l_Title_0.Visible = true;
                            if v28 then
                                l_Title_0.BackgroundColor3 = v28;
                            end;
                            local l_TextLabel_0 = l_Title_0:FindFirstChild("TextLabel");
                            if l_TextLabel_0 and v27 then
                                l_TextLabel_0.Text = v27;
                            end;
                        end;
                        local v33 = false;
                        if type(v25) == "table" then
                            v33 = false;
                            if #v25 > 0 then
                                v33 = type(v25[1]) == "table";
                            end;
                        end;
                        if v33 then
                            for _, v35 in ipairs(v25) do
                                for v36, v37 in pairs(v35) do
                                    local v38 = l_List_1.Templates.Template:Clone();
                                    v38.Parent = l_List_1;
                                    v38.Visible = true;
                                    v38.Name = v36;
                                    v38.ClearTextOnFocus = false;
                                    v38.MultiLine = false;
                                    v38.TextWrapped = false;
                                    v38.ClipsDescendants = false;
                                    v38.TextScaled = true;
                                    v38.PlaceholderText = v36:sub(1, 1):upper() .. v36:sub(2) .. " (" .. v37 .. ")";
                                    v38.Text = "";
                                    if v37 == "boolean" then
                                        v38.PlaceholderText = v36 .. " (true/false)";
                                    end;
                                    if v26 and v26[v36] then
                                        local l_Frame_0 = Instance.new("Frame");
                                        l_Frame_0.Name = v36 .. "_QuickSelect";
                                        l_Frame_0.Size = UDim2.new(1, 0, 0.08, 0);
                                        l_Frame_0.BackgroundTransparency = 1;
                                        l_Frame_0.Parent = l_List_1;
                                        local l_UIListLayout_0 = Instance.new("UIListLayout");
                                        l_UIListLayout_0.FillDirection = Enum.FillDirection.Horizontal;
                                        l_UIListLayout_0.HorizontalAlignment = Enum.HorizontalAlignment.Center;
                                        l_UIListLayout_0.SortOrder = Enum.SortOrder.LayoutOrder;
                                        l_UIListLayout_0.Padding = UDim.new(0.05, 0);
                                        l_UIListLayout_0.Parent = l_Frame_0;
                                        for _, v42 in ipairs(v26[v36]) do
                                            local l_TextButton_0 = Instance.new("TextButton");
                                            l_TextButton_0.Name = "Quick_" .. tostring(v42);
                                            l_TextButton_0.LayoutOrder = v42;
                                            l_TextButton_0.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                                            l_TextButton_0.Size = UDim2.new(0.25, 0, 1, 0);
                                            l_TextButton_0.BorderSizePixel = 0;
                                            l_TextButton_0.Text = "";
                                            l_TextButton_0.Parent = l_Frame_0;
                                            local l_UIGradient_0 = Instance.new("UIGradient");
                                            l_UIGradient_0.Color = ColorSequence.new({
                                                ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 255, 0)), 
                                                ColorSequenceKeypoint.new(1, Color3.fromRGB(98, 255, 0))
                                            });
                                            l_UIGradient_0.Rotation = 90;
                                            l_UIGradient_0.Parent = l_TextButton_0;
                                            local l_UIStroke_0 = Instance.new("UIStroke");
                                            l_UIStroke_0.Color = Color3.fromRGB(0, 85, 0);
                                            l_UIStroke_0.Thickness = 2;
                                            l_UIStroke_0.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                                            l_UIStroke_0.Parent = l_TextButton_0;
                                            local l_UICorner_0 = Instance.new("UICorner");
                                            l_UICorner_0.CornerRadius = UDim.new(0, 4);
                                            l_UICorner_0.Parent = l_TextButton_0;
                                            local l_TextLabel_1 = Instance.new("TextLabel");
                                            l_TextLabel_1.Name = "Label";
                                            l_TextLabel_1.Size = UDim2.new(0.8, 0, 0.8, 0);
                                            l_TextLabel_1.AnchorPoint = Vector2.new(0.5, 0.5);
                                            l_TextLabel_1.Position = UDim2.new(0.5, 0, 0.5, 0);
                                            l_TextLabel_1.BackgroundTransparency = 1;
                                            l_TextLabel_1.Text = tostring(v42) .. "x";
                                            l_TextLabel_1.TextColor3 = Color3.fromRGB(255, 255, 255);
                                            l_TextLabel_1.TextScaled = true;
                                            l_TextLabel_1.Font = Enum.Font.GothamBold;
                                            l_TextLabel_1.Parent = l_TextButton_0;
                                            local l_UIStroke_1 = Instance.new("UIStroke");
                                            l_UIStroke_1.Color = Color3.fromRGB(0, 80, 0);
                                            l_UIStroke_1.Thickness = 2;
                                            l_UIStroke_1.Parent = l_TextLabel_1;
                                            l_TextButton_0.Activated:Connect(function() --[[ Line: 180 ]]
                                                -- upvalues: v38 (copy), v42 (copy)
                                                v38.Text = tostring(v42);
                                            end);
                                        end;
                                    end;
                                end;
                            end;
                            return;
                        else
                            for v49, v50 in pairs(v25) do
                                local v51 = l_List_1.Templates.Template:Clone();
                                v51.Parent = l_List_1;
                                v51.Visible = true;
                                v51.Name = v49;
                                v51.ClearTextOnFocus = false;
                                v51.MultiLine = false;
                                v51.TextWrapped = false;
                                v51.ClipsDescendants = false;
                                v51.TextScaled = true;
                                v51.PlaceholderText = v49:sub(1, 1):upper() .. v49:sub(2) .. " (" .. v50 .. ")";
                                v51.Text = "";
                                if v50 == "boolean" then
                                    v51.PlaceholderText = v49 .. " (true/false)";
                                end;
                                if v26 and v26[v49] then
                                    local l_Frame_1 = Instance.new("Frame");
                                    l_Frame_1.Name = v49 .. "_QuickSelect";
                                    l_Frame_1.Size = UDim2.new(1, 0, 0, 30);
                                    l_Frame_1.BackgroundTransparency = 1;
                                    l_Frame_1.Parent = l_List_1;
                                    local l_UIListLayout_1 = Instance.new("UIListLayout");
                                    l_UIListLayout_1.FillDirection = Enum.FillDirection.Horizontal;
                                    l_UIListLayout_1.HorizontalAlignment = Enum.HorizontalAlignment.Center;
                                    l_UIListLayout_1.SortOrder = Enum.SortOrder.LayoutOrder;
                                    l_UIListLayout_1.Padding = UDim.new(0.2, 0);
                                    l_UIListLayout_1.Parent = l_Frame_1;
                                    for _, v55 in ipairs(v26[v49]) do
                                        local l_TextButton_1 = Instance.new("TextButton");
                                        l_TextButton_1.Name = "Quick_" .. tostring(v55);
                                        l_TextButton_1.LayoutOrder = v55;
                                        l_TextButton_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                                        l_TextButton_1.Size = UDim2.new(0.25, 0, 1, 0);
                                        l_TextButton_1.BorderSizePixel = 0;
                                        l_TextButton_1.Text = "";
                                        l_TextButton_1.Parent = l_Frame_1;
                                        local l_UIGradient_1 = Instance.new("UIGradient");
                                        l_UIGradient_1.Color = ColorSequence.new({
                                            ColorSequenceKeypoint.new(0, Color3.fromRGB(220, 255, 0)), 
                                            ColorSequenceKeypoint.new(1, Color3.fromRGB(98, 255, 0))
                                        });
                                        l_UIGradient_1.Rotation = 90;
                                        l_UIGradient_1.Parent = l_TextButton_1;
                                        local l_UIStroke_2 = Instance.new("UIStroke");
                                        l_UIStroke_2.Color = Color3.fromRGB(0, 59, 0);
                                        l_UIStroke_2.Thickness = 3;
                                        l_UIStroke_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                                        l_UIStroke_2.Parent = l_TextButton_1;
                                        local l_UICorner_1 = Instance.new("UICorner");
                                        l_UICorner_1.CornerRadius = UDim.new(0, 4);
                                        l_UICorner_1.Parent = l_TextButton_1;
                                        local l_TextLabel_2 = Instance.new("TextLabel");
                                        l_TextLabel_2.Name = "Label";
                                        l_TextLabel_2.Size = UDim2.new(1, 0, 1, 0);
                                        l_TextLabel_2.BackgroundTransparency = 1;
                                        l_TextLabel_2.Text = tostring(v55) .. "x";
                                        l_TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255);
                                        l_TextLabel_2.TextSize = 14;
                                        l_TextLabel_2.Font = Enum.Font.GothamBold;
                                        l_TextLabel_2.Parent = l_TextButton_1;
                                        local l_UIStroke_3 = Instance.new("UIStroke");
                                        l_UIStroke_3.Color = Color3.fromRGB(0, 80, 0);
                                        l_UIStroke_3.Thickness = 2;
                                        l_UIStroke_3.Parent = l_TextLabel_2;
                                        l_TextButton_1.Activated:Connect(function() --[[ Line: 269 ]]
                                            -- upvalues: v51 (copy), v55 (copy)
                                            v51.Text = tostring(v55);
                                        end);
                                    end;
                                end;
                            end;
                            return;
                        end;
                    end;
                    for v63, v64 in ipairs(v18) do
                        local v65 = l_List_0.Templates.Template:Clone();
                        v65.Parent = l_List_0;
                        v65.Visible = true;
                        v65.TextLabel.Text = v64.Name;
                        v65.Name = v64.Key;
                        v65.LayoutOrder = v64.LayoutOrder or v63;
                        if v64.Color then
                            local l_UIGradient_2 = v65:FindFirstChildOfClass("UIGradient");
                            if l_UIGradient_2 then
                                local v67, v68, v69 = v64.Color:ToHSV();
                                local v70 = Color3.fromHSV(v67, v68, (math.max(0, v69 - 0.2)));
                                l_UIGradient_2.Color = ColorSequence.new({
                                    ColorSequenceKeypoint.new(0, v64.Color), 
                                    ColorSequenceKeypoint.new(1, v70)
                                });
                            else
                                v65.BackgroundColor3 = v64.Color;
                            end;
                            local l_TextLabel_3 = v65:FindFirstChild("TextLabel");
                            if l_TextLabel_3 then
                                local l_UIStroke_4 = l_TextLabel_3:FindFirstChildOfClass("UIStroke");
                                if l_UIStroke_4 then
                                    local v73, v74, v75 = v64.Color:ToHSV();
                                    l_UIStroke_4.Color = Color3.fromHSV(v73, math.min(1, v74 + 0.2), (math.max(0, v75 * 0.3)));
                                end;
                            end;
                        end;
                        v11:GiveInstance(v65);
                        v65.Activated:Connect(function() --[[ Line: 315 ]]
                            -- upvalues: v62 (copy), v64 (copy)
                            v62(v64.Key, v64.Options, v64.QuickSelect, v64.Name, v64.Color);
                        end);
                    end;
                    v11:GiveCallback(function() --[[ Line: 320 ]]
                        -- upvalues: l_List_1 (copy)
                        for _, v77 in l_List_1:GetChildren() do
                            if v77:IsA("TextBox") then
                                v77:Destroy();
                            end;
                        end;
                    end);
                    local function v85(v78, v79, v80) --[[ Line: 328 ]] --[[ Name: AddButton ]]
                        -- upvalues: l_List_1 (copy)
                        local l_l_List_1_FirstChild_0 = l_List_1:FindFirstChild(v78);
                        if l_l_List_1_FirstChild_0 and l_l_List_1_FirstChild_0:IsA("TextBox") then
                            local l_Text_0 = l_l_List_1_FirstChild_0.Text;
                            if l_Text_0 == "" then
                                table.insert(v80, nil);
                                return;
                            elseif v79 == "boolean" then
                                local v83 = l_Text_0:lower();
                                local v84 = true;
                                if v83 ~= "true" then
                                    v84 = true;
                                    if v83 ~= "1" then
                                        v84 = true;
                                        if v83 ~= "yes" then
                                            v84 = true;
                                            if v83 ~= "on" then
                                                v84 = v83 == "enabled";
                                            end;
                                        end;
                                    end;
                                end;
                                table.insert(v80, v84);
                                return;
                            elseif v79 == "number" then
                                table.insert(v80, (tonumber(l_Text_0)));
                                return;
                            else
                                table.insert(v80, l_Text_0);
                                return;
                            end;
                        else
                            table.insert(v80, nil);
                            return;
                        end;
                    end;
                    local function v94() --[[ Line: 349 ]] --[[ Name: CollectOptionValues ]]
                        -- upvalues: v22 (ref), v85 (copy)
                        local v86 = {};
                        local v87 = false;
                        if type(v22) == "table" then
                            v87 = false;
                            if #v22 > 0 then
                                v87 = type(v22[1]) == "table";
                            end;
                        end;
                        if v87 then
                            for _, v89 in ipairs(v22) do
                                for v90, v91 in pairs(v89) do
                                    v85(v90, v91, v86);
                                end;
                            end;
                            return v86;
                        else
                            for v92, v93 in pairs(v22) do
                                v85(v92, v93, v86);
                            end;
                            return v86;
                        end;
                    end;
                    v11:GiveConnection(l_List_1.ExecuteCommand.Activated:Connect(function() --[[ Line: 368 ]]
                        -- upvalues: v21 (ref), v94 (copy), v5 (ref)
                        if not v21 then
                            return;
                        else
                            local v95 = v94();
                            v5:InvokeServer("AdminAbuse_ExecuteCommand", v21, table.unpack(v95));
                            return;
                        end;
                    end));
                    v11:GiveConnection(l_List_1.EndEarly.Activated:Connect(function() --[[ Line: 374 ]]
                        -- upvalues: v21 (ref), v5 (ref)
                        if not v21 then
                            return;
                        else
                            v5:InvokeServer("AdminAbuse_EndEventEarly", v21);
                            return;
                        end;
                    end));
                    return;
                end;
            end;
        end;
    end;
end;
v9.DisplayGlobalMessage = function(_, v97, v98, _, v100, v101) --[[ Line: 380 ]] --[[ Name: DisplayGlobalMessage ]]
    -- upvalues: v9 (copy), l_LocalPlayer_0 (copy), v11 (copy), l_TweenService_0 (copy)
    v97 = v97 or "";
    v98 = v98 or Color3.fromRGB(255, 255, 255);
    v100 = v100 or 5;
    if v9.AnnoucementSound then
        v9.AnnoucementSound:Play();
    end;
    local l_PlayerGui_0 = l_LocalPlayer_0.PlayerGui;
    local l_GlobalMessage_0 = l_PlayerGui_0:FindFirstChild("GlobalMessage");
    if not l_GlobalMessage_0 then
        l_GlobalMessage_0 = script.GlobalMessage:Clone();
        l_GlobalMessage_0.Parent = l_PlayerGui_0;
        v11:GiveInstance(l_GlobalMessage_0);
    end;
    local v104 = l_GlobalMessage_0.Templates:FindFirstChild("GlobalMessage"):Clone();
    local v105 = nil;
    for _, v107 in ipairs(l_GlobalMessage_0.Frame:GetChildren()) do
        if v107:IsA("Frame") and v107:GetAttribute("IsGlobalMessage") then
            local l_LayoutOrder_0 = v107.LayoutOrder;
            if v105 == nil or v105 < l_LayoutOrder_0 then
                v105 = l_LayoutOrder_0;
            end;
        end;
    end;
    if v105 == nil then
        v104.LayoutOrder = 0;
    else
        v104.LayoutOrder = v105 - 1;
    end;
    v104:SetAttribute("IsGlobalMessage", true);
    v104.Parent = l_GlobalMessage_0.Frame;
    v104.Visible = true;
    v11:GiveInstance(v104);
    local l_TextLabel_4 = v104:FindFirstChild("TextLabel");
    if not l_TextLabel_4 then
        return;
    else
        l_TextLabel_4.Text = "";
        l_TextLabel_4.TextColor3 = v98;
        l_TextLabel_4.TextTransparency = 0;
        l_TextLabel_4.TextStrokeTransparency = 0.5;
        v104.BackgroundTransparency = 0.5;
        local l_v97_0 = v97;
        local v111 = "";
        task.spawn(function() --[[ Line: 435 ]]
            -- upvalues: l_v97_0 (copy), v111 (ref), l_TextLabel_4 (copy), v100 (ref), l_TweenService_0 (ref), v104 (copy), v101 (copy)
            for v112 = 1, #l_v97_0 do
                v111 = string.sub(l_v97_0, 1, v112);
                l_TextLabel_4.Text = v111;
                task.wait(0.03);
            end;
            task.wait(v100);
            local v113 = l_TweenService_0:Create(v104, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                BackgroundTransparency = 1
            });
            local v114 = l_TweenService_0:Create(l_TextLabel_4, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
                TextTransparency = 1, 
                TextStrokeTransparency = 1
            });
            v113:Play();
            v114:Play();
            v114.Completed:Connect(function() --[[ Line: 459 ]]
                -- upvalues: v104 (ref), l_TextLabel_4 (ref), v101 (ref)
                v104.Visible = false;
                v104.BackgroundTransparency = 0.5;
                l_TextLabel_4.TextTransparency = 0;
                l_TextLabel_4.TextStrokeTransparency = 0.5;
                v104:Destroy();
                if v101 then
                    v101();
                end;
            end);
        end);
        return;
    end;
end;
v9.SetNightTime = function(_) --[[ Line: 475 ]] --[[ Name: SetNightTime ]]
    local l_Lighting_0 = game:GetService("Lighting");
    _G.AdminNightTimeActive = true;
    l_Lighting_0.ClockTime = 0;
end;
v9.DanceCrabs = function(_, v118) --[[ Line: 483 ]] --[[ Name: DanceCrabs ]]
    -- upvalues: v6 (copy)
    local l_ColorCorrection_0 = game.Lighting.ColorCorrection;
    local l_CurrentCamera_0 = workspace.CurrentCamera;
    v6:Tween(l_ColorCorrection_0, 0.5, "Quad", "Out", {
        Saturation = 1
    });
    v6:Tween(l_CurrentCamera_0, 0.5, "Quad", "Out", {
        FieldOfView = 90
    });
    task.delay(10, function() --[[ Line: 489 ]]
        -- upvalues: v6 (ref), l_ColorCorrection_0 (copy), l_CurrentCamera_0 (copy)
        v6:Tween(l_ColorCorrection_0, 0.25, "Quad", "Out", {
            Saturation = 0.5
        });
        v6:Tween(l_CurrentCamera_0, 0.25, "Quad", "Out", {
            FieldOfView = 70
        });
    end);
    for _, v122 in v118 do
        task.spawn(function() --[[ Line: 495 ]]
            -- upvalues: v122 (copy), v6 (ref)
            local v123 = v122:Clone();
            v122:Destroy();
            v123.Parent = workspace;
            local l_PrimaryPart_0 = v123.PrimaryPart;
            if not l_PrimaryPart_0 then
                v123:Destroy();
                return;
            else
                local l_v123_Pivot_0 = v123:GetPivot();
                local v126 = Vector3.new(l_v123_Pivot_0:ToOrientation());
                local v127 = CFrame.new(l_v123_Pivot_0.p) * CFrame.Angles(0, v126.Y, 0);
                local v128 = true;
                task.delay(math.random() * 2, function() --[[ Line: 510 ]]
                    -- upvalues: l_PrimaryPart_0 (copy), v128 (ref), v127 (copy), v6 (ref)
                    l_PrimaryPart_0.Anchored = true;
                    l_PrimaryPart_0.CanCollide = false;
                    while v128 do
                        local v129 = 8 + math.random() * 5;
                        local v130 = v127 + Vector3.new(0, v129, 0);
                        v6:Tween(l_PrimaryPart_0, 0.25, "Quad", "Out", {
                            CFrame = v130
                        });
                        task.wait(0.25);
                        v6:Tween(l_PrimaryPart_0, 0.25, "Quad", "Out", {
                            CFrame = v127
                        });
                        task.wait(0.25);
                    end;
                end);
                task.wait(10);
                v128 = false;
                task.wait(0.5);
                local v131 = math.random(0, 1) * 2 - 1;
                local v132 = (5 + math.random() * 5) * v131;
                local v133 = math.random(0, 1) * 2 - 1;
                local v134 = (5 + math.random() * 5) * v133;
                local v135 = 10 + math.random() * 5;
                local v136 = Vector3.new(v132 * 0.003, v135 * 0.003, v134 * 0.003);
                if v123.PrimaryPart then
                    v123.PrimaryPart.Anchored = false;
                    v123.PrimaryPart:ApplyImpulse(v136);
                end;
                task.delay(5, function() --[[ Line: 544 ]]
                    -- upvalues: v123 (copy)
                    v123:Destroy();
                end);
                return;
            end;
        end);
    end;
end;
v9.Init = function(_) --[[ Line: 551 ]] --[[ Name: Init ]]
    -- upvalues: v9 (copy), v5 (copy), v12 (copy), v8 (copy), l_LocalPlayer_0 (copy), v11 (copy)
    _G.DisplayGlobalMessage = function(...) --[[ Line: 552 ]]
        -- upvalues: v9 (ref)
        v9:DisplayGlobalMessage(...);
    end;
    v5:BindEvents({
        GlobalMessage = function(v138, v139, v140, v141, v142) --[[ Line: 556 ]] --[[ Name: GlobalMessage ]]
            -- upvalues: v9 (ref)
            v9:DisplayGlobalMessage(v138, v139, v140, v141, v142);
        end, 
        DanceCrabs = function(v143) --[[ Line: 559 ]] --[[ Name: DanceCrabs ]]
            -- upvalues: v9 (ref)
            v9:DanceCrabs(v143);
        end, 
        AdminAbuse_NewYears = function(_) --[[ Line: 562 ]] --[[ Name: AdminAbuse_NewYears ]]
            -- upvalues: v12 (ref)
            v12:StartEvent("NewYearsEvent");
        end, 
        AdminAbuse_SetNightTime = function(_) --[[ Line: 565 ]] --[[ Name: AdminAbuse_SetNightTime ]]
            -- upvalues: v9 (ref)
            v9:SetNightTime();
        end
    });
    if not v8.isDeveloper(l_LocalPlayer_0, true) then
        return;
    else
        task.spawn(function() --[[ Line: 575 ]]
            -- upvalues: l_LocalPlayer_0 (ref), v11 (ref), v9 (ref)
            local v146 = script.AdminAbuseConsole:Clone();
            v146.Parent = l_LocalPlayer_0.PlayerGui;
            v146.Enabled = true;
            v146.Menu.Visible = false;
            v11:GiveInstance(v146);
            local v147 = script.AdminAbuseButton:Clone();
            v147.Parent = l_LocalPlayer_0.PlayerGui:WaitForChild("Game"):WaitForChild("Left"):WaitForChild("Buttons");
            v147.Visible = true;
            v11:GiveInstance(v147);
            v9:SetupUi(v146);
            v11:GiveConnection(v146.Menu.Close.Button.Activated:Connect(function() --[[ Line: 589 ]]
                -- upvalues: v146 (copy)
                v146.Menu.Visible = false;
            end));
            v11:GiveConnection(v147.Button.Activated:Connect(function() --[[ Line: 593 ]]
                -- upvalues: v146 (copy)
                v146.Menu.Visible = not v146.Menu.Visible;
            end));
        end);
        return;
    end;
end;
return v9;