local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_TweenService_0 = game:GetService("TweenService");
local l_RunService_0 = game:GetService("RunService");
local v4 = require(l_ReplicatedStorage_0.Game.PetStats);
local v5 = require(l_ReplicatedStorage_0.Game.Eggs);
local v6 = require(l_ReplicatedStorage_0.Game.Replication);
local v7 = require(l_ReplicatedStorage_0.Game.PetFrames);
local v8 = require(l_ReplicatedStorage_0.Game.PetFrames.Info);
local v9 = require(l_ReplicatedStorage_0.Game.PetIndexBonusReward);
local v10 = require(l_ReplicatedStorage_0.Modules.ItemData);
local v11 = require(l_ReplicatedStorage_0.Modules.Network);
local v12 = require(l_ReplicatedStorage_0.Modules.Signal);
local v13 = require(l_ReplicatedStorage_0.Modules.Short);
local v14 = nil;
local v15 = {};
local v16 = nil;
local v17 = "Normal";
local v18 = nil;
local v19 = true;
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_l_LocalPlayer_0_Mouse_0 = l_LocalPlayer_0:GetMouse();
local v22 = {};
local v23 = nil;
local v24 = {
    "Normal", 
    "Golden", 
    "Rainbow"
};
local v25 = {
    Basic = 1, 
    Common = 2, 
    Rare = 3, 
    Epic = 4, 
    Legendary = 5, 
    Mythical = 6, 
    Secret = 7
};
local v26 = {
    Header = "#FFFFFF", 
    Quantity = "#00FF00", 
    Type = "#FFD700", 
    Description = "#AAAAAA"
};
local function v31(v27) --[[ Line: 57 ]] --[[ Name: buildRewardTooltip ]]
    -- upvalues: v10 (copy), v26 (copy), v13 (copy)
    if not v27 or not v27.Name or not v27.Type then
        return nil;
    else
        local l_v10_ItemData_0 = v10:GetItemData(v27.Type, v27.Name);
        if not l_v10_ItemData_0 then
            return nil;
        else
            local v29 = {};
            table.insert(v29, string.format("<font color=\"%s\"><b>%s</b></font>", "#FFFF00", l_v10_ItemData_0.name or v27.Name));
            local v30 = v27.Amount or 1;
            if v30 > 0 then
                table.insert(v29, string.format("<font color=\"%s\">Quantity: x%s</font>", v26.Quantity, v13:Abbreviate(v30)));
            end;
            table.insert(v29, string.format("<font color=\"%s\">Type: %s</font>", v26.Type, (tostring(v27.Type))));
            if l_v10_ItemData_0.description and l_v10_ItemData_0.description ~= "" then
                table.insert(v29, string.format("<font color=\"%s\">%s</font>", v26.Description, l_v10_ItemData_0.description));
            end;
            return table.concat(v29, "\n");
        end;
    end;
end;
local function v38(v32, v33) --[[ Line: 108 ]] --[[ Name: countDiscoveredInCategory ]]
    -- upvalues: v6 (copy), v5 (copy)
    if not v6.Loaded or not v5[v32] then
        return 0;
    else
        local v34 = 0;
        local v35 = v5[v32];
        if v35.Pets then
            for v36 in pairs(v35.Pets) do
                local l_v36_0 = v36;
                if v33 ~= "Normal" then
                    l_v36_0 = v36 .. "_" .. v33;
                end;
                if v6.Data.Discovered[l_v36_0] then
                    v34 = v34 + 1;
                end;
            end;
        end;
        return v34;
    end;
end;
local _ = function(v39) --[[ Line: 134 ]] --[[ Name: getTotalPetsInEgg ]]
    -- upvalues: v5 (copy)
    if not v5[v39] or not v5[v39].Pets then
        return 0;
    else
        local v40 = 0;
        for _, _ in pairs(v5[v39].Pets) do
            v40 = v40 + 1;
        end;
        return v40;
    end;
end;
local function v57(v44, v45) --[[ Line: 148 ]] --[[ Name: setupEggViewport ]]
    v44:ClearAllChildren();
    local l_Eggs_0 = workspace:FindFirstChild("Eggs");
    if not l_Eggs_0 then
        warn("workspace.Eggs folder not found!");
        return;
    else
        local l_l_Eggs_0_FirstChild_0 = l_Eggs_0:FindFirstChild(v45);
        if not l_l_Eggs_0_FirstChild_0 then
            warn("Egg model container not found for:", v45, "in workspace.Eggs");
            return;
        else
            local l_Egg_0 = l_l_Eggs_0_FirstChild_0:FindFirstChild("Egg");
            if not l_Egg_0 then
                warn("Egg not found inside:", v45, "- looking for 'Egg' child");
                return;
            else
                local v49 = l_Egg_0:Clone();
                local l_Camera_0 = Instance.new("Camera");
                l_Camera_0.Parent = v44;
                v44.CurrentCamera = l_Camera_0;
                v49.Parent = v44;
                local v51 = nil;
                local v52 = nil;
                if v49:IsA("Model") then
                    local l_v49_BoundingBox_0, v54 = v49:GetBoundingBox();
                    v51 = l_v49_BoundingBox_0;
                    v52 = v54;
                else
                    v51 = v49.CFrame;
                    v52 = v49.Size;
                end;
                local v55 = math.max(v52.X, v52.Y, v52.Z) * 2;
                local v56 = v51.Position + Vector3.new(v55 * 0.5, v55 * 0.3, v55);
                l_Camera_0.CFrame = CFrame.lookAt(v56, v51.Position);
                l_Camera_0.FieldOfView = 30;
                v44.Visible = true;
                v44.BackgroundTransparency = 1;
                return v49;
            end;
        end;
    end;
end;
local function v83(v58, _, v60) --[[ Line: 210 ]] --[[ Name: createEggFrame ]]
    -- upvalues: v14 (ref), v57 (copy), v5 (copy), v38 (copy), l_TweenService_0 (copy)
    local v61 = v14.Container.Eggs.List.EggTemplate:Clone();
    v61.Name = v58;
    v61.Visible = true;
    v61.LayoutOrder = v60;
    v61.Label.Text = v58 .. " Egg";
    v61.Label.Label.Text = v58 .. " Egg";
    local l_EggViewport_0 = v61:FindFirstChild("EggViewport");
    if l_EggViewport_0 then
        local l_ViewportFrame_0 = l_EggViewport_0:FindFirstChild("ViewportFrame");
        if l_ViewportFrame_0 then
            local v64 = v57(l_ViewportFrame_0, v58);
            if v64 then
                local v65 = false;
                local l_v64_0 = v64 --[[ copy: 7 -> 17 ]];
                do
                    local l_v65_0 = v65;
                    v61.MouseEnter:Connect(function() --[[ Line: 233 ]]
                        -- upvalues: l_v65_0 (ref), l_v64_0 (copy)
                        l_v65_0 = true;
                        task.spawn(function() --[[ Line: 237 ]]
                            -- upvalues: l_v65_0 (ref), l_v64_0 (ref)
                            while l_v65_0 and l_v64_0 and l_v64_0.Parent do
                                local l_l_v64_0_Pivot_0 = l_v64_0:GetPivot();
                                l_v64_0:PivotTo(l_l_v64_0_Pivot_0 * CFrame.Angles(0, 0.03490658503988659, 0));
                                task.wait(0.03);
                            end;
                        end);
                    end);
                    v61.MouseLeave:Connect(function() --[[ Line: 246 ]]
                        -- upvalues: l_v65_0 (ref)
                        l_v65_0 = false;
                    end);
                end;
            end;
        end;
    end;
    local v69;
    if not v5[v58] or not v5[v58].Pets then
        v69 = 0;
    else
        local v70 = 0;
        for _, _ in pairs(v5[v58].Pets) do
            v70 = v70 + 1;
        end;
        v69 = v70;
    end;
    local v73 = v38(v58, "Normal");
    local v74 = v38(v58, "Golden");
    local v75 = v38(v58, "Rainbow");
    v61.ProgressCategories.Normal.Text = v73 .. " / " .. v69;
    v61.ProgressCategories.Golden.Text = v74 .. " / " .. v69;
    v61.ProgressCategories.Rainbow.Text = v75 .. " / " .. v69;
    local v76 = v73 + v74 + v75;
    local v77 = v69 * 3;
    local v78 = v77 > 0 and v76 / v77 * 100 or 0;
    v61.Level.Bar.Size = UDim2.fromScale(math.min(v78 / 100, 1), 1);
    v61.Level.Percentage.Text = v76 .. " / " .. v77;
    v61.Level.Level.Text = "Discovered";
    if v61:FindFirstChild("ClaimableRewards") then
        v61.ClaimableRewards.Visible = false;
    end;
    local l_UIScale_0 = v61:FindFirstChildOfClass("UIScale");
    if not l_UIScale_0 then
        l_UIScale_0 = Instance.new("UIScale");
        l_UIScale_0.Scale = 1;
        l_UIScale_0.Parent = v61;
    end;
    local function _() --[[ Line: 288 ]] --[[ Name: playHoverSound ]]
        _G:Play("Click");
    end;
    local function _() --[[ Line: 292 ]] --[[ Name: playClickSound ]]
        _G:Play("Click2");
    end;
    local l_TextButton_0 = Instance.new("TextButton");
    l_TextButton_0.Name = "Button";
    l_TextButton_0.Size = UDim2.fromScale(1, 1);
    l_TextButton_0.BackgroundTransparency = 1;
    l_TextButton_0.Text = "";
    l_TextButton_0.ZIndex = 10;
    l_TextButton_0.Parent = v61;
    l_TextButton_0.MouseEnter:Connect(function() --[[ Line: 306 ]]
        -- upvalues: l_TweenService_0 (ref), l_UIScale_0 (ref)
        _G:Play("Click");
        l_TweenService_0:Create(l_UIScale_0, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Scale = 1.02
        }):Play();
    end);
    l_TextButton_0.MouseLeave:Connect(function() --[[ Line: 313 ]]
        -- upvalues: l_TweenService_0 (ref), l_UIScale_0 (ref)
        l_TweenService_0:Create(l_UIScale_0, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Scale = 1
        }):Play();
    end);
    l_TextButton_0.MouseButton1Down:Connect(function() --[[ Line: 320 ]]
        -- upvalues: l_TweenService_0 (ref), l_UIScale_0 (ref)
        l_TweenService_0:Create(l_UIScale_0, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Scale = 0.98
        }):Play();
    end);
    l_TextButton_0.MouseButton1Up:Connect(function() --[[ Line: 326 ]]
        -- upvalues: l_TweenService_0 (ref), l_UIScale_0 (ref)
        l_TweenService_0:Create(l_UIScale_0, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Scale = 1.02
        }):Play();
    end);
    l_TextButton_0.Activated:Connect(function() --[[ Line: 333 ]]
        -- upvalues: v58 (copy)
        _G:Play("Click2");
        selectEgg(v58);
    end);
    return v61;
end;
local function _() --[[ Line: 342 ]] --[[ Name: resetPetInfoOverlay ]]
    -- upvalues: v22 (ref), v23 (ref), v8 (copy)
    v22 = {};
    v23 = nil;
    v8:Close();
end;
selectEgg = function(v85) --[[ Line: 349 ]] --[[ Name: selectEgg ]]
    -- upvalues: v5 (copy), v22 (ref), v23 (ref), v8 (copy), v16 (ref), v14 (ref), v18 (ref), v19 (ref), l_TweenService_0 (copy)
    if not v5[v85] then
        return;
    else
        v22 = {};
        v23 = nil;
        v8:Close();
        v16 = v85;
        local l_ActualContainer_0 = v14.Container.RightSideEggInfo:FindFirstChild("ActualContainer");
        if l_ActualContainer_0 then
            if not v18 then
                v18 = l_ActualContainer_0.Position;
            end;
            if v19 then
                v19 = false;
                l_ActualContainer_0.Position = v18;
                updateRightPanel();
            else
                l_ActualContainer_0.Position = UDim2.new(1.5, 0, v18.Y.Scale, v18.Y.Offset);
                updateRightPanel();
                l_TweenService_0:Create(l_ActualContainer_0, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                    Position = v18
                }):Play();
            end;
        else
            updateRightPanel();
        end;
        for _, v88 in ipairs(v14.Container.Eggs.List:GetChildren()) do
            if v88:IsA("Frame") and v88.Name ~= "EggTemplate" then
                local v89 = v88.Background and v88.Background:FindFirstChild("UIStroke") or v88:FindFirstChild("UIStroke");
                if v89 then
                    if v88.Name == v85 then
                        if not v89:GetAttribute("OriginalColor") then
                            v89:SetAttribute("OriginalColor", true);
                            v89:SetAttribute("OriginalR", v89.Color.R);
                            v89:SetAttribute("OriginalG", v89.Color.G);
                            v89:SetAttribute("OriginalB", v89.Color.B);
                            v89:SetAttribute("OriginalTransparency", v89.Transparency);
                        end;
                        v89.Color = Color3.fromRGB(255, 255, 0);
                        v89.Transparency = 0;
                    elseif v89:GetAttribute("OriginalColor") then
                        v89.Color = Color3.fromRGB(v89:GetAttribute("OriginalR") * 255, v89:GetAttribute("OriginalG") * 255, v89:GetAttribute("OriginalB") * 255);
                        v89.Transparency = v89:GetAttribute("OriginalTransparency");
                    end;
                end;
            end;
        end;
        return;
    end;
end;
updateRightPanel = function() --[[ Line: 431 ]] --[[ Name: updateRightPanel ]]
    -- upvalues: v16 (ref), v5 (copy), v14 (ref), v17 (ref), v57 (copy), v38 (copy), v4 (copy), v25 (copy)
    if not v16 or not v5[v16] then
        return;
    else
        local v90 = v5[v16];
        local l_ActualContainer_1 = v14.Container.RightSideEggInfo:FindFirstChild("ActualContainer");
        if not l_ActualContainer_1 then
            warn("ActualContainer not found in RightSideEggInfo");
            return;
        else
            if l_ActualContainer_1.CurrentCategory then
                l_ActualContainer_1.CurrentCategory.Visible = true;
            end;
            if l_ActualContainer_1:FindFirstChild("Left") then
                l_ActualContainer_1.Left.Visible = true;
            end;
            if l_ActualContainer_1:FindFirstChild("Right") then
                l_ActualContainer_1.Right.Visible = true;
            end;
            if l_ActualContainer_1.PetsContainer then
                l_ActualContainer_1.PetsContainer.EggName.Text = v16 .. " Egg";
            end;
            if l_ActualContainer_1.CurrentCategory then
                l_ActualContainer_1.CurrentCategory.Title.Text = v17;
                local l_EggViewport_1 = l_ActualContainer_1.CurrentCategory:FindFirstChild("EggViewport");
                if l_EggViewport_1 then
                    local l_ViewportFrame_1 = l_EggViewport_1:FindFirstChild("ViewportFrame");
                    if l_ViewportFrame_1 then
                        v57(l_ViewportFrame_1, v16);
                    end;
                end;
            end;
            local l_v16_0 = v16;
            local v95;
            if not v5[l_v16_0] or not v5[l_v16_0].Pets then
                v95 = 0;
            else
                local v96 = 0;
                for _, _ in pairs(v5[l_v16_0].Pets) do
                    v96 = v96 + 1;
                end;
                v95 = v96;
            end;
            l_v16_0 = v38(v16, v17);
            local v99 = v95 > 0 and l_v16_0 / v95 or 0;
            if l_ActualContainer_1.PetsContainer and l_ActualContainer_1.PetsContainer:FindFirstChild("Progress") then
                local l_Progress_0 = l_ActualContainer_1.PetsContainer.Progress;
                if l_Progress_0:FindFirstChild("Bar") then
                    l_Progress_0.Bar.Size = UDim2.fromScale(math.min(v99, 1), 1);
                end;
                if l_Progress_0:FindFirstChild("Percentage") then
                    l_Progress_0.Percentage.Text = l_v16_0 .. " / " .. v95;
                end;
            end;
            local v101 = l_ActualContainer_1.PetsContainer and l_ActualContainer_1.PetsContainer.PetsScrollingFrame;
            if v101 then
                for _, v103 in ipairs(v101:GetChildren()) do
                    if v103:IsA("Frame") then
                        v103:Destroy();
                    end;
                end;
                if v90.Pets then
                    local v104 = {};
                    for v105, _ in pairs(v90.Pets) do
                        local l_v4_Rarity_0 = v4:GetRarity(v105);
                        local v108 = v25[l_v4_Rarity_0] or 0;
                        table.insert(v104, {
                            name = v105, 
                            rarity = l_v4_Rarity_0, 
                            order = v108
                        });
                    end;
                    table.sort(v104, function(v109, v110) --[[ Line: 516 ]]
                        return v109.order < v110.order;
                    end);
                    for v111, v112 in ipairs(v104) do
                        local v113 = createPetFrame(v112.name, v17);
                        v113.LayoutOrder = v111 - 1;
                        v113.Parent = v101;
                    end;
                end;
            end;
            updateRewardsDisplay(l_ActualContainer_1);
            return;
        end;
    end;
end;
createPetFrame = function(v114, v115) --[[ Line: 534 ]] --[[ Name: createPetFrame ]]
    -- upvalues: v4 (copy), v6 (copy), v5 (copy), v7 (copy), v22 (ref)
    local v116 = v4.Pets[v114];
    if not v116 then
        warn("Pet not found:", v114);
        return Instance.new("Frame");
    else
        local l_v114_0 = v114;
        if v115 ~= "Normal" then
            l_v114_0 = v114 .. "_" .. v115;
        end;
        local v118 = v6.Loaded and v6.Data.Discovered[l_v114_0];
        local v119 = false;
        local v120 = false;
        for _, v122 in pairs(v5) do
            if type(v122) == "table" and v122.Secrets then
                for v123, _ in pairs(v122.Secrets) do
                    if v123 == v114 then
                        v119 = true;
                        if v122.ShowSecrets then
                            v120 = true;
                            break;
                        else
                            break;
                        end;
                    end;
                end;
            end;
            if v119 then
                break;
            end;
        end;
        if v120 then
            v118 = true;
        end;
        local v125 = {
            Name = v114, 
            Tier = v115, 
            Multi1 = v116.Multiplier1 or 0, 
            Multi2 = v116.Multiplier2 or 0, 
            Level = 1, 
            XP = 0, 
            Id = v114 .. "_" .. v115, 
            Equipped = false
        };
        local l_v7_Frame_0 = v7:CreateFrame(v125, "Index");
        if v118 then
            v22[l_v7_Frame_0] = v125;
        end;
        if not v118 and l_v7_Frame_0 then
            local l_Main_0 = l_v7_Frame_0.Main;
            local l_New_0 = l_Main_0:FindFirstChild("New");
            if l_New_0 then
                l_New_0.Visible = false;
            end;
            local l_Odds_0 = l_Main_0:FindFirstChild("Odds");
            if l_Odds_0 then
                l_Odds_0.Visible = false;
            end;
            local l_PetName_0 = l_Main_0:FindFirstChild("PetName");
            if l_PetName_0 then
                l_PetName_0.Visible = false;
            end;
            local l_ViewportFrame_2 = l_Main_0:FindFirstChild("ViewportFrame");
            if l_ViewportFrame_2 then
                if v119 then
                    if l_ViewportFrame_2:IsA("ViewportFrame") then
                        l_ViewportFrame_2.ImageColor3 = Color3.fromRGB(0, 0, 0);
                        l_ViewportFrame_2.ImageTransparency = 0;
                        for _, v133 in ipairs(l_ViewportFrame_2:GetDescendants()) do
                            if v133:IsA("BasePart") then
                                v133.Color = Color3.fromRGB(0, 0, 0);
                            end;
                        end;
                    elseif l_ViewportFrame_2:IsA("ImageLabel") then
                        l_ViewportFrame_2.ImageColor3 = Color3.fromRGB(0, 0, 0);
                        l_ViewportFrame_2.ImageTransparency = 0;
                    end;
                elseif l_ViewportFrame_2:IsA("ViewportFrame") then
                    for _, v135 in ipairs(l_ViewportFrame_2:GetDescendants()) do
                        if v135:IsA("BasePart") then
                            local l_Color_0 = v135.Color;
                            v135.Color = Color3.new(l_Color_0.R * 0.2, l_Color_0.G * 0.2, l_Color_0.B * 0.2);
                        end;
                    end;
                elseif l_ViewportFrame_2:IsA("ImageLabel") then
                    l_ViewportFrame_2.ImageColor3 = Color3.fromRGB(0, 0, 0);
                end;
            end;
            local l_Multi_0 = l_Main_0:FindFirstChild("Multi");
            if l_Multi_0 then
                l_Multi_0.Text = "???";
            end;
        end;
        return l_v7_Frame_0;
    end;
end;
updateRewardsDisplay = function(v138) --[[ Line: 665 ]] --[[ Name: updateRewardsDisplay ]]
    -- upvalues: v14 (ref), v16 (ref), v5 (copy), v9 (copy), v17 (ref), v10 (copy), v31 (copy), v12 (copy), v38 (copy), v6 (copy)
    if not v138 then
        v138 = v14.Container.RightSideEggInfo:FindFirstChild("ActualContainer");
        if not v138 then
            return;
        end;
    end;
    local l_RewardsContainer_0 = v138:FindFirstChild("RewardsContainer");
    local l_List_0 = l_RewardsContainer_0.List;
    if not l_RewardsContainer_0 then
        return;
    else
        for _, v142 in ipairs(l_List_0:GetChildren()) do
            if v142:IsA("Frame") and v142.Name ~= "OutsideStuff" and not v142:IsA("UIListLayout") then
                v142:Destroy();
            end;
        end;
        if not v16 or v16 == "Secrets" or not v5[v16] then
            if l_RewardsContainer_0.OutsideStuff and l_RewardsContainer_0.OutsideStuff:FindFirstChild("Label") then
                l_RewardsContainer_0.OutsideStuff.Label.Text = "Rewards";
            end;
            if l_RewardsContainer_0.OutsideStuff and l_RewardsContainer_0.OutsideStuff:FindFirstChild("Claim") then
                l_RewardsContainer_0.OutsideStuff.Claim.Visible = false;
            end;
            return;
        else
            local l_v9_EggRewards_0 = v9:GetEggRewards(v16);
            if not l_v9_EggRewards_0 then
                if l_RewardsContainer_0.OutsideStuff and l_RewardsContainer_0.OutsideStuff:FindFirstChild("Label") then
                    l_RewardsContainer_0.OutsideStuff.Label.Text = "No Rewards";
                end;
                if l_RewardsContainer_0.OutsideStuff and l_RewardsContainer_0.OutsideStuff:FindFirstChild("Claim") then
                    l_RewardsContainer_0.OutsideStuff.Claim.Visible = false;
                end;
                return;
            else
                if l_RewardsContainer_0.OutsideStuff and l_RewardsContainer_0.OutsideStuff:FindFirstChild("Label") then
                    l_RewardsContainer_0.OutsideStuff.Label.Text = v17 .. " Rewards";
                end;
                local v144 = l_v9_EggRewards_0[v17];
                if v144 and #v144 > 0 then
                    for _, v146 in ipairs(v144) do
                        local l_v10_ItemSlot_0 = v10:CreateItemSlot(v146.Name, v146.Type, v146.Amount);
                        if l_v10_ItemSlot_0 then
                            l_v10_ItemSlot_0.Parent = l_List_0;
                            local l_Hitbox_0 = l_v10_ItemSlot_0:FindFirstChild("Hitbox");
                            if l_Hitbox_0 and l_Hitbox_0:IsA("TextButton") then
                                l_Hitbox_0.Active = false;
                                l_Hitbox_0.AutoButtonColor = false;
                            end;
                            local v149 = v31(v146);
                            if v149 then
                                local v150 = l_v10_ItemSlot_0:FindFirstChild("Main") or l_v10_ItemSlot_0;
                                v12.Fire("Tooltip", v150, v149);
                            end;
                        end;
                    end;
                end;
                local l_v16_1 = v16;
                local v152;
                if not v5[l_v16_1] or not v5[l_v16_1].Pets then
                    v152 = 0;
                else
                    local v153 = 0;
                    for _, _ in pairs(v5[l_v16_1].Pets) do
                        v153 = v153 + 1;
                    end;
                    v152 = v153;
                end;
                l_v16_1 = v38(v16, v17);
                local v156 = false;
                if v152 <= l_v16_1 then
                    v156 = v152 > 0;
                end;
                print(string.format("[PetIndex] %s - %s: %d/%d (Complete: %s)", v16, v17, l_v16_1, v152, (tostring(v156))));
                local v157 = false;
                if v6.Loaded and v6.Data.PetIndexRewards then
                    local v158 = v6.Data.PetIndexRewards[v16];
                    if v158 and v158[v17] then
                        v157 = true;
                    end;
                end;
                print(string.format("[PetIndex] %s - %s already claimed: %s", v16, v17, (tostring(v157))));
                local v159 = v156 and not v157;
                local l_ClaimedOverlay_0 = l_RewardsContainer_0.OutsideStuff:FindFirstChild("ClaimedOverlay");
                if l_ClaimedOverlay_0 then
                    l_ClaimedOverlay_0:Destroy();
                end;
                if v157 then
                    local l_Frame_0 = Instance.new("Frame");
                    l_Frame_0.Name = "ClaimedOverlay";
                    l_Frame_0.Size = UDim2.fromScale(1, 1);
                    l_Frame_0.Position = UDim2.fromScale(0, 0);
                    l_Frame_0.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
                    l_Frame_0.BackgroundTransparency = 0.7;
                    l_Frame_0.BorderSizePixel = 0;
                    l_Frame_0.ZIndex = 100;
                    l_Frame_0.Parent = l_RewardsContainer_0.OutsideStuff;
                    local l_TextLabel_0 = Instance.new("TextLabel");
                    l_TextLabel_0.Name = "ClaimedText";
                    l_TextLabel_0.Size = UDim2.fromScale(0.8, 0.3);
                    l_TextLabel_0.Position = UDim2.fromScale(0.5, 0.5);
                    l_TextLabel_0.AnchorPoint = Vector2.new(0.5, 0.5);
                    l_TextLabel_0.BackgroundTransparency = 1;
                    l_TextLabel_0.Text = "CLAIMED";
                    l_TextLabel_0.TextColor3 = Color3.fromRGB(255, 255, 0);
                    l_TextLabel_0.TextScaled = true;
                    l_TextLabel_0.Font = Enum.Font.GothamBold;
                    l_TextLabel_0.ZIndex = 101;
                    l_TextLabel_0.Parent = l_Frame_0;
                    local l_UIStroke_0 = Instance.new("UIStroke");
                    l_UIStroke_0.Thickness = 2;
                    l_UIStroke_0.Color = Color3.fromRGB(0, 0, 0);
                    l_UIStroke_0.Parent = l_TextLabel_0;
                end;
                if l_RewardsContainer_0.OutsideStuff and l_RewardsContainer_0.OutsideStuff:FindFirstChild("Claim") then
                    l_RewardsContainer_0.OutsideStuff.Claim.Visible = v159;
                    return;
                else
                    warn("[PetIndex] Could not find Claim button in OutsideStuff!");
                    return;
                end;
            end;
        end;
    end;
end;
local function v175() --[[ Line: 808 ]] --[[ Name: setupClaimButton ]]
    -- upvalues: v14 (ref), v16 (ref), v11 (copy), v10 (copy), v13 (copy), v12 (copy)
    local l_ActualContainer_2 = v14.Container.RightSideEggInfo:FindFirstChild("ActualContainer");
    if not l_ActualContainer_2 or not l_ActualContainer_2.RewardsContainer then
        return;
    else
        local l_RewardsContainer_1 = l_ActualContainer_2.RewardsContainer;
        if not l_RewardsContainer_1.OutsideStuff then
            return;
        else
            local l_Claim_0 = l_RewardsContainer_1.OutsideStuff:FindFirstChild("Claim");
            if not l_Claim_0 then
                return;
            else
                local l_Button_0 = l_Claim_0:FindFirstChild("Button");
                if not l_Button_0 then
                    return;
                else
                    l_Button_0.Activated:Connect(function() --[[ Line: 831 ]]
                        -- upvalues: v16 (ref), v11 (ref), v10 (ref), v13 (ref), v12 (ref)
                        if not v16 then
                            warn("[PetIndex] No egg selected");
                            return;
                        else
                            _G:Play("Click2");
                            local v168 = v11:InvokeServer("ClaimPetIndexReward", v16);
                            if type(v168) == "table" and v168.success then
                                if v168.rewards and #v168.rewards > 0 then
                                    local v169 = {};
                                    for _, v171 in ipairs(v168.rewards) do
                                        local l_v10_ItemData_1 = v10:GetItemData(v171[1], v171[2]);
                                        local v173 = l_v10_ItemData_1 and l_v10_ItemData_1.name or v171[2];
                                        local v174 = v13:Abbreviate(v171[3]);
                                        table.insert(v169, string.format("+%s %s", v174, v173));
                                    end;
                                    v12.Fire("Reward", v168.rewards, false, "Victory");
                                end;
                                task.wait(0.5);
                                if v16 == "Secrets" then
                                    updateSecretsPanel();
                                    return;
                                else
                                    updateRightPanel();
                                    return;
                                end;
                            else
                                if type(v168) == "string" then
                                    warn("[PetIndex] Claim failed:", v168);
                                end;
                                return;
                            end;
                        end;
                    end);
                    return;
                end;
            end;
        end;
    end;
end;
local function v195() --[[ Line: 873 ]] --[[ Name: createSecretsFrame ]]
    -- upvalues: v14 (ref), l_ReplicatedStorage_0 (copy), v5 (copy), v6 (copy), l_TweenService_0 (copy)
    local v176 = v14.Container.Eggs.List.EggTemplate:Clone();
    v176.Name = "Secrets";
    v176.Visible = true;
    v176.LayoutOrder = 999999;
    v176.Label.Text = "Secret Pets";
    v176.Label.Label.Text = "Secret Pets";
    local l_EggViewport_2 = v176:FindFirstChild("EggViewport");
    if l_EggViewport_2 then
        local l_ViewportFrame_3 = l_EggViewport_2:FindFirstChild("ViewportFrame");
        if l_ViewportFrame_3 then
            l_ViewportFrame_3:ClearAllChildren();
            local l_SecretEgg_0 = l_ReplicatedStorage_0.Content:FindFirstChild("SecretEgg");
            if l_SecretEgg_0 then
                local v180 = l_SecretEgg_0:Clone();
                local l_Camera_1 = Instance.new("Camera");
                l_Camera_1.Parent = l_ViewportFrame_3;
                l_ViewportFrame_3.CurrentCamera = l_Camera_1;
                v180.Parent = l_ViewportFrame_3;
                local l_CFrame_0 = v180.CFrame;
                local l_Size_0 = v180.Size;
                local v184 = math.max(l_Size_0.X, l_Size_0.Y, l_Size_0.Z) * 2;
                local v185 = l_CFrame_0.Position + Vector3.new(v184 * 0.5, v184 * 0.3, v184);
                l_Camera_1.CFrame = CFrame.lookAt(v185, l_CFrame_0.Position);
                l_Camera_1.FieldOfView = 30;
                l_ViewportFrame_3.Visible = true;
                l_ViewportFrame_3.BackgroundTransparency = 1;
            end;
        end;
    end;
    local v186 = 0;
    local v187 = 0;
    for _, v189 in pairs(v5) do
        if type(v189) == "table" and v189.Secrets then
            for v190, _ in pairs(v189.Secrets) do
                v186 = v186 + 1;
                if v6.Loaded and v6.Data.Discovered[v190] then
                    v187 = v187 + 1;
                end;
            end;
        end;
    end;
    v176.ProgressCategories.Normal.Text = v187 .. " / " .. v186;
    v176.ProgressCategories.Golden.Visible = false;
    v176.ProgressCategories.Rainbow.Visible = false;
    local v192 = v186 > 0 and v187 / v186 * 100 or 0;
    v176.Level.Bar.Size = UDim2.fromScale(math.min(v192 / 100, 1), 1);
    v176.Level.Percentage.Text = math.floor(v192) .. "%";
    v176.Level.Level.Text = "Secrets";
    v176.Level.Level.TextColor3 = Color3.fromRGB(255, 0, 255);
    v176.Level.Bar.BackgroundColor3 = Color3.fromRGB(255, 0, 255);
    if v176:FindFirstChild("ClaimableRewards") then
        v176.ClaimableRewards.Visible = false;
    end;
    local l_UIScale_1 = Instance.new("UIScale");
    l_UIScale_1.Scale = 1;
    l_UIScale_1.Parent = v176;
    local l_TextButton_1 = Instance.new("TextButton");
    l_TextButton_1.Name = "Button";
    l_TextButton_1.Size = UDim2.fromScale(1, 1);
    l_TextButton_1.BackgroundTransparency = 1;
    l_TextButton_1.Text = "";
    l_TextButton_1.ZIndex = 10;
    l_TextButton_1.Parent = v176;
    l_TextButton_1.MouseEnter:Connect(function() --[[ Line: 971 ]]
        -- upvalues: l_TweenService_0 (ref), l_UIScale_1 (copy)
        _G:Play("Click");
        l_TweenService_0:Create(l_UIScale_1, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Scale = 1.02
        }):Play();
    end);
    l_TextButton_1.MouseLeave:Connect(function() --[[ Line: 978 ]]
        -- upvalues: l_TweenService_0 (ref), l_UIScale_1 (copy)
        l_TweenService_0:Create(l_UIScale_1, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Scale = 1
        }):Play();
    end);
    l_TextButton_1.MouseButton1Down:Connect(function() --[[ Line: 985 ]]
        -- upvalues: l_TweenService_0 (ref), l_UIScale_1 (copy)
        l_TweenService_0:Create(l_UIScale_1, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Scale = 0.98
        }):Play();
    end);
    l_TextButton_1.MouseButton1Up:Connect(function() --[[ Line: 991 ]]
        -- upvalues: l_TweenService_0 (ref), l_UIScale_1 (copy)
        l_TweenService_0:Create(l_UIScale_1, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Scale = 1.02
        }):Play();
    end);
    l_TextButton_1.Activated:Connect(function() --[[ Line: 998 ]]
        _G:Play("Click");
        selectSecrets();
    end);
    return v176;
end;
selectSecrets = function() --[[ Line: 1007 ]] --[[ Name: selectSecrets ]]
    -- upvalues: v22 (ref), v23 (ref), v8 (copy), v16 (ref), v14 (ref), v18 (ref), l_TweenService_0 (copy)
    v22 = {};
    v23 = nil;
    v8:Close();
    v16 = "Secrets";
    local l_ActualContainer_3 = v14.Container.RightSideEggInfo:FindFirstChild("ActualContainer");
    if l_ActualContainer_3 then
        if not v18 then
            v18 = l_ActualContainer_3.Position;
        end;
        l_ActualContainer_3.Position = UDim2.new(1.5, 0, v18.Y.Scale, v18.Y.Offset);
        updateSecretsPanel();
        l_TweenService_0:Create(l_ActualContainer_3, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = v18
        }):Play();
    else
        updateSecretsPanel();
    end;
    for _, v198 in ipairs(v14.Container.Eggs.List:GetChildren()) do
        if v198:IsA("Frame") and v198.Name ~= "EggTemplate" then
            local v199 = v198.Background and v198.Background:FindFirstChild("UIStroke") or v198:FindFirstChild("UIStroke");
            if v199 then
                if v198.Name == "Secrets" then
                    v199.Color = Color3.fromRGB(255, 255, 255);
                    v199.Transparency = 0;
                else
                    v199.Color = Color3.fromRGB(100, 100, 100);
                    v199.Transparency = 0.5;
                end;
            end;
        end;
    end;
end;
updateSecretsPanel = function() --[[ Line: 1059 ]] --[[ Name: updateSecretsPanel ]]
    -- upvalues: v14 (ref), v5 (copy), v6 (copy), v4 (copy), v25 (copy)
    local l_ActualContainer_4 = v14.Container.RightSideEggInfo:FindFirstChild("ActualContainer");
    if not l_ActualContainer_4 then
        warn("ActualContainer not found");
        return;
    else
        if l_ActualContainer_4.PetsContainer then
            l_ActualContainer_4.PetsContainer.EggName.Text = "Secret Pets";
        end;
        if l_ActualContainer_4.CurrentCategory then
            l_ActualContainer_4.CurrentCategory.Visible = false;
        end;
        if l_ActualContainer_4:FindFirstChild("Left") then
            l_ActualContainer_4.Left.Visible = false;
        end;
        if l_ActualContainer_4:FindFirstChild("Right") then
            l_ActualContainer_4.Right.Visible = false;
        end;
        local v201 = 0;
        for _, v203 in pairs(v5) do
            if type(v203) == "table" and v203.Secrets then
                for _ in pairs(v203.Secrets) do
                    v201 = v201 + 1;
                end;
            end;
        end;
        local v205 = 0;
        for _, v207 in pairs(v5) do
            if type(v207) == "table" and v207.Secrets then
                for v208, _ in pairs(v207.Secrets) do
                    if v6.Loaded and v6.Data.Discovered[v208] then
                        v205 = v205 + 1;
                    end;
                end;
            end;
        end;
        if l_ActualContainer_4.PetsContainer and l_ActualContainer_4.PetsContainer:FindFirstChild("Progress") then
            local l_Progress_1 = l_ActualContainer_4.PetsContainer.Progress;
            local v211 = v201 > 0 and v205 / v201 or 0;
            if l_Progress_1:FindFirstChild("Bar") then
                l_Progress_1.Bar.Size = UDim2.fromScale(math.min(v211, 1), 1);
                l_Progress_1.Bar.BackgroundColor3 = Color3.fromRGB(255, 0, 255);
            end;
            if l_Progress_1:FindFirstChild("Percentage") then
                l_Progress_1.Percentage.Text = v205 .. " / " .. v201;
            end;
        end;
        local v212 = l_ActualContainer_4.PetsContainer and l_ActualContainer_4.PetsContainer.PetsScrollingFrame;
        if v212 then
            for _, v214 in ipairs(v212:GetChildren()) do
                if v214:IsA("Frame") then
                    v214:Destroy();
                end;
            end;
            local v215 = {};
            for _, v217 in pairs(v5) do
                if type(v217) == "table" and v217.Secrets then
                    for v218, _ in pairs(v217.Secrets) do
                        local l_v4_Rarity_1 = v4:GetRarity(v218);
                        local v221 = v25[l_v4_Rarity_1] or 7;
                        table.insert(v215, {
                            name = v218, 
                            rarity = l_v4_Rarity_1, 
                            order = v221
                        });
                    end;
                end;
            end;
            table.sort(v215, function(v222, v223) --[[ Line: 1148 ]]
                return v222.order < v223.order;
            end);
            for v224, v225 in ipairs(v215) do
                local v226 = createPetFrame(v225.name, "Normal");
                v226.LayoutOrder = v224 - 1;
                v226.Parent = v212;
            end;
        end;
        updateSecretsRewardsDisplay(l_ActualContainer_4);
        return;
    end;
end;
updateSecretsRewardsDisplay = function(v227) --[[ Line: 1165 ]] --[[ Name: updateSecretsRewardsDisplay ]]
    -- upvalues: v14 (ref), v9 (copy), v10 (copy), v31 (copy), v12 (copy), v5 (copy), v6 (copy)
    if not v227 then
        v227 = v14.Container.RightSideEggInfo:FindFirstChild("ActualContainer");
        if not v227 then
            return;
        end;
    end;
    local l_RewardsContainer_2 = v227:FindFirstChild("RewardsContainer");
    local l_List_1 = l_RewardsContainer_2.List;
    if not l_RewardsContainer_2 then
        return;
    else
        for _, v231 in ipairs(l_List_1:GetChildren()) do
            if v231:IsA("Frame") and v231.Name ~= "OutsideStuff" and not v231:IsA("UIListLayout") then
                v231:Destroy();
            end;
        end;
        if l_RewardsContainer_2.OutsideStuff and l_RewardsContainer_2.OutsideStuff:FindFirstChild("Label") then
            l_RewardsContainer_2.OutsideStuff.Label.Text = "Secret Completion Reward";
        end;
        local l_v9_EggRewards_1 = v9:GetEggRewards("Secrets");
        if not l_v9_EggRewards_1 or not l_v9_EggRewards_1.Complete then
            return;
        else
            for _, v234 in ipairs(l_v9_EggRewards_1.Complete) do
                local l_v10_ItemSlot_1 = v10:CreateItemSlot(v234.Name, v234.Type, v234.Amount);
                if l_v10_ItemSlot_1 then
                    l_v10_ItemSlot_1.Parent = l_List_1;
                    local l_Hitbox_1 = l_v10_ItemSlot_1:FindFirstChild("Hitbox");
                    if l_Hitbox_1 and l_Hitbox_1:IsA("TextButton") then
                        l_Hitbox_1.Active = false;
                        l_Hitbox_1.AutoButtonColor = false;
                    end;
                    local v237 = v31(v234);
                    if v237 then
                        local v238 = l_v10_ItemSlot_1:FindFirstChild("Main") or l_v10_ItemSlot_1;
                        v12.Fire("Tooltip", v238, v237);
                    end;
                end;
            end;
            local v239 = 0;
            local v240 = 0;
            for _, v242 in pairs(v5) do
                if type(v242) == "table" and v242.Secrets then
                    for v243, _ in pairs(v242.Secrets) do
                        v239 = v239 + 1;
                        if v6.Loaded and v6.Data.Discovered[v243] then
                            v240 = v240 + 1;
                        end;
                    end;
                end;
            end;
            local v245 = false;
            if v239 <= v240 then
                v245 = v239 > 0;
            end;
            local v246 = false;
            if v6.Loaded and v6.Data.PetIndexRewards then
                local l_Secrets_0 = v6.Data.PetIndexRewards.Secrets;
                if l_Secrets_0 and l_Secrets_0.Complete then
                    v246 = true;
                end;
            end;
            local v248 = v245 and not v246;
            local l_ClaimedOverlay_1 = l_RewardsContainer_2.OutsideStuff:FindFirstChild("ClaimedOverlay");
            if l_ClaimedOverlay_1 then
                l_ClaimedOverlay_1:Destroy();
            end;
            if v246 then
                local l_Frame_1 = Instance.new("Frame");
                l_Frame_1.Name = "ClaimedOverlay";
                l_Frame_1.Size = UDim2.fromScale(1, 1);
                l_Frame_1.Position = UDim2.fromScale(0, 0);
                l_Frame_1.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
                l_Frame_1.BackgroundTransparency = 0.7;
                l_Frame_1.BorderSizePixel = 0;
                l_Frame_1.ZIndex = 100;
                l_Frame_1.Parent = l_RewardsContainer_2.OutsideStuff;
                local l_TextLabel_1 = Instance.new("TextLabel");
                l_TextLabel_1.Name = "ClaimedText";
                l_TextLabel_1.Size = UDim2.fromScale(0.8, 0.3);
                l_TextLabel_1.Position = UDim2.fromScale(0.5, 0.5);
                l_TextLabel_1.AnchorPoint = Vector2.new(0.5, 0.5);
                l_TextLabel_1.BackgroundTransparency = 1;
                l_TextLabel_1.Text = "CLAIMED";
                l_TextLabel_1.TextColor3 = Color3.fromRGB(255, 255, 0);
                l_TextLabel_1.TextScaled = true;
                l_TextLabel_1.Font = Enum.Font.GothamBold;
                l_TextLabel_1.ZIndex = 101;
                l_TextLabel_1.Parent = l_Frame_1;
                local l_UIStroke_1 = Instance.new("UIStroke");
                l_UIStroke_1.Thickness = 2;
                l_UIStroke_1.Color = Color3.fromRGB(0, 0, 0);
                l_UIStroke_1.Parent = l_TextLabel_1;
            end;
            if l_RewardsContainer_2.OutsideStuff and l_RewardsContainer_2.OutsideStuff:FindFirstChild("Claim") then
                l_RewardsContainer_2.OutsideStuff.Claim.Visible = v248;
            end;
            return;
        end;
    end;
end;
local function v262() --[[ Line: 1290 ]] --[[ Name: populateEggList ]]
    -- upvalues: v14 (ref), v5 (copy), v83 (copy), v195 (copy)
    for _, v254 in ipairs(v14.Container.Eggs.List:GetChildren()) do
        if v254:IsA("Frame") and v254.Name ~= "EggTemplate" then
            v254:Destroy();
        end;
    end;
    local v255 = {};
    for v256, v257 in pairs(v5) do
        if type(v257) == "table" and v257.Index and v257.Pets and not v257.Exclusive and not v257.RobuxEgg and (v257.Index < 900 or v257.Index >= 1000) then
            table.insert(v255, {
                name = v256, 
                info = v257, 
                index = v257.Index
            });
        end;
    end;
    table.sort(v255, function(v258, v259) --[[ Line: 1312 ]]
        return v258.index < v259.index;
    end);
    for _, v261 in ipairs(v255) do
        v83(v261.name, v261.info, v261.index).Parent = v14.Container.Eggs.List;
    end;
    v195().Parent = v14.Container.Eggs.List;
    if #v255 > 0 then
        task.defer(function() --[[ Line: 1328 ]]
            -- upvalues: v255 (copy)
            selectEgg(v255[1].name);
        end);
    end;
end;
local function v268() --[[ Line: 1335 ]] --[[ Name: setupCategoryButtons ]]
    -- upvalues: v14 (ref), v24 (copy), v17 (ref)
    local l_ActualContainer_5 = v14.Container.RightSideEggInfo:FindFirstChild("ActualContainer");
    if not l_ActualContainer_5 then
        warn("ActualContainer not found for category buttons");
        return;
    else
        local function _() --[[ Line: 1345 ]] --[[ Name: playClickSound ]]
            _G:Play("Click");
        end;
        if l_ActualContainer_5:FindFirstChild("Right") then
            local l_Button_1 = l_ActualContainer_5.Right:FindFirstChild("Button");
            if l_Button_1 then
                l_Button_1.Activated:Connect(function() --[[ Line: 1353 ]]
                    -- upvalues: v24 (ref), v17 (ref)
                    _G:Play("Click");
                    v17 = v24[(table.find(v24, v17) or 1) % #v24 + 1];
                    updateRightPanel();
                end);
            end;
        end;
        if l_ActualContainer_5:FindFirstChild("Left") then
            local l_Button_2 = l_ActualContainer_5.Left:FindFirstChild("Button");
            if l_Button_2 then
                l_Button_2.Activated:Connect(function() --[[ Line: 1367 ]]
                    -- upvalues: v24 (ref), v17 (ref)
                    _G:Play("Click");
                    local v267 = (table.find(v24, v17) or 1) - 1;
                    if v267 < 1 then
                        v267 = #v24;
                    end;
                    v17 = v24[v267];
                    updateRightPanel();
                end);
            end;
        end;
        return;
    end;
end;
local function v282() --[[ Line: 1382 ]] --[[ Name: updateAllEggProgress ]]
    -- upvalues: v14 (ref), v5 (copy), v38 (copy), v16 (ref)
    if not v14 then
        return;
    else
        for _, v270 in ipairs(v14.Container.Eggs.List:GetChildren()) do
            if v270:IsA("Frame") and v270.Name ~= "EggTemplate" then
                local l_Name_0 = v270.Name;
                if v5[l_Name_0] then
                    local v272;
                    if not v5[l_Name_0] or not v5[l_Name_0].Pets then
                        v272 = 0;
                    else
                        local v273 = 0;
                        for _, _ in pairs(v5[l_Name_0].Pets) do
                            v273 = v273 + 1;
                        end;
                        v272 = v273;
                    end;
                    local v276 = v38(l_Name_0, "Normal");
                    local v277 = v38(l_Name_0, "Golden");
                    local v278 = v38(l_Name_0, "Rainbow");
                    v270.ProgressCategories.Normal.Text = v276 .. " / " .. v272;
                    v270.ProgressCategories.Golden.Text = v277 .. " / " .. v272;
                    v270.ProgressCategories.Rainbow.Text = v278 .. " / " .. v272;
                    local v279 = v276 + v277 + v278;
                    local v280 = v272 * 3;
                    local v281 = v280 > 0 and v279 / v280 * 100 or 0;
                    v270.Level.Bar.Size = UDim2.fromScale(math.min(v281 / 100, 1), 1);
                    v270.Level.Percentage.Text = v279 .. " / " .. v280;
                end;
            end;
        end;
        if v16 then
            updateRightPanel();
        end;
        return;
    end;
end;
local v283 = require(l_ReplicatedStorage_0.Game.Achievements);
local function v293() --[[ Line: 1417 ]] --[[ Name: displayAchievement ]]
    -- upvalues: v6 (copy), v14 (ref), v283 (copy), v13 (copy)
    if not v6.Loaded or not v6.Data.Achievements or not v6.Data.Achievements.Collection then
        return;
    else
        local l_Reward_0 = v14.Container.Reward;
        local l_Index_0 = v6.Data.Achievements.Collection.Index;
        local v286 = v283.Collection.Tasks[l_Index_0];
        if v283.Collection.Tasks[l_Index_0 + 1] then
            l_Reward_0.Tier.Visible = true;
            l_Reward_0.Arrow.Visible = true;
            l_Reward_0.Tier.Text = "Tier " .. l_Index_0;
            l_Reward_0.Tier2.Text = "Tier " .. l_Index_0 + 1;
        else
            l_Reward_0.Tier.Visible = false;
            l_Reward_0.Arrow.Visible = false;
            l_Reward_0.Tier2.Text = "Tier " .. l_Index_0;
        end;
        if v286 then
            local l_Equips_0 = v286.Reward.Equips;
            local l_Storage_0 = v286.Reward.Storage;
            local v289 = (l_Equips_0 and "+" .. l_Equips_0 .. " Pet Equipped Slot" .. (l_Equips_0 == 1 and "" or "s") or "") .. (l_Storage_0 and "   +" .. l_Storage_0 .. " Pet Storage Slot" .. (l_Storage_0 == 1 and "" or "s") or "");
            l_Reward_0.Reward.Text = v289;
            local l_Amount_0 = v6.Data.Achievements.Collection.Amount;
            local l_Amount_1 = v286.Amount;
            local v292 = math.min(l_Amount_0 / l_Amount_1, 1);
            l_Reward_0.Bar.Title.Text = v13:Commas(l_Amount_0) .. " / " .. v13:Commas(l_Amount_1);
            l_Reward_0.Bar.Frame.Size = UDim2.fromScale(math.max(v292, 0.033), 1);
            return;
        else
            l_Reward_0.Reward.Text = "Come back later!";
            l_Reward_0.Tier.Text = "Max Tier";
            l_Reward_0.Tier2.Text = "Max Tier";
            l_Reward_0.Bar.Title.Text = "Max";
            l_Reward_0.Bar.Frame.Size = UDim2.fromScale(1, 1);
            return;
        end;
    end;
end;
v15.Init = function(_, _, v296) --[[ Line: 1468 ]] --[[ Name: Init ]]
    -- upvalues: v14 (ref), v175 (copy), v293 (copy), v8 (copy), v19 (ref), v6 (copy), v262 (copy), v268 (copy), v22 (ref), v23 (ref), l_RunService_0 (copy), l_LocalPlayer_0 (copy), l_l_LocalPlayer_0_Mouse_0 (copy), v282 (copy), v16 (ref)
    v14 = v296;
    local l_Parent_0 = v14.Parent;
    v175();
    v293();
    v8:Start();
    l_Parent_0:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 1483 ]]
        -- upvalues: l_Parent_0 (copy), v19 (ref), v293 (ref), v6 (ref), v262 (ref), v268 (ref), v22 (ref), v23 (ref), v8 (ref)
        if l_Parent_0.Enabled then
            v19 = true;
            v293();
            if not v6.Loaded then
                v6:Connect("DataLoaded", function() --[[ Line: 1490 ]]
                    -- upvalues: v262 (ref), v268 (ref)
                    v262();
                    v268();
                end);
                return;
            else
                v262();
                v268();
                return;
            end;
        else
            v22 = {};
            v23 = nil;
            v8:Close();
            return;
        end;
    end);
    l_RunService_0.Heartbeat:Connect(function() --[[ Line: 1505 ]]
        -- upvalues: l_Parent_0 (copy), v23 (ref), v8 (ref), l_LocalPlayer_0 (ref), l_l_LocalPlayer_0_Mouse_0 (ref), v22 (ref)
        if not l_Parent_0.Enabled then
            if v23 then
                v8:Close();
                v23 = nil;
            end;
            return;
        else
            local l_GuiObjectsAtPosition_0 = l_LocalPlayer_0.PlayerGui:GetGuiObjectsAtPosition(l_l_LocalPlayer_0_Mouse_0.X, l_l_LocalPlayer_0_Mouse_0.Y);
            local v299 = nil;
            local v300 = nil;
            for _, v302 in ipairs(l_GuiObjectsAtPosition_0) do
                for v303, v304 in pairs(v22) do
                    if v302 == v303 or v302:IsDescendantOf(v303) then
                        v299 = v303;
                        v300 = v304;
                        break;
                    end;
                end;
                if v299 then
                    break;
                end;
            end;
            if v299 ~= v23 then
                if v299 and v300 then
                    v8:Prompt(v300);
                else
                    v8:Close();
                end;
                v23 = v299;
            end;
            return;
        end;
    end);
    v6:Connect("Discovered", function() --[[ Line: 1544 ]]
        -- upvalues: l_Parent_0 (copy), v293 (ref), v282 (ref)
        if l_Parent_0.Enabled then
            v293();
            v282();
        end;
    end);
    v6:Connect("DataLoaded", function() --[[ Line: 1552 ]]
        -- upvalues: l_Parent_0 (copy), v282 (ref)
        if l_Parent_0.Enabled then
            v282();
        end;
    end);
    v6:Connect("PetIndexRewards", function() --[[ Line: 1559 ]]
        -- upvalues: l_Parent_0 (copy), v16 (ref)
        if l_Parent_0.Enabled and v16 then
            if v16 == "Secrets" then
                updateSecretsPanel();
                return;
            else
                updateRightPanel();
            end;
        end;
    end);
end;
return v15;