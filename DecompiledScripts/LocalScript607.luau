local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_ContentProvider_0 = game:GetService("ContentProvider");
local v2 = require(l_ReplicatedStorage_0.Modules.GIF);
local v3 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v4 = require(l_ReplicatedStorage_0.Modules.Signal);
local _ = require(l_ReplicatedStorage_0.Game.Portals);
local v6 = require(l_ReplicatedStorage_0.Game.Titles);
local v7 = require(l_ReplicatedStorage_0.Game.Ranks);
local l_Frame_0 = script.Parent.Frame;
local v9 = nil;
local function v14(v10) --[[ Line: 18 ]] --[[ Name: Sparkle ]]
    -- upvalues: v9 (ref), v2 (copy)
    local v11 = script.Sprite:Clone();
    local v12 = nil;
    local v13 = nil;
    if v9 then
        v12 = v9;
        v13 = v9:Clone();
        v13.Adornee = v11;
        v9 = v13;
    else
        v13 = v2.new();
        v13.FrameRate = 45;
        v13.InheritSpriteSheet = true;
        v13.Looped = false;
        v13.Adornee = v11;
        v13.SpriteSizePixel = Vector2.new(256, 256);
        v13.SpriteCountX = 4;
        v13.SpriteCount = 8;
        v9 = v13;
    end;
    v11.Parent = v10 or script.Parent.Frame;
    v13:Play();
    task.delay(1, function() --[[ Line: 42 ]]
        -- upvalues: v12 (ref), v11 (copy)
        if v12 then
            v12:Destroy();
        end;
        v11:Destroy();
    end);
end;
local function v28(v15) --[[ Line: 50 ]] --[[ Name: Unlock ]]
    -- upvalues: l_Frame_0 (copy), v6 (copy), v7 (copy), v14 (copy), v3 (copy)
    local v16 = l_Frame_0:Clone();
    v16.Parent = script.Parent;
    v16.Visible = true;
    v6.ApplyLabel(v16.Description, v7.Ranks[v15].Title.label.Name);
    local v17 = {
        [v16] = {
            Position = v16.Position, 
            Size = v16.Size
        }
    };
    for _, v19 in ipairs(v16:GetChildren()) do
        if v19:IsA("GuiObject") then
            v17[v19] = {
                Position = v19.Position, 
                Size = v19.Size
            };
        end;
    end;
    for _, v21 in ipairs(v16.CanvasGroup:GetChildren()) do
        if v21:IsA("TextLabel") then
            v17[v21] = {
                Position = v21.Position, 
                Size = v21.Size
            };
        end;
    end;
    v16.Icon.Size = UDim2.new();
    v16.Icon.Position = UDim2.fromScale(0.5, 0.8);
    v16.Description.Size = UDim2.fromScale(0, 0);
    v16.Description.Size = UDim2.new();
    v16.Glow.Glow.UIGradient.Offset = Vector2.new(0, -0.9);
    v16.Glow.GroupTransparency = 0;
    for _, v23 in ipairs(v16.CanvasGroup:GetChildren()) do
        if v23:IsA("TextLabel") then
            v23.Position = UDim2.fromScale(v23.Position.X.Scale, 1);
            v23.Size = UDim2.fromScale(0.1, 0.5);
        end;
    end;
    script.Parent.Enabled = true;
    v14(v16);
    v3:Tween(v16.Icon, 0.5, "Back", "Out", {
        Size = v17[v16.Icon].Size, 
        Position = v17[v16.Icon].Position
    });
    v3:Tween(v16.Description, 0.3, "Back", "Out", {
        Size = v17[v16.Description].Size
    });
    v3:Tween(v16.Glow.Glow.UIGradient, 0.3, "Quad", "Out", {
        Offset = Vector2.new(0, 0)
    });
    for v24, v25 in ipairs(v16.CanvasGroup:GetChildren()) do
        if v25:IsA("TextLabel") then
            task.delay((15 - v24) / 45, function() --[[ Line: 111 ]]
                -- upvalues: v3 (ref), v25 (copy), v17 (copy)
                v3:Tween(v25, 0.2, "Back", "Out", {
                    Size = v17[v25].Size, 
                    Position = v17[v25].Position
                });
            end);
        end;
    end;
    v3:Tween(v16, 3, "Sine", "InOut", {
        Position = UDim2.fromScale(0.5, 0.047)
    }, nil, nil, function() --[[ Line: 123 ]]
        -- upvalues: v3 (ref), v16 (copy), v17 (copy)
        v3:Tween(v16, 0.3, "Back", "In", {
            Position = v17[v16].Position
        });
        v3:Tween(v16.Icon, 0.4, "Back", "In", {
            Size = UDim2.fromScale(0, 0), 
            Position = UDim2.fromScale(0.5, 0.8)
        });
        v3:Tween(v16.Description, 0.3, "Back", "In", {
            Size = UDim2.fromScale(0, 0)
        });
        v3:Tween(v16.Glow, 0.3, "Quad", "Out", {
            GroupTransparency = 1
        });
        for v26, v27 in ipairs(v16.CanvasGroup:GetChildren()) do
            if v27:IsA("TextLabel") then
                task.delay(v26 / 40, function() --[[ Line: 141 ]]
                    -- upvalues: v3 (ref), v27 (copy)
                    v3:Tween(v27, 0.2, "Back", "Out", {
                        Size = UDim2.fromScale(0.1, 0.5), 
                        Position = UDim2.fromScale(v27.Position.X.Scale, -1)
                    });
                end);
            end;
        end;
        task.delay(1, function() --[[ Line: 151 ]]
            -- upvalues: v16 (ref)
            v16:Destroy();
            script.Parent.Enabled = false;
        end);
    end);
end;
l_ContentProvider_0:PreloadAsync({
    l_Frame_0.Sprite
});
l_Frame_0.Sprite:Destroy();
v4.new("RankUpAnimation"):Connect(function(v29) --[[ Line: 161 ]]
    -- upvalues: v28 (copy)
    v28(v29);
end);