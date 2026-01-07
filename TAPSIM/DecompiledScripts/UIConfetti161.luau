local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_CurrentCamera_0 = workspace.CurrentCamera;
local l_ConfettiShapes_0 = l_ReplicatedStorage_0:WaitForChild("Content"):WaitForChild("ConfettiShapes");
local v3 = {
    Circle = 20, 
    Square = 20, 
    Triangle = 20, 
    Heart = 10, 
    Star = 5, 
    Diamond = 5
};
local function v11() --[[ Line: 14 ]] --[[ Name: getRandomConfettiShape ]]
    -- upvalues: v3 (copy), l_ConfettiShapes_0 (copy)
    local v4 = 0;
    for _, v6 in v3 do
        v4 = v4 + v6;
    end;
    local v7 = math.random(v4);
    local v8 = 0;
    for v9, v10 in v3 do
        v8 = v8 + v10;
        if v7 <= v8 then
            return l_ConfettiShapes_0:FindFirstChild(v9);
        end;
    end;
end;
local v12 = {};
v12.__index = v12;
v12.new = function(v13) --[[ Line: 41 ]] --[[ Name: new ]]
    -- upvalues: v12 (copy), v11 (copy)
    if not v13 then
        return;
    else
        local v14 = setmetatable({}, v12);
        local v15 = if v13.Force.X < 0 then v13.Force.X * -1 else v13.Force.X;
        v13.Force = Vector2.new(v13.Force.X, v13.Force.Y + (0 - v15) * 0.8);
        local v16 = nil;
        if not v13.Colors then
            v13.Colors = {
                Color3.fromRGB(118, 0, 253), 
                Color3.fromRGB(0, 195, 255), 
                Color3.fromRGB(89, 255, 0), 
                Color3.fromRGB(255, 44, 48), 
                Color3.fromRGB(255, 191, 0)
            };
        end;
        v16 = v13.Colors;
        v14.Gravity = v13.Gravity or Vector2.new(0, 1);
        v14.EmitterPosition = v13.Position;
        v14.EmitterPower = v13.Force;
        v14.Position = Vector2.new(0, 0);
        v14.Power = v13.Force;
        v14.Colors = v13.Colors;
        v14.CurrentColor = v16[math.random(#v16)];
        local function _() --[[ Line: 73 ]] --[[ Name: getParticle ]]
            -- upvalues: v11 (ref), v14 (copy), v13 (copy)
            local v17 = v11():Clone();
            v17.ImageColor3 = v14.CurrentColor;
            v17.Parent = v13.Parent;
            v17.Rotation = math.random(360);
            v17.Visible = true;
            v17.ZIndex = 200;
            return v17;
        end;
        local v19 = v11():Clone();
        v19.ImageColor3 = v14.CurrentColor;
        v19.Parent = v13.Parent;
        v19.Rotation = math.random(360);
        v19.Visible = true;
        v19.ZIndex = 200;
        v14.Label = v19;
        v14.DefaultSize = 30;
        v14.Size = 1;
        v14.Side = -1;
        v14.OutOfBounds = false;
        v14.Enabled = false;
        v14.Cycles = 0;
        return v14;
    end;
end;
v12.Update = function(v20) --[[ Line: 94 ]] --[[ Name: Update ]]
    -- upvalues: l_CurrentCamera_0 (copy)
    if v20.Enabled and v20.OutOfBounds then
        v20.Label.ImageColor3 = v20.CurrentColor;
        v20.Position = Vector2.new(0, 0);
        v20.Power = Vector2.new(v20.EmitterPower.X + math.random(10) - 5, v20.EmitterPower.Y + math.random(10) - 5);
        v20.Cycles = v20.Cycles + 1;
    end;
    if not v20.Enabled and v20.OutOfBounds or not v20.Enabled and v20.Cycles == 0 then
        v20.Label.Visible = false;
        v20.OutOfBounds = true;
        v20.CurrentColor = v20.Colors[math.random(#v20.Colors)];
        return;
    else
        v20.Label.Visible = true;
        local l_EmitterPosition_0 = v20.EmitterPosition;
        local l_Position_0 = v20.Position;
        local l_Power_0 = v20.Power;
        local l_Label_0 = v20.Label;
        if l_Label_0 then
            local v25 = Vector2.new(l_Position_0.X - l_Power_0.X, l_Position_0.Y - l_Power_0.Y);
            local v26 = Vector2.new(l_Power_0.X / 1.05 - v20.Gravity.X, l_Power_0.Y / 1.05 - v20.Gravity.Y);
            local l_ViewportSize_0 = l_CurrentCamera_0.ViewportSize;
            l_Label_0.Position = UDim2.new(l_EmitterPosition_0.X, v25.X, l_EmitterPosition_0.Y, v25.Y);
            v20.OutOfBounds = l_Label_0.AbsolutePosition.X > l_ViewportSize_0.X and v20.Gravity.X > 0 or l_Label_0.AbsolutePosition.Y > l_ViewportSize_0.Y and v20.Gravity.Y > 0 or l_Label_0.AbsolutePosition.X < 0 and v20.Gravity.X < 0 or l_Label_0.AbsolutePosition.Y < 0 and v20.Gravity.Y < 0;
            v20.Position = v25;
            v20.Power = v26;
            if v26.Y < 0 then
                if v20.Size <= 0 then
                    v20.Side = 1;
                    l_Label_0.ImageColor3 = v20.CurrentColor;
                end;
                if v20.Size >= v20.DefaultSize then
                    v20.Side = -1;
                    l_Label_0.ImageColor3 = Color3.new(v20.CurrentColor.r * 0.9, v20.CurrentColor.g * 0.9, v20.CurrentColor.b * 0.9);
                end;
                v20.Size = v20.Size + v20.Side * 2;
                l_Label_0.Size = UDim2.new(0, v20.DefaultSize, 0, v20.Size);
            end;
        end;
        return;
    end;
end;
v12.Toggle = function(v28) --[[ Line: 145 ]] --[[ Name: Toggle ]]
    v28.Enabled = not v28.Enabled;
end;
v12.Destroy = function(v29) --[[ Line: 149 ]] --[[ Name: Destroy ]]
    v29.Label:Destroy();
    table.clear(v29);
    setmetatable(v29, nil);
end;
return v12;