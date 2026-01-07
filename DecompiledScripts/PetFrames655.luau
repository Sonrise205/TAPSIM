local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local v3 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v4 = require(l_ReplicatedStorage_0.Modules.Network);
local v5 = require(l_ReplicatedStorage_0.Modules.Signal);
local v6 = require(l_ReplicatedStorage_0.Modules.Rainbow);
local v7 = require(l_ReplicatedStorage_0.Modules.Gradients);
local v8 = require(l_ReplicatedStorage_0.Modules.Short);
local v9 = require(script.Parent.PetStats);
local v10 = require(script.Parent.Replication);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local _ = l_LocalPlayer_0:GetMouse();
local l_Content_0 = l_ReplicatedStorage_0.Content;
local l_UI_0 = l_Content_0.UI;
local l_Pet_0 = l_UI_0.Pet;
local l_PetBig_0 = l_UI_0.PetBig;
local v17 = Instance.new("ScreenGui", l_LocalPlayer_0.PlayerGui);
v17.DisplayOrder = 2;
v17.Name = "overlay thing lol";
local _ = {};
local _ = {};
local v20 = {
    InventoryFrames = {}, 
    PetCounts = {}
};
local v21 = {};
local v22 = {};
local v23 = {};
local v24 = false;
local v25 = false;
local v30 = {
    Inventory = {
        Click = function(_, _) --[[ Line: 43 ]] --[[ Name: Click ]]

        end
    }, 
    Trade = {
        Click = function(_, _) --[[ Line: 49 ]] --[[ Name: Click ]]
            -- upvalues: v25 (ref)
            _G:Play("Click");
            if v25 then
                return;
            else
                v25 = true;
                task.delay(0.2, function() --[[ Line: 54 ]]
                    -- upvalues: v25 (ref)
                    v25 = false;
                end);
                return;
            end;
        end
    }
};
local v31 = {
    [10] = "\240\159\146\142", 
    [100] = "\240\159\148\165", 
    [500] = "\240\159\146\165", 
    [1000] = "\226\173\144", 
    [10000] = "\226\156\168", 
    [100000] = "\226\154\161"
};
v20.getEmoji = function(_, v33) --[[ Line: 71 ]] --[[ Name: getEmoji ]]
    -- upvalues: v31 (copy)
    local v34 = 1000000000000;
    for v35, _ in pairs(v31) do
        if v33 <= v35 and v35 < v34 then
            v34 = v35;
        end;
    end;
    if v31[v34] then
        return v31[v34] .. " ";
    else
        return "";
    end;
end;
updateEquip = function(v37, v38) --[[ Line: 84 ]] --[[ Name: updateEquip ]]
    local l_Equip_0 = v38.Actions.Equip;
    local l_TradeInfo_0 = v38.TradeInfo;
    local l_UIGradient_0 = l_Equip_0.Main:FindFirstChildOfClass("UIGradient");
    if l_UIGradient_0 then
        l_UIGradient_0:Destroy();
    end;
    if v37 then
        l_TradeInfo_0.Unequip:Clone().Parent = l_Equip_0.Main;
        l_Equip_0.Main.TextLabel.Text = "UNEQUIP";
        l_Equip_0.Main.TextLabel.UIStroke.Color = Color3.fromRGB(165, 0, 0);
        l_Equip_0.BackgroundColor3 = Color3.fromRGB(190, 0, 0);
        return;
    else
        l_TradeInfo_0.Equip:Clone().Parent = l_Equip_0.Main;
        l_Equip_0.Main.TextLabel.Text = "EQUIP";
        l_Equip_0.Main.TextLabel.UIStroke.Color = Color3.fromRGB(32, 171, 1);
        l_Equip_0.BackgroundColor3 = Color3.fromRGB(35, 190, 2);
        return;
    end;
end;
local function _(v42, v43) --[[ Line: 106 ]] --[[ Name: darkenColor ]]
    local v44, v45, v46 = v42:ToHSV();
    if v46 == 0 then
        return Color3.fromRGB(0, 0, 0);
    else
        return Color3.fromHSV(v44, v45, v46 * v43);
    end;
end;
local function _(v48, v49) --[[ Line: 114 ]] --[[ Name: saturateColor ]]
    local v50, v51, v52 = v48:ToHSV();
    return Color3.fromHSV(v50, v51, v52 * v49);
end;
v20.UpdateCounts = function(_) --[[ Line: 120 ]] --[[ Name: UpdateCounts ]]
    -- upvalues: v4 (copy), v20 (copy)
    local v55 = v4:InvokeServer("GetPetList");
    if v55 then
        v20.PetCounts = v55;
    end;
end;
v20.setupViewport = function(_, v57, v58, v59) --[[ Line: 127 ]] --[[ Name: setupViewport ]]
    -- upvalues: v9 (copy), v23 (copy)
    local v60 = v9.Pets[v58] and (v9:GetImage(v58, v59) or v9:GetImage(v58));
    if not v60 or v9.Pets[v58].UseViewport then
        local l_ViewportFrame_0 = Instance.new("ViewportFrame");
        local l_Camera_0 = Instance.new("Camera");
        l_Camera_0.Parent = l_ViewportFrame_0;
        l_Camera_0.FieldOfView = 50;
        l_ViewportFrame_0.Size = UDim2.fromScale(1, 1);
        l_ViewportFrame_0.Position = UDim2.fromScale(0.5, 0.5);
        l_ViewportFrame_0.AnchorPoint = Vector2.new(0.5, 0.5);
        l_ViewportFrame_0.BackgroundTransparency = 1;
        l_ViewportFrame_0.BackgroundColor3 = Color3.fromRGB(53, 184, 255);
        l_ViewportFrame_0.LightColor = Color3.fromRGB(220, 220, 220);
        l_ViewportFrame_0.Ambient = Color3.fromRGB(255, 255, 255);
        l_ViewportFrame_0.LightDirection = Vector3.new(0, -60, 20, 0);
        l_ViewportFrame_0.CurrentCamera = l_Camera_0;
        l_ViewportFrame_0.AnchorPoint = Vector2.new(0.5, 0.5);
        l_ViewportFrame_0.Position = UDim2.fromScale(0.5, 0.5);
        l_ViewportFrame_0.ZIndex = v57.ZIndex;
        local l_v9_Model_0 = v9:GetModel(v58, v59, nil, true);
        local l_Decal_0 = l_v9_Model_0.PrimaryPart:FindFirstChildOfClass("Decal");
        l_v9_Model_0:PivotTo(CFrame.new(0, 0, 0));
        local l_WorldModel_0 = Instance.new("WorldModel");
        l_WorldModel_0.Parent = l_ViewportFrame_0;
        l_v9_Model_0.Parent = l_WorldModel_0;
        if l_v9_Model_0:FindFirstChild("Animations") and l_v9_Model_0.Animations:FindFirstChild("Idle") and l_v9_Model_0:FindFirstChild("AnimationController") then
            local v66 = l_v9_Model_0.AnimationController.Animator:LoadAnimation(l_v9_Model_0.Animations.Idle);
            v66.Looped = true;
            v66:Play();
            table.insert(v23, v66);
        end;
        if l_Decal_0 then
            l_Decal_0.Texture = "rbxthumb://type=Asset&id=" .. string.gsub(l_Decal_0.Texture, "%D", "") .. "&w=150&h=150";
        end;
        local v67 = l_v9_Model_0:FindFirstChild("Head") or l_v9_Model_0.PrimaryPart;
        l_Camera_0.FieldOfView = 40;
        l_Camera_0.CameraSubject = l_v9_Model_0;
        local l_l_v9_Model_0_ExtentsSize_0 = l_v9_Model_0:GetExtentsSize();
        local v69 = math.clamp(math.max(l_l_v9_Model_0_ExtentsSize_0.X, l_l_v9_Model_0_ExtentsSize_0.Y, l_l_v9_Model_0_ExtentsSize_0.Z) / 2 * -4.8, -12, -3);
        if l_v9_Model_0:FindFirstChild("Camera") then
            l_Camera_0.CFrame = l_v9_Model_0.Camera.CFrame;
            return l_ViewportFrame_0;
        else
            l_Camera_0.CFrame = CFrame.new(Vector3.new(0, 0, v69), v67.Position - Vector3.new(0.09000000357627869, 0.20000000298023224, 0, 0)) + Vector3.new(0, 0.10000000149011612, 0, 0);
            return l_ViewportFrame_0;
        end;
    else
        local v70 = v9.Pets[v58].Huge and UDim2.fromScale(1.06, 1.05) or UDim2.fromScale(1.05, 1.05);
        local l_ImageLabel_0 = Instance.new("ImageLabel");
        l_ImageLabel_0.Name = "ViewportFrame";
        l_ImageLabel_0.BackgroundTransparency = 1;
        l_ImageLabel_0.AnchorPoint = Vector2.new(0.5, 0.5);
        l_ImageLabel_0.Position = UDim2.fromScale(0.5, 0.5);
        l_ImageLabel_0.Size = v70;
        l_ImageLabel_0.Position = UDim2.fromScale(0.5, 0.5);
        if typeof(v60) == "table" and v60.imageId and v60.rectOffset then
            l_ImageLabel_0.Image = v60.imageId;
            local v72 = Vector2.new(256, 256);
            local l_rectOffset_0 = v60.rectOffset;
            l_ImageLabel_0.ImageRectSize = v72;
            l_ImageLabel_0.ImageRectOffset = l_rectOffset_0;
        else
            l_ImageLabel_0.Image = "rbxthumb://type=Asset&id=" .. string.gsub(v60, "%D", "") .. "&w=150&h=150";
        end;
        l_ImageLabel_0.ScaleType = Enum.ScaleType.Crop;
        l_ImageLabel_0.ZIndex = v57.ZIndex;
        if v57:FindFirstChild("UICorner") then
            v57.UICorner:Clone().Parent = l_ImageLabel_0;
        end;
        return l_ImageLabel_0;
    end;
end;
v20.UpdateOrder = function(_, v75, v76, v77) --[[ Line: 224 ]] --[[ Name: UpdateOrder ]]
    -- upvalues: v8 (copy), v9 (copy)
    local v78 = typeof(v77) == "table" and v77.Multiplier1 or v77 or 0;
    if v76 then
        v75.Parent.LayoutOrder = -v8:Compress(v78);
        return;
    else
        v75.Parent.LayoutOrder = v8.layoutLimit - v8:Compress(v78);
        if typeof(v77) == "table" and v9:GetPercentage(v77.Name) and v9:GetPercentage(v77.Name) >= 100 then
            v75.Parent.LayoutOrder = 0 - v9:GetMulti(v9:GetPercentage(v77.Name), v77.Tier, v77.Level, v77);
        end;
        return;
    end;
end;
v20.UpdateEquip = function(v79, v80, v81, v82) --[[ Line: 241 ]] --[[ Name: UpdateEquip ]]
    local l_Multiplier1_0 = v81.Multiplier1;
    v80.Parent.Equipped.Visible = v82 or v81.Equipped;
    v79:UpdateOrder(v80, v82 or v81.Equipped, l_Multiplier1_0);
end;
v20.UpdateLevel = function(v84, v85, v86, v87) --[[ Line: 249 ]] --[[ Name: UpdateLevel ]]
    -- upvalues: v9 (copy), v10 (copy), v8 (copy)
    local l_v9_Percentage_0 = v9:GetPercentage(v86.Name);
    if not v87 then
        if not l_v9_Percentage_0 then
            v86.Multiplier1 = v9:GetMulti(v86.Multi1, v86.Tier, v86.Level, v86);
            v86.Multiplier2 = v9:GetMulti(v86.Multi2, v86.Tier, v86.Level, v86);
        else
            v86.Multiplier1 = v9:GetMulti(v10.Data.BestMultiplier[1] * l_v9_Percentage_0 / 100, v86.Tier, v86.Level, v86);
            v86.Multiplier2 = v9:GetMulti(v10.Data.BestMultiplier[2] * l_v9_Percentage_0 / 100, v86.Tier, v86.Level, v86);
        end;
    end;
    if l_v9_Percentage_0 then
        v85.Multi.Text = math.round(l_v9_Percentage_0 * 10) / 10 .. "% (" .. v8:Abbreviate(v86.Multiplier1) .. ")";
    else
        v85.Multi.Text = "x" .. v8:Abbreviate(v86.Multiplier1);
    end;
    v84:UpdateOrder(v85, v86.Equipped, v86);
end;
v20.SetupTweens = function(_, v90, v91, v92) --[[ Line: 271 ]] --[[ Name: SetupTweens ]]
    -- upvalues: v3 (copy), v30 (copy), v5 (copy)
    v90 = v90.Main;
    local l_Button_0 = v90.Button;
    l_Button_0.Activated:Connect(function() --[[ Line: 275 ]]
        -- upvalues: v3 (ref), v90 (ref), v30 (ref), v91 (copy), v92 (copy)
        v3:Tween(v90, 0.2, "Back", "Out", {
            Size = UDim2.fromScale(0.93, 0.93)
        });
        if v30[v91] then
            v30[v91].Click(v90, v92);
        end;
    end);
    l_Button_0.MouseEnter:Connect(function() --[[ Line: 282 ]]
        -- upvalues: v3 (ref), v90 (ref)
        v3:Tween(v90, 0.2, "Quad", "Out", {
            Size = UDim2.fromScale(0.94, 0.94)
        });
        if v90:FindFirstChild("Overlay") then
            v90.Overlay:Destroy();
        end;
    end);
    l_Button_0.MouseLeave:Connect(function() --[[ Line: 289 ]]
        -- upvalues: v3 (ref), v90 (ref)
        v3:Tween(v90, 0.2, "Quad", "Out", {
            Size = UDim2.fromScale(0.93, 0.93)
        });
    end);
    l_Button_0.MouseButton1Down:Connect(function() --[[ Line: 293 ]]
        -- upvalues: v3 (ref), v90 (ref), v5 (ref)
        v3:Tween(v90, 0.2, "Back", "Out", {
            Size = UDim2.fromScale(0.91, 0.91)
        });
        v5.Fire("BurstFX");
        _G:Play("Click");
    end);
end;
v20.CreateFrame = function(v94, v95, v96, v97) --[[ Line: 300 ]] --[[ Name: CreateFrame ]]
    -- upvalues: v9 (copy), v10 (copy), l_PetBig_0 (copy), l_Pet_0 (copy), l_Content_0 (copy), l_ReplicatedStorage_0 (copy), v8 (copy), v6 (copy), v21 (copy), v7 (copy), v22 (copy), v20 (copy), l_UI_0 (copy)
    local l_v9_Percentage_1 = v9:GetPercentage(v95.Name);
    if not l_v9_Percentage_1 then
        v95.Multiplier1 = v9:GetMulti(v95.Multi1, v95.Tier, v95.Level, v95);
        v95.Multiplier2 = v9:GetMulti(v95.Multi2, v95.Tier, v95.Level, v95);
    else
        v95.Multiplier1 = v9:GetMulti(v10.Data.BestMultiplier[1] * l_v9_Percentage_1 / 100, v95.Tier, v95.Level, v95);
        v95.Multiplier2 = v9:GetMulti(v10.Data.BestMultiplier[2] * l_v9_Percentage_1 / 100, v95.Tier, v95.Level, v95);
    end;
    local _ = v95.Id;
    local l_Tier_0 = v95.Tier;
    local l_Name_0 = v95.Name;
    local l_Multiplier1_1 = v95.Multiplier1;
    local _ = v95.Multiplier2;
    local l_Equipped_0 = v95.Equipped;
    local l_v9_Rarity_0, v106, v107 = v9:GetRarity(l_Name_0, true);
    local l_v9_BigFrame_0 = v9:GetBigFrame(l_Name_0);
    local v109 = l_v9_BigFrame_0 and l_PetBig_0:Clone() or l_Pet_0:Clone();
    local l_Main_0 = v109.Main;
    local _ = l_Main_0.Button;
    if l_v9_BigFrame_0 then
        l_Main_0.PetName.Text = l_Name_0;
        l_Main_0.Odds.Text = v9:GetInfoText(l_Name_0) or "???";
    elseif v9:GetInfoText(l_Name_0) then
        local v112 = l_Content_0.UI.PetInfoText:Clone();
        v112.Text = v9:GetInfoText(l_Name_0);
        v112.Parent = l_Main_0;
    end;
    local l_FirstChild_0 = l_ReplicatedStorage_0.Content.UI.PetParticles:FindFirstChild(l_v9_Rarity_0);
    if l_FirstChild_0 then
        for _, v115 in l_FirstChild_0:GetChildren() do
            v115:Clone().Parent = l_Main_0;
        end;
    end;
    local l_FirstChild_1 = l_ReplicatedStorage_0.Content.UI.PetParticles:FindFirstChild(l_Tier_0);
    if l_FirstChild_1 then
        for _, v118 in l_FirstChild_1:GetChildren() do
            v118:Clone().Parent = l_Main_0;
        end;
    end;
    local v119 = v94:setupViewport(l_Main_0, l_Name_0, v95.Tier);
    v119.ZIndex = 3;
    v119.Parent = l_Main_0;
    if v119:IsA("ViewportFrame") and l_Main_0:FindFirstChild("UICorner") then
        l_Main_0.UICorner:Clone().Parent = v119;
    end;
    v109.Name = l_Name_0;
    l_Main_0.Multi.Text = "x" .. v8:Abbreviate(l_Multiplier1_1);
    if l_v9_Percentage_1 then
        l_Main_0.Multi.Text = math.round(l_v9_Percentage_1 * 10) / 10 .. "% (" .. v8:Abbreviate(v95.Multiplier1) .. ")";
    end;
    if l_Tier_0 == "Golden" then
        local l_UIGradient_1 = Instance.new("UIGradient");
        l_UIGradient_1.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, Color3.fromHex("ffe20a")), 
            ColorSequenceKeypoint.new(1, Color3.fromHex("ffb301"))
        });
        l_UIGradient_1.Rotation = -90;
        l_UIGradient_1.Parent = l_Main_0.Multi;
    elseif l_Tier_0 == "Rainbow" then
        v6:Add(l_Main_0.Multi);
        table.insert(v21, l_Main_0.Multi);
    end;
    v94:UpdateOrder(l_Main_0, v96 ~= "Crafting" and (l_Equipped_0 or false), v95.Multiplier1);
    if v96 == "Inventory" then
        v94:UpdateEquip(l_Main_0, v95);
    end;
    local v121 = {};
    local v122 = l_Content_0.UI.OverlayTags:FindFirstChild(v95.Tier) and l_Content_0.UI.OverlayTags[v95.Tier].UIGradient;
    if l_Tier_0 == "Rainbow" then
        v6:Add(l_Main_0.ViewportFrame);
        table.insert(v21, l_Main_0.ViewportFrame);
    end;
    if v122 then
        l_Main_0.Parent.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        local v123 = v122:Clone();
        v123.Parent = l_Main_0.Parent;
        v7:Add(v123);
        table.insert(v121, v123);
        table.insert(v22, v123);
    end;
    if l_v9_Rarity_0 ~= "Common" and l_v9_Rarity_0 ~= "Basic" then
        if v107 then
            l_Main_0.Parent.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
            local v124, v125, v126 = v106:ToHSV();
            v124, v125, v126 = (if v126 == 0 then Color3.fromRGB(0, 0, 0) else Color3.fromHSV(v124, v125, v126 * 0.9)):ToHSV();
            l_Main_0.BackgroundColor3 = Color3.fromHSV(v124, v125, v126 * 0.9);
            l_Main_0.InnerGlow.ImageColor3 = Color3.fromRGB(255, 255, 255);
            if not v122 then
                local v127 = v107:Clone();
                v127.Parent = l_Main_0.Parent;
                v7:Add(v127);
                table.insert(v121, v127);
                table.insert(v22, v127);
            end;
            local v128 = v107:Clone();
            v128.Parent = l_Main_0;
            v7:Add(v128);
            table.insert(v121, v128);
            table.insert(v22, v128);
            v107:Clone().Parent = l_Main_0.InnerGlow;
            if l_v9_BigFrame_0 then
                local v129 = v107:Clone();
                v129.Parent = l_Main_0.Odds;
                v129.Rotation = 90;
            end;
        else
            if not v122 then
                l_Main_0.Parent.BackgroundColor3 = v106;
            end;
            l_Main_0.InnerGlow.ImageColor3 = v106;
            local v130, v131, v132 = v106:ToHSV();
            v130, v131, v132 = (if v132 == 0 then Color3.fromRGB(0, 0, 0) else Color3.fromHSV(v130, v131, v132 * 0.85)):ToHSV();
            l_Main_0.BackgroundColor3 = Color3.fromHSV(v130, v131, v132 * 1.25);
        end;
    end;
    v20:SetupTweens(v109, v96, v95);
    if v97 then
        l_UI_0.NewLabel:Clone().Parent = l_Main_0;
        local l_Frame_0 = Instance.new("Frame");
        l_Frame_0.Name = "FlashFrame";
        l_Frame_0.Size = UDim2.fromScale(1, 1);
        l_Frame_0.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
        l_Frame_0.BackgroundTransparency = 1;
        l_Frame_0.ZIndex = 20;
        l_Frame_0.Parent = l_Main_0;
        local l_UICorner_0 = l_Main_0:FindFirstChild("UICorner");
        if l_UICorner_0 then
            l_UICorner_0:Clone().Parent = l_Frame_0;
        else
            local l_UICorner_1 = Instance.new("UICorner");
            l_UICorner_1.CornerRadius = UDim.new(0.1, 0);
            l_UICorner_1.Parent = l_Frame_0;
        end;
        local v136 = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 5, true);
        local v137 = game:GetService("TweenService"):Create(l_Frame_0, v136, {
            BackgroundTransparency = 0.6
        });
        v137:Play();
        v137.Completed:Connect(function() --[[ Line: 478 ]]
            -- upvalues: l_Frame_0 (copy), v137 (copy)
            l_Frame_0:Destroy();
            v137:Destroy();
        end);
    end;
    v109.Destroying:Connect(function() --[[ Line: 484 ]]
        -- upvalues: v121 (copy), v7 (ref)
        for _, v139 in ipairs(v121) do
            v7:Remove(v139);
        end;
    end);
    return v109;
end;
v20.PauseEffects = function(_) --[[ Line: 494 ]] --[[ Name: PauseEffects ]]
    -- upvalues: v24 (ref), v21 (copy), v6 (copy), v22 (copy), v7 (copy), v23 (copy)
    if v24 then
        return;
    else
        v24 = true;
        for v141 = #v21, 1, -1 do
            local v142 = v21[v141];
            if v142 and v142.Parent then
                v6:Remove(v142);
            else
                table.remove(v21, v141);
            end;
        end;
        for v143 = #v22, 1, -1 do
            local v144 = v22[v143];
            if v144 and v144.Parent then
                v7:Remove(v144);
            else
                table.remove(v22, v143);
            end;
        end;
        for v145 = #v23, 1, -1 do
            local v146 = v23[v145];
            if v146 and v146.IsPlaying then
                v146:Stop();
            elseif not v146 then
                table.remove(v23, v145);
            end;
        end;
        return;
    end;
end;
v20.ResumeEffects = function(_) --[[ Line: 530 ]] --[[ Name: ResumeEffects ]]
    -- upvalues: v24 (ref), v21 (copy), v6 (copy), v22 (copy), v7 (copy), v23 (copy)
    if not v24 then
        return;
    else
        v24 = false;
        for v148 = #v21, 1, -1 do
            local v149 = v21[v148];
            if v149 and v149.Parent then
                v6:Add(v149);
            else
                table.remove(v21, v148);
            end;
        end;
        for v150 = #v22, 1, -1 do
            local v151 = v22[v150];
            if v151 and v151.Parent then
                v7:Add(v151);
            else
                table.remove(v22, v150);
            end;
        end;
        for v152 = #v23, 1, -1 do
            local v153 = v23[v152];
            if v153 then
                v153:Play();
            else
                table.remove(v23, v152);
            end;
        end;
        return;
    end;
end;
return v20;