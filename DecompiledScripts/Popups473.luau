local l_Players_0 = game:GetService("Players");
local l_TweenService_0 = game:GetService("TweenService");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local _ = require(l_ReplicatedStorage_0.Game.Replication);
local v5 = require(l_ReplicatedStorage_0.Modules.Network);
local v6 = require(l_ReplicatedStorage_0.Modules.Signal);
local v7 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v8 = require(l_ReplicatedStorage_0.Modules.Short);
local _ = require(l_ReplicatedStorage_0.Game.Skins);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_UI_0 = l_ReplicatedStorage_0.Content.UI;
local _ = l_UI_0.Circle;
local l_Sparkle_0 = l_UI_0.Sparkle;
local v14 = nil;
local v15 = nil;
local v16 = nil;
local v17 = nil;
local _ = nil;
local _ = nil;
local v20 = nil;
local _ = {};
local v22 = {};
local _ = {};
lerp = function(v24, v25, v26) --[[ Line: 28 ]] --[[ Name: lerp ]]
    return v24 + (v25 - v24) * v26;
end;
quadraticBezier = function(v27, v28, v29, v30) --[[ Line: 32 ]] --[[ Name: quadraticBezier ]]
    return (v28:Lerp(v29, v27):Lerp(v29:Lerp(v30, v27), v27));
end;
cubicBezier = function(v31, v32, v33, v34, v35) --[[ Line: 39 ]] --[[ Name: cubicBezier ]]
    local v36 = v32:Lerp(v33, v31);
    local v37 = v33:Lerp(v34, v31);
    local v38 = v34:Lerp(v35, v31);
    return (v36:Lerp(v37, v31):Lerp(v37:Lerp(v38, v31), v31));
end;
local function v43(v39, v40) --[[ Line: 49 ]] --[[ Name: increaseIndex ]]
    v39.ZIndex = v39.ZIndex + v40;
    for _, v42 in ipairs(v39:GetDescendants()) do
        if v42:IsA("GuiObject") or v42:IsA("Frame") then
            v42.ZIndex = v42.ZIndex + v40;
        end;
    end;
end;
local function v74(v44, v45, v46, _, v48) --[[ Line: 58 ]] --[[ Name: TapPopup ]]
    -- upvalues: l_UI_0 (copy), v8 (copy), v43 (copy), l_LocalPlayer_0 (copy), l_RunService_0 (copy), l_TweenService_0 (copy), v16 (ref), v14 (ref), v7 (copy), l_Sparkle_0 (copy)
    v44 = math.round(v44);
    local v49 = not v45 and l_UI_0.TapPopup:Clone() or l_UI_0.CriticalTapPopup:Clone();
    local l_Size_0 = v49.Size;
    local v51 = not v46 and Random.new():NextNumber(0.2, 0.8) or _G:ConvertOffset(v46.X, "X");
    local v52 = not v46 and Random.new():NextNumber(0.15, 0.85) or _G:ConvertOffset(v46.Y, "Y") + 0.05;
    v49.Position = UDim2.fromScale(v51, v52);
    v49.Size = UDim2.fromScale(v49.Size.X.Scale * 0.1, v49.Size.Y.Scale * 0.1);
    v49.Text = "+" .. (v44 > 1000000 and v8:Abbreviate(v44) or v8:Commas(v44));
    v49.Shadow.Text = v49.Text;
    v49.Highlight.Text = v49.Text;
    if v48 then
        v49.Size = UDim2.fromScale(l_Size_0.X.Scale * 0.5, l_Size_0.Y.Scale * 0.35);
        v49.Position = v49.Position:Lerp(UDim2.fromScale(0.5, 1.1), 0.4);
        v52 = v52 - 0.05;
        l_Size_0 = l_Size_0 + UDim2.fromScale(l_Size_0.X.Scale * 2.4, l_Size_0.Y.Scale * 2.4);
        v43(v49, 25);
    else
        v49.Position = v49.Position - UDim2.fromScale(0, 0.02);
    end;
    local v53 = 1;
    local v54 = v45 and 9 or 2;
    for v55 = v53, v54 do
        local v56 = v46 and Vector2.new(v46.X, v46.Y) or Vector2.new(game:GetService("Workspace").CurrentCamera.ViewportSize.X * Random.new():NextNumber(0.2, 0.8), game:GetService("Workspace").CurrentCamera.ViewportSize.Y * Random.new():NextNumber(0.15, 0.85));
        local v57 = Vector2.new(Random.new():NextNumber(-1, 1), Random.new():NextNumber(-1, 0)).Unit * math.random(50, 100) * (v45 and 2 or 1);
        local v58 = 25 * (v45 and 1.5 or 1);
        local v59 = l_UI_0.Popup_Clicks:Clone();
        v59.Size = UDim2.fromScale(0.03, 0.04);
        v59.Name = "Debris";
        v59.Visible = true;
        v59.Parent = l_LocalPlayer_0.PlayerGui.ScreenGlow;
        local l_Size_1 = v59.Size;
        local v61 = os.clock();
        local v62 = nil;
        do
            local l_v56_0, l_v57_0, l_v62_0 = v56, v57, v62;
            l_v62_0 = l_RunService_0.RenderStepped:Connect(function(v66) --[[ Line: 101 ]]
                -- upvalues: v61 (copy), l_v56_0 (ref), l_v57_0 (ref), v58 (copy), l_TweenService_0 (ref), v59 (copy), l_Size_1 (copy), l_v62_0 (ref)
                local v67 = os.clock() - v61;
                local v68 = math.clamp(v67 / 0.25, 0, 1);
                local v69 = math.clamp(v67 / 1, 0, 1);
                v66 = v66 * 5;
                l_v56_0 = l_v56_0 + l_v57_0 * v66;
                l_v57_0 = l_v57_0 + Vector2.new(0, v58 * v66);
                local v70 = math.sin(l_TweenService_0:GetValue(v68, Enum.EasingStyle.Quad, Enum.EasingDirection.Out) * 3.141592653589793);
                v59.Size = l_Size_1:Lerp(UDim2.new(l_Size_1.X.Scale * 1.5, 0, l_Size_1.Y.Scale * 1.5, 0), v70);
                v59.ImageTransparency = lerp(0, 1, v69);
                local _ = l_v57_0.Magnitude;
                local l_Unit_0 = l_v57_0.Unit;
                v59.Rotation = math.deg((math.atan2(l_Unit_0.Y, l_Unit_0.X))) + 45 + 90;
                v59.Position = UDim2.fromOffset(l_v56_0.X, l_v56_0.Y);
                if v69 >= 1 then
                    l_v62_0:Disconnect();
                    v59:Destroy();
                    l_v62_0 = nil;
                end;
            end);
            if v55 < 3 then
                task.wait(0.01);
            end;
        end;
    end;
    v49.Parent = v48 and v16 or v14;
    v7:Tween(v49, 0.7, "Back", "Out", {
        Size = l_Size_0
    });
    v7:Tween(v49.Shockwave, 0.8, "Cubic", "Out", {
        ImageTransparency = 1, 
        Size = not v45 and UDim2.fromScale(2, 5) or UDim2.fromScale(6, 15)
    });
    v7:Tween(v49.Highlight, 0.8, "Cubic", "Out", {
        TextTransparency = 1, 
        Size = not v45 and UDim2.fromScale(4, 4) or UDim2.fromScale(7, 7)
    });
    v7:Tween(v49, v48 and 0.3 or 0.1, "Sine", "InOut", {
        Position = UDim2.fromScale(v51, v52)
    }, nil, nil, function() --[[ Line: 145 ]]
        -- upvalues: v7 (ref), v49 (copy), v45 (copy), v48 (copy), l_Sparkle_0 (ref), v14 (ref)
        v7:Tween(v49, not v45 and 0.4 or 1, "Sine", "Out", {
            Position = v49.Position - UDim2.fromScale(0, 0.08), 
            Rotation = math.random(-5, 5)
        });
        task.wait(not v45 and 0.4 or 1);
        v7:Tween(v49, 0.1, "Back", "In", {
            Size = UDim2.fromScale(v49.Size.X.Scale * 0.6, v49.Size.Y.Scale * 0.6)
        });
        task.wait(0.05);
        v49:Destroy();
        if not v48 and math.random(1, 2) == 1 then
            local v73 = l_Sparkle_0:Clone();
            v73.Position = v49.Position;
            v73.Parent = v14;
            v7:Tween(v73, 0.14, "Quad", "Out", {
                Size = UDim2.fromScale(0.07, 0.07), 
                ImageTransparency = 0, 
                Rotation = Random.new():NextNumber(-5, 5)
            });
            task.wait(0.14);
            v7:Tween(v73, 0.14, "Quad", "Out", {
                Size = UDim2.fromScale(0.04, 0.04), 
                ImageTransparency = 1
            });
            task.wait(0.14);
            v73:Destroy();
        end;
    end);
end;
local function v83(v75) --[[ Line: 166 ]] --[[ Name: RebirthPopup ]]
    -- upvalues: l_UI_0 (copy), v8 (copy), v14 (ref), v7 (copy)
    local v76 = l_UI_0.RebirthPopup:Clone();
    local v77 = Random.new():NextNumber(0.2, 0.3);
    local v78 = Random.new():NextNumber(0.2, 0.7);
    local v79 = v75 > 9999 and v8:Abbreviate(v75) or v8:Commas(v75);
    local l_Position_0 = v76.Icon.Position;
    local l_Size_2 = v76.Icon.Size;
    local l_Size_3 = v76.Amount.Size;
    v76.Amount.Size = UDim2.fromScale(1.742, 0.2);
    v76.Icon.Size = UDim2.fromScale(0.5, 0.5);
    v76.Icon.Position = UDim2.fromScale(0.5, 0.8);
    v76.Position = UDim2.fromScale(v77, v78 + 0.2);
    v76.Amount.Text = "+" .. v79;
    v76.Amount.Amount.Text = "+" .. v79;
    v76.Parent = v14;
    v7:Tween(v76, 0.5, "Cubic", "InOut", {
        Position = UDim2.fromScale(v77, v78)
    });
    v7:Tween(v76.Glow, 0.3, "Sine", "InOut", {
        ImageTransparency = 0.5, 
        Size = UDim2.fromScale(1.57, 1.19)
    });
    v7:Tween(v76.Shockwave, 0.3, "Sine", "Out", {
        ImageTransparency = 0.5, 
        Size = UDim2.fromScale(1, 1)
    });
    v7:Tween(v76.Icon, 0.45, "Back", "InOut", {
        Size = l_Size_2, 
        Position = l_Position_0
    });
    v7:Tween(v76.Amount, 0.45, "Back", "Out", {
        Size = l_Size_3
    });
    task.wait(0.3);
    v7:Tween(v76.Glow, 2, "Cubic", "InOut", {
        ImageTransparency = 1, 
        Size = UDim2.fromScale(2.1, 2.1)
    });
    v7:Tween(v76.Shockwave, 0.7, "Sine", "InOut", {
        ImageTransparency = 1, 
        Size = UDim2.fromScale(2.5, 2.5)
    });
    v7:Tween(v76.Icon, 1, "Back", "InOut", {
        Rotation = -360
    });
    task.wait(1);
    v7:Tween(v76, 0.3, "Back", "In", {
        Size = UDim2.new(v76.Size.X.Scale * 0.7, v76.Size.Y.Scale * 0.7)
    });
    task.wait(0.3);
    v76:Destroy();
end;
local function v93(v84) --[[ Line: 205 ]] --[[ Name: ClickPopup ]]
    -- upvalues: l_UI_0 (copy), v8 (copy), v20 (ref), v14 (ref), v7 (copy)
    if workspace:GetAttribute("HideClicks") == true then
        return;
    else
        local v85 = l_UI_0.ClickPopup:Clone();
        local v86 = Random.new():NextNumber(0.2, 0.9);
        local v87 = Random.new():NextNumber(0.2, 0.7);
        local v88 = v84 > 9999 and v8:Abbreviate(v84) or v8:Commas(v84);
        local l_Position_1 = v85.Icon.Position;
        local l_Size_4 = v85.Icon.Size;
        local l_Size_5 = v85.Amount.Size;
        v85.Icon.Image = v20.Image == "rbxassetid://78262050700575" and v85.Icon.Image or v20.Image;
        v85.Amount.Size = UDim2.fromScale(1.742, 0.2);
        v85.Icon.Size = UDim2.fromScale(0.5, 0.5);
        v85.Icon.Position = UDim2.fromScale(0.5, 0.8);
        v85.Position = UDim2.fromScale(v86, v87 + 0.2);
        v85.Amount.Text = "+" .. v88;
        v85.Amount.Amount.Text = "+" .. v88;
        v85.Parent = v14;
        v7:Tween(v85, 0.25, "Back", "Out", {
            Position = UDim2.fromScale(v86, v87)
        });
        v7:Tween(v85.Glow, 0.3, "Sine", "Out", {
            ImageTransparency = 0.5, 
            Size = UDim2.fromScale(1.57, 1.19)
        });
        v7:Tween(v85.Icon, 0.45, "Back", "Out", {
            Size = l_Size_4, 
            Position = l_Position_1
        });
        v7:Tween(v85.Amount, 0.45, "Back", "Out", {
            Size = l_Size_5
        });
        task.wait(0.2);
        v7:Tween(v85.Glow, 1, "Cubic", "Out", {
            ImageTransparency = 1, 
            Size = UDim2.fromScale(2.1, 2.1)
        });
        v7:Tween(v85.Shockwave, 0.5, "Sine", "Out", {
            ImageTransparency = 1, 
            Size = UDim2.fromScale(1.8, 1.8)
        });
        v7:Tween(v85.Icon, 1, "Back", "Out", {
            Rotation = -360
        });
        local v92 = v85.Icon:Clone();
        v7:Tween(v92, 0.3, "Sine", "Out", {
            ImageTransparency = 1, 
            Size = UDim2.fromScale(1.5, 1.5)
        });
        task.wait(1);
        v7:Tween(v85, 0.3, "Back", "In", {
            Size = UDim2.new(v85.Size.X.Scale * 0.7, v85.Size.Y.Scale * 0.7)
        });
        task.wait(0.3);
        v85:Destroy();
        return;
    end;
end;
local function v102(v94) --[[ Line: 254 ]] --[[ Name: XPPopup ]]
    -- upvalues: l_UI_0 (copy), l_LocalPlayer_0 (copy), v8 (copy), v14 (ref), v7 (copy)
    local v95 = l_UI_0.XPPopup:Clone();
    local l_X_0 = l_LocalPlayer_0:GetMouse().X;
    local l_Y_0 = l_LocalPlayer_0:GetMouse().Y;
    local v98 = v94 > 9999 and v8:Abbreviate(v94) or v8:Commas(v94);
    local l_Position_2 = v95.Icon.Position;
    local l_Size_6 = v95.Icon.Size;
    local l_Size_7 = v95.Amount.Size;
    v95.Amount.Size = UDim2.fromScale(1.742, 0.2);
    v95.Icon.Size = UDim2.fromScale(0.5, 0.5);
    v95.Icon.Position = UDim2.fromScale(0.5, 0.8);
    v95.Position = UDim2.fromOffset(l_X_0, l_Y_0 + v95.AbsoluteSize.Y * 1.3);
    v95.Amount.Text = "+" .. v98 .. " XP";
    v95.Parent = v14;
    v7:Tween(v95, 0.25, "Cubic", "InOut", {
        Position = UDim2.fromOffset(l_X_0, l_Y_0 + v95.AbsoluteSize.Y / 2)
    });
    v7:Tween(v95.Glow, 0.3, "Sine", "InOut", {
        ImageTransparency = 0.5, 
        Size = UDim2.fromScale(1.57, 1.19)
    });
    v7:Tween(v95.Shockwave, 0.3, "Sine", "Out", {
        ImageTransparency = 0.3, 
        Size = UDim2.fromScale(1, 1)
    });
    v7:Tween(v95.Icon, 0.45, "Back", "InOut", {
        Size = l_Size_6, 
        Position = l_Position_2
    });
    v7:Tween(v95.Amount, 0.45, "Back", "Out", {
        Size = l_Size_7
    });
    task.wait(0.2);
    v7:Tween(v95.Glow, 1, "Cubic", "InOut", {
        ImageTransparency = 1, 
        Size = UDim2.fromScale(2.1, 2.1)
    });
    v7:Tween(v95.Shockwave, 0.7, "Sine", "InOut", {
        ImageTransparency = 1, 
        Size = UDim2.fromScale(2.5, 2.5)
    });
    v7:Tween(v95.Icon, 1, "Back", "InOut", {
        Rotation = -360
    });
    task.wait(1);
    v7:Tween(v95, 0.3, "Back", "In", {
        Size = UDim2.new(v95.Size.X.Scale * 0.7, v95.Size.Y.Scale * 0.7)
    });
    task.wait(0.3);
    v95:Destroy();
end;
local function v111(v103) --[[ Line: 293 ]] --[[ Name: CritClickPopup ]]
    -- upvalues: l_UI_0 (copy), v8 (copy), v14 (ref), v7 (copy)
    if workspace:GetAttribute("HideClicks") == true then
        return;
    else
        local v104 = l_UI_0.CriticalPopup:Clone();
        local v105 = Random.new():NextNumber(0.2, 0.3);
        local v106 = Random.new():NextNumber(0.2, 0.7);
        local v107 = v103 > 9999 and v8:Abbreviate(v103) or v8:Commas(v103);
        local l_Position_3 = v104.Icon.Position;
        local l_Size_8 = v104.Icon.Size;
        local l_Size_9 = v104.Amount.Size;
        v104.Amount.Size = UDim2.fromScale(1.742, 0.2);
        v104.Icon.Size = UDim2.fromScale(0.5, 0.5);
        v104.Icon.Position = UDim2.fromScale(0.5, 0.8);
        v104.Position = UDim2.fromScale(v105, v106 + 0.2);
        v104.Amount.Text = "+" .. v107;
        v104.Amount.Amount.Text = "+" .. v107;
        v104.Parent = v14;
        v7:Tween(v104, 0.25, "Cubic", "InOut", {
            Position = UDim2.fromScale(v105, v106)
        });
        v7:Tween(v104.Glow, 0.3, "Sine", "InOut", {
            ImageTransparency = 0.5, 
            Size = UDim2.fromScale(1.57, 1.19)
        });
        v7:Tween(v104.Shockwave, 0.3, "Sine", "Out", {
            ImageTransparency = 0.5, 
            Size = UDim2.fromScale(1, 1)
        });
        v7:Tween(v104.Icon, 0.45, "Back", "InOut", {
            Size = l_Size_8, 
            Position = l_Position_3
        });
        v7:Tween(v104.Amount, 0.45, "Back", "Out", {
            Size = l_Size_9
        });
        task.wait(0.4);
        v7:Tween(v104.Glow, 1, "Cubic", "InOut", {
            ImageTransparency = 1, 
            Size = UDim2.fromScale(2.1, 2.1)
        });
        v7:Tween(v104.Shockwave, 0.7, "Sine", "InOut", {
            ImageTransparency = 1, 
            Size = UDim2.fromScale(2.5, 2.5)
        });
        v7:Tween(v104.Icon, 1, "Back", "InOut", {
            Rotation = -360
        });
        task.wait(2);
        v7:Tween(v104, 1, "Back", "In", {
            Size = UDim2.new(v104.Size.X.Scale * 0.7, v104.Size.Y.Scale * 0.7)
        });
        task.wait(1);
        v104:Destroy();
        return;
    end;
end;
v22.AddPopup = function(_, v113, v114, v115, v116) --[[ Line: 336 ]] --[[ Name: AddPopup ]]
    -- upvalues: l_UI_0 (copy), v17 (ref), v15 (ref), l_RunService_0 (copy), l_TweenService_0 (copy), v6 (copy)
    if not l_UI_0:FindFirstChild("Popup_" .. v113) then
        return;
    else
        local l_FirstChild_0 = v17.Left:FindFirstChild(v113);
        local v118 = l_FirstChild_0 and l_FirstChild_0.Main and (l_FirstChild_0.Main:FindFirstChild("ImageLabel") or l_FirstChild_0.Main:IsA("ImageLabel") and l_FirstChild_0.Main);
        local v119 = v118 and v118.AbsolutePosition;
        local v120 = v118 and v118.AbsoluteSize;
        v119 = v119 and UDim2.fromOffset(v119.X, v119.Y);
        v120 = v120 and UDim2.fromOffset(v120.X, v120.Y);
        local v121 = v115 or UDim2.fromScale(Random.new():NextNumber(0.3, 0.2), Random.new():NextNumber(0.35, 0.5));
        local v122 = v116 or (v115 or UDim2.new()) + UDim2.fromScale(0.5, Random.new():NextNumber(0, 1));
        local v123 = v119 or UDim2.fromScale(-0.1, 0.5);
        local v124 = math.random(-30, 30);
        local v125 = tick();
        local v126 = tick() + Random.new():NextNumber(0.9, 1.3);
        local v127 = nil;
        local v128 = l_UI_0["Popup_" .. v113]:Clone();
        v128.Position = v121;
        v128.Rotation = v124;
        v128.Parent = v15;
        v127 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 364 ]]
            -- upvalues: v125 (copy), v126 (copy), l_TweenService_0 (ref), v128 (copy), v121 (copy), v122 (copy), v123 (copy), v120 (ref), v118 (copy), v124 (copy), v114 (ref), v119 (ref), v113 (copy), v6 (ref), v127 (ref)
            local v129 = math.min(math.abs((v125 - tick()) / (v126 - v125)), 1);
            local l_l_TweenService_0_Value_0 = l_TweenService_0:GetValue(v129, Enum.EasingStyle.Cubic, Enum.EasingDirection.In);
            v128.Position = quadraticBezier(v129, v121, v122, v123);
            v128.Size = cubicBezier(l_l_TweenService_0_Value_0, UDim2.fromScale(0.03, 0.07), UDim2.fromScale(0.06, 0.2), UDim2.fromScale(0.03, 0.2), v120 or UDim2.fromScale(0, 0));
            if v118 then
                v128.Rotation = lerp(v124, v118.Rotation, l_l_TweenService_0_Value_0);
            end;
            if v129 == 1 and v114 then
                v114 = nil;
                v128:Destroy();
                v128.Position = v119;
                if v113 == "Gems" then
                    v6.Fire("ScaleGemBar");
                end;
                v127:Disconnect();
                v127 = nil;
            end;
        end);
        return;
    end;
end;
v22.PopupRain = function(_, v132, v133, v134) --[[ Line: 395 ]] --[[ Name: PopupRain ]]
    -- upvalues: l_LocalPlayer_0 (copy), l_UI_0 (copy), v7 (copy), l_RunService_0 (copy)
    local l_ScreenGlow_0 = l_LocalPlayer_0.PlayerGui.ScreenGlow;
    local l_NumberValue_0 = Instance.new("NumberValue");
    local v137 = l_UI_0["Popup_" .. v132];
    local v138 = 0.02 * v133;
    local v139 = 0;
    local v140 = nil;
    l_NumberValue_0.Value = v138 / 5;
    v7:Tween(l_NumberValue_0, v134, "Quad", "InOut", {
        Value = v138 / 1.5
    });
    v140 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 406 ]]
        -- upvalues: v139 (ref), l_NumberValue_0 (copy), v137 (copy), l_ScreenGlow_0 (copy), l_RunService_0 (ref)
        if tick() - v139 > l_NumberValue_0.Value then
            local v141 = v137:Clone();
            local v142 = Random.new():NextNumber(0.75, 1.5);
            local v143 = Random.new():NextNumber(-0.01, 0.01);
            local v144 = Random.new():NextNumber(-0.02, 0.01);
            local v145 = nil;
            v141.ZIndex = v142 * 1000;
            v141.Size = UDim2.fromScale(v141.Size.X.Scale * v142 ^ 1.2, v141.Size.Y.Scale * v142 ^ 1.2);
            v141.Position = UDim2.fromScale(Random.new():NextNumber(-0.07, 1.03), -v141.Size.Y.Scale);
            v141.Rotation = Random.new():NextNumber(-90, 65);
            v141.Parent = l_ScreenGlow_0;
            do
                local l_v145_0 = v145;
                l_v145_0 = l_RunService_0.Heartbeat:Connect(function(v147) --[[ Line: 420 ]]
                    -- upvalues: v141 (copy), v143 (copy), v144 (copy), v142 (copy), l_v145_0 (ref)
                    local l_v141_0 = v141;
                    l_v141_0.Position = l_v141_0.Position + UDim2.fromScale(v143 * (v147 / 0.164), (v144 + 0.2) * (v147 / 0.164) * v142);
                    if v141.Position.Y.Scale > 1.05 then
                        v141:Destroy();
                        l_v145_0:Disconnect();
                    end;
                end);
                v139 = tick();
            end;
        end;
    end);
    task.delay(v134 or 2, function() --[[ Line: 433 ]]
        -- upvalues: v140 (ref), l_NumberValue_0 (copy)
        v140:Disconnect();
        l_NumberValue_0:Destroy();
    end);
end;
v22.Popup = function(_, v150, ...) --[[ Line: 440 ]] --[[ Name: Popup ]]
    -- upvalues: v74 (copy), v83 (copy), v93 (copy), v111 (copy), v102 (copy)
    if v150 == "tap" then
        v74(...);
        return;
    elseif v150 == "rebirth" then
        v83(...);
        return;
    elseif v150 == "tapArea" then
        v93(...);
        return;
    elseif v150 == "critTapArea" then
        v111(...);
        return;
    else
        if v150 == "xp" then
            v102(...);
        end;
        return;
    end;
end;
v22.Init = function(v151, v152) --[[ Line: 454 ]] --[[ Name: Init ]]
    -- upvalues: v17 (ref), v14 (ref), v16 (ref), v20 (ref), v15 (ref), l_LocalPlayer_0 (copy), v6 (copy), v5 (copy)
    v17 = v152;
    v14 = v152.Popups;
    v16 = v152.Bottom.Tap.Main.Popups;
    v20 = v152.Bottom.Tap.Main.Icon;
    v15 = Instance.new("ScreenGui", l_LocalPlayer_0.PlayerGui);
    v15.Name = "Popups";
    v15.DisplayOrder = 6;
    v15.IgnoreGuiInset = false;
    v15.ZIndexBehavior = Enum.ZIndexBehavior.Global;
    v6.new("Popup"):Connect(function(...) --[[ Line: 466 ]]
        -- upvalues: v151 (copy)
        v151:Popup(...);
    end);
    v6.new("AddPopup"):Connect(function(...) --[[ Line: 470 ]]
        -- upvalues: v151 (copy)
        v151:AddPopup(...);
    end);
    v6.new("PopupRain"):Connect(function(...) --[[ Line: 474 ]]
        -- upvalues: v151 (copy)
        v151:PopupRain(...);
    end);
    v5:BindEvents({
        PopupRain = function(...) --[[ Line: 479 ]] --[[ Name: PopupRain ]]
            -- upvalues: v151 (copy)
            v151:PopupRain(...);
        end
    });
end;
return v22;