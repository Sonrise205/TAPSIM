local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_UserInputService_0 = game:GetService("UserInputService");
local v4 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v5 = require(l_ReplicatedStorage_0.Modules.Network);
local v6 = require(l_ReplicatedStorage_0.Modules.Signal);
local v7 = require(l_ReplicatedStorage_0.Modules.Short);
local v8 = require(l_ReplicatedStorage_0.Modules.Rainbow);
local v9 = require(l_ReplicatedStorage_0.Modules.CustomGrid);
local v10 = require(l_ReplicatedStorage_0.Game.Replication);
local v11 = require(l_ReplicatedStorage_0.Game.PetStats);
local v12 = require(l_ReplicatedStorage_0.Game.PetFrames);
local v13 = require(l_ReplicatedStorage_0.Game.PetFrames.Info);
local v14 = require(l_ReplicatedStorage_0.Game.Replication);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_Mouse_0 = l_Players_0.LocalPlayer:GetMouse();
local l_Content_0 = l_ReplicatedStorage_0.Content;
local _ = l_Content_0.UI;
local l_InfoUI_0 = l_LocalPlayer_0.PlayerGui.InfoUI;
local _ = l_LocalPlayer_0:WaitForChild("PlayerGui"):WaitForChild("Game");
local v21 = {};
local v22 = nil;
local v23 = nil;
local v24 = nil;
local v25 = nil;
local _ = nil;
local v27 = nil;
local _ = nil;
local v29 = nil;
local v30 = nil;
local v31 = nil;
local v32 = nil;
local _ = {
    "Dog", 
    1
};
local v34 = 1;
local v35 = {
    {
        "Clicks", 
        "Multi1"
    }, 
    {
        "Gems", 
        "Multi2"
    }, 
    {
        "Level", 
        "Level"
    }, 
    {
        "Exists", 
        "Exists"
    }
};
local _ = {};
local v37 = {};
local v38 = {};
local v39 = {};
local v40 = {};
local v41 = {};
local _ = function(v42, v43) --[[ Line: 54 ]] --[[ Name: getAmount ]]
    -- upvalues: v37 (copy)
    local v44 = 0;
    for _, v46 in pairs(v37) do
        if v46.Name == v42 and v46.Tier == v43 and not v46.Locked then
            v44 = v44 + 1;
        end;
    end;
    return v44;
end;
promptEquips = function() --[[ Line: 64 ]] --[[ Name: promptEquips ]]
    -- upvalues: v10 (copy), v6 (copy)
    if not v10.Data.Gamepasses["+2Equip"] then
        v6.Fire("PromptGamepass", "+2Equip");
        return;
    elseif not v10.Data.Gamepasses["+4Equip"] then
        v6.Fire("PromptGamepass", "+4Equip");
        return;
    else
        v6.Fire("Notification", "Complete quests to unlock more!", Color3.fromRGB(140, 0, 255));
        return;
    end;
end;
promptStorage = function() --[[ Line: 78 ]] --[[ Name: promptStorage ]]
    -- upvalues: v10 (copy), v6 (copy)
    if not v10.Data.Gamepasses.Storage1 then
        v6.Fire("PromptGamepass", "Storage1");
        return;
    elseif not v10.Data.Gamepasses.Storage2 then
        v6.Fire("PromptGamepass", "Storage2");
        return;
    else
        v6.Fire("Notification", "Complete quests to unlock more!", Color3.fromRGB(140, 0, 255));
        return;
    end;
end;
local v48 = nil;
selectPet = function(v49) --[[ Line: 92 ]] --[[ Name: selectPet ]]
    -- upvalues: v30 (ref), v29 (ref), v8 (copy), v24 (ref), v37 (copy), v48 (ref), v4 (copy), l_Content_0 (copy), v11 (copy), v10 (copy), v7 (copy)
    if v49 ~= v30 then
        v29.Actions.Delete.Main.Title.Text = "Delete";
    end;
    v30 = v49;
    if v29.PetName:FindFirstChildOfClass("UIGradient") then
        v29.PetName:FindFirstChildOfClass("UIGradient"):Destroy();
    end;
    if not v49 then
        v8:Remove(v29.ImageLabel);
        v8:Remove(v29.PetName);
        local l_v29_FirstChild_0 = v29:FindFirstChild("Golden", true);
        local l_v29_FirstChild_1 = v29:FindFirstChild("Rainbow", true);
        if l_v29_FirstChild_0 then
            l_v29_FirstChild_0.Visible = false;
        end;
        if l_v29_FirstChild_1 then
            l_v29_FirstChild_1.Visible = false;
            if l_v29_FirstChild_1:FindFirstChild("UIGradient") then
                v8:Remove(l_v29_FirstChild_1.UIGradient);
            end;
        end;
        v29.Visible = false;
        v24.InfoBackground.Select.Visible = true;
        return;
    elseif not v37[v49] then
        return;
    else
        if v48 then
            v48:Destroy();
        end;
        v29.Size = UDim2.fromScale(0.195, 0.7);
        v48 = v4:Tween(v29, 0.2, "Back", "Out", {
            Size = UDim2.fromScale(0.215, 0.801)
        });
        v29.Visible = true;
        v24.InfoBackground.Select.Visible = false;
        v29.Actions.Equip.Visible = not v37[v49].Equipped;
        v29.Actions.Unequip.Visible = v37[v49].Equipped;
        v29.PetName.Text = v37[v49].Name;
        if v37[v49].ChangedNickname then
            v29.PetName.Text = v37[v49].Nickname and "\"" .. v37[v49].Nickname .. "\"" or v37[v49].Name;
        end;
        if v37[v49].Signature then
            v29.SetNickname.Visible = false;
            l_Content_0.UI.SignedGradient:Clone().Parent = v29.PetName;
            v29.PetName.Text = v37[v49].Signature:gsub("0xE002", "\238\128\128");
        else
            v29.SetNickname.Visible = true;
        end;
        local l_v11_Image_0 = v11:GetImage(v37[v49].Name, v37[v49].Tier ~= "Normal" and v37[v49].Tier or nil);
        if typeof(l_v11_Image_0) == "table" and l_v11_Image_0.imageId and l_v11_Image_0.rectOffset then
            v29.ImageLabel.Image = l_v11_Image_0.imageId;
            local v53 = Vector2.new(256, 256);
            local l_rectOffset_0 = l_v11_Image_0.rectOffset;
            v29.ImageLabel.ImageRectSize = v53;
            v29.ImageLabel.ImageRectOffset = l_rectOffset_0;
        else
            v29.ImageLabel.ImageRectSize = Vector2.new();
            v29.ImageLabel.ImageRectOffset = Vector2.new();
            v29.ImageLabel.Image = l_v11_Image_0;
        end;
        v8:Remove(v29.ImageLabel);
        v8:Remove(v29.PetName);
        v29.ImageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255);
        v29.PetName.TextColor3 = Color3.fromRGB(255, 255, 255);
        if v37[v49].Tier == "Rainbow" then
            v8:Add(v29.ImageLabel);
            if not v37[v49].Signature then
                v8:Add(v29.PetName);
            end;
        end;
        local l_Tier_0 = v37[v49].Tier;
        local l_v29_FirstChild_2 = v29:FindFirstChild("Golden", true);
        local l_v29_FirstChild_3 = v29:FindFirstChild("Rainbow", true);
        if l_v29_FirstChild_2 then
            l_v29_FirstChild_2.Visible = l_Tier_0 == "Golden";
        end;
        if l_v29_FirstChild_3 then
            if l_v29_FirstChild_3:FindFirstChild("UIGradient") then
                v8:Remove(l_v29_FirstChild_3.UIGradient);
            end;
            l_v29_FirstChild_3.Visible = l_Tier_0 == "Rainbow";
            if l_Tier_0 == "Rainbow" and l_v29_FirstChild_3:FindFirstChild("UIGradient") then
                v8:Add(l_v29_FirstChild_3.UIGradient);
            end;
        end;
        v29.Stats.Multi2.Visible = v37[v49].Multi2 > 0;
        local l_v11_Percentage_0 = v11:GetPercentage(v37[v49].Name);
        if l_v11_Percentage_0 then
            v29.Stats.Percentage.Visible = true;
            v29.Stats.Percentage.Text = math.round(l_v11_Percentage_0 * 10) / 10 .. "% Best Pet";
            v37[v49].Multiplier1 = v11:GetMulti(v10.Data.BestMultiplier[1] * l_v11_Percentage_0 / 100, v37[v49].Tier, v37[v49].Level, v37[v49]);
            v37[v49].Multiplier2 = v11:GetMulti(v10.Data.BestMultiplier[2] * l_v11_Percentage_0 / 100, v37[v49].Tier, v37[v49].Level, v37[v49]);
        else
            v29.Stats.Percentage.Visible = false;
        end;
        local v59 = v37[v49];
        if v59 then
            v29.Stats.Multi1.Amount.Text = "x" .. v7:Abbreviate(v59.Multiplier1 or 0);
            v29.Stats.Multi2.Amount.Text = "x" .. v7:Abbreviate(v59.Multiplier2 or 0);
        end;
        local l_v11_MaxLevel_0 = v11:GetMaxLevel(v11:GetRarity(v37[v49].Name));
        local v61 = math.round((v11:XPRequirement(v37[v49].Level, v11:GetRarity(v37[v49].Name))));
        v29.Stats.Level.Lvl.Text = "Level " .. v37[v49].Level;
        if l_v11_MaxLevel_0 <= v37[v49].Level then
            v29.Stats.Level.Percentage.Text = "Max Level";
            v29.Stats.Level.Bar.Size = UDim2.fromScale(1, 1);
        else
            v29.Stats.Level.Percentage.Text = math.round(v37[v49].XP) .. " / " .. v61;
            v29.Stats.Level.Bar.Size = UDim2.fromScale(v37[v49].XP / v61, 1);
        end;
        if v37[v49].Serial then
            v29.Stats.Level.Serial.Visible = true;
            v29.Stats.Level.Serial.Text = "#" .. v37[v49].Serial;
            return;
        else
            v29.Stats.Level.Serial.Visible = false;
            return;
        end;
    end;
end;
local v62 = 0;
UpdateInvStats = function() --[[ Line: 257 ]] --[[ Name: UpdateInvStats ]]
    -- upvalues: v23 (ref), v37 (copy), v11 (copy), v24 (ref), v14 (copy), v25 (ref), v10 (copy), v62 (ref)
    if not v23.Parent.Enabled then
        return;
    else
        local v63 = 0;
        local v64 = 0;
        local v65 = 0;
        for _, v67 in pairs(v37) do
            v63 = v63 + 1;
            v65 = v65 + 1;
            if v67.Equipped then
                v64 = v64 + 1;
            end;
            if v11:GetBigFrame(v67.Name) then
                v65 = v65 + 3;
            end;
        end;
        v24.Top.Storage.Text = v63 .. " / " .. v14.Data.StorageLimit;
        v24.Top.Equipped.Text = v64 .. " / " .. v14.Data.EquipLimit;
        if v64 == 0 then
            v25.Parent.Equipped.Visible = false;
            v25.Parent.Divider.Visible = false;
        else
            v25.Parent.Equipped.Visible = true;
            v25.Parent.Divider.Visible = true;
            if v64 > 6 then
                v25.Parent.Equipped.UIPadding.PaddingTop = UDim.new(0.05, 0);
            else
                v25.Parent.Equipped.UIPadding.PaddingTop = UDim.new(0.16, 0);
            end;
        end;
        local v68 = math.ceil((v65 - v64) / 6) + math.max(0, (math.ceil((v64 - 6) / 6))) - 3;
        if v64 > 6 then
            v68 = v68 + 0.5;
        end;
        if v68 > 0 then
            v25.Parent.CanvasSize = UDim2.fromScale(0, v68 * 0.23124 + 2.5);
        else
            v25.Parent.CanvasSize = UDim2.fromScale(0, 2.5);
        end;
        local v69 = true;
        if v14.Data.EquipLimit > v64 then
            v69 = v64 == v63;
        end;
        local v70 = false;
        local v71 = false;
        if v69 then
            local _ = v11:GetBestPets(v14.Data.Pets, nil, v14.Data.BestPet);
            local v73 = 0;
            local v74 = {};
            local v75 = {};
            for _, v77 in pairs(v37) do
                local l_Multiplier1_0 = v77.Multiplier1;
                if v11:GetPercentage(v77.Name) then
                    l_Multiplier1_0 = v11:GetMulti(v10.Data.BestMultiplier[1] * v11:GetPercentage(v77.Name) / 100, v77.Tier, v77.Level, v77);
                end;
                table.insert(v74, l_Multiplier1_0);
                if v77.Equipped then
                    table.insert(v75, l_Multiplier1_0);
                end;
            end;
            table.sort(v74, function(v79, v80) --[[ Line: 340 ]]
                return v80 < v79;
            end);
            table.sort(v75, function(v81, v82) --[[ Line: 341 ]]
                return v82 < v81;
            end);
            local v83 = {};
            for v84 = 1, math.min(v14.Data.EquipLimit, #v74) do
                v83[v84] = v74[v84];
                v73 = v73 + 1;
            end;
            if #v75 == #v83 then
                v70 = true;
                for v85 = 1, #v83 do
                    if v75[v85] ~= v83[v85] then
                        v70 = false;
                        break;
                    end;
                end;
            else
                v70 = false;
            end;
            if v73 == 0 then
                v71 = true;
            end;
        end;
        v24.Bottom1.Actions.Best.Visible = not v70 or v71;
        v24.Bottom1.Actions.None.Visible = v70 and not v71;
        local v86 = v63 - v64;
        if v62 ~= v86 then
            v62 = v86;
        end;
        return;
    end;
end;
local function _() --[[ Line: 378 ]] --[[ Name: updateMultiDelete ]]
    -- upvalues: v24 (ref), v40 (ref)
    v24.MultiDelete.Title.Text = "Deleting " .. #v40 .. " Pets";
    v24.MultiDelete.Buttons.Delete.Main.Label.Text = "Delete (" .. #v40 .. ")";
end;
local function v93(v88, v89, v90) --[[ Line: 383 ]] --[[ Name: deletingFunction ]]
    -- upvalues: v40 (ref), v24 (ref)
    if v88.Main:FindFirstChild("Deleting") then
        if v90 == true then
            return true;
        else
            v88.Main.Deleting:Destroy();
            local v91 = table.find(v40, v89);
            if v91 then
                table.remove(v40, v91);
                v24.MultiDelete.Title.Text = "Deleting " .. #v40 .. " Pets";
                v24.MultiDelete.Buttons.Delete.Main.Label.Text = "Delete (" .. #v40 .. ")";
            end;
            return false;
        end;
    elseif not v88.Main:FindFirstChild("Deleting") then
        if v90 == false or table.find(v40, v89) then
            return false;
        else
            local v92 = v88.Main.Multi:Clone();
            v92.Size = UDim2.fromScale(0.7, 0.7);
            v92.Position = UDim2.fromScale(0.5, 0.5);
            v92.AnchorPoint = Vector2.new(0.5, 0.5);
            v92.Text = "X";
            v92.TextXAlignment = Enum.TextXAlignment.Center;
            v92.TextColor3 = Color3.fromRGB(255, 20, 20);
            v92.UIStroke.Color = Color3.fromRGB(135, 0, 0);
            v92.Name = "Deleting";
            v92.Parent = v88.Main;
            if not table.find(v40, v89) then
                table.insert(v40, v89);
                v24.MultiDelete.Title.Text = "Deleting " .. #v40 .. " Pets";
                v24.MultiDelete.Buttons.Delete.Main.Label.Text = "Delete (" .. #v40 .. ")";
            end;
            return true;
        end;
    else
        return false;
    end;
end;
v41.AddPet = function(_, v95, v96) --[[ Line: 432 ]] --[[ Name: AddPet ]]
    -- upvalues: v14 (copy), v37 (copy), v12 (copy), v39 (copy), v11 (copy), v38 (copy), v7 (copy), v21 (ref), v93 (copy), v31 (ref), l_RunService_0 (copy), l_LocalPlayer_0 (copy), l_Mouse_0 (copy), v25 (ref)
    if v14.Loaded then
        v14.Data.Discovered[v95] = true;
    end;
    v14.Data.Discovered[v37[v95].Name .. "_" .. v37[v95].Tier] = true;
    local l_v12_Frame_0 = v12:CreateFrame(v37[v95], "Inventory", v96);
    v39[v95] = l_v12_Frame_0;
    v12.InventoryFrames[v95] = l_v12_Frame_0;
    if v11:GetPercentage(v37[v95].Name) then
        v38[v95] = true;
    end;
    if v11:GetPercentage(v37[v95].Name) and v11:GetPercentage(v37[v95].Name) >= 100 or v11:GetBigFrame(v37[v95].Name) then
        l_v12_Frame_0.LayoutOrder = 0 - v7:Compress(v37[v95].Multi1);
    else
        l_v12_Frame_0.LayoutOrder = v7.layoutLimit - v7:Compress(v37[v95].Multi1);
    end;
    l_v12_Frame_0:SetAttribute("Id", v37[v95].Id);
    l_v12_Frame_0.Main.Button.Activated:Connect(function() --[[ Line: 462 ]]
        -- upvalues: v95 (copy)
        if not _G.PetsDeleting == true then
            selectPet(v95);
        end;
    end);
    l_v12_Frame_0.Main.Button.MouseEnter:Connect(function() --[[ Line: 468 ]]
        -- upvalues: v21 (ref), v95 (copy), l_v12_Frame_0 (copy)
        if table.find(v21, v95) then
            l_v12_Frame_0.Main.NewLabel:Destroy();
            table.remove(v21, table.find(v21, v95));
        end;
    end);
    l_v12_Frame_0.Main.Button.MouseButton1Down:Connect(function() --[[ Line: 475 ]]
        -- upvalues: v93 (ref), l_v12_Frame_0 (copy), v95 (copy), v31 (ref), l_RunService_0 (ref), l_LocalPlayer_0 (ref), l_Mouse_0 (ref)
        if _G.PetsDeleting == true then
            local v98 = v93(l_v12_Frame_0, v95);
            if not v31 then
                local l_l_v12_Frame_0_0 = l_v12_Frame_0;
                do
                    local l_l_l_v12_Frame_0_0_0 = l_l_v12_Frame_0_0;
                    v31 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 481 ]]
                        -- upvalues: v31 (ref), l_LocalPlayer_0 (ref), l_Mouse_0 (ref), l_l_l_v12_Frame_0_0_0 (ref), v93 (ref), v98 (copy)
                        if _G.PetsDeleting == false then
                            v31:Disconnect();
                            v31 = nil;
                        end;
                        local l_GuiObjectsAtPosition_0 = l_LocalPlayer_0.PlayerGui:GetGuiObjectsAtPosition(l_Mouse_0.X, l_Mouse_0.Y);
                        for _, v103 in ipairs(l_GuiObjectsAtPosition_0) do
                            if v103.Name == "Main" and v103.Parent:GetAttribute("Id") and v103.Parent ~= l_l_l_v12_Frame_0_0_0 then
                                v93(v103.Parent, v103.Parent:GetAttribute("Id"), v98);
                                l_l_l_v12_Frame_0_0_0 = v103.Parent;
                                return;
                            end;
                        end;
                    end);
                end;
            end;
        end;
    end);
    if not v25:FindFirstChild(v95) then
        l_v12_Frame_0.Parent = v37[v95].Equipped and v25.Parent.Equipped.List or v25;
        return;
    else
        l_v12_Frame_0:Destroy();
        return;
    end;
end;
v41.RemovePet = function(_, v105) --[[ Line: 507 ]] --[[ Name: RemovePet ]]
    -- upvalues: v39 (copy), v12 (copy), v37 (copy), v38 (copy), v30 (ref), v23 (ref)
    if not v39[v105] then
        return;
    else
        v39[v105]:Destroy();
        v39[v105] = nil;
        v12.InventoryFrames[v105] = nil;
        v37[v105] = nil;
        v38[v105] = nil;
        if v30 == v105 then
            v30 = nil;
        end;
        if v23.Parent.Enabled then
            UpdateInvStats();
            closeInfo();
        end;
        return;
    end;
end;
v41.SetSort = function(_, v107) --[[ Line: 526 ]] --[[ Name: SetSort ]]
    -- upvalues: v34 (ref), v39 (copy), v37 (copy), v35 (copy), v11 (copy), v7 (copy)
    v34 = v107;
    for _, v109 in pairs(v39) do
        local v110 = v37[v109:GetAttribute("Id")];
        if v110 then
            local v111 = 0;
            v111 = if v35[v107][2] == "Exists" then v11:GetPetCount(v110.Name, v110.Tier) or 0 else v7:Compress(v110[v35[v107][2]] or 0);
            local l_v11_Percentage_1 = v11:GetPercentage(v110.Name);
            if l_v11_Percentage_1 and l_v11_Percentage_1 >= 100 or v11:GetBigFrame(v110.Name) then
                v111 = v7.layoutLimit - v111;
            end;
            v109.LayoutOrder = v7.layoutLimit - v111;
        end;
    end;
end;
closeInfo = function() --[[ Line: 554 ]] --[[ Name: closeInfo ]]
    -- upvalues: l_InfoUI_0 (copy), v13 (copy)
    if l_InfoUI_0:FindFirstChild("CanvasGroup") and l_InfoUI_0.CanvasGroup.Visible then
        v13:Close();
    end;
end;
v41.Init = function(v113, v114, v115) --[[ Line: 561 ]] --[[ Name: Init ]]
    -- upvalues: v22 (ref), v24 (ref), v25 (ref), v27 (ref), v23 (ref), v29 (ref), v21 (ref), v39 (copy), v5 (copy), v37 (copy), v6 (copy), v14 (copy), v30 (ref), v12 (copy), v11 (copy), v10 (copy), v13 (copy), v34 (ref), v35 (copy), v41 (copy), v32 (ref), v40 (ref), l_UserInputService_0 (copy), v31 (ref), v9 (copy), v38 (copy), l_LocalPlayer_0 (copy), l_RunService_0 (copy), l_Players_0 (copy), l_Mouse_0 (copy)
    v22 = v114;
    v24 = v115.Categories.Pets;
    v25 = v24.Inner.List.Container;
    v27 = v24.Inner.List;
    v23 = v115;
    v29 = v24.Info;
    v25.Parent:GetPropertyChangedSignal("CanvasPosition"):Connect(function() --[[ Line: 570 ]]
        closeInfo();
    end);
    v23.Parent:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 575 ]]
        -- upvalues: v23 (ref), v21 (ref), v39 (ref)
        if not v23.Parent.Enabled then
            for _, v117 in ipairs(v21) do
                if v39[v117] and v39[v117].Main:FindFirstChild("NewLabel") then
                    v39[v117].Main.NewLabel:Destroy();
                end;
            end;
            v21 = {};
        end;
    end);
    v5:BindEvents({
        AddPet = function(v118) --[[ Line: 587 ]] --[[ Name: AddPet ]]
            -- upvalues: v37 (ref), v113 (copy), v21 (ref), v6 (ref), v14 (ref)
            if v37[v118.Id] then
                return;
            else
                v37[v118.Id] = v118;
                v113:AddPet(v118.Id, true);
                table.insert(v21, v118.Id);
                if not v6:GetSignal("AddNotifications") then
                    repeat
                        task.wait();
                    until v6:GetSignal("AddNotifications");
                end;
                v6.Fire("AddNotifications", 1, "Pets");
                if v14.Data then
                    v14.Data.Pets[v118.Id] = v118;
                end;
                UpdateInvStats();
                return;
            end;
        end, 
        RemovePet = function(v119) --[[ Line: 608 ]] --[[ Name: RemovePet ]]
            -- upvalues: v37 (ref), v113 (copy), v14 (ref)
            if typeof(v119) == "string" then
                v37[v119] = nil;
                v113:RemovePet(v119);
                if v14.Data then
                    v14.Data.Pets[v119] = nil;
                end;
            else
                for v120 = 1, #v119 do
                    local v121 = v119[v120];
                    v37[v121] = nil;
                    v113:RemovePet(v121);
                    if v14.Data then
                        v14.Data.Pets[v121] = nil;
                    end;
                end;
            end;
            UpdateInvStats();
        end, 
        UpdatePetData = function(v122, v123) --[[ Line: 631 ]] --[[ Name: UpdatePetData ]]
            -- upvalues: v37 (ref), v39 (ref), v25 (ref), v14 (ref), v30 (ref)
            if v37[v122] then
                if v37[v122].Equipped and not v123.Equipped then
                    v39[v122].Parent = v25;
                elseif not v37[v122].Equipped and v123.Equipped then
                    v39[v122].Parent = v25.Parent.Equipped.List;
                end;
            end;
            v37[v122] = v123;
            if v14.Data then
                v14.Data.Pets[v122] = v123;
            end;
            if v30 == v122 then
                selectPet(v122);
            end;
        end, 
        UpdatePetLevel = function(v124, v125, v126) --[[ Line: 651 ]] --[[ Name: UpdatePetLevel ]]
            -- upvalues: v37 (ref), v39 (ref), v12 (ref), v30 (ref), v11 (ref), v10 (ref), v14 (ref), v13 (ref)
            if not v37[v124] then
                return;
            else
                if v37[v124].Level ~= v125 and v39[v124] then
                    v37[v124].Level = v125;
                    v37[v124].XP = v126;
                    v12:UpdateLevel(v39[v124].Main, v37[v124]);
                end;
                if v124 == v30 then
                    selectPet(v124);
                end;
                v37[v124].Level = v125;
                v37[v124].XP = v126;
                local l_v11_Percentage_2 = v11:GetPercentage(v37[v124].Name);
                if l_v11_Percentage_2 then
                    v37[v124].Multiplier1 = v11:GetMulti(v10.Data.BestMultiplier[1] * l_v11_Percentage_2 / 100, v37[v124].Tier, v37[v124].Level, v37[v124]);
                    v37[v124].Multiplier2 = v11:GetMulti(v10.Data.BestMultiplier[2] * l_v11_Percentage_2 / 100, v37[v124].Tier, v37[v124].Level, v37[v124]);
                else
                    v37[v124].Multiplier1 = v11:GetMulti(v37[v124].Multi1, v37[v124].Tier, v37[v124].Level, v37[v124]);
                    v37[v124].Multiplier2 = v11:GetMulti(v37[v124].Multi2, v37[v124].Tier, v37[v124].Level, v37[v124]);
                end;
                if v14.Data then
                    v14.Data.Pets[v124].Level = v125;
                    v14.Data.Pets[v124].XP = v126;
                end;
                if v13.displayedId == v124 then
                    v13:UpdateLevel(v37[v124].Name, v125, v126);
                end;
                return;
            end;
        end
    });
    v14:Connect("StorageLimit", function() --[[ Line: 689 ]]
        UpdateInvStats();
    end);
    v6.new("UpdatePetData"):Connect(function(v128) --[[ Line: 693 ]]
        -- upvalues: v37 (ref)
        if v37[v128.Id] then
            v37[v128.Id] = v128;
        end;
    end);
    v24.Bottom2.Search.TextBox.Changed:Connect(function() --[[ Line: 700 ]]
        -- upvalues: v24 (ref), v39 (ref), v37 (ref)
        local l_Text_0 = v24.Bottom2.Search.TextBox.Text;
        if l_Text_0 == "" then
            for _, v131 in pairs(v39) do
                v131.Visible = true;
            end;
            return;
        else
            for v132, v133 in pairs(v37) do
                if string.find(string.lower(v133.Name), string.lower(l_Text_0)) or v133.Tier ~= "Normal" and string.find(string.lower(v133.Tier), string.lower(l_Text_0)) then
                    v39[v132].Visible = true;
                else
                    v39[v132].Visible = false;
                end;
            end;
            return;
        end;
    end);
    v24.Bottom2.Sort.Button.Activated:Connect(function() --[[ Line: 717 ]]
        -- upvalues: v34 (ref), v35 (ref), v24 (ref), v113 (copy)
        v34 = v34 + 1;
        if v34 > #v35 then
            v34 = 1;
        end;
        v24.Bottom2.Sort.Main.Title.Text = v35[v34][1];
        v113:SetSort(v34);
    end);
    local v134 = false;
    v29.Actions.Equip.Button.Activated:Connect(function() --[[ Line: 729 ]]
        -- upvalues: v134 (ref), v5 (ref), v30 (ref), v39 (ref), v25 (ref), v37 (ref), v12 (ref), v29 (ref)
        if v134 then
            return;
        else
            v134 = true;
            local v135 = v5:InvokeServer("Equip", v30);
            v134 = false;
            if v135 then
                v39[v30].Parent = v25.Parent.Equipped.List;
                v37[v30].Equipped = true;
                v12:UpdateEquip(v39[v30].Main, v37[v30], true);
                v29.Actions.Equip.Visible = false;
                v29.Actions.Unequip.Visible = true;
            end;
            UpdateInvStats();
            return;
        end;
    end);
    v29.Actions.Unequip.Button.Activated:Connect(function() --[[ Line: 748 ]]
        -- upvalues: v134 (ref), v5 (ref), v30 (ref), v39 (ref), v25 (ref), v37 (ref), v12 (ref), v29 (ref)
        if v134 then
            return;
        else
            v134 = true;
            local v136 = v5:InvokeServer("Unequip", v30);
            v134 = false;
            if v136 then
                v39[v30].Parent = v25;
                v37[v30].Equipped = false;
                v12:UpdateEquip(v39[v30].Main, v37[v30], false);
                v29.Actions.Equip.Visible = true;
                v29.Actions.Unequip.Visible = false;
            end;
            UpdateInvStats();
            return;
        end;
    end);
    v29.Actions.Delete.Button.Activated:Connect(function() --[[ Line: 767 ]]
        -- upvalues: v29 (ref), v134 (ref), v30 (ref), v5 (ref), v41 (ref)
        if v29.Actions.Delete.Main.Title.Text == "Confirm" then
            if v134 then
                return;
            else
                v134 = true;
                local l_v30_0 = v30;
                selectPet(nil);
                local v138 = v5:InvokeServer("DeletePet", l_v30_0);
                v134 = false;
                if v138 then
                    v41:RemovePet(l_v30_0);
                    return;
                end;
            end;
        else
            v29.Actions.Delete.Main.Title.Text = "Confirm";
        end;
    end);
    v29.SetNickname.Activated:Connect(function() --[[ Line: 786 ]]
        -- upvalues: v6 (ref), v30 (ref), v13 (ref)
        v6.Fire("OpenNicknameSelection", v30);
        v13:Close();
    end);
    selectPet(nil);
    v6.Fire("InitButton", v29.Actions.Equip.Button);
    v6.Fire("InitButton", v29.Actions.Unequip.Button);
    v6.Fire("InitButton", v29.Actions.Delete.Button);
    local function v144() --[[ Line: 799 ]] --[[ Name: equipBest ]]
        -- upvalues: v5 (ref), v37 (ref), v39 (ref), v12 (ref), v25 (ref), v21 (ref), v30 (ref)
        _G:Play("Click");
        local v139 = v5:InvokeServer("EquipBest");
        for v140, v141 in pairs(v37) do
            if v141.Equipped and not table.find(v139, v140) then
                v141.Equipped = false;
                if v39[v140] and v39[v140].Main then
                    v12:UpdateEquip(v39[v140].Main, v141, false);
                    v39[v140].Parent = v25;
                end;
            end;
        end;
        for _, v143 in pairs(v139) do
            if v37[v143] and v39[v143] then
                v37[v143].Equipped = true;
                v39[v143].Parent = v25.Parent.Equipped.List;
                v12:UpdateEquip(v39[v143].Main, v37[v143], true);
            end;
            if table.find(v21, v143) and v39[v143] then
                v39[v143].Main.NewLabel:Destroy();
                table.remove(v21, table.find(v21, v143));
            end;
        end;
        selectPet(v30);
        UpdateInvStats();
        closeInfo();
    end;
    v6.new("EquipBest"):Connect(function() --[[ Line: 837 ]]
        -- upvalues: v144 (copy)
        v144();
    end);
    v24.Bottom1.Actions.Best.Button.Activated:Connect(function() --[[ Line: 841 ]]
        -- upvalues: v144 (copy)
        v144();
    end);
    v24.Bottom1.Actions.None.Button.Activated:Connect(function() --[[ Line: 845 ]]
        -- upvalues: v5 (ref), v25 (ref), v37 (ref), v39 (ref), v12 (ref), v30 (ref)
        if v5:InvokeServer("UnequipAll") then
            for _, v146 in pairs(v25.Parent.Equipped.List:GetChildren()) do
                if v146:IsA("Frame") then
                    v146.Parent = v25;
                end;
            end;
            for v147, v148 in pairs(v37) do
                if v148.Equipped then
                    v148.Equipped = false;
                    if v39[v147] and v39[v147].Main then
                        v12:UpdateEquip(v39[v147].Main, v148, false);
                    end;
                end;
            end;
            selectPet(v30);
            UpdateInvStats();
            closeInfo();
        end;
    end);
    v24.Bottom1.Actions.Minimize.Activated:Connect(function() --[[ Line: 872 ]]
        -- upvalues: v24 (ref), v32 (ref)
        v24.Bottom1.Actions.Minimize.Visible = false;
        v24.Bottom1.Actions.Upscale.Visible = true;
        v32:SetWidth(8);
    end);
    v24.Bottom1.Actions.Upscale.Activated:Connect(function() --[[ Line: 879 ]]
        -- upvalues: v24 (ref), v32 (ref)
        v24.Bottom1.Actions.Minimize.Visible = true;
        v24.Bottom1.Actions.Upscale.Visible = false;
        v32:ResetWidth();
    end);
    local function v151() --[[ Line: 888 ]] --[[ Name: disableMultiDelete ]]
        -- upvalues: v40 (ref), v39 (ref), v24 (ref)
        for _, v150 in pairs(v40) do
            if v39[v150] and v39[v150].Main:FindFirstChild("Deleting") then
                v39[v150].Main.Deleting:Destroy();
            end;
        end;
        _G.PetsDeleting = false;
        v24.MultiDelete.Title.Text = "Deleting " .. #v40 .. " Pets";
        v24.MultiDelete.Buttons.Delete.Main.Label.Text = "Delete (" .. #v40 .. ")";
    end;
    v24.Bottom1.Actions.Delete.Activated:Connect(function() --[[ Line: 899 ]]
        -- upvalues: v24 (ref), v40 (ref), v151 (copy)
        if v24.Bottom1.Actions.Delete.ImageColor3 == Color3.fromRGB(255, 255, 255) then
            _G.PetsDeleting = true;
            v24.Bottom1.Actions.Delete.ImageColor3 = Color3.fromRGB(255, 41, 41);
            v24.MultiDelete.Visible = true;
            v24.MultiDelete.Title.Text = "Deleting " .. #v40 .. " Pets";
            v24.MultiDelete.Buttons.Delete.Main.Label.Text = "Delete (" .. #v40 .. ")";
            return;
        else
            _G.PetsDeleting = false;
            v24.Bottom1.Actions.Delete.ImageColor3 = Color3.fromRGB(255, 255, 255);
            v24.MultiDelete.Visible = false;
            v151();
            v40 = {};
            v24.MultiDelete.Title.Text = "Deleting " .. #v40 .. " Pets";
            v24.MultiDelete.Buttons.Delete.Main.Label.Text = "Delete (" .. #v40 .. ")";
            return;
        end;
    end);
    v24.MultiDelete.Buttons.Cancel.Button.Activated:Connect(function() --[[ Line: 917 ]]
        -- upvalues: v151 (copy), v40 (ref), v24 (ref)
        v151();
        v40 = {};
        v24.MultiDelete.Visible = false;
        v24.Bottom1.Actions.Delete.ImageColor3 = Color3.fromRGB(255, 255, 255);
    end);
    v24.MultiDelete.Buttons.Delete.Button.Activated:Connect(function() --[[ Line: 925 ]]
        -- upvalues: v151 (copy), v24 (ref), v40 (ref), v6 (ref), v39 (ref), v5 (ref), v41 (ref)
        v151();
        v24.MultiDelete.Visible = false;
        v24.Bottom1.Actions.Delete.ImageColor3 = Color3.fromRGB(255, 255, 255);
        if #v40 > 0 then
            v6.Fire("OpenMessage", "Multi Delete", "Are you sure you want to delete (" .. #v40 .. ") Pets?", {
                {
                    nil, 
                    function() --[[ Line: 932 ]]
                        -- upvalues: v40 (ref), v39 (ref), v5 (ref), v41 (ref), v6 (ref)
                        local v152 = #v40;
                        for _, v154 in ipairs(v40) do
                            v39[v154].Visible = false;
                            task.defer(function() --[[ Line: 937 ]]
                                -- upvalues: v5 (ref), v154 (copy), v39 (ref), v41 (ref)
                                if v5:InvokeServer("DeletePet", v154) then
                                    if v39[v154] then
                                        v41:RemovePet(v154);
                                        return;
                                    end;
                                else
                                    v39[v154].Visible = true;
                                end;
                            end);
                        end;
                        v40 = {};
                        v6.Fire("OpenMenu", "Inventory");
                        v6.Fire("Notification", "Deleted " .. v152 .. " Pets", Color3.fromRGB(255, 23, 23));
                    end
                }
            });
            return;
        else
            v40 = {};
            v6.Fire("Notification", "No Pets Selected", Color3.fromRGB(255, 23, 23));
            return;
        end;
    end);
    v6.Fire("InitButton", v24.MultiDelete.Buttons.Cancel.Button);
    v6.Fire("InitButton", v24.MultiDelete.Buttons.Delete.Button);
    l_UserInputService_0.InputEnded:Connect(function(v155, _) --[[ Line: 964 ]]
        -- upvalues: v31 (ref)
        if v155.UserInputType == Enum.UserInputType.MouseButton1 and v31 then
            v31:Disconnect();
            v31 = nil;
        end;
    end);
    v24.Top.MoreEquip.Button.Activated:Connect(function() --[[ Line: 972 ]]
        promptEquips();
    end);
    v24.Top.MoreStorage.Button.Activated:Connect(function() --[[ Line: 976 ]]
        promptStorage();
    end);
    v6.Fire("InitButton", v24.Top.MoreEquip.Button);
    v6.Fire("InitButton", v24.Top.MoreStorage.Button);
    v6.Fire("InitButton", v24.Bottom2.Sort.Button);
    v6.new("EquipPetUI"):Connect(function(v157) --[[ Line: 985 ]]
        -- upvalues: v37 (ref), v39 (ref), v12 (ref), v25 (ref)
        if not v37[v157] then
            warn("EquipPetUI: Pet not in inventory:", v157);
            return;
        else
            v37[v157].Equipped = true;
            if not v39[v157] then
                task.spawn(function() --[[ Line: 995 ]]
                    -- upvalues: v39 (ref), v157 (copy), v12 (ref), v37 (ref), v25 (ref)
                    local v158 = 0;
                    while not v39[v157] and v158 < 100 do
                        task.wait(0.05);
                        v158 = v158 + 1;
                    end;
                    if v39[v157] and v39[v157].Main then
                        v12:UpdateEquip(v39[v157].Main, v37[v157], true);
                        v39[v157].Parent = v25.Parent.Equipped.List;
                        UpdateInvStats();
                    end;
                end);
                return;
            else
                if v39[v157].Main then
                    v12:UpdateEquip(v39[v157].Main, v37[v157], true);
                    v39[v157].Parent = v25.Parent.Equipped.List;
                end;
                UpdateInvStats();
                return;
            end;
        end;
    end);
    v6.new("UnequipPetUI"):Connect(function(v159) --[[ Line: 1017 ]]
        -- upvalues: v37 (ref), v39 (ref), v12 (ref), v25 (ref)
        if not v37[v159] then
            warn("UnequipPetUI: Pet not in inventory:", v159);
            return;
        else
            v37[v159].Equipped = false;
            if not v39[v159] then
                task.spawn(function() --[[ Line: 1027 ]]
                    -- upvalues: v39 (ref), v159 (copy), v12 (ref), v37 (ref), v25 (ref)
                    local v160 = 0;
                    while not v39[v159] and v160 < 100 do
                        task.wait(0.05);
                        v160 = v160 + 1;
                    end;
                    if v39[v159] and v39[v159].Main then
                        v12:UpdateEquip(v39[v159].Main, v37[v159], false);
                        v39[v159].Parent = v25;
                        UpdateInvStats();
                    end;
                end);
                return;
            else
                if v39[v159].Main then
                    v12:UpdateEquip(v39[v159].Main, v37[v159], false);
                    v39[v159].Parent = v25;
                end;
                UpdateInvStats();
                return;
            end;
        end;
    end);
    task.defer(function() --[[ Line: 1050 ]]
        -- upvalues: v14 (ref), v37 (ref), v11 (ref), v113 (copy), v12 (ref)
        repeat
            task.wait();
        until v14.Loaded;
        local l_Pets_0 = v14.Data.Pets;
        local v162 = 0;
        for v163, v164 in pairs(l_Pets_0) do
            if not v37[v163] then
                if v11.Pets[v164.Name] then
                    if v11.Pets[v164.Name].Huge then
                        v164.Huge = true;
                    end;
                    v37[v163] = v164;
                    v113:AddPet(v163);
                end;
                if v162 % 100 == 0 then
                    task.wait();
                    v12:UpdateCounts();
                end;
                v162 = v162 + 1;
            end;
        end;
        UpdateInvStats();
        v12:UpdateCounts();
        v12:PauseEffects();
    end);
    v32 = v9.new(v25);
    local v165 = {
        0, 
        0
    };
    v10:Connect("BestMultiplier", function(_) --[[ Line: 1084 ]]
        -- upvalues: v165 (ref), v10 (ref), v38 (ref), v37 (ref), v39 (ref), v11 (ref), v12 (ref)
        if math.round(v165[1]) ~= math.round(v10.Data.BestMultiplier[1]) then
            v165 = v10.Data.BestMultiplier;
            for v167, _ in pairs(v38) do
                local v169 = v37[v167];
                if v169 and v39[v167] then
                    local l_v11_Percentage_3 = v11:GetPercentage(v169.Name);
                    if l_v11_Percentage_3 then
                        v169.Multiplier1 = v11:GetMulti(v10.Data.BestMultiplier[1] * l_v11_Percentage_3 / 100, v169.Tier, v169.Level, v169);
                        v169.Multiplier2 = v11:GetMulti(v10.Data.BestMultiplier[2] * l_v11_Percentage_3 / 100, v169.Tier, v169.Level, v169);
                        v12:UpdateLevel(v39[v167].Main, v37[v167], true);
                    end;
                end;
            end;
        end;
    end);
    local l_Parent_0 = v115.Parent;
    local v172 = tick();
    l_Parent_0:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 1105 ]]
        -- upvalues: l_Parent_0 (copy), v30 (ref), v24 (ref), v12 (ref), v172 (ref)
        if l_Parent_0.Enabled then
            selectPet(v30);
            UpdateInvStats();
            v24.Bottom2.Search.TextBox.Text = "";
            v12:ResumeEffects();
        else
            closeInfo();
            v12:PauseEffects();
        end;
        if l_Parent_0.Enabled and tick() - v172 > 5 then
            v172 = tick();
            v12:UpdateCounts();
        end;
    end);
    l_Parent_0.Menu.Categories.Pets:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 1125 ]]
        -- upvalues: l_Parent_0 (copy), v12 (ref)
        closeInfo();
        if l_Parent_0.Menu.Categories.Pets.Visible then
            v12:ResumeEffects();
            return;
        else
            v12:PauseEffects();
            return;
        end;
    end);
    v13:Start();
    task.defer(function() --[[ Line: 1138 ]]
        -- upvalues: l_LocalPlayer_0 (ref), v13 (ref), v37 (ref)
        local l_ControllerInput_0 = l_LocalPlayer_0:WaitForChild("PlayerScripts"):WaitForChild("Modules"):WaitForChild("Controllers"):FindFirstChild("ControllerInput");
        if l_ControllerInput_0 then
            local v174 = require(l_ControllerInput_0);
            if v174.SetPetReferences then
                v174:SetPetReferences(v13, v37);
            end;
        end;
    end);
    local v175 = nil;
    l_RunService_0.Heartbeat:Connect(function() --[[ Line: 1150 ]]
        -- upvalues: l_Parent_0 (copy), l_Players_0 (ref), l_LocalPlayer_0 (ref), l_Mouse_0 (ref), v39 (ref), v175 (ref), v13 (ref), v37 (ref)
        if not l_Parent_0.Enabled or not l_Parent_0.Menu.Categories.Pets.Visible then
            return;
        elseif l_Players_0.LocalPlayer.PlayerGui:FindFirstChild("PetSetNickname") and l_Players_0.LocalPlayer.PlayerGui:FindFirstChild("PetSetNickname").Enabled then
            return;
        else
            local l_GuiObjectsAtPosition_1 = l_LocalPlayer_0.PlayerGui:GetGuiObjectsAtPosition(l_Mouse_0.X, l_Mouse_0.Y);
            local v177 = nil;
            for _, v179 in ipairs(l_GuiObjectsAtPosition_1) do
                if v179.Parent.Name ~= "ParticleFrame" then
                    for v180, v181 in pairs(v39) do
                        if v181 and (v179 == v181 or v179:IsDescendantOf(v181)) then
                            v177 = v180;
                            break;
                        end;
                    end;
                    if v177 then
                        break;
                    end;
                end;
            end;
            if v177 ~= v175 then
                if v177 then
                    v13:Prompt(v37[v177]);
                else
                    v13:Close();
                end;
                v175 = v177;
            end;
            return;
        end;
    end);
    selectPet(nil);
end;
return v41;