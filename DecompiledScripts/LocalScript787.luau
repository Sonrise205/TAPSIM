local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_ContentProvider_0 = game:GetService("ContentProvider");
local v2 = require(l_ReplicatedStorage_0.Modules.GIF);
local v3 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v4 = require(l_ReplicatedStorage_0.Modules.Signal);
local v5 = require(l_ReplicatedStorage_0.Game.Portals);
local l_Frame_0 = script.Parent.Frame;
local v7 = nil;
local function v12(v8) --[[ Line: 16 ]] --[[ Name: Sparkle ]]
    -- upvalues: v7 (ref), v2 (copy)
    local v9 = script.Sprite:Clone();
    local v10 = nil;
    local v11 = nil;
    if v7 then
        v10 = v7;
        v11 = v7:Clone();
        v11.Adornee = v9;
        v7 = v11;
    else
        v11 = v2.new();
        v11.FrameRate = 45;
        v11.InheritSpriteSheet = true;
        v11.Looped = false;
        v11.Adornee = v9;
        v11.SpriteSizePixel = Vector2.new(256, 256);
        v11.SpriteCountX = 4;
        v11.SpriteCount = 8;
        v7 = v11;
    end;
    v9.Parent = v8 or script.Parent.Frame;
    v11:Play();
    task.delay(1, function() --[[ Line: 40 ]]
        -- upvalues: v10 (ref), v9 (copy)
        if v10 then
            v10:Destroy();
        end;
        v9:Destroy();
    end);
end;
local function v27(v13) --[[ Line: 48 ]] --[[ Name: Unlock ]]
    -- upvalues: l_Frame_0 (copy), v5 (copy), v12 (copy), v3 (copy)
    local v14 = l_Frame_0:Clone();
    v14.Parent = script.Parent;
    v14.Visible = true;
    local v15 = v5[v13] or v5.Forest;
    v14.Icon.Image = v15.Image;
    v14.Glow.Glow.ImageColor3 = v15.Color;
    local v16 = {
        [v14] = {
            Position = v14.Position, 
            Size = v14.Size
        }
    };
    for _, v18 in ipairs(v14:GetChildren()) do
        if v18:IsA("GuiObject") then
            v16[v18] = {
                Position = v18.Position, 
                Size = v18.Size
            };
        end;
    end;
    for _, v20 in ipairs(v14.CanvasGroup:GetChildren()) do
        if v20:IsA("TextLabel") then
            v16[v20] = {
                Position = v20.Position, 
                Size = v20.Size
            };
        end;
    end;
    v14.Icon.Size = UDim2.new();
    v14.Icon.Position = UDim2.fromScale(0.5, 0.8);
    v14.Description.Size = UDim2.fromScale(0, 0);
    v14.Description.Size = UDim2.new();
    v14.Glow.Glow.UIGradient.Offset = Vector2.new(0, -0.9);
    v14.Glow.GroupTransparency = 0;
    for _, v22 in ipairs(v14.CanvasGroup:GetChildren()) do
        if v22:IsA("TextLabel") then
            v22.Position = UDim2.fromScale(v22.Position.X.Scale, 1);
            v22.Size = UDim2.fromScale(0.1, 0.5);
        end;
    end;
    script.Parent.Enabled = true;
    v12(v14);
    v3:Tween(v14.Icon, 0.5, "Back", "Out", {
        Size = v16[v14.Icon].Size, 
        Position = v16[v14.Icon].Position
    });
    v3:Tween(v14.Description, 0.3, "Back", "Out", {
        Size = v16[v14.Description].Size
    });
    v3:Tween(v14.Glow.Glow.UIGradient, 0.3, "Quad", "Out", {
        Offset = Vector2.new(0, 0)
    });
    for v23, v24 in ipairs(v14.CanvasGroup:GetChildren()) do
        if v24:IsA("TextLabel") then
            task.delay((15 - v23) / 45, function() --[[ Line: 112 ]]
                -- upvalues: v3 (ref), v24 (copy), v16 (copy)
                v3:Tween(v24, 0.2, "Back", "Out", {
                    Size = v16[v24].Size, 
                    Position = v16[v24].Position
                });
            end);
        end;
    end;
    v3:Tween(v14, 3, "Sine", "InOut", {
        Position = UDim2.fromScale(0.5, 0.047)
    }, nil, nil, function() --[[ Line: 124 ]]
        -- upvalues: v3 (ref), v14 (copy), v16 (copy)
        v3:Tween(v14, 0.3, "Back", "In", {
            Position = v16[v14].Position
        });
        v3:Tween(v14.Icon, 0.4, "Back", "In", {
            Size = UDim2.fromScale(0, 0), 
            Position = UDim2.fromScale(0.5, 0.8)
        });
        v3:Tween(v14.Description, 0.3, "Back", "In", {
            Size = UDim2.fromScale(0, 0)
        });
        v3:Tween(v14.Glow, 0.3, "Quad", "Out", {
            GroupTransparency = 1
        });
        for v25, v26 in ipairs(v14.CanvasGroup:GetChildren()) do
            if v26:IsA("TextLabel") then
                task.delay(v25 / 40, function() --[[ Line: 142 ]]
                    -- upvalues: v3 (ref), v26 (copy)
                    v3:Tween(v26, 0.2, "Back", "Out", {
                        Size = UDim2.fromScale(0.1, 0.5), 
                        Position = UDim2.fromScale(v26.Position.X.Scale, -1)
                    });
                end);
            end;
        end;
        task.delay(1, function() --[[ Line: 152 ]]
            -- upvalues: v14 (ref)
            v14:Destroy();
            script.Parent.Enabled = false;
        end);
    end);
end;
l_ContentProvider_0:PreloadAsync({
    l_Frame_0.Sprite
});
l_Frame_0.Sprite:Destroy();
v4.new("IslandAnimation"):Connect(function(v28) --[[ Line: 162 ]]
    -- upvalues: v27 (copy)
    v27(v28);
end);