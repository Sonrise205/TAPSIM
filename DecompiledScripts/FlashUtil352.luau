local l_TweenService_0 = game:GetService("TweenService");
return {
    FlashAtPosition = function(_, v2, v3, v4, v5) --[[ Line: 9 ]] --[[ Name: FlashAtPosition ]]
        -- upvalues: l_TweenService_0 (copy)
        v5 = v5 or {};
        local v6 = v5.Color or Color3.fromRGB(255, 255, 255);
        local v7 = v5.Transparency or 0.3;
        local v8 = v5.Duration or 0.3;
        local v9 = v5.SizeMultiplier or 1.1;
        local v10 = v5.CornerRadius or 8;
        local v11 = v5.ZIndex or 10;
        local v12 = v3.X * v9;
        local v13 = v3.Y * v9;
        local v14 = v2.X - (v12 - v3.X) / 2;
        local v15 = v2.Y - (v13 - v3.Y) / 2;
        local l_Frame_0 = Instance.new("Frame");
        l_Frame_0.Name = "FlashOverlay";
        l_Frame_0.Size = UDim2.fromOffset(v12, v13);
        l_Frame_0.Position = UDim2.fromOffset(v14, v15);
        l_Frame_0.BackgroundColor3 = v6;
        l_Frame_0.BackgroundTransparency = v7;
        l_Frame_0.BorderSizePixel = 0;
        l_Frame_0.ZIndex = v11;
        l_Frame_0.Parent = v4 or game.Players.LocalPlayer.PlayerGui;
        if v10 > 0 then
            local l_UICorner_0 = Instance.new("UICorner");
            l_UICorner_0.CornerRadius = UDim.new(0, v10);
            l_UICorner_0.Parent = l_Frame_0;
        end;
        local v18 = l_TweenService_0:Create(l_Frame_0, TweenInfo.new(v8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        });
        v18:Play();
        v18.Completed:Connect(function() --[[ Line: 53 ]]
            -- upvalues: l_Frame_0 (copy)
            if l_Frame_0 and l_Frame_0.Parent then
                l_Frame_0:Destroy();
            end;
        end);
        return l_Frame_0;
    end, 
    FlashObject = function(v19, v20, v21) --[[ Line: 63 ]] --[[ Name: FlashObject ]]
        local v22 = v21 or {};
        return v19:FlashAtPosition(v20.AbsolutePosition, v20.AbsoluteSize, v20.Parent, v22);
    end, 
    FlashWhite = function(v23, v24, v25) --[[ Line: 74 ]] --[[ Name: FlashWhite ]]
        v25 = v25 or {};
        v25.Color = Color3.fromRGB(255, 255, 255);
        v25.Transparency = v25.Transparency or 0.3;
        return v23:FlashObject(v24, v25);
    end, 
    FlashColor = function(v26, v27, v28, v29) --[[ Line: 82 ]] --[[ Name: FlashColor ]]
        v29 = v29 or {};
        v29.Color = v28;
        return v26:FlashObject(v27, v29);
    end
};