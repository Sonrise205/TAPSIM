local l_RunService_0 = game:GetService("RunService");
local l_TweenService_0 = game:GetService("TweenService");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_Parent_0 = script.Parent;
local v4 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local v5 = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
local v6 = Vector2.new(0, 0);
local v7 = {};
local function v24(v8, v9) --[[ Line: 32 ]] --[[ Name: SetupHoverVisibility ]]
    -- upvalues: l_TweenService_0 (copy), v4 (copy), v5 (copy)
    if not v8 then
        return;
    else
        for _, v11 in ipairs(v9) do
            if v11 then
                if v11:IsA("TextLabel") or v11:IsA("TextButton") or v11:IsA("TextBox") then
                    v11.TextTransparency = 1;
                    if v11:FindFirstChildOfClass("UIStroke") then
                        v11:FindFirstChildOfClass("UIStroke").Transparency = 1;
                    end;
                end;
                if v11:IsA("GuiObject") then
                    v11.BackgroundTransparency = 1;
                    for _, v13 in ipairs(v11:GetChildren()) do
                        if v13:IsA("UIStroke") then
                            v13.Transparency = 1;
                        end;
                    end;
                end;
            end;
        end;
        local function v18() --[[ Line: 56 ]] --[[ Name: ShowElements ]]
            -- upvalues: v8 (copy), v9 (copy), l_TweenService_0 (ref), v4 (ref)
            print("here");
            v8.Lightning.Emit:Fire();
            for _, v15 in ipairs(v9) do
                if v15 then
                    if v15:IsA("TextLabel") or v15:IsA("TextButton") or v15:IsA("TextBox") then
                        l_TweenService_0:Create(v15, v4, {
                            TextTransparency = 0
                        }):Play();
                    end;
                    if v15:IsA("Frame") then
                        l_TweenService_0:Create(v15, v4, {
                            BackgroundTransparency = 0
                        }):Play();
                    end;
                    for _, v17 in ipairs(v15:GetChildren()) do
                        if v17:IsA("UIStroke") then
                            l_TweenService_0:Create(v17, v4, {
                                Transparency = 0
                            }):Play();
                        end;
                    end;
                end;
            end;
        end;
        local function v23() --[[ Line: 76 ]] --[[ Name: HideElements ]]
            -- upvalues: v9 (copy), l_TweenService_0 (ref), v5 (ref)
            for _, v20 in ipairs(v9) do
                if v20 then
                    if v20:IsA("TextLabel") or v20:IsA("TextButton") or v20:IsA("TextBox") then
                        l_TweenService_0:Create(v20, v5, {
                            TextTransparency = 1
                        }):Play();
                    end;
                    if v20:IsA("Frame") then
                        l_TweenService_0:Create(v20, v5, {
                            BackgroundTransparency = 1
                        }):Play();
                    end;
                    for _, v22 in ipairs(v20:GetChildren()) do
                        if v22:IsA("UIStroke") then
                            l_TweenService_0:Create(v22, v5, {
                                Transparency = 1
                            }):Play();
                        end;
                    end;
                end;
            end;
        end;
        v8.MouseEnter:Connect(v18);
        v8.MouseLeave:Connect(v23);
        return;
    end;
end;
local function v33(v25, v26, v27) --[[ Line: 100 ]] --[[ Name: SetupViewport ]]
    -- upvalues: v7 (copy)
    if not v25 or not v26 then
        return;
    else
        v27 = v27 or 5;
        local v28 = v26:Clone();
        v28.Parent = v25;
        local l_Camera_0 = Instance.new("Camera");
        l_Camera_0.Parent = v25;
        v25.CurrentCamera = l_Camera_0;
        local l_v28_BoundingBox_0, v31 = v28:GetBoundingBox();
        local _ = math.max(v31.X, v31.Y, v31.Z) * v27 * 0.5;
        l_Camera_0.CFrame = CFrame.new(l_v28_BoundingBox_0.Position + Vector3.new(0, v31.Y * 0.2, 0), l_v28_BoundingBox_0.Position);
        table.insert(v7, {
            model = v28, 
            viewport = v25, 
            originalCFrame = l_v28_BoundingBox_0, 
            index = #v7 + 1
        });
        return v28;
    end;
end;
local function v43(v34) --[[ Line: 133 ]] --[[ Name: SetupFrame ]]
    -- upvalues: v24 (copy), v7 (copy)
    for _, v36 in ipairs(v34:GetDescendants()) do
        if v36:IsA("ViewportFrame") then
            local l_ImageLabel_0 = v36:FindFirstChild("ImageLabel");
            if l_ImageLabel_0 then
                local l_InfoText_0 = l_ImageLabel_0:FindFirstChild("InfoText");
                local l_Info_0 = l_ImageLabel_0:FindFirstChild("Info");
                local v40 = {};
                if l_InfoText_0 then
                    table.insert(v40, l_InfoText_0);
                end;
                if l_Info_0 then
                    table.insert(v40, l_Info_0);
                end;
                if #v40 > 0 then
                    v24(l_ImageLabel_0, v40);
                end;
            end;
        end;
        if v36:IsA("Model") and v36 then
            local l_v36_BoundingBox_0, _ = v36:GetBoundingBox();
            table.insert(v7, {
                model = v36, 
                viewport = v36.Parent, 
                originalCFrame = l_v36_BoundingBox_0, 
                index = #v7 + 1
            });
        end;
    end;
end;
local function _(v44) --[[ Line: 172 ]] --[[ Name: GetViewportCenter ]]
    local l_AbsolutePosition_0 = v44.AbsolutePosition;
    local l_AbsoluteSize_0 = v44.AbsoluteSize;
    return l_AbsolutePosition_0.X + l_AbsoluteSize_0.X / 2, l_AbsolutePosition_0.Y + l_AbsoluteSize_0.Y / 2;
end;
local function v49() --[[ Line: 178 ]] --[[ Name: UpdateScreenCenter ]]
    -- upvalues: v6 (ref)
    local l_CurrentCamera_0 = workspace.CurrentCamera;
    if l_CurrentCamera_0 then
        v6 = l_CurrentCamera_0.ViewportSize / 2;
    end;
end;
local l_CurrentCamera_1 = workspace.CurrentCamera;
if l_CurrentCamera_1 then
    v6 = l_CurrentCamera_1.ViewportSize / 2;
end;
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(v49);
l_RunService_0.RenderStepped:Connect(function(_) --[[ Line: 189 ]]
    -- upvalues: l_UserInputService_0 (copy), v6 (ref), v7 (copy)
    local v52 = tick();
    local l_l_UserInputService_0_MouseLocation_0 = l_UserInputService_0:GetMouseLocation();
    local v54 = (l_l_UserInputService_0_MouseLocation_0.X - v6.X) / v6.X;
    local v55 = (l_l_UserInputService_0_MouseLocation_0.Y - v6.Y) / v6.Y;
    for _, v57 in ipairs(v7) do
        local l_model_0 = v57.model;
        local l_originalCFrame_0 = v57.originalCFrame;
        local l_index_0 = v57.index;
        local l_viewport_0 = v57.viewport;
        v57.currentLookX = v57.currentLookX or 0;
        v57.currentLookY = v57.currentLookY or 0;
        v57.currentParallaxX = v57.currentParallaxX or 0;
        v57.currentParallaxY = v57.currentParallaxY or 0;
        if l_model_0 and l_model_0.Parent and l_viewport_0 then
            local l_AbsolutePosition_1 = l_viewport_0.AbsolutePosition;
            local l_AbsoluteSize_1 = l_viewport_0.AbsoluteSize;
            local v64 = l_AbsolutePosition_1.X + l_AbsoluteSize_1.X / 2;
            local v65 = l_AbsolutePosition_1.Y + l_AbsoluteSize_1.Y / 2;
            l_AbsolutePosition_1 = (v64 - v6.X) / v6.X;
            l_AbsoluteSize_1 = (v65 - v6.Y) / v6.Y;
            local v66 = l_AbsolutePosition_1 * 2 + v54 * 0.6;
            local v67 = l_AbsoluteSize_1 * 2 + v55 * 0.6;
            v57.currentParallaxX = v57.currentParallaxX + (v66 - v57.currentParallaxX) * 0.1;
            v57.currentParallaxY = v57.currentParallaxY + (v67 - v57.currentParallaxY) * 0.1;
            local v68 = l_l_UserInputService_0_MouseLocation_0.X - v64;
            local v69 = l_l_UserInputService_0_MouseLocation_0.Y - v65;
            local v70 = math.sqrt(v68 * v68 + v69 * v69);
            local v71 = 0;
            local v72 = 0;
            if v70 < 350 then
                local v73 = 1 - v70 / 350;
                local v74 = math.clamp(v68 / 350, -1, 1);
                local v75 = math.clamp(v69 / 350, -1, 1);
                v72 = v74 * 0.4363323129985824 * v73;
                v71 = -v75 * 0.4363323129985824 * v73;
            end;
            v57.currentLookX = v57.currentLookX + (v71 - v57.currentLookX) * 0.15;
            v57.currentLookY = v57.currentLookY + (v72 - v57.currentLookY) * 0.15;
            local v76 = math.sin(v52 * 2.3 + l_index_0) * 0.03490658503988659;
            local v77 = math.cos(v52 * 2.3 + l_index_0) * 0.03490658503988659;
            local v78 = Vector3.new(v57.currentParallaxX, -v57.currentParallaxY * 0.5, 0);
            l_model_0:PivotTo(CFrame.new(l_originalCFrame_0.Position + v78) * CFrame.Angles(l_originalCFrame_0:ToEulerAnglesXYZ()) * CFrame.Angles(v76 + v57.currentLookX, v57.currentLookY, v77));
        end;
    end;
end);
v43(l_Parent_0);
return {
    SetupFrame = v43, 
    SetupViewport = v33, 
    SetupHoverVisibility = v24
};