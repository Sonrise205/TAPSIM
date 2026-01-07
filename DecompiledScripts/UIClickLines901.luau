local l_TweenService_0 = game:GetService("TweenService");
local l_LocalPlayer_0 = game:GetService("Players").LocalPlayer;
local l_PlayerGui_0 = l_LocalPlayer_0:WaitForChild("PlayerGui");
local v3 = {};
v3.__index = v3;
local v4 = {
    LineCount = 7, 
    Length = 60, 
    Thickness = 6, 
    MoveDistance = 120, 
    StartOffset = 15, 
    Duration = 0.3, 
    FadeTime = 0.15, 
    Color = Color3.fromRGB(255, 255, 255)
};
v3.new = function(v5) --[[ Line: 24 ]] --[[ Name: new ]]
    -- upvalues: v3 (copy), l_PlayerGui_0 (copy)
    local v6 = setmetatable({}, v3);
    v6.Gui = v5 or Instance.new("ScreenGui");
    v6.Gui.Name = "UIClickFX";
    v6.Gui.IgnoreGuiInset = false;
    v6.Gui.ResetOnSpawn = false;
    v6.Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
    v6.Gui.Parent = l_PlayerGui_0;
    return v6;
end;
local function v11(v7, v8) --[[ Line: 35 ]] --[[ Name: createLine ]]
    -- upvalues: v4 (copy)
    local l_Frame_0 = Instance.new("Frame");
    l_Frame_0.AnchorPoint = Vector2.new(0.5, 0.5);
    l_Frame_0.Position = v8;
    l_Frame_0.Size = UDim2.fromOffset(v4.Length, v4.Thickness);
    l_Frame_0.BackgroundColor3 = v4.Color;
    l_Frame_0.BorderSizePixel = 0;
    l_Frame_0.BackgroundTransparency = 0;
    l_Frame_0.Rotation = 0;
    l_Frame_0.Parent = v7;
    local l_UIStroke_0 = Instance.new("UIStroke");
    l_UIStroke_0.Thickness = 1;
    l_UIStroke_0.Color = Color3.new(1, 1, 1);
    l_UIStroke_0.Transparency = 0.4;
    l_UIStroke_0.Parent = l_Frame_0;
    return l_Frame_0;
end;
v3.SpawnBurst = function(v12, v13) --[[ Line: 55 ]] --[[ Name: SpawnBurst ]]
    -- upvalues: v4 (copy), v11 (copy), l_TweenService_0 (copy)
    for _ = 1, v4.LineCount do
        local v15 = math.rad((math.random(0, 360)));
        local v16 = Vector2.new(math.cos(v15), (math.sin(v15)));
        local v17 = v13 + v16 * v4.StartOffset;
        local v18 = v11(v12.Gui, UDim2.fromOffset(v17.X, v17.Y));
        v18.Rotation = math.deg(v15);
        local v19 = v17 + v16 * v4.MoveDistance;
        l_TweenService_0:Create(v18, TweenInfo.new(v4.Duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.fromOffset(v19.X, v19.Y), 
            BackgroundTransparency = 1
        }):Play();
        l_TweenService_0:Create(v18.UIStroke, TweenInfo.new(v4.Duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
        game:GetService("Debris"):AddItem(v18, v4.Duration + v4.FadeTime);
    end;
end;
v3.Enable = function(v20) --[[ Line: 90 ]] --[[ Name: Enable ]]
    -- upvalues: l_LocalPlayer_0 (copy)
    if v20._conn then
        return;
    else
        local l_l_LocalPlayer_0_Mouse_0 = l_LocalPlayer_0:GetMouse();
        v20._conn = l_l_LocalPlayer_0_Mouse_0.Button1Down:Connect(function() --[[ Line: 93 ]]
            -- upvalues: v20 (copy), l_l_LocalPlayer_0_Mouse_0 (copy)
            v20:SpawnBurst(Vector2.new(l_l_LocalPlayer_0_Mouse_0.X, l_l_LocalPlayer_0_Mouse_0.Y));
        end);
        return;
    end;
end;
v3.Disable = function(v22) --[[ Line: 98 ]] --[[ Name: Disable ]]
    if v22._conn then
        v22._conn:Disconnect();
        v22._conn = nil;
    end;
end;
return v3;