local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local _ = game:GetService("PhysicsService");
local _ = game:GetService("TweenService");
local v5 = require(l_ReplicatedStorage_0.Modules.CameraShaker);
local v6 = require(l_ReplicatedStorage_0.Game.Variables);
local v7 = require(l_ReplicatedStorage_0.Game.PetFrames);
local v8 = require(l_ReplicatedStorage_0.Modules.Rainbow);
local _ = require(l_ReplicatedStorage_0.Modules.Network);
local v10 = require(l_ReplicatedStorage_0.Modules.Signal);
local v11 = require(l_ReplicatedStorage_0.Modules.Tweens);
local _ = require(l_ReplicatedStorage_0.Modules.Short);
local _ = l_Players_0.LocalPlayer;
local l_Content_0 = l_ReplicatedStorage_0:WaitForChild("Content");
local l_CraftingSlots_0 = l_Content_0.UI.CraftingSlots;
local v16 = "Rainbow";
local v17 = "Golden";
local v18 = 0;
local v19 = 0;
local v20 = nil;
local v21 = nil;
local v22 = nil;
local v23 = nil;
local v24 = {};
local v25 = {};
local function v30(v26, v27) --[[ Line: 37 ]] --[[ Name: increaseIndex ]]
    v26.ZIndex = v26.ZIndex + v27;
    for _, v29 in ipairs(v26:GetDescendants()) do
        if v29:IsA("GuiObject") or v29:IsA("Frame") then
            v29.ZIndex = v29.ZIndex + v27;
        end;
    end;
end;
local _ = function(v31, v32, v33) --[[ Line: 46 ]] --[[ Name: fireParticle ]]
    -- upvalues: l_Players_0 (copy), l_Content_0 (copy)
    local v34 = nil;
    for _, v36 in ipairs(workspace.Game.CraftingStations:GetChildren()) do
        if v36.Name == v31 and v36:FindFirstChild("Main") then
            local l_Position_0 = v36:GetPivot().Position;
            if (l_Players_0.LocalPlayer.Character.PrimaryPart.Position - l_Position_0).Magnitude < 100 then
                v34 = v36;
                break;
            end;
        end;
    end;
    if v34 then
        local v38 = l_Content_0.Particles[v31 .. "Machine"]:Clone();
        v38.Parent = v34.Main;
        for _, v40 in ipairs(v38:GetChildren()) do
            if v40:IsA("ParticleEmitter") then
                v40.Enabled = true;
                if v40.Name ~= "Sparks" then
                    v40.Color = v33.Color;
                end;
                task.delay(v32 or 2, function() --[[ Line: 71 ]]
                    -- upvalues: v40 (copy)
                    v40.Enabled = false;
                end);
            end;
        end;
        task.delay(v32 and v32 + 1.5 or 3.5, function() --[[ Line: 77 ]]
            -- upvalues: v38 (copy)
            v38:Destroy();
        end);
    end;
end;
local function v47(v42, v43, v44) --[[ Line: 83 ]] --[[ Name: getFrame ]]
    -- upvalues: v16 (ref), v18 (ref), v17 (ref), l_CraftingSlots_0 (copy), v8 (copy)
    local v45 = v44 or v43 == v16;
    if v45 then
        v43 = v16;
    end;
    if not v43 then
        if v18 < 22 * ((100 - v42) / 100) then
            if v42 < Random.new():NextInteger(-15, 100) then
                v43 = "Fail";
            end;
        else
            v43 = v17;
        end;
    end;
    if not v43 then
        v43 = v17;
    end;
    local v46 = l_CraftingSlots_0[v43]:Clone();
    if v43 == "Fail" then
        v42 = 100 - v42;
    end;
    v46.Inner.Chance.Text = v45 and "???" or v42 .. "%";
    if v43 == "Rainbow" then
        v8:Add(v46.Inner.Pattern.UIGradient);
    end;
    return v46;
end;
local function v58(v48, v49, v50) --[[ Line: 120 ]] --[[ Name: setupFrame ]]
    -- upvalues: v20 (ref), v21 (ref), v25 (ref), v8 (copy), v22 (ref), v7 (copy), v30 (copy)
    local l_Menu_0 = (v20.Parent.Tabs:FindFirstChild(v48) or v20.Parent.Tabs:FindFirstChild("Golden")).Menu;
    v21.Info.UIStroke.UIGradient:Destroy();
    l_Menu_0.Label.UIStroke.UIGradient:Clone().Parent = v21.Info.UIStroke;
    if v21.Info.View:FindFirstChild("Pet") then
        v21.Info.View.Pet:Destroy();
    end;
    for _, v53 in ipairs(v21.Main.Holder.List:GetChildren()) do
        if v53:IsA("Frame") then
            v53:Destroy();
        end;
    end;
    for _, v55 in pairs(v25) do
        v55:Pause();
        v55:Destroy();
    end;
    v25 = {};
    v8:Remove(v22.Selector.Glow);
    v8:Remove(v22.Selector.Glow2);
    v22.Holder.List.Position = UDim2.fromScale(0, 0.5);
    v22.Selector.Glow.ImageTransparency = 1;
    v22.Selector.Glow2.ImageTransparency = 1;
    v22.Selector.Glow.ImageColor3 = Color3.fromRGB(255, 255, 255);
    v22.Selector.Glow2.ImageColor3 = Color3.fromRGB(255, 255, 255);
    v22.Selector.ImageColor3 = Color3.fromRGB(255, 255, 255);
    v22.Selector.Size = UDim2.fromScale(0.98, 0.5);
    v22.WinCover.BackgroundTransparency = 1;
    if v22.Selector:FindFirstChild("UIGradient") then
        v8:Remove(v22.Selector.UIGradient);
        v22.Selector.UIGradient:Destroy();
    end;
    v21.Info.View.None.Visible = true;
    v21.Info.View.Fail.Visible = false;
    if v50 ~= "Fail" then
        local l_v7_Frame_0 = v7:CreateFrame({
            Equipped = false, 
            Name = v49, 
            Tier = v50, 
            Multi1 = 1, 
            Multi2 = 1, 
            Level = 1
        }, "Inventory");
        l_v7_Frame_0.Main.Multi:Destroy();
        l_v7_Frame_0.Name = "Pet";
        l_v7_Frame_0.AnchorPoint = Vector2.new(0.5, 0.5);
        l_v7_Frame_0.Position = UDim2.fromScale(0.5, 0.5);
        l_v7_Frame_0.Size = UDim2.fromScale(1.1, 1.1);
        l_v7_Frame_0.Parent = v21.Info.View;
        if l_v7_Frame_0.Main:FindFirstChild("SpecialFrame") then
            local l_UIStroke_0 = l_v7_Frame_0.Main.UIStroke;
            l_UIStroke_0.Thickness = l_UIStroke_0.Thickness * 1.4;
        end;
        v30(l_v7_Frame_0, -100);
        return;
    else
        v21.Info.View.Fail.Size = UDim2.fromScale(1.1, 1.1);
        return;
    end;
end;
local function v76(v59, v60, v61, v62) --[[ Line: 194 ]] --[[ Name: roll ]]
    -- upvalues: v17 (ref), v16 (ref), v19 (ref), v18 (ref), v21 (ref), v47 (copy), v6 (copy), v23 (ref), v25 (ref), v11 (copy), l_Content_0 (copy), v10 (copy), v5 (copy), v22 (ref), v30 (copy), v8 (copy)
    v17 = v59;
    v16 = v60;
    v19 = v62 == v16 and 1 or 0;
    v18 = 0;
    local v63 = v21.Info.View[v62 == "Fail" and "Fail" or "Pet"];
    local v64 = v47(v61, v62);
    local v65 = _G:Play("Spin");
    local v66 = v61 == 100 and 0.5 or 4;
    local v67 = 22;
    if v62 == "Rainbow" then
        v66 = 4;
    end;
    if v62 ~= v59 and v62 ~= "Fail" then
        v67 = 35;
        v65.Volume = 1;
    else
        v67 = v67 + Random.new():NextInteger(-1, 3);
        v65.Volume = 1.2;
    end;
    _G:Play("Woosh");
    task.delay(0.03, function() --[[ Line: 220 ]]
        -- upvalues: v6 (ref)
        v6.hatching = true;
    end);
    v21.Info.Chance.Text = v61 .. "%";
    v21.Info.Chance.Label.Text = v61 .. "%";
    v21.Info.Chance.Label2.Text = v61 .. "%";
    for v68 = 1, v67 do
        if v68 == v67 then
            v64.LayoutOrder = 99;
            v64.Parent = v23;
        else
            local l_v47_0 = v47;
            local l_v61_0 = v61;
            local v71 = nil;
            local v72 = false;
            if v19 < math.random(1, 2) then
                v72 = math.random(1, 10) == 4;
            end;
            l_v47_0 = l_v47_0(l_v61_0, v71, v72) or v68 == 1 and math.random(1, 2) == 1;
            l_v47_0.LayoutOrder = v68 > 2 and 100 - v68 or 101 - v68;
            l_v47_0.Parent = v23;
            if l_v47_0.Name == "Fail" then
                v18 = v18 + 1;
            elseif l_v47_0.Name == v16 then
                v19 = v19 + 1;
            end;
        end;
    end;
    local v73 = v23.Position.Y.Scale - (v64.AbsolutePosition.Y + v64.AbsoluteSize.Y / 2 - (v23.AbsolutePosition.Y + v23.AbsoluteSize.Y / 2)) / v23.AbsoluteSize.Y;
    v25.Spin = v11:Tween(v23, v66, "Cubic", "Out", {
        Position = UDim2.fromScale(0, math.random(1, 3) == 2 and v73 - 0.19 or v73 + 0.25)
    });
    local v74 = v64.Inner.Pattern:FindFirstChild("UIGradient") or v64.Inner.Title:FindFirstChild("UIGradient") or l_Content_0.UI.OverlayTags:FindFirstChild(v62) and l_Content_0.UI.OverlayTags[v62]:FindFirstChild("UIGradient");
    task.delay(v66 - 0.03, function() --[[ Line: 259 ]]
        -- upvalues: v10 (ref), v74 (copy), v64 (copy), v62 (copy), v5 (ref), v59 (copy)
        v10.Fire("ScreenGlow", v74 or v64.Inner.Pattern.ImageColor3, 3, 0, 0.03);
        if v62 == "Fail" then
            _G:Play("Broke");
        else
            _G.camShake:Shake(v5.Presets.Bump);
        end;
        if v62 == v59 then
            _G:Play("EggWin2");
            _G:Play("CraftPet");
            _G:Play("MagicExplosion");
        end;
        if v62 ~= "Fail" and v62 ~= v59 then
            _G:Play("CelWinOld");
            _G:Play("QuestReward");
            _G:Play("MagicExplosion");
        end;
    end);
    task.wait(v66);
    v65:Stop();
    v63.Visible = true;
    v11:Tween(v23, 0.6, "Quad", "Out", {
        Position = UDim2.fromScale(0, v73)
    });
    v11:Tween(v23, 0.6, "Elastic", "Out", {
        Position = UDim2.fromScale(0, v73)
    });
    v11:Tween(v63, 0.2, "Back", "Out", {
        Size = UDim2.fromScale(1, 1)
    });
    v25.WinCover = v11:Tween(v22.WinCover, 0.5, "Sine", "InOut", {
        BackgroundTransparency = 0.4
    }, true, -1);
    v30(v64, 50);
    v11:Tween(v64.Inner, 0.2, "Back", "Out", {
        Size = UDim2.fromScale(1.07, 1.07)
    });
    v11:Tween(v22.Selector, 0.2, "Back", "Out", {
        Size = UDim2.fromScale(1.03, 0.52)
    });
    if v62 == "Rainbow" and v74 then
        v74:Clone().Parent = v22.Selector;
        if v62 == "Rainbow" then
            v8:Add(v22.Selector.UIGradient);
        end;
    end;
    if v62 ~= v59 and v62 ~= "Fail" then
        v11:Tween(v22.Selector.Glow2, 0.2, "Back", "Out", {
            ImageTransparency = 0.2
        });
        v8:Add(v22.Selector.Glow2);
        if v62 == "Rainbow" then
            v11:Tween(v22.Selector.Glow, 0.2, "Back", "Out", {
                ImageTransparency = 0
            });
            v8:Add(v22.Selector.Glow);
        end;
        v21.Info.UIStroke.UIGradient:Destroy();
        v74:Clone().Parent = v21.Info.UIStroke;
    else
        v22.Selector.Glow2.ImageColor3 = v64.Inner.Pattern.ImageColor3;
        v11:Tween(v22.Selector.Glow2, 0.2, "Back", "Out", {
            ImageTransparency = 0.5
        });
    end;
    v21.Info.View.None.Visible = false;
    v30(v63, 100);
    if v62 ~= "Fail" then
        local v75 = v21.Behind:Clone();
        v75.UIGradient:Destroy();
        v75.BackgroundColor3 = v74 and Color3.fromRGB(255, 255, 255) or v64.Inner.Pattern.ImageColor3;
        v75.Position = UDim2.fromScale(0.5, 0.5);
        v75.ZIndex = v75.ZIndex - 2;
        v75.UICorner.CornerRadius = UDim.new(0.1, 0);
        v75.Parent = v21;
        v75.UIStroke:Destroy();
        if v74 then
            v74:Clone().Parent = v75;
        end;
        v11:Tween(v75, 0.5, "Sine", "Out", {
            Size = UDim2.fromScale(1.3, 1.45), 
            BackgroundTransparency = 1
        });
        task.wait(0.4);
        v75:Destroy();
    end;
    task.wait(1);
    v6.hatching = false;
    task.wait(1);
    if v21.Visible then
        v10.Fire("OpenMenu", v59);
    end;
end;
v24.Init = function(_, v78, v79) --[[ Line: 364 ]] --[[ Name: Init ]]
    -- upvalues: v21 (ref), v20 (ref), v22 (ref), v23 (ref), v10 (copy), v58 (copy), v76 (copy)
    v21 = v79;
    v20 = v78;
    v22 = v21.Main;
    v23 = v22.Holder.List;
    v10.new("CraftingRoll"):Connect(function(v80, v81, v82, v83, v84) --[[ Line: 370 ]]
        -- upvalues: v58 (ref), v10 (ref), v76 (ref)
        v58(v80, v83, v84);
        v10.Fire("OpenMenu", "CraftingRoll");
        v76(v80, v81, v82, v84);
    end);
end;
return v24;