local l_CollectionService_0 = game:GetService("CollectionService");
local l_Players_0 = game:GetService("Players");
local _ = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_UserInputService_0 = game:GetService("UserInputService");
local v5 = require(script.Parent.GuiUtils);
local v6 = require(script.Parent.CollectionUtils);
local v7 = require(script.Parent.Maid);
local l_PlayerGui_0 = l_Players_0.LocalPlayer:WaitForChild("PlayerGui");
local l_ScreenGui_0 = Instance.new("ScreenGui");
l_ScreenGui_0.ResetOnSpawn = false;
l_ScreenGui_0.IgnoreGuiInset = false;
l_ScreenGui_0.DisplayOrder = 1000;
l_ScreenGui_0.Enabled = true;
l_ScreenGui_0.Parent = l_PlayerGui_0;
local l_Frame_0 = Instance.new("Frame");
l_Frame_0.AnchorPoint = Vector2.new(0.5, 0);
l_Frame_0.Position = UDim2.fromScale(0.5, 0.5);
l_Frame_0.AutomaticSize = Enum.AutomaticSize.XY;
l_Frame_0.Parent = l_ScreenGui_0;
local l_UIListLayout_0 = Instance.new("UIListLayout");
l_UIListLayout_0.FillDirection = Enum.FillDirection.Vertical;
l_UIListLayout_0.SortOrder = Enum.SortOrder.LayoutOrder;
l_UIListLayout_0.HorizontalAlignment = Enum.HorizontalAlignment.Center;
l_UIListLayout_0.VerticalAlignment = Enum.VerticalAlignment.Top;
l_UIListLayout_0.Parent = l_Frame_0;
local l_UIPadding_0 = Instance.new("UIPadding");
l_UIPadding_0.PaddingBottom = UDim.new(0, 5);
l_UIPadding_0.PaddingTop = UDim.new(0, 5);
l_UIPadding_0.PaddingLeft = UDim.new(0, 5);
l_UIPadding_0.PaddingRight = UDim.new(0, 5);
l_UIPadding_0.Parent = l_Frame_0;
local l_UICorner_0 = Instance.new("UICorner");
l_UICorner_0.Parent = l_Frame_0;
local l_UIStroke_0 = Instance.new("UIStroke");
l_UIStroke_0.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
l_UIStroke_0.Parent = l_Frame_0;
local v15 = nil;
local v16 = {};
local v17 = v7.new();
local function v21(v18) --[[ Line: 85 ]] --[[ Name: addTextLabel ]]
    -- upvalues: l_Frame_0 (copy), v17 (copy)
    local l_TextLabel_0 = Instance.new("TextLabel");
    l_TextLabel_0.Text = v18.Text;
    l_TextLabel_0.TextColor3 = v18.TextColor3 or Color3.fromRGB(255, 255, 255);
    l_TextLabel_0.TextSize = v18.TextSize or 16;
    l_TextLabel_0.TextStrokeColor3 = v18.TextStrokeColor3 or Color3.fromRGB(0, 0, 0);
    l_TextLabel_0.Font = v18.Font or Enum.Font.FredokaOne;
    l_TextLabel_0.BackgroundTransparency = 1;
    l_TextLabel_0.AutomaticSize = Enum.AutomaticSize.XY;
    l_TextLabel_0.Size = UDim2.fromScale(0, 0);
    l_TextLabel_0.TextStrokeTransparency = 0;
    l_TextLabel_0.TextWrapped = true;
    l_TextLabel_0.RichText = true;
    local l_UISizeConstraint_0 = Instance.new("UISizeConstraint");
    l_UISizeConstraint_0.MaxSize = Vector2.new(500, 1e999);
    l_UISizeConstraint_0.MinSize = Vector2.new(0, 0);
    l_UISizeConstraint_0.Parent = l_TextLabel_0;
    l_TextLabel_0.Parent = l_Frame_0;
    v17:GiveInstance(l_TextLabel_0);
end;
local function v24(v22) --[[ Line: 109 ]] --[[ Name: addImageLabel ]]
    -- upvalues: l_Frame_0 (copy), v17 (copy)
    local l_ImageLabel_0 = Instance.new("ImageLabel");
    l_ImageLabel_0.Image = v22.Image;
    l_ImageLabel_0.ImageColor3 = v22.ImageColor3 or Color3.fromRGB(255, 255, 255);
    l_ImageLabel_0.Size = v22.ImageSize or UDim2.fromOffset(50, 50);
    l_ImageLabel_0.BackgroundTransparency = 1;
    l_ImageLabel_0.Parent = l_Frame_0;
    v17:GiveInstance(l_ImageLabel_0);
end;
v6.onRemoved("ToolTip", function(v25) --[[ Line: 120 ]]
    -- upvalues: v16 (copy)
    if v25:IsA("GuiObject") then
        v16[v25] = nil;
    end;
end);
l_RunService_0.Heartbeat:Connect(function(_) --[[ Line: 126 ]]
    -- upvalues: v5 (copy), v16 (copy), l_Frame_0 (copy), v15 (ref), v17 (copy), v21 (copy), v24 (copy), l_UIStroke_0 (copy), l_UICorner_0 (copy), l_UserInputService_0 (copy), l_ScreenGui_0 (copy)
    local v27, _ = v5.getGuiObjectsAtMousePosition();
    local v29 = nil;
    for _, v31 in v27 do
        if v16[v31] then
            v29 = v31;
            break;
        end;
    end;
    if not v29 then
        l_Frame_0.Visible = false;
        v15 = nil;
        return;
    else
        local v32 = v16[v29];
        local _ = v32.Decorations;
        local l_Background_0 = v32.Background;
        if v29 ~= v15 then
            v15 = v29;
            v17:DoCleaning();
            for _, v36 in v32.Decorations do
                if v36.Text then
                    v21(v36);
                else
                    v24(v36);
                end;
            end;
            l_Frame_0.BackgroundTransparency = l_Background_0.BackgroundTransparency;
            l_Frame_0.BackgroundColor3 = l_Background_0.BackgroundColor3;
            l_UIStroke_0.Color = l_Background_0.BorderColor3;
            l_UIStroke_0.Transparency = l_Background_0.BorderTransparency;
            l_UIStroke_0.Thickness = l_Background_0.BorderThickness or 1;
            l_UICorner_0.CornerRadius = l_Background_0.CornerRadius;
        end;
        local _ = v29.AbsolutePosition;
        local _ = v29.AbsoluteSize;
        local l_AbsoluteSize_1 = l_Frame_0.AbsoluteSize;
        local l_l_UserInputService_0_MouseLocation_0 = l_UserInputService_0:GetMouseLocation();
        local l_X_0 = l_l_UserInputService_0_MouseLocation_0.X;
        local v42 = l_l_UserInputService_0_MouseLocation_0.Y - v5.getGuiInset() + 25;
        local l_AbsoluteSize_2 = l_ScreenGui_0.AbsoluteSize;
        local v44 = math.clamp(l_X_0, l_AbsoluteSize_1.X / 2 + 10, l_AbsoluteSize_2.X - l_AbsoluteSize_1.X / 2 - 10);
        local v45 = math.clamp(v42, l_AbsoluteSize_1.Y + 10, l_AbsoluteSize_2.Y - l_AbsoluteSize_1.Y - 10);
        l_Frame_0.Position = UDim2.fromOffset(v44, v45);
        l_Frame_0.Visible = true;
        return;
    end;
end);
return {
    add = function(v46, v47, v48) --[[ Line: 183 ]] --[[ Name: add ]]
        -- upvalues: v16 (copy), l_CollectionService_0 (copy)
        v16[v46] = {
            Decorations = v47, 
            Background = v48
        };
        l_CollectionService_0:AddTag(v46, "ToolTip");
    end, 
    remove = function(v49) --[[ Line: 192 ]] --[[ Name: remove ]]
        -- upvalues: v16 (copy), l_CollectionService_0 (copy)
        v16[v49] = nil;
        l_CollectionService_0:RemoveTag(v49, "ToolTip");
    end
};