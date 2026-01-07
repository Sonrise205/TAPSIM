local l_TweenService_0 = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local v2 = {};
v2.__index = v2;
local function _(v3, v4, v5, v6) --[[ Line: 29 ]] --[[ Name: quadraticBezier ]]
    local v7 = 1 - v3;
    return v7 * v7 * v4 + v7 * 2 * v3 * v5 + v3 * v3 * v6;
end;
local function _(v9, v10, v11, v12, v13) --[[ Line: 35 ]] --[[ Name: cubicBezier ]]
    local v14 = 1 - v9;
    return v14 ^ 3 * v10 + v14 ^ 2 * 3 * v9 * v11 + v14 * 3 * v9 ^ 2 * v12 + v9 ^ 3 * v13;
end;
v2.new = function() --[[ Line: 40 ]] --[[ Name: new ]]
    -- upvalues: v2 (copy)
    local v16 = setmetatable({}, v2);
    v16.isActive = false;
    v16.connection = nil;
    v16.targetGui = nil;
    v16.cursorGui = nil;
    v16.clickEffectGui = nil;
    v16.customStartPosition = nil;
    v16.customEndPosition = nil;
    v16.startOffset = Vector2.new(-200, -150);
    v16.useRelativePositions = true;
    v16.pathDuration = 1.5;
    v16.clickInterval = 1.5;
    v16.curveRadius = 80;
    v16.useCubicBezier = true;
    v16.elapsedTime = 0;
    v16.lastClickTime = -999;
    v16.hasClickedThisCycle = false;
    v16:_createCursorGui();
    return v16;
end;
v2._createCursorGui = function(v17) --[[ Line: 72 ]] --[[ Name: _createCursorGui ]]
    -- upvalues: l_TweenService_0 (copy)
    local l_ScreenGui_0 = Instance.new("ScreenGui");
    l_ScreenGui_0.Name = "OnboardingCursorGui";
    l_ScreenGui_0.ResetOnSpawn = false;
    l_ScreenGui_0.DisplayOrder = 1001;
    l_ScreenGui_0.IgnoreGuiInset = true;
    l_ScreenGui_0.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    local l_Frame_0 = Instance.new("Frame");
    l_Frame_0.Name = "Cursor";
    l_Frame_0.Size = UDim2.fromOffset(120, 120);
    l_Frame_0.Position = UDim2.fromScale(0.5, 0.5);
    l_Frame_0.AnchorPoint = Vector2.new(0.5, 0.5);
    l_Frame_0.BackgroundTransparency = 1;
    l_Frame_0.ZIndex = 1001;
    l_Frame_0.Parent = l_ScreenGui_0;
    local l_UIScale_0 = Instance.new("UIScale");
    l_UIScale_0.Name = "UIScale";
    l_UIScale_0.Scale = 1;
    l_UIScale_0.Parent = l_Frame_0;
    local l_ImageLabel_0 = Instance.new("ImageLabel");
    l_ImageLabel_0.Name = "CursorImage";
    l_ImageLabel_0.Size = UDim2.fromScale(1, 1);
    l_ImageLabel_0.Position = UDim2.fromScale(0.5, 0.5);
    l_ImageLabel_0.AnchorPoint = Vector2.new(0.5, 0.5);
    l_ImageLabel_0.BackgroundTransparency = 1;
    l_ImageLabel_0.Image = "rbxassetid://75575449919105";
    l_ImageLabel_0.ScaleType = Enum.ScaleType.Fit;
    l_ImageLabel_0.ImageColor3 = Color3.fromRGB(255, 255, 255);
    l_ImageLabel_0.Parent = l_Frame_0;
    local l_ImageLabel_1 = Instance.new("ImageLabel");
    l_ImageLabel_1.Name = "Glow";
    l_ImageLabel_1.Size = UDim2.fromScale(1.5, 1.5);
    l_ImageLabel_1.Position = UDim2.fromScale(0.5, 0.5);
    l_ImageLabel_1.AnchorPoint = Vector2.new(0.5, 0.5);
    l_ImageLabel_1.BackgroundTransparency = 1;
    l_ImageLabel_1.Image = "rbxasset://6673021990";
    l_ImageLabel_1.ImageColor3 = Color3.fromRGB(255, 255, 100);
    l_ImageLabel_1.ImageTransparency = 0.5;
    l_ImageLabel_1.ZIndex = 1000;
    l_ImageLabel_1.Parent = l_Frame_0;
    local v23 = l_TweenService_0:Create(l_ImageLabel_1, TweenInfo.new(0.8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true), {
        ImageTransparency = 0.8, 
        Size = UDim2.fromScale(2, 2)
    });
    v23:Play();
    v17.cursorGui = l_ScreenGui_0;
    v17.cursorFrame = l_Frame_0;
    v17.cursorImage = l_ImageLabel_0;
    v17.glowTween = v23;
    v17.cursorScale = l_UIScale_0;
end;
v2._createClickEffect = function(v24, v25) --[[ Line: 142 ]] --[[ Name: _createClickEffect ]]
    -- upvalues: l_TweenService_0 (copy)
    if not v24.cursorGui then
        return;
    else
        local l_Frame_1 = Instance.new("Frame");
        l_Frame_1.Name = "ClickEffect";
        l_Frame_1.Size = UDim2.fromOffset(60, 60);
        l_Frame_1.Position = UDim2.fromOffset(v25.X, v25.Y);
        l_Frame_1.AnchorPoint = Vector2.new(0.5, 0.5);
        l_Frame_1.BackgroundTransparency = 1;
        l_Frame_1.ZIndex = 1002;
        l_Frame_1.Parent = v24.cursorGui;
        local l_ImageLabel_2 = Instance.new("ImageLabel");
        l_ImageLabel_2.Name = "Circle";
        l_ImageLabel_2.Size = UDim2.fromScale(1, 1);
        l_ImageLabel_2.Position = UDim2.fromScale(0.5, 0.5);
        l_ImageLabel_2.AnchorPoint = Vector2.new(0.5, 0.5);
        l_ImageLabel_2.BackgroundTransparency = 1;
        l_ImageLabel_2.Image = "rbxasset://10928806253";
        l_ImageLabel_2.ImageColor3 = Color3.fromRGB(255, 255, 255);
        l_ImageLabel_2.ImageTransparency = 0.7;
        l_ImageLabel_2.Parent = l_Frame_1;
        local l_UIStroke_0 = Instance.new("UIStroke");
        l_UIStroke_0.Color = Color3.fromRGB(255, 255, 255);
        l_UIStroke_0.Thickness = 5;
        l_UIStroke_0.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        l_UIStroke_0.Parent = l_ImageLabel_2;
        local l_UICorner_0 = Instance.new("UICorner");
        l_UICorner_0.CornerRadius = UDim.new(1, 0);
        l_UICorner_0.Parent = l_ImageLabel_2;
        local v30 = l_TweenService_0:Create(l_Frame_1, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.fromOffset(200, 200)
        });
        local v31 = l_TweenService_0:Create(l_ImageLabel_2, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ImageTransparency = 1
        });
        local v32 = l_TweenService_0:Create(l_UIStroke_0, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 1
        });
        v30:Play();
        v31:Play();
        v32:Play();
        v30.Completed:Connect(function() --[[ Line: 209 ]]
            -- upvalues: l_Frame_1 (copy)
            l_Frame_1:Destroy();
        end);
        return;
    end;
end;
v2._getBezierPoints = function(v33, v34) --[[ Line: 214 ]] --[[ Name: _getBezierPoints ]]
    local l_curveRadius_0 = v33.curveRadius;
    if v33.useCubicBezier then
        return {
            v34 + Vector2.new(l_curveRadius_0, 0), 
            v34 + Vector2.new(l_curveRadius_0, -l_curveRadius_0 * 1.2), 
            v34 + Vector2.new(-l_curveRadius_0, -l_curveRadius_0 * 1.2), 
            v34 + Vector2.new(-l_curveRadius_0, 0), 
            v34 + Vector2.new(-l_curveRadius_0, l_curveRadius_0 * 1.2), 
            v34 + Vector2.new(l_curveRadius_0, l_curveRadius_0 * 1.2)
        };
    else
        return {
            v34 + Vector2.new(l_curveRadius_0, 0), 
            v34 + Vector2.new(0, -l_curveRadius_0 * 1.5), 
            v34 + Vector2.new(-l_curveRadius_0, 0), 
            v34 + Vector2.new(0, l_curveRadius_0 * 1.5)
        };
    end;
end;
v2._updateCursorPosition = function(v36, v37) --[[ Line: 246 ]] --[[ Name: _updateCursorPosition ]]
    -- upvalues: l_TweenService_0 (copy)
    if not v36.targetGui or not v36.cursorFrame then
        return;
    elseif not v36.targetGui.Parent then
        warn("[OnboardingCursor] Target GUI was destroyed, stopping cursor");
        v36:Stop();
        return;
    else
        v36.elapsedTime = v36.elapsedTime + v37;
        local l_AbsolutePosition_0 = v36.targetGui.AbsolutePosition;
        local l_AbsoluteSize_0 = v36.targetGui.AbsoluteSize;
        if l_AbsoluteSize_0.X <= 0 or l_AbsoluteSize_0.Y <= 0 then
            warn("[OnboardingCursor] Target GUI has invalid size, stopping cursor");
            v36:Stop();
            return;
        else
            local v40 = Vector2.new(l_AbsolutePosition_0.X + l_AbsoluteSize_0.X / 2, l_AbsolutePosition_0.Y + l_AbsoluteSize_0.Y / 2 + v36.cursorFrame.AbsoluteSize.Y / 2);
            local v41 = v40 + v36.startOffset;
            local v42 = v36.pathDuration + 0.3;
            local v43 = math.min(v36.elapsedTime % v42 / v42 / (v36.pathDuration / v42), 1);
            local v44 = nil;
            local v45 = v41 + Vector2.new(80, 0);
            local v46 = v40 + Vector2.new(0, -60);
            local v47 = 1 - v43;
            v44 = v47 ^ 3 * v41 + v47 ^ 2 * 3 * v43 * v45 + v47 * 3 * v43 ^ 2 * v46 + v43 ^ 3 * v40;
            v36.cursorFrame.Position = UDim2.fromOffset(v44.X, v44.Y);
            if v36.cursorScale then
                if v43 >= 0.7 and v43 < 1 then
                    v47 = (v43 - 0.7) / 0.3;
                    v36.cursorScale.Scale = v47 * 0.2 + 1;
                elseif v43 >= 1 then
                    v36.cursorScale.Scale = 1.2;
                else
                    v36.cursorScale.Scale = 1;
                end;
            end;
            if v43 >= 1 then
                if not v36.hasClickedThisCycle then
                    v36.hasClickedThisCycle = true;
                    v36:_createClickEffect(v40);
                    if v36.cursorScale then
                        v36.cursorScale.Scale = 0.9;
                        l_TweenService_0:Create(v36.cursorScale, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                            Scale = 1.2
                        }):Play();
                        return;
                    end;
                end;
            else
                v36.hasClickedThisCycle = false;
            end;
            return;
        end;
    end;
end;
v2.SetTarget = function(v48, v49) --[[ Line: 333 ]] --[[ Name: SetTarget ]]
    v48.targetGui = v49;
end;
v2.SetStartPosition = function(v50, v51) --[[ Line: 337 ]] --[[ Name: SetStartPosition ]]
    v50.customStartPosition = v51;
end;
v2.SetEndPosition = function(v52, v53) --[[ Line: 341 ]] --[[ Name: SetEndPosition ]]
    v52.customEndPosition = v53;
end;
v2.SetStartOffset = function(v54, v55) --[[ Line: 345 ]] --[[ Name: SetStartOffset ]]
    v54.startOffset = v55;
end;
v2.SetCursorImage = function(v56, v57) --[[ Line: 351 ]] --[[ Name: SetCursorImage ]]
    if v56.cursorImage then
        v56.cursorImage.Image = v57;
    end;
end;
v2.SetCursorColor = function(v58, v59) --[[ Line: 357 ]] --[[ Name: SetCursorColor ]]
    if v58.cursorImage then
        v58.cursorImage.ImageColor3 = v59;
    end;
end;
v2.SetPathDuration = function(v60, v61) --[[ Line: 363 ]] --[[ Name: SetPathDuration ]]
    v60.pathDuration = v61;
end;
v2.SetClickInterval = function(v62, v63) --[[ Line: 367 ]] --[[ Name: SetClickInterval ]]
    v62.clickInterval = v63;
end;
v2.SetCurveRadius = function(v64, v65) --[[ Line: 371 ]] --[[ Name: SetCurveRadius ]]
    v64.curveRadius = v65;
end;
v2.SetBezierType = function(v66, v67) --[[ Line: 375 ]] --[[ Name: SetBezierType ]]
    v66.useCubicBezier = v67;
end;
v2.Start = function(v68) --[[ Line: 379 ]] --[[ Name: Start ]]
    -- upvalues: l_RunService_0 (copy)
    if v68.isActive then
        return;
    elseif not v68.targetGui then
        warn("OnboardingCursor: No target set. Use SetTarget() first.");
        return;
    else
        v68.isActive = true;
        v68.elapsedTime = 0;
        v68.lastClickTime = 0;
        local l_LocalPlayer_0 = game:GetService("Players").LocalPlayer;
        if l_LocalPlayer_0 then
            v68.cursorGui.Parent = l_LocalPlayer_0:WaitForChild("PlayerGui");
        end;
        v68.connection = l_RunService_0.RenderStepped:Connect(function(v70) --[[ Line: 397 ]]
            -- upvalues: v68 (copy)
            v68:_updateCursorPosition(v70);
        end);
        return;
    end;
end;
v2.Stop = function(v71) --[[ Line: 402 ]] --[[ Name: Stop ]]
    if not v71.isActive then
        return;
    else
        v71.isActive = false;
        if v71.connection then
            v71.connection:Disconnect();
            v71.connection = nil;
        end;
        if v71.cursorGui then
            v71.cursorGui.Parent = nil;
        end;
        return;
    end;
end;
v2.IsActive = function(v72) --[[ Line: 417 ]] --[[ Name: IsActive ]]
    return v72.isActive;
end;
v2.Destroy = function(v73) --[[ Line: 421 ]] --[[ Name: Destroy ]]
    v73:Stop();
    if v73.glowTween then
        v73.glowTween:Cancel();
        v73.glowTween = nil;
    end;
    if v73.cursorGui then
        v73.cursorGui:Destroy();
        v73.cursorGui = nil;
    end;
    v73.targetGui = nil;
    v73.cursorFrame = nil;
    v73.cursorImage = nil;
end;
return v2;