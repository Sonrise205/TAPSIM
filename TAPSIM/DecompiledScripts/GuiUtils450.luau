local l_GuiService_0 = game:GetService("GuiService");
local l_Players_0 = game:GetService("Players");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_PlayerGui_0 = l_Players_0.LocalPlayer:WaitForChild("PlayerGui");
local v4 = {
    TextTransparency = true, 
    TextStrokeTransparency = true, 
    ImageTransparency = true, 
    BackgroundTransparency = true, 
    Transparency = true
};
local function v6(v5) --[[ Line: 17 ]] --[[ Name: setDefaultTransparencies ]]
    if v5:IsA("GuiObject") then
        if v5:IsA("TextLabel") then
            if v5:GetAttribute("TextTransparency") == nil then
                v5:SetAttribute("TextTransparency", v5.TextTransparency);
            end;
            if v5:GetAttribute("TextStrokeTransparency") == nil then
                v5:SetAttribute("TextStrokeTransparency", v5.TextStrokeTransparency);
            end;
        end;
        if (v5:IsA("ImageLabel") or v5:IsA("ImageButton") or v5:IsA("ViewportFrame")) and v5:GetAttribute("ImageTransparency") == nil then
            v5:SetAttribute("ImageTransparency", v5.ImageTransparency);
        end;
        if v5:GetAttribute("BackgroundTransparency") == nil then
            v5:SetAttribute("BackgroundTransparency", v5.BackgroundTransparency);
            return;
        end;
    elseif v5:IsA("UIStroke") and not v5:GetAttribute("Transparency") then
        v5:SetAttribute("Transparency", v5.Transparency);
    end;
end;
local function _(v7, v8) --[[ Line: 45 ]] --[[ Name: setUpdatedTransparencies ]]
    -- upvalues: v4 (copy)
    for v9, v10 in v7:GetAttributes() do
        if v4[v9] then
            v7[v9] = v10 + (1 - v10) * v8;
        end;
    end;
end;
local v12 = {
    getGuiInset = function() --[[ Line: 55 ]] --[[ Name: getGuiInset ]]
        -- upvalues: l_GuiService_0 (copy)
        return l_GuiService_0:GetGuiInset().Y;
    end
};
v12.getGuiObjectsAtMousePosition = function() --[[ Line: 59 ]] --[[ Name: getGuiObjectsAtMousePosition ]]
    -- upvalues: l_UserInputService_0 (copy), v12 (copy), l_PlayerGui_0 (copy)
    local l_l_UserInputService_0_MouseLocation_0 = l_UserInputService_0:GetMouseLocation();
    local l_X_0 = l_l_UserInputService_0_MouseLocation_0.X;
    local v15 = l_l_UserInputService_0_MouseLocation_0.Y - v12.getGuiInset();
    return l_PlayerGui_0:GetGuiObjectsAtPosition(l_X_0, v15), l_l_UserInputService_0_MouseLocation_0;
end;
v12.onGuiPressed = function(v16) --[[ Line: 67 ]] --[[ Name: onGuiPressed ]]
    if v16:IsA("GuiButton") then
        return v16.Activated;
    else
        local l_GuiButton_0 = v16:FindFirstChildWhichIsA("GuiButton");
        if not l_GuiButton_0 then
            l_GuiButton_0 = Instance.new("TextButton");
            l_GuiButton_0.Size = UDim2.fromScale(1, 1);
            l_GuiButton_0.Position = UDim2.fromScale(0.5, 0.5);
            l_GuiButton_0.AnchorPoint = Vector2.new(0.5, 0.5);
            l_GuiButton_0.BackgroundTransparency = 1;
            l_GuiButton_0.Text = "";
            l_GuiButton_0.Parent = v16;
        end;
        return l_GuiButton_0.Activated;
    end;
end;
v12.scaleTransparency = function(v18, v19) --[[ Line: 86 ]] --[[ Name: scaleTransparency ]]
    -- upvalues: v6 (copy), v4 (copy)
    v6(v18);
    for v20, v21 in v18:GetAttributes() do
        if v4[v20] then
            v18[v20] = v21 + (1 - v21) * v19;
        end;
    end;
    for _, v23 in v18:GetDescendants() do
        v6(v23);
        for v24, v25 in v23:GetAttributes() do
            if v4[v24] then
                v23[v24] = v25 + (1 - v25) * v19;
            end;
        end;
    end;
end;
return v12;