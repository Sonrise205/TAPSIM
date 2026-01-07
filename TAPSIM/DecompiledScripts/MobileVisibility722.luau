local l_Players_0 = game:GetService("Players");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_CollectionService_0 = game:GetService("CollectionService");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local v4 = false;
local v5 = {};
local v6 = {};
local v7 = nil;
local v8 = false;
local v9 = {
    [Enum.UserInputType.Keyboard] = "Keyboard", 
    [Enum.UserInputType.TextInput] = "Keyboard", 
    [Enum.UserInputType.MouseMovement] = "Keyboard", 
    [Enum.UserInputType.MouseWheel] = "Keyboard", 
    [Enum.UserInputType.MouseButton1] = "Keyboard", 
    [Enum.UserInputType.MouseButton2] = "Keyboard", 
    [Enum.UserInputType.MouseButton3] = "Keyboard", 
    [Enum.UserInputType.Touch] = "Touch", 
    [Enum.UserInputType.Gyro] = "Touch", 
    [Enum.UserInputType.Accelerometer] = "Touch", 
    [Enum.UserInputType.Gamepad1] = "Gamepad", 
    [Enum.UserInputType.Gamepad2] = "Gamepad", 
    [Enum.UserInputType.Gamepad3] = "Gamepad", 
    [Enum.UserInputType.Gamepad4] = "Gamepad", 
    [Enum.UserInputType.Gamepad5] = "Gamepad", 
    [Enum.UserInputType.Gamepad6] = "Gamepad", 
    [Enum.UserInputType.Gamepad7] = "Gamepad", 
    [Enum.UserInputType.Gamepad8] = "Gamepad"
};
v6.GetDevice = function(_) --[[ Line: 42 ]] --[[ Name: GetDevice ]]
    -- upvalues: v9 (copy), l_UserInputService_0 (copy), v7 (ref)
    if v9[l_UserInputService_0:GetLastInputType()] then
        v7 = v9[l_UserInputService_0:GetLastInputType()];
    end;
    return v7;
end;
local function _() --[[ Line: 50 ]] --[[ Name: detectMobile ]]
    -- upvalues: l_UserInputService_0 (copy), l_LocalPlayer_0 (copy)
    return l_UserInputService_0.TouchEnabled and not l_UserInputService_0.KeyboardEnabled or l_LocalPlayer_0.Name == "Zued";
end;
local function _(v12, v13) --[[ Line: 57 ]] --[[ Name: applyVisibility ]]
    if v12:IsA("GuiObject") then
        v12.Visible = v13;
        return;
    else
        if v12:IsA("ScreenGui") or v12:IsA("BillboardGui") or v12:IsA("SurfaceGui") then
            v12.Enabled = v13;
        end;
        return;
    end;
end;
local function v20(v15) --[[ Line: 67 ]] --[[ Name: applySize ]]
    -- upvalues: v5 (copy), v4 (ref)
    if not v15:IsA("GuiObject") then
        warn(string.format("[MobileVisibility] ResizeMobile tag on non-GuiObject: %s", v15:GetFullName()));
        return;
    else
        if not v5[v15] then
            v5[v15] = v15.Size;
        end;
        if v4 then
            local l_v15_Attribute_0 = v15:GetAttribute("Size");
            if l_v15_Attribute_0 then
                if typeof(l_v15_Attribute_0) == "UDim2" then
                    v15.Size = l_v15_Attribute_0;
                    return;
                elseif typeof(l_v15_Attribute_0) == "string" then
                    local v17 = l_v15_Attribute_0:gsub("[{}%s]", "");
                    local v18 = {};
                    for v19 in v17:gmatch("[^,]+") do
                        table.insert(v18, (tonumber(v19)));
                    end;
                    if #v18 == 4 then
                        v15.Size = UDim2.new(v18[1], v18[2], v18[3], v18[4]);
                        return;
                    else
                        warn(string.format("[MobileVisibility] Invalid Size attribute format on %s: %s", v15:GetFullName(), l_v15_Attribute_0));
                        return;
                    end;
                end;
            else
                warn(string.format("[MobileVisibility] ResizeMobile tag found but no Size attribute on: %s", v15:GetFullName()));
                return;
            end;
        else
            v15.Size = v5[v15];
        end;
        return;
    end;
end;
local function v23() --[[ Line: 111 ]] --[[ Name: handleHideMobile ]]
    -- upvalues: l_CollectionService_0 (copy), v4 (ref)
    for _, v22 in ipairs(l_CollectionService_0:GetTagged("HideMobile")) do
        if v4 then
            if v22:IsA("GuiObject") then
                v22.Visible = false;
            elseif v22:IsA("ScreenGui") or v22:IsA("BillboardGui") or v22:IsA("SurfaceGui") then
                v22.Enabled = false;
            end;
        elseif v22:IsA("GuiObject") then
            v22.Visible = true;
        elseif v22:IsA("ScreenGui") or v22:IsA("BillboardGui") or v22:IsA("SurfaceGui") then
            v22.Enabled = true;
        end;
    end;
end;
local function v26() --[[ Line: 122 ]] --[[ Name: handleShowMobile ]]
    -- upvalues: l_CollectionService_0 (copy), v4 (ref)
    for _, v25 in ipairs(l_CollectionService_0:GetTagged("ShowMobile")) do
        if v4 then
            if v25:IsA("GuiObject") then
                v25.Visible = true;
            elseif v25:IsA("ScreenGui") or v25:IsA("BillboardGui") or v25:IsA("SurfaceGui") then
                v25.Enabled = true;
            end;
        elseif v25:IsA("GuiObject") then
            v25.Visible = false;
        elseif v25:IsA("ScreenGui") or v25:IsA("BillboardGui") or v25:IsA("SurfaceGui") then
            v25.Enabled = false;
        end;
    end;
end;
local _ = function() --[[ Line: 133 ]] --[[ Name: handleResizeMobile ]]
    -- upvalues: l_CollectionService_0 (copy), v20 (copy)
    for _, v28 in ipairs(l_CollectionService_0:GetTagged("ResizeMobile")) do
        v20(v28);
    end;
end;
local function v33() --[[ Line: 140 ]] --[[ Name: setupTagListeners ]]
    -- upvalues: l_CollectionService_0 (copy), v4 (ref), v20 (copy)
    l_CollectionService_0:GetInstanceAddedSignal("HideMobile"):Connect(function(v30) --[[ Line: 142 ]]
        -- upvalues: v4 (ref)
        if v4 then
            if v30:IsA("GuiObject") then
                v30.Visible = false;
                return;
            elseif v30:IsA("ScreenGui") or v30:IsA("BillboardGui") or v30:IsA("SurfaceGui") then
                v30.Enabled = false;
                return;
            end;
        elseif v30:IsA("GuiObject") then
            v30.Visible = true;
            return;
        elseif v30:IsA("ScreenGui") or v30:IsA("BillboardGui") or v30:IsA("SurfaceGui") then
            v30.Enabled = true;
        end;
    end);
    l_CollectionService_0:GetInstanceAddedSignal("ShowMobile"):Connect(function(v31) --[[ Line: 151 ]]
        -- upvalues: v4 (ref)
        if v4 then
            if v31:IsA("GuiObject") then
                v31.Visible = true;
                return;
            elseif v31:IsA("ScreenGui") or v31:IsA("BillboardGui") or v31:IsA("SurfaceGui") then
                v31.Enabled = true;
                return;
            end;
        elseif v31:IsA("GuiObject") then
            v31.Visible = false;
            return;
        elseif v31:IsA("ScreenGui") or v31:IsA("BillboardGui") or v31:IsA("SurfaceGui") then
            v31.Enabled = false;
        end;
    end);
    l_CollectionService_0:GetInstanceAddedSignal("ResizeMobile"):Connect(function(v32) --[[ Line: 160 ]]
        -- upvalues: v20 (ref)
        v20(v32);
    end);
end;
v6.GetDeviceFromInput = function(_, v35) --[[ Line: 165 ]] --[[ Name: GetDeviceFromInput ]]
    -- upvalues: v9 (copy)
    return v9[v35];
end;
v6.ListenToDeviceChange = function(_, v37) --[[ Line: 169 ]] --[[ Name: ListenToDeviceChange ]]
    -- upvalues: l_UserInputService_0 (copy), v6 (copy)
    local _ = nil;
    return (l_UserInputService_0.InputChanged:Connect(function(v39, v40) --[[ Line: 172 ]]
        -- upvalues: v6 (ref), v37 (copy)
        if v40 then
            return;
        else
            local l_v6_DeviceFromInput_0 = v6:GetDeviceFromInput(v39.UserInputType);
            v37(l_v6_DeviceFromInput_0);
            return;
        end;
    end));
end;
local function v54() --[[ Line: 181 ]] --[[ Name: initialize ]]
    -- upvalues: l_LocalPlayer_0 (copy), v23 (copy), v26 (copy), l_CollectionService_0 (copy), v20 (copy), v33 (copy), v6 (copy), v4 (ref)
    local l_RightHud_0 = l_LocalPlayer_0:WaitForChild("PlayerGui"):WaitForChild("RightHud");
    task.wait(0.5);
    local l_UIListLayout_0 = l_RightHud_0.Main.UIListLayout;
    local l_UIPadding_0 = l_RightHud_0.Main.UIPadding;
    local l_UIAspectRatioConstraint_0 = l_RightHud_0.Main.RightUI.UIAspectRatioConstraint;
    v23();
    v26();
    for _, v47 in ipairs(l_CollectionService_0:GetTagged("ResizeMobile")) do
        v20(v47);
    end;
    v33();
    local function v49(v48) --[[ Line: 200 ]] --[[ Name: DeviceUpdated ]]
        -- upvalues: l_UIAspectRatioConstraint_0 (copy), l_UIPadding_0 (copy), l_RightHud_0 (copy), l_UIListLayout_0 (copy)
        if v48 == "Touch" then
            l_UIAspectRatioConstraint_0.AspectRatio = 0.72;
            l_UIAspectRatioConstraint_0.AspectType = Enum.AspectType.ScaleWithParentSize;
            l_UIAspectRatioConstraint_0.DominantAxis = Enum.DominantAxis.Height;
            l_UIPadding_0.PaddingBottom = UDim.new(0.23, 0);
            l_UIPadding_0.PaddingTop = UDim.new(0, 0);
            l_UIPadding_0.PaddingLeft = UDim.new(0.1, 0);
            l_UIPadding_0.PaddingRight = UDim.new(0.01, 0);
            l_RightHud_0.Main.Buttons.Size = UDim2.new(1, 0, 0.05, 50);
            l_UIListLayout_0.HorizontalAlignment = Enum.HorizontalAlignment.Right;
            l_UIListLayout_0.VerticalAlignment = Enum.VerticalAlignment.Center;
        end;
    end;
    local _ = #l_CollectionService_0:GetTagged("HideMobile");
    local _ = #l_CollectionService_0:GetTagged("ShowMobile");
    local _ = #l_CollectionService_0:GetTagged("ResizeMobile");
    if v6:GetDevice() then
        if v4 == true then
            return;
        else
            if v6:GetDevice() == "Touch" then
                v4 = true;
            end;
            v49(v6:GetDevice());
        end;
    end;
    v6:ListenToDeviceChange(function(v53) --[[ Line: 233 ]]
        -- upvalues: v4 (ref), v6 (ref), v49 (copy)
        if v4 == true then
            return;
        else
            if v6:GetDevice() == "Touch" then
                v4 = true;
            end;
            v49(v53);
            return;
        end;
    end);
end;
v6.Init = function(_) --[[ Line: 245 ]] --[[ Name: Init ]]
    -- upvalues: v8 (ref), v54 (copy)
    if v8 then
        return;
    else
        v8 = true;
        task.defer(function() --[[ Line: 251 ]]
            -- upvalues: v54 (ref)
            local l_status_0, l_result_0 = pcall(v54);
            if not l_status_0 then
                warn("[MobileVisibility] Initialization error:", l_result_0);
            end;
        end);
        return;
    end;
end;
return v6;