local l_RunService_0 = game:GetService("RunService");
local l_TweenService_0 = game:GetService("TweenService");
local l_Players_0 = game:GetService("Players");
local _ = game:GetService("GuiService");
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_Camera_0 = workspace.Camera;
local v6 = {};
v6.__index = v6;
local v7 = nil;
local v8 = Vector2.new(1920, 1080);
local function _(v9) --[[ Line: 27 ]] --[[ Name: getBox ]]
    return (math.min(v9.X, v9.Y));
end;
local function _() --[[ Line: 31 ]] --[[ Name: getScreenRatio ]]
    -- upvalues: l_Camera_0 (ref), v8 (copy)
    local l_ViewportSize_0 = l_Camera_0.ViewportSize;
    local v12 = math.min(l_ViewportSize_0.X, l_ViewportSize_0.Y);
    local l_v8_0 = v8;
    return v12 / math.min(l_v8_0.X, l_v8_0.Y);
end;
v6.new = function() --[[ Line: 36 ]] --[[ Name: new ]]
    -- upvalues: v7 (ref), v6 (copy), l_LocalPlayer_0 (copy), l_Camera_0 (ref)
    if v7 then
        return v7;
    else
        local v15 = setmetatable({}, v6);
        v15._defaultStrokeTransparency = 0.35;
        v15.holderScreenGui = Instance.new("ScreenGui");
        v15.holderScreenGui.Name = "ScreenFocusHolder";
        v15.holderScreenGui.IgnoreGuiInset = false;
        v15.holderScreenGui.ResetOnSpawn = false;
        v15.holderScreenGui.SafeAreaCompatibility = Enum.SafeAreaCompatibility.None;
        v15.holderScreenGui.ClipToDeviceSafeArea = false;
        v15.holderScreenGui.Parent = l_LocalPlayer_0:WaitForChild("PlayerGui");
        v15.holderScreenGui.DisplayOrder = 999;
        v15.frame = Instance.new("Frame");
        v15.frame.BackgroundColor3 = Color3.new(0, 0, 0);
        v15.frame.BackgroundTransparency = 1;
        v15.frame.AnchorPoint = Vector2.new(0.5, 0.5);
        v15.frame.Size = UDim2.fromScale(0, 0);
        v15.frame.ZIndex = 0;
        v15.frame.Parent = v15.holderScreenGui;
        v15.uiStroke = Instance.new("UIStroke");
        v15.uiStroke.Transparency = v15._defaultStrokeTransparency;
        v15.uiStroke.Thickness = 0;
        v15.uiStroke.LineJoinMode = Enum.LineJoinMode.Round;
        v15.uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual;
        v15.uiStroke.Parent = v15.frame;
        v15.uiCorner = Instance.new("UICorner");
        v15.uiCorner.CornerRadius = UDim.new(0, 0);
        v15.uiCorner.Parent = v15.frame;
        v15._target = nil;
        v15._updateConnection = nil;
        local function v17() --[[ Line: 76 ]] --[[ Name: viewportSizeUpdated ]]
            -- upvalues: l_Camera_0 (ref), v15 (copy)
            local l_Magnitude_0 = l_Camera_0.ViewportSize.Magnitude;
            v15.uiStroke.Thickness = math.floor(l_Magnitude_0);
        end;
        local l_Magnitude_1 = l_Camera_0.ViewportSize.Magnitude;
        v15.uiStroke.Thickness = math.floor(l_Magnitude_1);
        v15._updateUIStrokeThicknessConnection = l_Camera_0:GetPropertyChangedSignal("ViewportSize"):Connect(v17);
        v7 = v15;
        return v7;
    end;
end;
v6._fadeIn = function(v19) --[[ Line: 90 ]] --[[ Name: _fadeIn ]]
    -- upvalues: l_TweenService_0 (copy)
    v19.uiStroke.Transparency = 1;
    l_TweenService_0:Create(v19.uiStroke, TweenInfo.new(0.25), {
        Transparency = v19._defaultStrokeTransparency
    }):Play();
end;
v6._fadeOut = function(v20) --[[ Line: 95 ]] --[[ Name: _fadeOut ]]
    -- upvalues: l_TweenService_0 (copy)
    l_TweenService_0:Create(v20.uiStroke, TweenInfo.new(0.25), {
        Transparency = 1
    }):Play();
end;
v6.FocusAt = function(v21, v22, v23) --[[ Line: 99 ]] --[[ Name: FocusAt ]]
    v21._target = v22;
    v21.frame.Position = UDim2.fromOffset(v22.X, v22.Y);
    v21.frame.Size = UDim2.fromOffset(v23.X, v23.Y);
    v21:FadeIn();
end;
v6.Focus2D = function(v24, v25, v26) --[[ Line: 108 ]] --[[ Name: Focus2D ]]
    -- upvalues: l_RunService_0 (copy), l_Camera_0 (ref), v8 (copy)
    v24._target = v25;
    if v24._updateConnection then
        v24._updateConnection:Disconnect();
    end;
    if v26 == nil then
        v26 = {};
    end;
    v24._pulsateTransparencyTask = task.spawn(function() --[[ Line: 120 ]]
        -- upvalues: v24 (copy), v26 (ref)
        local l_uiStroke_0 = v24.uiStroke;
        local l_ShouldPulsateTransparency_0 = v26.ShouldPulsateTransparency;
        while l_uiStroke_0 and l_uiStroke_0.Parent do
            if l_ShouldPulsateTransparency_0 then
                local v29 = os.clock() % 3;
                if v29 < 0.5 then
                    l_uiStroke_0.Transparency = 0.35 + 0.65 * (v29 / 0.5);
                elseif v29 < 1 then
                    l_uiStroke_0.Transparency = 1 - 0.65 * ((v29 - 0.5) / 0.5);
                else
                    l_uiStroke_0.Transparency = 0.35;
                end;
            else
                l_uiStroke_0.Transparency = v24._defaultStrokeTransparency;
            end;
            task.wait(0.016666666666666666);
        end;
    end);
    v24._updateConnection = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 150 ]]
        -- upvalues: v25 (copy), v24 (copy), l_Camera_0 (ref), v26 (ref), v8 (ref)
        if not v25 or v25.Parent == nil then
            v24:Clear();
            return;
        else
            local _ = l_Camera_0.ViewportSize;
            local l_AbsolutePosition_0 = v25.AbsolutePosition;
            local l_AbsoluteSize_0 = v25.AbsoluteSize;
            local v33;
            if v26.Offset then
                local l_Offset_0 = v26.Offset;
                local l_ViewportSize_2 = l_Camera_0.ViewportSize;
                local v36 = math.min(l_ViewportSize_2.X, l_ViewportSize_2.Y);
                local l_v8_1 = v8;
                v33 = l_Offset_0 * (v36 / math.min(l_v8_1.X, l_v8_1.Y));
            else
                v33 = 0;
            end;
            v24.frame.Position = UDim2.fromOffset(l_AbsolutePosition_0.X + l_AbsoluteSize_0.X / 2, l_AbsolutePosition_0.Y + l_AbsoluteSize_0.Y / 2);
            v24.frame.Size = UDim2.fromOffset(l_AbsoluteSize_0.X + v33, l_AbsoluteSize_0.Y + v33);
            local l_UICorner_0 = v25:FindFirstChildOfClass("UICorner");
            if l_UICorner_0 then
                local l_Scale_0 = l_UICorner_0.CornerRadius.Scale;
                local l_Offset_1 = l_UICorner_0.CornerRadius.Offset;
                if l_Scale_0 == 0 and l_Offset_1 == 0 then
                    v24.uiCorner.CornerRadius = UDim.new(0, 0);
                    return;
                else
                    local l_X_0 = l_AbsoluteSize_0.X;
                    local l_Y_0 = l_AbsoluteSize_0.Y;
                    local v43 = math.min(l_X_0, l_Y_0);
                    local v44 = l_X_0 + v33;
                    local v45 = l_Y_0 + v33;
                    local v46 = math.min(v44, v45);
                    local _ = math.max(0, math.min(l_Offset_1 + l_Scale_0 * v43, v43 * 0.5) + math.min((v44 - l_X_0) * 0.5, (v45 - l_Y_0) * 0.5));
                    local _ = v46 * 0.5;
                    v24.uiCorner.CornerRadius = UDim.new(0.2, 0);
                    return;
                end;
            else
                v24.uiCorner.CornerRadius = UDim.new(0.2, 0);
                return;
            end;
        end;
    end);
    v24:_fadeIn();
end;
v6.Focus3D = function(v49, v50, v51) --[[ Line: 203 ]] --[[ Name: Focus3D ]]
    -- upvalues: l_RunService_0 (copy), l_Camera_0 (ref)
    v49._target = v50;
    if v49._updateConnection then
        v49._updateConnection:Disconnect();
    end;
    if v51 == nil then
        v51 = {};
    end;
    local v52 = v51.Offset or 0;
    v49._pulsateTransparencyTask = task.spawn(function() --[[ Line: 217 ]]
        -- upvalues: v49 (copy)
        local l_uiStroke_1 = v49.uiStroke;
        while l_uiStroke_1 and l_uiStroke_1.Parent do
            l_uiStroke_1.Transparency = v49._defaultStrokeTransparency;
            task.wait(0.016666666666666666);
        end;
    end);
    v49._updateConnection = l_RunService_0.RenderStepped:Connect(function() --[[ Line: 247 ]]
        -- upvalues: l_Camera_0 (ref), v50 (copy), v49 (copy), v52 (copy)
        if not l_Camera_0 then
            l_Camera_0 = workspace.CurrentCamera;
            if not l_Camera_0 then
                return;
            end;
        end;
        local l_CFrame_0 = v50.CFrame;
        local v55 = v50.Size * 0.5;
        local v56 = {
            Vector3.new(-v55.X, -v55.Y, -v55.Z), 
            Vector3.new(-v55.X, -v55.Y, v55.Z), 
            Vector3.new(-v55.X, v55.Y, -v55.Z), 
            Vector3.new(-v55.X, v55.Y, v55.Z), 
            Vector3.new(v55.X, -v55.Y, -v55.Z), 
            Vector3.new(v55.X, -v55.Y, v55.Z), 
            Vector3.new(v55.X, v55.Y, -v55.Z), 
            (Vector3.new(v55.X, v55.Y, v55.Z))
        };
        local v57 = 1e999;
        local v58 = 1e999;
        local v59 = -1e999;
        local v60 = -1e999;
        local v61 = 0;
        for _, v63 in ipairs(v56) do
            local v64 = l_CFrame_0:PointToWorldSpace(v63);
            local v65, v66 = l_Camera_0:WorldToScreenPoint(v64);
            if v66 and v65.Z > 0 then
                v61 = v61 + 1;
                v57 = math.min(v57, v65.X);
                v58 = math.min(v58, v65.Y);
                v59 = math.max(v59, v65.X);
                v60 = math.max(v60, v65.Y);
            end;
        end;
        if v61 >= 4 then
            v49.frame.Visible = true;
            local v67 = v59 - v57 + v52;
            local v68 = v60 - v58 + v52;
            local v69 = (v57 + v59) / 2;
            local v70 = (v58 + v60) / 2;
            v49.frame.Position = UDim2.fromOffset(v69, v70);
            v49.frame.Size = UDim2.fromOffset(v67, v68);
            local v71 = math.min(v67, v68);
            v49.uiCorner.CornerRadius = UDim.new(0, (math.floor(v71 * 0.1)));
            return;
        else
            v49.frame.Visible = false;
            return;
        end;
    end);
    v49:_fadeIn();
end;
v6.Clear = function(v72) --[[ Line: 306 ]] --[[ Name: Clear ]]
    if v72._updateConnection then
        v72._updateConnection:Disconnect();
        v72._updateConnection = nil;
    end;
    if v72._pulsateTransparencyTask then
        task.cancel(v72._pulsateTransparencyTask);
    end;
    v72:_fadeOut();
end;
return v6.new();