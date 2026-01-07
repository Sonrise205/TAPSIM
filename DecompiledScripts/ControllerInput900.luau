local l_Players_0 = game:GetService("Players");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_GuiService_0 = game:GetService("GuiService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local v4 = require(l_ReplicatedStorage_0.Modules.Signal);
local l_PlayerGui_0 = l_Players_0.LocalPlayer:WaitForChild("PlayerGui");
local function v8(v6) --[[ Line: 16 ]] --[[ Name: getButtonString ]]
    -- upvalues: l_UserInputService_0 (copy)
    local l_l_UserInputService_0_StringForKeyCode_0 = l_UserInputService_0:GetStringForKeyCode(v6);
    if l_l_UserInputService_0_StringForKeyCode_0 and l_l_UserInputService_0_StringForKeyCode_0 ~= "" then
        return l_l_UserInputService_0_StringForKeyCode_0;
    else
        return ({
            [Enum.KeyCode.ButtonY] = "Y", 
            [Enum.KeyCode.ButtonX] = "X", 
            [Enum.KeyCode.ButtonA] = "A", 
            [Enum.KeyCode.ButtonB] = "B", 
            [Enum.KeyCode.ButtonL1] = "LB", 
            [Enum.KeyCode.ButtonR1] = "RB", 
            [Enum.KeyCode.ButtonL2] = "LT", 
            [Enum.KeyCode.ButtonR2] = "RT", 
            [Enum.KeyCode.ButtonSelect] = "Select", 
            [Enum.KeyCode.ButtonStart] = "Start", 
            [Enum.KeyCode.DPadUp] = "D-Up", 
            [Enum.KeyCode.DPadDown] = "D-Down", 
            [Enum.KeyCode.DPadLeft] = "D-Left", 
            [Enum.KeyCode.DPadRight] = "D-Right"
        })[v6] or v6.Name;
    end;
end;
local function _(v9) --[[ Line: 44 ]] --[[ Name: getButtonImage ]]
    -- upvalues: l_UserInputService_0 (copy)
    local l_l_UserInputService_0_ImageForKeyCode_0 = l_UserInputService_0:GetImageForKeyCode(v9);
    if l_l_UserInputService_0_ImageForKeyCode_0 and l_l_UserInputService_0_ImageForKeyCode_0 ~= "" then
        return l_l_UserInputService_0_ImageForKeyCode_0;
    else
        return nil;
    end;
end;
local v12 = {
    [Enum.KeyCode.ButtonY] = "OpenInventory", 
    [Enum.KeyCode.ButtonX] = "ToggleAutoClicker", 
    [Enum.KeyCode.ButtonB] = "CloseMenu", 
    [Enum.KeyCode.ButtonL1] = "PreviousTab", 
    [Enum.KeyCode.ButtonR1] = "NextTab"
};
local v13 = {};
local v14 = {};
local v15 = false;
local v16 = false;
local v17 = nil;
local v18 = nil;
local v19 = nil;
local v20 = {};
local v21 = nil;
local v22 = nil;
v20.CreateKeybindLabel = function(_, v24, v25, v26) --[[ Line: 80 ]] --[[ Name: CreateKeybindLabel ]]
    -- upvalues: l_UserInputService_0 (copy), v15 (ref), v8 (copy)
    if not v24 or not v25 then
        return nil;
    else
        local l_l_UserInputService_0_ImageForKeyCode_1 = l_UserInputService_0:GetImageForKeyCode(v25);
        local v28 = if l_l_UserInputService_0_ImageForKeyCode_1 and l_l_UserInputService_0_ImageForKeyCode_1 ~= "" then l_l_UserInputService_0_ImageForKeyCode_1 else nil;
        l_l_UserInputService_0_ImageForKeyCode_1 = Instance.new("ImageLabel");
        l_l_UserInputService_0_ImageForKeyCode_1.Name = "ControllerKeybind";
        l_l_UserInputService_0_ImageForKeyCode_1.Size = UDim2.new(0, 32, 0, 32);
        l_l_UserInputService_0_ImageForKeyCode_1.Position = v26 or UDim2.new(1, -2, 0, -2);
        l_l_UserInputService_0_ImageForKeyCode_1.AnchorPoint = Vector2.new(1, 0);
        l_l_UserInputService_0_ImageForKeyCode_1.BackgroundTransparency = 1;
        l_l_UserInputService_0_ImageForKeyCode_1.BorderSizePixel = 0;
        l_l_UserInputService_0_ImageForKeyCode_1.ZIndex = 100;
        l_l_UserInputService_0_ImageForKeyCode_1.Visible = v15;
        l_l_UserInputService_0_ImageForKeyCode_1.ScaleType = Enum.ScaleType.Fit;
        l_l_UserInputService_0_ImageForKeyCode_1.Parent = v24;
        if v28 then
            l_l_UserInputService_0_ImageForKeyCode_1.Image = v28;
            return l_l_UserInputService_0_ImageForKeyCode_1;
        else
            l_l_UserInputService_0_ImageForKeyCode_1:Destroy();
            local l_TextLabel_0 = Instance.new("TextLabel");
            l_TextLabel_0.Name = "ControllerKeybind";
            l_TextLabel_0.Size = UDim2.new(0, 28, 0, 28);
            l_TextLabel_0.Position = v26 or UDim2.new(1, -2, 0, -2);
            l_TextLabel_0.AnchorPoint = Vector2.new(1, 0);
            l_TextLabel_0.BackgroundColor3 = Color3.fromRGB(30, 30, 30);
            l_TextLabel_0.BackgroundTransparency = 0.2;
            l_TextLabel_0.BorderSizePixel = 0;
            l_TextLabel_0.Font = Enum.Font.GothamBold;
            l_TextLabel_0.Text = v8(v25);
            l_TextLabel_0.TextColor3 = Color3.fromRGB(255, 255, 255);
            l_TextLabel_0.TextScaled = true;
            l_TextLabel_0.ZIndex = 100;
            l_TextLabel_0.Visible = v15;
            l_TextLabel_0.Parent = v24;
            local l_UICorner_0 = Instance.new("UICorner");
            l_UICorner_0.CornerRadius = UDim.new(0.3, 0);
            l_UICorner_0.Parent = l_TextLabel_0;
            return l_TextLabel_0;
        end;
    end;
end;
v20.UpdateKeybindVisibility = function(v31, v32, v33) --[[ Line: 132 ]] --[[ Name: UpdateKeybindVisibility ]]
    -- upvalues: v15 (ref), v13 (copy), v14 (copy)
    v15 = v32;
    for _, v35 in pairs(v13) do
        if v35 and v35.Parent then
            v35.Visible = v32;
        end;
    end;
    for _, v37 in pairs(v14) do
        if v37 and v37.Parent then
            v37.Visible = not v32;
        end;
    end;
    v31:UpdateCursorModeHint();
    if v33 then
        v31:AdjustBottomPosition(v33, v32);
    end;
end;
v20.CreateCursorModeHint = function(_, v39) --[[ Line: 157 ]] --[[ Name: CreateCursorModeHint ]]
    -- upvalues: v18 (ref), l_UserInputService_0 (copy), v8 (copy), v15 (ref), v17 (ref)
    if not v39 then
        return nil;
    else
        v18 = v39.Position;
        local l_Parent_0 = v39.Parent;
        if not l_Parent_0 then
            return nil;
        else
            local l_ButtonSelect_0 = Enum.KeyCode.ButtonSelect;
            local l_l_UserInputService_0_ImageForKeyCode_2 = l_UserInputService_0:GetImageForKeyCode(l_ButtonSelect_0);
            local v43 = if l_l_UserInputService_0_ImageForKeyCode_2 and l_l_UserInputService_0_ImageForKeyCode_2 ~= "" then l_l_UserInputService_0_ImageForKeyCode_2 else nil;
            l_ButtonSelect_0 = v8(Enum.KeyCode.ButtonSelect);
            l_l_UserInputService_0_ImageForKeyCode_2 = Instance.new("Frame");
            l_l_UserInputService_0_ImageForKeyCode_2.Name = "CursorModeHint";
            l_l_UserInputService_0_ImageForKeyCode_2.Size = UDim2.new(0, 300, 0, 28);
            l_l_UserInputService_0_ImageForKeyCode_2.Position = UDim2.new(0.5, 0, 1, -5);
            l_l_UserInputService_0_ImageForKeyCode_2.AnchorPoint = Vector2.new(0.5, 1);
            l_l_UserInputService_0_ImageForKeyCode_2.BackgroundColor3 = Color3.fromRGB(20, 20, 20);
            l_l_UserInputService_0_ImageForKeyCode_2.BackgroundTransparency = 0.3;
            l_l_UserInputService_0_ImageForKeyCode_2.BorderSizePixel = 0;
            l_l_UserInputService_0_ImageForKeyCode_2.ZIndex = 100;
            l_l_UserInputService_0_ImageForKeyCode_2.Visible = v15;
            l_l_UserInputService_0_ImageForKeyCode_2.Parent = l_Parent_0;
            local l_UICorner_1 = Instance.new("UICorner");
            l_UICorner_1.CornerRadius = UDim.new(0, 6);
            l_UICorner_1.Parent = l_l_UserInputService_0_ImageForKeyCode_2;
            local l_UIListLayout_0 = Instance.new("UIListLayout");
            l_UIListLayout_0.FillDirection = Enum.FillDirection.Horizontal;
            l_UIListLayout_0.HorizontalAlignment = Enum.HorizontalAlignment.Center;
            l_UIListLayout_0.VerticalAlignment = Enum.VerticalAlignment.Center;
            l_UIListLayout_0.Padding = UDim.new(0, 6);
            l_UIListLayout_0.Parent = l_l_UserInputService_0_ImageForKeyCode_2;
            local l_TextLabel_1 = Instance.new("TextLabel");
            l_TextLabel_1.Name = "PressText";
            l_TextLabel_1.Size = UDim2.new(0, 40, 0, 20);
            l_TextLabel_1.BackgroundTransparency = 1;
            l_TextLabel_1.Font = Enum.Font.FredokaOne;
            l_TextLabel_1.Text = "Press";
            l_TextLabel_1.TextColor3 = Color3.fromRGB(255, 255, 255);
            l_TextLabel_1.TextSize = 14;
            l_TextLabel_1.ZIndex = 101;
            l_TextLabel_1.LayoutOrder = 1;
            l_TextLabel_1.Parent = l_l_UserInputService_0_ImageForKeyCode_2;
            local l_ImageLabel_0 = Instance.new("ImageLabel");
            l_ImageLabel_0.Name = "ButtonIcon";
            l_ImageLabel_0.Size = UDim2.new(0, 24, 0, 24);
            l_ImageLabel_0.BackgroundTransparency = 1;
            l_ImageLabel_0.ScaleType = Enum.ScaleType.Fit;
            l_ImageLabel_0.ZIndex = 101;
            l_ImageLabel_0.LayoutOrder = 2;
            l_ImageLabel_0.Parent = l_l_UserInputService_0_ImageForKeyCode_2;
            if v43 then
                l_ImageLabel_0.Image = v43;
            else
                l_ImageLabel_0.Visible = false;
                local l_TextLabel_2 = Instance.new("TextLabel");
                l_TextLabel_2.Name = "ButtonText";
                l_TextLabel_2.Size = UDim2.new(0, 50, 0, 20);
                l_TextLabel_2.BackgroundTransparency = 1;
                l_TextLabel_2.Font = Enum.Font.FredokaOne;
                l_TextLabel_2.Text = l_ButtonSelect_0;
                l_TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255);
                l_TextLabel_2.TextSize = 14;
                l_TextLabel_2.ZIndex = 101;
                l_TextLabel_2.LayoutOrder = 2;
                l_TextLabel_2.Parent = l_l_UserInputService_0_ImageForKeyCode_2;
            end;
            local l_TextLabel_3 = Instance.new("TextLabel");
            l_TextLabel_3.Name = "ActionText";
            l_TextLabel_3.Size = UDim2.new(0, 160, 0, 20);
            l_TextLabel_3.BackgroundTransparency = 1;
            l_TextLabel_3.Font = Enum.Font.FredokaOne;
            l_TextLabel_3.Text = "to enter cursor mode";
            l_TextLabel_3.TextColor3 = Color3.fromRGB(255, 255, 255);
            l_TextLabel_3.TextSize = 14;
            l_TextLabel_3.ZIndex = 101;
            l_TextLabel_3.LayoutOrder = 3;
            l_TextLabel_3.Parent = l_l_UserInputService_0_ImageForKeyCode_2;
            v17 = l_l_UserInputService_0_ImageForKeyCode_2;
            return l_l_UserInputService_0_ImageForKeyCode_2;
        end;
    end;
end;
v20.UpdateCursorModeHint = function(_) --[[ Line: 256 ]] --[[ Name: UpdateCursorModeHint ]]
    -- upvalues: v17 (ref), v16 (ref), v15 (ref)
    if not v17 then
        return;
    else
        local l_ActionText_0 = v17:FindFirstChild("ActionText");
        if v16 then
            v17.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
            v17.BackgroundTransparency = 0.1;
            if l_ActionText_0 then
                l_ActionText_0.Text = "to exit cursor mode";
                l_ActionText_0.TextColor3 = Color3.fromRGB(30, 30, 30);
            end;
            local l_PressText_0 = v17:FindFirstChild("PressText");
            if l_PressText_0 then
                l_PressText_0.TextColor3 = Color3.fromRGB(30, 30, 30);
            end;
        else
            v17.BackgroundColor3 = Color3.fromRGB(20, 20, 20);
            v17.BackgroundTransparency = 0.3;
            if l_ActionText_0 then
                l_ActionText_0.Text = "to enter cursor mode";
                l_ActionText_0.TextColor3 = Color3.fromRGB(255, 255, 255);
            end;
            local l_PressText_1 = v17:FindFirstChild("PressText");
            if l_PressText_1 then
                l_PressText_1.TextColor3 = Color3.fromRGB(255, 255, 255);
            end;
        end;
        v17.Visible = v15;
        return;
    end;
end;
v20.AdjustBottomPosition = function(_, v55, v56) --[[ Line: 295 ]] --[[ Name: AdjustBottomPosition ]]
    -- upvalues: v18 (ref)
    if not v55 or not v18 then
        return;
    elseif v56 then
        v55.Position = UDim2.new(v18.X.Scale, v18.X.Offset, v18.Y.Scale, v18.Y.Offset - 25);
        return;
    else
        v55.Position = v18;
        return;
    end;
end;
v20.SetupButtonKeybind = function(v57, v58, v59, v60) --[[ Line: 313 ]] --[[ Name: SetupButtonKeybind ]]
    -- upvalues: v13 (copy)
    if not v58 then
        return;
    else
        local l_ControllerKeybind_0 = v58:FindFirstChild("ControllerKeybind");
        if l_ControllerKeybind_0 then
            l_ControllerKeybind_0:Destroy();
        end;
        local l_v57_KeybindLabel_0 = v57:CreateKeybindLabel(v58, v59, v60);
        if l_v57_KeybindLabel_0 then
            table.insert(v13, l_v57_KeybindLabel_0);
        end;
        return l_v57_KeybindLabel_0;
    end;
end;
v20.SetupCloseButtonKeybind = function(_, v64, v65) --[[ Line: 331 ]] --[[ Name: SetupCloseButtonKeybind ]]
    -- upvalues: v14 (copy), v15 (ref), l_UserInputService_0 (copy), v8 (copy), v13 (copy)
    if not v64 then
        return;
    else
        local l_Main_0 = v64:FindFirstChild("Main");
        if l_Main_0 then
            local l_Label_0 = l_Main_0:FindFirstChild("Label");
            if l_Label_0 then
                table.insert(v14, l_Label_0);
                if v15 then
                    l_Label_0.Visible = false;
                end;
            end;
        end;
        local l_ControllerKeybind_1 = v64:FindFirstChild("ControllerKeybind");
        if l_ControllerKeybind_1 then
            l_ControllerKeybind_1:Destroy();
        end;
        local l_l_UserInputService_0_ImageForKeyCode_3 = l_UserInputService_0:GetImageForKeyCode(v65);
        local v70 = if l_l_UserInputService_0_ImageForKeyCode_3 and l_l_UserInputService_0_ImageForKeyCode_3 ~= "" then l_l_UserInputService_0_ImageForKeyCode_3 else nil;
        l_l_UserInputService_0_ImageForKeyCode_3 = Instance.new("ImageLabel");
        l_l_UserInputService_0_ImageForKeyCode_3.Name = "ControllerKeybind";
        l_l_UserInputService_0_ImageForKeyCode_3.Size = UDim2.new(0.8, 0, 0.8, 0);
        l_l_UserInputService_0_ImageForKeyCode_3.Position = UDim2.new(0.5, 0, 0.5, 0);
        l_l_UserInputService_0_ImageForKeyCode_3.AnchorPoint = Vector2.new(0.5, 0.5);
        l_l_UserInputService_0_ImageForKeyCode_3.BackgroundTransparency = 1;
        l_l_UserInputService_0_ImageForKeyCode_3.BorderSizePixel = 0;
        l_l_UserInputService_0_ImageForKeyCode_3.ZIndex = 100;
        l_l_UserInputService_0_ImageForKeyCode_3.Visible = v15;
        l_l_UserInputService_0_ImageForKeyCode_3.ScaleType = Enum.ScaleType.Fit;
        l_l_UserInputService_0_ImageForKeyCode_3.Parent = v64;
        if v70 then
            l_l_UserInputService_0_ImageForKeyCode_3.Image = v70;
            table.insert(v13, l_l_UserInputService_0_ImageForKeyCode_3);
            return l_l_UserInputService_0_ImageForKeyCode_3;
        else
            l_l_UserInputService_0_ImageForKeyCode_3:Destroy();
            local l_TextLabel_4 = Instance.new("TextLabel");
            l_TextLabel_4.Name = "ControllerKeybind";
            l_TextLabel_4.Size = UDim2.new(0.8, 0, 0.8, 0);
            l_TextLabel_4.Position = UDim2.new(0.5, 0, 0.5, 0);
            l_TextLabel_4.AnchorPoint = Vector2.new(0.5, 0.5);
            l_TextLabel_4.BackgroundTransparency = 1;
            l_TextLabel_4.BorderSizePixel = 0;
            l_TextLabel_4.Font = Enum.Font.GothamBold;
            l_TextLabel_4.Text = v8(v65);
            l_TextLabel_4.TextColor3 = Color3.fromRGB(255, 255, 255);
            l_TextLabel_4.TextScaled = true;
            l_TextLabel_4.ZIndex = 100;
            l_TextLabel_4.Visible = v15;
            l_TextLabel_4.Parent = v64;
            table.insert(v13, l_TextLabel_4);
            return l_TextLabel_4;
        end;
    end;
end;
v20.EnableSelection = function(_, v73) --[[ Line: 398 ]] --[[ Name: EnableSelection ]]
    if not v73 then
        return;
    elseif v73:IsA("ScrollingFrame") then
        v73.Selectable = false;
        return;
    else
        v73.Selectable = true;
        return;
    end;
end;
v20.DisableScrollingFrameSelection = function(_, v75) --[[ Line: 412 ]] --[[ Name: DisableScrollingFrameSelection ]]
    if not v75 then
        return;
    else
        for _, v77 in ipairs(v75:GetDescendants()) do
            if v77:IsA("ScrollingFrame") then
                v77.Selectable = false;
            end;
        end;
        return;
    end;
end;
v20.SetupSelectionGroup = function(v78, v79, v80) --[[ Line: 423 ]] --[[ Name: SetupSelectionGroup ]]
    if not v79 then
        return;
    else
        v80 = v80 or "TextButton";
        local v81 = {};
        for _, v83 in ipairs(v79:GetDescendants()) do
            if v83:IsA("ScrollingFrame") then
                v83.Selectable = false;
            elseif v83:IsA(v80) or v83:IsA("ImageButton") then
                v78:EnableSelection(v83);
                table.insert(v81, v83);
            end;
        end;
        return v81;
    end;
end;
v20.IsControllerActive = function(_) --[[ Line: 445 ]] --[[ Name: IsControllerActive ]]
    -- upvalues: v15 (ref)
    return v15;
end;
v20.GetKeybindForAction = function(_, v86) --[[ Line: 450 ]] --[[ Name: GetKeybindForAction ]]
    -- upvalues: v12 (copy)
    for v87, v88 in pairs(v12) do
        if v88 == v86 then
            return v87;
        end;
    end;
    return nil;
end;
v20.GetButtonIcon = function(_, v90) --[[ Line: 460 ]] --[[ Name: GetButtonIcon ]]
    -- upvalues: v8 (copy)
    return (v8(v90));
end;
v20.ScrollToElement = function(_, v92) --[[ Line: 465 ]] --[[ Name: ScrollToElement ]]
    if not v92 or not v92.Parent then
        return;
    else
        return;
    end;
end;
v20.HandlePetSelectionTooltip = function(v93, v94) --[[ Line: 470 ]] --[[ Name: HandlePetSelectionTooltip ]]
    -- upvalues: v21 (ref), v19 (ref), v22 (ref)
    if not v94 then
        if v21 and v19 then
            v21:Close();
            v19 = nil;
        end;
        return;
    else
        if v94.Name == "Button" and v94.Parent and v94.Parent.Name == "Main" then
            local l_Parent_1 = v94.Parent.Parent;
            if l_Parent_1 then
                local l_l_Parent_1_Attribute_0 = l_Parent_1:GetAttribute("Id");
                if l_l_Parent_1_Attribute_0 and v22 and v22[l_l_Parent_1_Attribute_0] then
                    task.defer(function() --[[ Line: 488 ]]
                        -- upvalues: v93 (copy), l_Parent_1 (copy)
                        task.wait(0.05);
                        v93:ScrollToElement(l_Parent_1);
                    end);
                    if v21 then
                        if v21.SetControllerTarget then
                            v21:SetControllerTarget(l_Parent_1);
                        end;
                        v21:Prompt(v22[l_l_Parent_1_Attribute_0]);
                        v19 = v94;
                    end;
                    return;
                end;
            end;
        end;
        if v21 and v19 then
            v21:Close();
            v19 = nil;
        end;
        return;
    end;
end;
v20.SetPetReferences = function(_, v98, v99) --[[ Line: 515 ]] --[[ Name: SetPetReferences ]]
    -- upvalues: v21 (ref), v22 (ref)
    v21 = v98;
    v22 = v99;
end;
v20.Init = function(v100) --[[ Line: 521 ]] --[[ Name: Init ]]
    -- upvalues: l_PlayerGui_0 (copy), v15 (ref), l_GuiService_0 (copy), v16 (ref), l_UserInputService_0 (copy), v12 (copy), v4 (copy)
    local l_Bottom_0 = l_PlayerGui_0:WaitForChild("Game"):WaitForChild("Bottom");
    local l_Tabs_0 = l_PlayerGui_0:WaitForChild("Tabs");
    local function v106(v103) --[[ Line: 527 ]] --[[ Name: updateInputType ]]
        -- upvalues: v15 (ref), v100 (copy), l_Bottom_0 (copy), l_GuiService_0 (ref)
        local v104 = {
            Enum.UserInputType.Gamepad1, 
            Enum.UserInputType.Gamepad2, 
            Enum.UserInputType.Gamepad3, 
            Enum.UserInputType.Gamepad4
        };
        local v105 = table.find(v104, v103) ~= nil;
        if v105 ~= v15 then
            v100:UpdateKeybindVisibility(v105, l_Bottom_0);
            if v105 then
                if l_Bottom_0.Pets and l_Bottom_0.Pets:FindFirstChild("Button") then
                    l_GuiService_0.SelectedObject = l_Bottom_0.Pets.Button;
                    return;
                end;
            else
                l_GuiService_0.SelectedObject = nil;
            end;
        end;
    end;
    game:GetService("GamepadService"):GetPropertyChangedSignal("GamepadCursorEnabled"):Connect(function() --[[ Line: 552 ]]
        -- upvalues: v16 (ref), v15 (ref), v100 (copy)
        local l_v16_0 = v16;
        v16 = game:GetService("GamepadService").GamepadCursorEnabled and v15;
        if l_v16_0 ~= v16 then
            v100:UpdateCursorModeHint();
        end;
    end);
    l_GuiService_0:GetPropertyChangedSignal("SelectedObject"):Connect(function() --[[ Line: 562 ]]
        -- upvalues: v100 (copy), l_GuiService_0 (ref)
        v100:HandlePetSelectionTooltip(l_GuiService_0.SelectedObject);
    end);
    l_UserInputService_0.InputBegan:Connect(function(v108) --[[ Line: 568 ]]
        -- upvalues: v16 (ref), l_GuiService_0 (ref)
        if v108.KeyCode == Enum.KeyCode.ButtonSelect and v16 then
            task.defer(function() --[[ Line: 572 ]]
                -- upvalues: l_GuiService_0 (ref)
                task.wait(0.1);
                if not l_GuiService_0.SelectedObject then
                    l_GuiService_0:RemoveSelectionGroup("ControllerInput");
                end;
            end);
        end;
    end);
    if l_UserInputService_0.GamepadEnabled and #l_UserInputService_0:GetConnectedGamepads() > 0 then
        v15 = true;
    end;
    l_UserInputService_0.LastInputTypeChanged:Connect(function(v109) --[[ Line: 593 ]]
        -- upvalues: v106 (copy)
        v106(v109);
    end);
    l_UserInputService_0.InputBegan:Connect(function(v110, v111) --[[ Line: 598 ]]
        -- upvalues: v15 (ref), v12 (ref), v4 (ref), v100 (copy)
        if not v15 then
            return;
        elseif v111 then
            return;
        else
            local v112 = v12[v110.KeyCode];
            if v112 then
                if v112 == "OpenInventory" then
                    v4.Fire("ToggleMenu", "Inventory");
                    return;
                elseif v112 == "ToggleAutoClicker" then
                    if v4:GetSignal("StartAutoClicking") then
                        local v113 = _G.GetCurrentAutoClicking and _G.GetCurrentAutoClicking();
                        v4.Fire("StartAutoClicking", not v113);
                        return;
                    end;
                elseif v112 == "CloseMenu" then
                    v4.Fire("CloseAllMenus");
                    return;
                elseif v112 == "PreviousTab" or v112 == "NextTab" then
                    v100:NavigateTabs(v112 == "NextTab" and 1 or -1);
                end;
            end;
            return;
        end;
    end);
    task.defer(function() --[[ Line: 622 ]]
        -- upvalues: l_Bottom_0 (copy), v100 (copy), l_Tabs_0 (copy), v15 (ref)
        if l_Bottom_0:FindFirstChild("Pets") then
            v100:SetupButtonKeybind(l_Bottom_0.Pets, Enum.KeyCode.ButtonY);
            if l_Bottom_0.Pets:FindFirstChild("Button") then
                v100:EnableSelection(l_Bottom_0.Pets.Button);
            end;
        end;
        if l_Bottom_0:FindFirstChild("Auto") then
            v100:SetupButtonKeybind(l_Bottom_0.Auto, Enum.KeyCode.ButtonX);
            if l_Bottom_0.Auto:FindFirstChild("Button") then
                v100:EnableSelection(l_Bottom_0.Auto.Button);
            end;
        end;
        if l_Bottom_0:FindFirstChild("FreeAutoTap") then
            v100:SetupButtonKeybind(l_Bottom_0.FreeAutoTap, Enum.KeyCode.ButtonX);
            if l_Bottom_0.FreeAutoTap:FindFirstChild("Button") then
                v100:EnableSelection(l_Bottom_0.FreeAutoTap.Button);
            end;
        end;
        if l_Bottom_0:FindFirstChild("AutoTap") and l_Bottom_0.AutoTap:FindFirstChild("Button") then
            v100:EnableSelection(l_Bottom_0.AutoTap.Button);
        end;
        v100:CreateCursorModeHint(l_Bottom_0);
        local l_Inventory_0 = l_Tabs_0:WaitForChild("Inventory");
        l_Inventory_0:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 659 ]]
            -- upvalues: l_Inventory_0 (copy), v100 (ref)
            if l_Inventory_0.Enabled then
                task.defer(function() --[[ Line: 661 ]]
                    -- upvalues: v100 (ref)
                    v100:SetupInventorySelection();
                end);
            end;
        end);
        v100:SetupLeftMenuSelection();
        v100:SetupRightHudSelection();
        v100:UpdateKeybindVisibility(v15, l_Bottom_0);
    end);
end;
v20.NavigateTabs = function(_, v116) --[[ Line: 679 ]] --[[ Name: NavigateTabs ]]
    -- upvalues: l_PlayerGui_0 (copy)
    local l_Tabs_1 = l_PlayerGui_0:FindFirstChild("Tabs");
    if not l_Tabs_1 then
        return;
    else
        local l_Inventory_1 = l_Tabs_1:FindFirstChild("Inventory");
        if not l_Inventory_1 or not l_Inventory_1.Enabled then
            return;
        else
            local l_Menu_0 = l_Inventory_1:FindFirstChild("Menu");
            if not l_Menu_0 then
                return;
            else
                local l_Tabs_2 = l_Menu_0:FindFirstChild("Tabs");
                if not l_Tabs_2 then
                    return;
                else
                    local v121 = {};
                    local v122 = 1;
                    for _, v124 in ipairs(l_Tabs_2:GetChildren()) do
                        if v124:IsA("Frame") then
                            table.insert(v121, v124);
                            if v124.ZIndex >= 2 then
                                v122 = #v121;
                            end;
                        end;
                    end;
                    local v125 = v122 + v116;
                    if v125 < 1 then
                        v125 = #v121;
                    end;
                    if #v121 < v125 then
                        v125 = 1;
                    end;
                    local v126 = v121[v125];
                    if v126 and v126:FindFirstChild("Button") then
                        local l_Button_0 = v126.Button;
                        if l_Button_0:IsA("TextButton") or l_Button_0:IsA("ImageButton") then
                            l_Button_0.Activated:Fire();
                        end;
                    end;
                    return;
                end;
            end;
        end;
    end;
end;
v20.SetupInventorySelection = function(v128) --[[ Line: 722 ]] --[[ Name: SetupInventorySelection ]]
    -- upvalues: l_PlayerGui_0 (copy), v8 (copy), v15 (ref), v13 (copy), l_GuiService_0 (copy)
    local l_Tabs_3 = l_PlayerGui_0:FindFirstChild("Tabs");
    if not l_Tabs_3 then
        return;
    else
        local l_Inventory_2 = l_Tabs_3:FindFirstChild("Inventory");
        if not l_Inventory_2 then
            return;
        else
            local l_Menu_1 = l_Inventory_2:FindFirstChild("Menu");
            if not l_Menu_1 then
                return;
            else
                local l_Tabs_4 = l_Menu_1:FindFirstChild("Tabs");
                if l_Tabs_4 then
                    for _, v134 in ipairs(l_Tabs_4:GetChildren()) do
                        if v134:IsA("Frame") and v134:FindFirstChild("Button") then
                            v128:EnableSelection(v134.Button);
                        end;
                    end;
                end;
                local l_Categories_0 = l_Menu_1:FindFirstChild("Categories");
                if l_Categories_0 then
                    v128:DisableScrollingFrameSelection(l_Categories_0);
                    for _, v137 in ipairs(l_Categories_0:GetChildren()) do
                        if v137:IsA("Frame") then
                            v128:SetupSelectionGroup(v137, "TextButton");
                        end;
                    end;
                end;
                local function v141(v138) --[[ Line: 756 ]] --[[ Name: setupActionButtons ]]
                    -- upvalues: v128 (copy)
                    if not v138 then
                        return;
                    else
                        for _, v140 in ipairs(v138:GetDescendants()) do
                            if (v140:IsA("TextButton") or v140:IsA("ImageButton")) and v140.Name == "Button" then
                                v128:EnableSelection(v140);
                            end;
                        end;
                        return;
                    end;
                end;
                local v142 = l_Categories_0 and l_Categories_0:FindFirstChild("Pets");
                if v142 then
                    v141(v142:FindFirstChild("Bottom1"));
                    v141(v142:FindFirstChild("Bottom2"));
                    v141(v142:FindFirstChild("Info"));
                end;
                if l_Tabs_4 and not l_Tabs_4:FindFirstChild("TabNavHint") then
                    local v143 = v8(Enum.KeyCode.ButtonL1);
                    local v144 = v8(Enum.KeyCode.ButtonR1);
                    local l_Frame_0 = Instance.new("Frame");
                    l_Frame_0.Name = "TabNavHint";
                    l_Frame_0.Size = UDim2.new(1, 0, 0, 25);
                    l_Frame_0.Position = UDim2.new(0, 0, 0, -30);
                    l_Frame_0.BackgroundTransparency = 1;
                    l_Frame_0.Visible = v15;
                    l_Frame_0.Parent = l_Tabs_4;
                    local l_TextLabel_5 = Instance.new("TextLabel");
                    l_TextLabel_5.Name = "LeftHint";
                    l_TextLabel_5.Size = UDim2.new(0.5, 0, 1, 0);
                    l_TextLabel_5.BackgroundTransparency = 1;
                    l_TextLabel_5.Font = Enum.Font.GothamBold;
                    l_TextLabel_5.Text = "\226\151\132 " .. v143;
                    l_TextLabel_5.TextColor3 = Color3.fromRGB(255, 255, 255);
                    l_TextLabel_5.TextSize = 14;
                    l_TextLabel_5.TextXAlignment = Enum.TextXAlignment.Left;
                    l_TextLabel_5.Parent = l_Frame_0;
                    local l_TextLabel_6 = Instance.new("TextLabel");
                    l_TextLabel_6.Name = "RightHint";
                    l_TextLabel_6.Size = UDim2.new(0.5, 0, 1, 0);
                    l_TextLabel_6.Position = UDim2.new(0.5, 0, 0, 0);
                    l_TextLabel_6.BackgroundTransparency = 1;
                    l_TextLabel_6.Font = Enum.Font.GothamBold;
                    l_TextLabel_6.Text = v144 .. " \226\150\186";
                    l_TextLabel_6.TextColor3 = Color3.fromRGB(255, 255, 255);
                    l_TextLabel_6.TextSize = 14;
                    l_TextLabel_6.TextXAlignment = Enum.TextXAlignment.Right;
                    l_TextLabel_6.Parent = l_Frame_0;
                    table.insert(v13, l_Frame_0);
                end;
                local l_Close_0 = l_Menu_1:FindFirstChild("Close");
                if l_Close_0 then
                    v128:SetupCloseButtonKeybind(l_Close_0, Enum.KeyCode.ButtonB);
                    local l_Button_1 = l_Close_0:FindFirstChild("Button");
                    if l_Button_1 then
                        v128:EnableSelection(l_Button_1);
                    end;
                end;
                if v15 then
                    task.defer(function() --[[ Line: 824 ]]
                        -- upvalues: l_Categories_0 (copy), l_GuiService_0 (ref), l_Tabs_4 (copy)
                        task.wait(0.1);
                        local v150 = l_Categories_0 and l_Categories_0:FindFirstChild("Pets");
                        if v150 and v150.Visible then
                            local l_Inner_0 = v150:FindFirstChild("Inner");
                            if l_Inner_0 then
                                local l_List_0 = l_Inner_0:FindFirstChild("List");
                                if l_List_0 then
                                    local v153 = l_List_0:FindFirstChild("Container") or l_List_0;
                                    local l_Equipped_0 = l_List_0:FindFirstChild("Equipped");
                                    local v155 = l_Equipped_0 and l_Equipped_0:FindFirstChild("List");
                                    if v155 then
                                        for _, v157 in ipairs(v155:GetChildren()) do
                                            if v157:IsA("Frame") and v157.Visible then
                                                local l_Main_1 = v157:FindFirstChild("Main");
                                                if l_Main_1 then
                                                    local l_Button_2 = l_Main_1:FindFirstChild("Button");
                                                    if l_Button_2 and (l_Button_2:IsA("TextButton") or l_Button_2:IsA("ImageButton")) then
                                                        l_GuiService_0.SelectedObject = l_Button_2;
                                                        return;
                                                    end;
                                                end;
                                            end;
                                        end;
                                    end;
                                    for _, v161 in ipairs(v153:GetChildren()) do
                                        if v161:IsA("Frame") and v161.Visible then
                                            local l_Main_2 = v161:FindFirstChild("Main");
                                            if l_Main_2 then
                                                local l_Button_3 = l_Main_2:FindFirstChild("Button");
                                                if l_Button_3 and (l_Button_3:IsA("TextButton") or l_Button_3:IsA("ImageButton")) then
                                                    l_GuiService_0.SelectedObject = l_Button_3;
                                                    return;
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                        if l_Tabs_4 then
                            for _, v165 in ipairs(l_Tabs_4:GetChildren()) do
                                if v165:IsA("Frame") and v165:FindFirstChild("Button") and v165.Visible then
                                    l_GuiService_0.SelectedObject = v165.Button;
                                    return;
                                end;
                            end;
                        end;
                    end);
                end;
                return;
            end;
        end;
    end;
end;
v20.SetupLeftMenuSelection = function(v166) --[[ Line: 889 ]] --[[ Name: SetupLeftMenuSelection ]]
    -- upvalues: l_PlayerGui_0 (copy)
    local l_Game_0 = l_PlayerGui_0:FindFirstChild("Game");
    if not l_Game_0 then
        return;
    else
        local l_Left_0 = l_Game_0:FindFirstChild("Left");
        if not l_Left_0 then
            return;
        else
            local l_Buttons_0 = l_Left_0:FindFirstChild("Buttons");
            if not l_Buttons_0 then
                return;
            else
                for _, v171 in ipairs(l_Buttons_0:GetChildren()) do
                    if v171:IsA("Frame") and v171:FindFirstChild("Button") then
                        v166:EnableSelection(v171.Button);
                    end;
                end;
                return;
            end;
        end;
    end;
end;
v20.SetupRightHudSelection = function(v172) --[[ Line: 907 ]] --[[ Name: SetupRightHudSelection ]]
    -- upvalues: l_PlayerGui_0 (copy)
    local l_RightHud_0 = l_PlayerGui_0:FindFirstChild("RightHud");
    if not l_RightHud_0 then
        return;
    else
        v172:DisableScrollingFrameSelection(l_RightHud_0);
        local l_Main_3 = l_RightHud_0:FindFirstChild("Main");
        if not l_Main_3 then
            return;
        else
            local l_Buttons_1 = l_Main_3:FindFirstChild("Buttons");
            if l_Buttons_1 then
                for _, v177 in ipairs(l_Buttons_1:GetChildren()) do
                    if v177:IsA("Frame") and v177:FindFirstChild("Button") then
                        v172:EnableSelection(v177.Button);
                    end;
                end;
            end;
            local l_ButtonsVertical_0 = l_Main_3:FindFirstChild("ButtonsVertical");
            if l_ButtonsVertical_0 then
                for _, v180 in ipairs(l_ButtonsVertical_0:GetChildren()) do
                    if v180:IsA("Frame") and v180:FindFirstChild("Button") then
                        v172:EnableSelection(v180.Button);
                    end;
                end;
            end;
            local l_RightUI_0 = l_Main_3:FindFirstChild("RightUI");
            if l_RightUI_0 then
                v172:DisableScrollingFrameSelection(l_RightUI_0);
                local l_Rebirths_0 = l_RightUI_0:FindFirstChild("Rebirths");
                if l_Rebirths_0 then
                    v172:DisableScrollingFrameSelection(l_Rebirths_0);
                    v172:SetupSelectionGroup(l_Rebirths_0, "TextButton");
                end;
                local l_Quests_0 = l_RightUI_0:FindFirstChild("Quests");
                if l_Quests_0 then
                    v172:DisableScrollingFrameSelection(l_Quests_0);
                    v172:SetupSelectionGroup(l_Quests_0, "TextButton");
                end;
                local l_Badges_0 = l_RightUI_0:FindFirstChild("Badges");
                if l_Badges_0 then
                    v172:DisableScrollingFrameSelection(l_Badges_0);
                    v172:SetupSelectionGroup(l_Badges_0, "TextButton");
                end;
                local l_Items_0 = l_RightUI_0:FindFirstChild("Items");
                if l_Items_0 then
                    v172:DisableScrollingFrameSelection(l_Items_0);
                    v172:SetupSelectionGroup(l_Items_0, "TextButton");
                end;
            end;
            return;
        end;
    end;
end;
v20.SetupEggBillboard = function(v186, v187) --[[ Line: 972 ]] --[[ Name: SetupEggBillboard ]]
    if not v187 then
        return;
    else
        local v188 = v187:FindFirstChild("Main") and v187.Main:FindFirstChild("Buttons");
        if not v188 then
            return;
        else
            local l_Single_0 = v188:FindFirstChild("Single");
            if l_Single_0 then
                v186:SetupButtonKeybind(l_Single_0, Enum.KeyCode.ButtonA);
                if l_Single_0:FindFirstChild("Button") then
                    v186:EnableSelection(l_Single_0.Button);
                end;
            end;
            local l_Triple_0 = v188:FindFirstChild("Triple");
            if l_Triple_0 then
                v186:SetupButtonKeybind(l_Triple_0, Enum.KeyCode.ButtonX);
                if l_Triple_0:FindFirstChild("Button") then
                    v186:EnableSelection(l_Triple_0.Button);
                end;
            end;
            local l_Octo_0 = v188:FindFirstChild("Octo");
            if l_Octo_0 then
                v186:SetupButtonKeybind(l_Octo_0, Enum.KeyCode.ButtonY);
                if l_Octo_0:FindFirstChild("Button") then
                    v186:EnableSelection(l_Octo_0.Button);
                end;
            end;
            return;
        end;
    end;
end;
return v20;