local l_Players_0 = game:GetService("Players");
local l_TweenService_0 = game:GetService("TweenService");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_RunService_0 = game:GetService("RunService");
local l_PlayerGui_0 = l_Players_0.LocalPlayer:WaitForChild("PlayerGui");
local v5 = tick();
local v6 = nil;
local v7 = nil;
local v8 = false;
local l_CurrentCamera_0 = workspace.CurrentCamera;
local v12 = (function() --[[ Line: 26 ]] --[[ Name: buildUI ]]
    -- upvalues: v6 (ref), l_PlayerGui_0 (copy), v7 (ref)
    v6 = Instance.new("ScreenGui");
    v6.Name = "AFKWarning";
    v6.IgnoreGuiInset = true;
    v6.ResetOnSpawn = false;
    v6.Parent = l_PlayerGui_0;
    local l_Frame_0 = Instance.new("Frame");
    l_Frame_0.Name = "Box";
    l_Frame_0.AnchorPoint = Vector2.new(0, 1);
    l_Frame_0.Position = UDim2.new(0, 20, 1, -20);
    l_Frame_0.Size = UDim2.new(0, 0, 0, 0);
    l_Frame_0.BackgroundColor3 = Color3.fromRGB(30, 30, 35);
    l_Frame_0.BackgroundTransparency = 0.25;
    l_Frame_0.BorderSizePixel = 0;
    l_Frame_0.Parent = v6;
    Instance.new("UICorner", l_Frame_0).CornerRadius = UDim.new(0, 8);
    Instance.new("UIPadding", l_Frame_0).PaddingLeft = UDim.new(0, 12);
    l_Frame_0.UIPadding.PaddingRight = UDim.new(0, 12);
    l_Frame_0.UIPadding.PaddingTop = UDim.new(0, 8);
    l_Frame_0.UIPadding.PaddingBottom = UDim.new(0, 8);
    v7 = Instance.new("TextLabel");
    v7.BackgroundTransparency = 1;
    v7.Size = UDim2.new(1, 0, 1, 0);
    v7.Font = Enum.Font.GothamBold;
    v7.TextSize = 14;
    v7.TextXAlignment = Enum.TextXAlignment.Left;
    v7.TextColor3 = Color3.fromRGB(255, 200, 100);
    v7.Text = "\226\154\160\239\184\143 You'll be kicked for AFK in " .. 16 .. " minutes.";
    v7.TextTransparency = 1;
    v7.Parent = l_Frame_0;
    local l_UIStroke_0 = Instance.new("UIStroke");
    l_UIStroke_0.Color = Color3.fromRGB(255, 180, 60);
    l_UIStroke_0.Thickness = 1;
    l_UIStroke_0.Transparency = 0.7;
    l_UIStroke_0.Parent = l_Frame_0;
    return l_Frame_0;
end)();
local function v13() --[[ Line: 72 ]] --[[ Name: show ]]
    -- upvalues: v8 (ref), l_TweenService_0 (copy), v12 (copy), v7 (ref)
    if v8 then
        return;
    else
        v8 = true;
        l_TweenService_0:Create(v12, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 300, 0, 38)
        }):Play();
        task.wait(0.2);
        l_TweenService_0:Create(v7, TweenInfo.new(0.25), {
            TextTransparency = 0
        }):Play();
        return;
    end;
end;
local function v14() --[[ Line: 84 ]] --[[ Name: hide ]]
    -- upvalues: v8 (ref), l_TweenService_0 (copy), v7 (ref), v12 (copy)
    if not v8 then
        return;
    else
        v8 = false;
        l_TweenService_0:Create(v7, TweenInfo.new(0.2), {
            TextTransparency = 1
        }):Play();
        task.wait(0.15);
        l_TweenService_0:Create(v12, TweenInfo.new(0.25), {
            Size = UDim2.new(0, 0, 0, 0)
        }):Play();
        return;
    end;
end;
local l_CFrame_0 = l_CurrentCamera_0.CFrame;
local function v16() --[[ Line: 96 ]] --[[ Name: registerActivity ]]
    -- upvalues: v5 (ref), v8 (ref), v14 (copy)
    v5 = tick();
    if v8 then
        v14();
    end;
end;
l_UserInputService_0.InputBegan:Connect(v16);
l_UserInputService_0.InputChanged:Connect(v16);
l_UserInputService_0.TouchStarted:Connect(v16);
l_RunService_0.RenderStepped:Connect(function() --[[ Line: 107 ]]
    -- upvalues: l_CurrentCamera_0 (copy), l_CFrame_0 (ref), v5 (ref), v8 (ref), v14 (copy)
    if (l_CurrentCamera_0.CFrame.Position - l_CFrame_0.Position).Magnitude > 0.01 then
        v5 = tick();
        if v8 then
            v14();
        end;
    end;
    l_CFrame_0 = l_CurrentCamera_0.CFrame;
end);
task.spawn(function() --[[ Line: 115 ]]
    -- upvalues: v5 (ref), v13 (copy), v14 (copy)
    while true do
        task.wait(1);
        local v17 = tick() - v5;
        if v17 < 1140 then
            if v17 >= 180 then
                v13();
            else
                v14();
            end;
        end;
    end;
end);