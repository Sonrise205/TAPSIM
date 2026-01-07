local l_Players_0 = game:GetService("Players");
local _ = game:GetService("TweenService");
local v2 = require(script.Parent.GIF);
local v3 = require(script.Parent.Signal);
local v4 = require(script.Parent.Tweens);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_PlayerGui_0 = l_LocalPlayer_0:WaitForChild("PlayerGui");
local l_l_LocalPlayer_0_Mouse_0 = l_LocalPlayer_0:GetMouse();
local _ = script.Circle;
local l_Sprite_0 = script.Sprite;
local l_Shock_0 = script.Shock;
local v11 = nil;
local l_ScreenGui_0 = Instance.new("ScreenGui");
l_ScreenGui_0.Name = "SpriteHolder";
l_ScreenGui_0.DisplayOrder = 4;
l_ScreenGui_0.Parent = l_PlayerGui_0;
local v20 = {
    Burst = function(_) --[[ Line: 27 ]] --[[ Name: Burst ]]
        -- upvalues: l_Shock_0 (copy), l_l_LocalPlayer_0_Mouse_0 (copy), l_ScreenGui_0 (copy), v4 (copy)
        local v14 = l_Shock_0:Clone();
        v14.Position = UDim2.new(0, l_l_LocalPlayer_0_Mouse_0.X, 0, l_l_LocalPlayer_0_Mouse_0.Y);
        v14.Size = UDim2.fromScale(1, 0);
        v14.Parent = l_ScreenGui_0;
        v4:Tween(v14, 0.25, "Cubic", "Out", {
            Size = UDim2.fromScale(1, 0.1), 
            ImageTransparency = 1
        }, nil, nil, function() --[[ Line: 33 ]]
            -- upvalues: v14 (copy)
            v14:Destroy();
        end);
    end, 
    BurstV2 = function(_) --[[ Line: 38 ]] --[[ Name: BurstV2 ]]
        -- upvalues: l_l_LocalPlayer_0_Mouse_0 (copy), l_Sprite_0 (copy), v11 (ref), v2 (copy), l_ScreenGui_0 (copy)
        local v16 = UDim2.new(0, l_l_LocalPlayer_0_Mouse_0.X, 0, l_l_LocalPlayer_0_Mouse_0.Y);
        local v17 = l_Sprite_0:Clone();
        local v18 = nil;
        local v19 = nil;
        if v11 then
            v18 = v11;
            v19 = v11:Clone();
            v19.Adornee = v17;
            v11 = v19;
        else
            v19 = v2.new();
            v19.FrameRate = 40;
            v19.InheritSpriteSheet = true;
            v19.Looped = false;
            v19.Adornee = v17;
            v19.SpriteSizePixel = Vector2.new(200, 200);
            v19.SpriteCountX = 4;
            v19.SpriteCount = 11;
            v11 = v19;
        end;
        v17.Position = v16;
        v17.Parent = l_ScreenGui_0;
        v19:Play();
        task.delay(1, function() --[[ Line: 64 ]]
            -- upvalues: v18 (ref), v17 (copy)
            if v18 then
                v18:Destroy();
            end;
            v17:Destroy();
        end);
    end
};
v3.new("BurstFX"):Connect(function() --[[ Line: 73 ]]
    -- upvalues: v20 (copy)
    v20:Burst();
end);
return v20;