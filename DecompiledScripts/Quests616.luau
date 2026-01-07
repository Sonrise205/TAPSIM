local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local v3 = require(l_ReplicatedStorage_0.Game.Replication);
local v4 = require(l_ReplicatedStorage_0.Game.Quests);
local v5 = require(l_ReplicatedStorage_0.Modules.Network);
local v6 = require(l_ReplicatedStorage_0.Modules.Signal);
local v7 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v8 = require(l_ReplicatedStorage_0.Modules.Short);
local _ = require(l_ReplicatedStorage_0.Modules.Flash);
local v10 = require(l_ReplicatedStorage_0.Modules.ItemData);
local v11 = require(l_ReplicatedStorage_0.Game.PetStats.Rarities);
local _ = require(l_ReplicatedStorage_0.Game.Portals);
local l_Quests_0 = l_Players_0.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("RightHud").Main.RightUI.Quests;
local l_List_0 = l_Quests_0:WaitForChild("List");
local v15 = l_List_0:FindFirstChildWhichIsA("UIListLayout") or l_List_0:FindFirstChildWhichIsA("UIGridLayout");
local v16 = nil;
local v17 = nil;
local v18 = nil;
local l_UI_0 = l_ReplicatedStorage_0.Content.UI;
local v20 = {};
local v21 = {};
local v22 = 0;
local v23 = {
    Header = "#FFD369", 
    Description = "#D9ECFF", 
    Progress = "#B9FFF6", 
    Section = "#FFFFFF", 
    Empty = "#A1B0C3", 
    RewardDefault = "#F1F5F9"
};
local v24 = {
    Clicks = "#7EE8FF", 
    Gems = "#7CFFB6", 
    Rebirths = "#FFE066", 
    Tokens = "#F5B8FF", 
    Item = "#F6A3FF", 
    Items = "#F6A3FF", 
    Currency = "#E5ECFF", 
    Boost = "#FFB8F2", 
    Default = "#F1F5F9"
};
local v25 = {
    Desert = {
        Primary = Color3.fromRGB(255, 190, 60), 
        Secondary = Color3.fromRGB(255, 130, 40), 
        Rotation = 90
    }, 
    Jungle = {
        Primary = Color3.fromRGB(80, 255, 130), 
        Secondary = Color3.fromRGB(30, 200, 100), 
        Rotation = 90
    }, 
    Heaven = {
        Primary = Color3.fromRGB(255, 255, 255), 
        Secondary = Color3.fromRGB(200, 230, 255), 
        Rotation = 90
    }, 
    Dojo = {
        Primary = Color3.fromRGB(255, 100, 200), 
        Secondary = Color3.fromRGB(200, 50, 180), 
        Rotation = 90
    }, 
    Volcano = {
        Primary = Color3.fromRGB(255, 160, 40), 
        Secondary = Color3.fromRGB(255, 60, 20), 
        Rotation = 90
    }, 
    Candy = {
        Primary = Color3.fromRGB(255, 100, 200), 
        Secondary = Color3.fromRGB(255, 0, 115), 
        Rotation = 90
    }, 
    Atlantis = {
        Primary = Color3.fromRGB(0, 255, 102), 
        Secondary = Color3.fromRGB(0, 34, 255), 
        Rotation = 90
    }, 
    Space = {
        Primary = Color3.fromRGB(38, 0, 255), 
        Secondary = Color3.fromRGB(183, 0, 255), 
        Rotation = 90
    }
};
local function v36(v26, v27, v28) --[[ Line: 99 ]] --[[ Name: applyIslandGradient ]]
    -- upvalues: v25 (copy)
    local v29 = v25[v28];
    if not v29 then
        return;
    else
        local l_UIGradient_0 = v26:FindFirstChildOfClass("UIGradient");
        if l_UIGradient_0 then
            l_UIGradient_0:Destroy();
        end;
        local l_UIGradient_1 = Instance.new("UIGradient");
        l_UIGradient_1.Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, v29.Primary), 
            ColorSequenceKeypoint.new(1, v29.Secondary)
        });
        l_UIGradient_1.Rotation = v29.Rotation;
        l_UIGradient_1.Parent = v26;
        if v27 then
            local l_UIGradient_2 = v27:FindFirstChildOfClass("UIGradient");
            if l_UIGradient_2 then
                l_UIGradient_2:Destroy();
            end;
            local v33 = Color3.new(v29.Primary.R * 0.3, v29.Primary.G * 0.3, v29.Primary.B * 0.3);
            local v34 = Color3.new(v29.Secondary.R * 0.3, v29.Secondary.G * 0.3, v29.Secondary.B * 0.3);
            local l_UIGradient_3 = Instance.new("UIGradient");
            l_UIGradient_3.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, v33), 
                ColorSequenceKeypoint.new(1, v34)
            });
            l_UIGradient_3.Rotation = v29.Rotation;
            l_UIGradient_3.Parent = v27;
        end;
        return;
    end;
end;
local v37 = {};
local function v42(v38) --[[ Line: 150 ]] --[[ Name: color3ToHex ]]
    if not v38 then
        return nil;
    else
        local v39 = math.clamp(math.floor(v38.R * 255 + 0.5), 0, 255);
        local v40 = math.clamp(math.floor(v38.G * 255 + 0.5), 0, 255);
        local v41 = math.clamp(math.floor(v38.B * 255 + 0.5), 0, 255);
        return string.format("#%02X%02X%02X", v39, v40, v41);
    end;
end;
local function _(v43) --[[ Line: 162 ]] --[[ Name: getRarityHex ]]
    -- upvalues: v37 (copy), v11 (copy), v42 (copy)
    if not v43 then
        return nil;
    elseif v37[v43] then
        return v37[v43];
    else
        local v44 = v11[v43];
        if v44 and v44[1] then
            local v45 = v42(v44[1]);
            v37[v43] = v45;
            return v45;
        else
            return nil;
        end;
    end;
end;
local function _(v47) --[[ Line: 181 ]] --[[ Name: formatNumber ]]
    -- upvalues: v8 (copy)
    if typeof(v47) ~= "number" then
        return nil;
    else
        return v8:Abbreviate(v47);
    end;
end;
local function v56(v49, v50, v51) --[[ Line: 189 ]] --[[ Name: getRewardColorFromData ]]
    -- upvalues: v37 (copy), v11 (copy), v42 (copy), v24 (copy)
    local v52 = v51 and (v51.rarity or v51.data and v51.data.Rarity);
    local l_v52_0 = v52;
    if l_v52_0 then
        if not v52 then
            l_v52_0 = nil;
        elseif v37[v52] then
            l_v52_0 = v37[v52];
        else
            local v54 = v11[v52];
            if v54 and v54[1] then
                local v55 = v42(v54[1]);
                v37[v52] = v55;
                l_v52_0 = v55;
            else
                l_v52_0 = nil;
            end;
        end;
    end;
    if l_v52_0 then
        return l_v52_0;
    elseif typeof(v49) == "string" and v24[v49] then
        return v24[v49];
    elseif typeof(v50) == "string" and v24[v50] then
        return v24[v50];
    else
        return v24.Default;
    end;
end;
local function v65(v57, v58) --[[ Line: 207 ]] --[[ Name: buildItemTooltipText ]]
    -- upvalues: v37 (copy), v11 (copy), v42 (copy), v23 (copy), v8 (copy)
    if not v57 then
        return nil;
    else
        local v59 = {};
        local v60 = v57.rarity or v57.data and v57.data.Rarity;
        local v61;
        if not v60 then
            v61 = nil;
        elseif v37[v60] then
            v61 = v37[v60];
        else
            local v62 = v11[v60];
            if v62 and v62[1] then
                local v63 = v42(v62[1]);
                v37[v60] = v63;
                v61 = v63;
            else
                v61 = nil;
            end;
        end;
        if not v61 then
            v61 = v23.Section;
        end;
        table.insert(v59, string.format("<font color=\"%s\"><b>%s</b></font>", v61, v57.name or "Item"));
        if v58 then
            local v64 = (if typeof(v58) ~= "number" then nil else v8:Abbreviate(v58)) or tostring(v58);
            table.insert(v59, string.format("<font color=\"%s\">Quantity: x%s</font>", v23.Description, v64));
        end;
        if v57.description and v57.description ~= "" then
            table.insert(v59, string.format("<font color=\"%s\">%s</font>", v23.Description, v57.description));
        end;
        return table.concat(v59, "\n");
    end;
end;
local function v84(v66) --[[ Line: 230 ]] --[[ Name: buildQuestRewardLines ]]
    -- upvalues: v10 (copy), v8 (copy), v56 (copy)
    local v67 = {};
    if typeof(v66) ~= "table" then
        return v67;
    else
        local v68 = v66[1];
        local v69 = v66[2];
        local v70 = v66[3];
        if v68 == "Items" and typeof(v69) == "table" then
            for v71, v72 in pairs(v69) do
                local l_v72_0 = v72;
                local v74 = "Item";
                if typeof(v72) == "table" then
                    l_v72_0 = v72.Amount or v72.Count or v72.Quantity or v72.Value or v72[1] or l_v72_0;
                    v74 = v72.Type or v72.ItemType or v74;
                end;
                local l_v10_ItemData_0 = v10:GetItemData(v74, v71);
                local v76 = l_v10_ItemData_0 and l_v10_ItemData_0.name or v71;
                local l_l_v72_0_0 = l_v72_0;
                if l_l_v72_0_0 then
                    local l_l_v72_0_1 = l_v72_0;
                    l_l_v72_0_0 = if typeof(l_l_v72_0_1) ~= "number" then nil else v8:Abbreviate(l_l_v72_0_1);
                end;
                local v79 = v56(v71, v74, l_v10_ItemData_0);
                if l_l_v72_0_0 then
                    table.insert(v67, string.format("<font color=\"%s\"><b>x%s</b> %s</font>", v79, l_l_v72_0_0, v76));
                else
                    table.insert(v67, string.format("<font color=\"%s\"><b>%s</b></font>", v79, v76));
                end;
            end;
            return v67;
        else
            local v80 = nil;
            if typeof(v68) == "string" and typeof(v69) == "string" then
                v80 = v10:GetItemData(v69, v68);
            elseif typeof(v68) == "string" then
                v80 = v10:GetItemData("item", v68);
            end;
            local v81 = v80 and v80.name or v68 or "Reward";
            local v82 = v70 and if typeof(v70) ~= "number" then nil else v8:Abbreviate(v70);
            local v83 = v56(v68, v69, v80);
            if v82 then
                table.insert(v67, string.format("<font color=\"%s\"><b>+%s</b> %s</font>", v83, v82, v81));
                return v67;
            else
                table.insert(v67, string.format("<font color=\"%s\"><b>%s</b></font>", v83, v81));
                return v67;
            end;
        end;
    end;
end;
local function v95(v85) --[[ Line: 285 ]] --[[ Name: buildQuestTooltipText ]]
    -- upvalues: v4 (copy), v23 (copy), v3 (copy), v8 (copy), v84 (copy)
    local v86 = v4[v85];
    if not v86 then
        return nil;
    else
        local v87 = {};
        table.insert(v87, string.format("<font color=\"%s\"><b>%s</b></font>", v23.Header, v86.Description or v85));
        local v88 = v3.Data and v3.Data.Quests and v3.Data.Quests[v85];
        if v88 and v86.Goal then
            local v89 = v88.Amount or 0;
            local v90 = (if typeof(v89) ~= "number" then nil else v8:Abbreviate(v89)) or tostring(v88.Amount or 0);
            local l_Goal_0 = v86.Goal;
            v89 = (if typeof(l_Goal_0) ~= "number" then nil else v8:Abbreviate(l_Goal_0)) or tostring(v86.Goal);
            table.insert(v87, string.format("<font color=\"%s\">Progress: %s / %s</font>", v23.Progress, v90, v89));
            l_Goal_0 = nil;
            l_Goal_0 = v88.Claimed and "Claimed" or (v88.Completed or (v88.Amount or 0) >= (v86.Goal or 0)) and "Ready to claim" or "In progress";
            table.insert(v87, string.format("<font color=\"%s\">Status: %s</font>", v23.Description, l_Goal_0));
        end;
        local v92 = v84(v86.Reward);
        table.insert(v87, string.format("<font color=\"%s\"><b>Rewards</b></font>", v23.Section));
        if #v92 == 0 then
            table.insert(v87, string.format("<font color=\"%s\">No listed rewards.</font>", v23.Empty));
        else
            for _, v94 in ipairs(v92) do
                table.insert(v87, v94);
            end;
        end;
        return table.concat(v87, "\n");
    end;
end;
local function _(v96, v97) --[[ Line: 325 ]] --[[ Name: applyQuestTooltip ]]
    -- upvalues: v95 (copy), v6 (copy)
    if not v96 or not v97 then
        return;
    else
        local v98 = v96:FindFirstChild("Hitbox") or v96;
        if not v98 or not v98:IsA("GuiObject") then
            return;
        else
            local v99 = v95(v97);
            if v99 then
                v6.Fire("Tooltip", v98, v99);
            end;
            return;
        end;
    end;
end;
local function _(v101) --[[ Line: 342 ]] --[[ Name: getOrder ]]
    -- upvalues: v4 (copy)
    local v102 = v4[v101];
    if not v102 then
        return 2000;
    else
        local l_Group_0 = v102.Group;
        local l_Goal_1 = v102.Goal;
        if not l_Group_0 or not l_Goal_1 then
            return 2000;
        else
            local l_Orders_0 = v4.Orders;
            if not l_Orders_0 then
                return 2000;
            else
                return (l_Orders_0[l_Group_0] or 2000) + math.min(l_Goal_1, 1000);
            end;
        end;
    end;
end;
local function _() --[[ Line: 363 ]] --[[ Name: getQuestListLayout ]]
    -- upvalues: v15 (ref), l_List_0 (copy)
    if v15 and v15.Parent == l_List_0 then
        return v15;
    else
        v15 = l_List_0:FindFirstChildWhichIsA("UIListLayout") or l_List_0:FindFirstChildWhichIsA("UIGridLayout");
        return v15;
    end;
end;
local function _() --[[ Line: 372 ]] --[[ Name: getQuestListPaddingPixels ]]
    -- upvalues: l_List_0 (copy)
    local l_UIPadding_0 = l_List_0:FindFirstChildWhichIsA("UIPadding");
    if not l_UIPadding_0 then
        return 0;
    else
        local l_Y_0 = l_List_0.AbsoluteSize.Y;
        local l_PaddingTop_0 = l_UIPadding_0.PaddingTop;
        local l_PaddingBottom_0 = l_UIPadding_0.PaddingBottom;
        return (math.max(0, l_PaddingTop_0.Scale * l_Y_0 + l_PaddingTop_0.Offset + (l_PaddingBottom_0.Scale * l_Y_0 + l_PaddingBottom_0.Offset)));
    end;
end;
local function v124(v113) --[[ Line: 387 ]] --[[ Name: updateQuestListCanvas ]]
    -- upvalues: l_List_0 (copy), v15 (ref)
    if not l_List_0 or not l_List_0:IsA("ScrollingFrame") then
        return;
    else
        local v114;
        if v15 and v15.Parent == l_List_0 then
            v114 = v15;
        else
            v15 = l_List_0:FindFirstChildWhichIsA("UIListLayout") or l_List_0:FindFirstChildWhichIsA("UIGridLayout");
            v114 = v15;
        end;
        if not v114 then
            return;
        else
            l_List_0.AutomaticCanvasSize = Enum.AutomaticSize.None;
            local l_UIPadding_1 = l_List_0:FindFirstChildWhichIsA("UIPadding");
            local v116;
            if not l_UIPadding_1 then
                v116 = 0;
            else
                local l_Y_1 = l_List_0.AbsoluteSize.Y;
                local l_PaddingTop_1 = l_UIPadding_1.PaddingTop;
                local l_PaddingBottom_1 = l_UIPadding_1.PaddingBottom;
                v116 = math.max(0, l_PaddingTop_1.Scale * l_Y_1 + l_PaddingTop_1.Offset + (l_PaddingBottom_1.Scale * l_Y_1 + l_PaddingBottom_1.Offset));
            end;
            local v120 = v114.AbsoluteContentSize.Y + v116;
            local l_CanvasPosition_0 = l_List_0.CanvasPosition;
            l_List_0.CanvasSize = UDim2.new(0, 0, 0, v120);
            local v122 = math.max(0, v120 - l_List_0.AbsoluteSize.Y);
            local v123 = math.clamp(l_CanvasPosition_0.Y, 0, v122);
            if v113 == false then
                v123 = 0;
            end;
            if math.abs(l_CanvasPosition_0.Y - v123) > 0.001 or v122 < l_CanvasPosition_0.Y then
                l_List_0.CanvasPosition = Vector2.new(l_CanvasPosition_0.X, v123);
            end;
            return;
        end;
    end;
end;
local function v126() --[[ Line: 418 ]] --[[ Name: bindQuestLayoutListener ]]
    -- upvalues: v15 (ref), l_List_0 (copy), v16 (ref), v124 (copy)
    local v125;
    if v15 and v15.Parent == l_List_0 then
        v125 = v15;
    else
        v15 = l_List_0:FindFirstChildWhichIsA("UIListLayout") or l_List_0:FindFirstChildWhichIsA("UIGridLayout");
        v125 = v15;
    end;
    if not v125 then
        return;
    else
        if v16 then
            v16:Disconnect();
        end;
        v16 = v125:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() --[[ Line: 428 ]]
            -- upvalues: v124 (ref)
            v124();
        end);
        return;
    end;
end;
local function v128() --[[ Line: 433 ]] --[[ Name: bindQuestPaddingListener ]]
    -- upvalues: v17 (ref), v18 (ref), l_List_0 (copy), v124 (copy)
    if v17 then
        v17:Disconnect();
        v17 = nil;
    end;
    if v18 then
        v18:Disconnect();
        v18 = nil;
    end;
    local l_UIPadding_2 = l_List_0:FindFirstChildWhichIsA("UIPadding");
    if not l_UIPadding_2 then
        return;
    else
        v17 = l_UIPadding_2:GetPropertyChangedSignal("PaddingTop"):Connect(function() --[[ Line: 449 ]]
            -- upvalues: v124 (ref)
            v124();
        end);
        v18 = l_UIPadding_2:GetPropertyChangedSignal("PaddingBottom"):Connect(function() --[[ Line: 453 ]]
            -- upvalues: v124 (ref)
            v124();
        end);
        return;
    end;
end;
v126();
v128();
v124(true);
l_List_0.ChildAdded:Connect(function(v129) --[[ Line: 462 ]]
    -- upvalues: v15 (ref), v126 (copy), v124 (copy), v128 (copy)
    if v129:IsA("UIListLayout") or v129:IsA("UIGridLayout") then
        v15 = v129;
        v126();
        v124();
        return;
    else
        if v129:IsA("UIPadding") then
            v128();
            v124();
        end;
        return;
    end;
end);
l_List_0.ChildRemoved:Connect(function(v130) --[[ Line: 473 ]]
    -- upvalues: v15 (ref), v16 (ref), v126 (copy), v124 (copy), v128 (copy)
    if v130 == v15 then
        if v16 then
            v16:Disconnect();
            v16 = nil;
        end;
        v15 = nil;
        v126();
        v124();
        return;
    else
        if v130:IsA("UIPadding") then
            v128();
            v124();
        end;
        return;
    end;
end);
l_List_0:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 488 ]]
    -- upvalues: v124 (copy)
    v124();
end);
v20.SetupQuest = function(_, v132) --[[ Line: 492 ]] --[[ Name: SetupQuest ]]
    -- upvalues: v4 (copy), l_UI_0 (copy), v21 (copy), v25 (copy), v36 (copy), l_List_0 (copy), v124 (copy), v5 (copy), v3 (copy), v22 (ref), v6 (copy), l_ReplicatedStorage_0 (copy), v10 (copy), v65 (copy)
    local v133 = v4[v132];
    if not v133 then
        warn("Quest info not found for:", v132);
        return nil;
    else
        local v134 = l_UI_0.Quest:Clone();
        v21[v132] = v134;
        local v135 = v4[v132];
        local v136;
        if not v135 then
            v136 = 2000;
        else
            local l_Group_1 = v135.Group;
            local l_Goal_2 = v135.Goal;
            if not l_Group_1 or not l_Goal_2 then
                v136 = 2000;
            else
                local l_Orders_1 = v4.Orders;
                v136 = not l_Orders_1 and 2000 or (l_Orders_1[l_Group_1] or 2000) + math.min(l_Goal_2, 1000);
            end;
        end;
        v134.LayoutOrder = v136;
        v134.Top.Title.Text = v133.Description or v132;
        v134.Top.Shadow.Text = v133.Description or v132;
        if v133.Island and v25[v133.Island] then
            v36(v134.Top.Title, v134.Top.Shadow, v133.Island);
        end;
        v134.Bar.Title.Text = "? / ?";
        v134.Name = v132;
        v134.Parent = l_List_0;
        v124();
        v136 = false;
        v135 = function() --[[ Line: 520 ]] --[[ Name: claimReward ]]
            -- upvalues: v136 (ref), v134 (copy), v5 (ref), v132 (copy), v3 (ref), v21 (ref), v124 (ref), v4 (ref), v22 (ref), v6 (ref), l_ReplicatedStorage_0 (ref)
            if v136 == true then
                return;
            else
                v136 = true;
                task.delay(1, function() --[[ Line: 524 ]]
                    -- upvalues: v136 (ref)
                    v136 = false;
                end);
                if not v134:HasTag("Flash") then
                    _G:Play("Broke");
                    return;
                else
                    local l_Flash_0 = v134:FindFirstChild("Flash");
                    local l_UIGradient_4 = l_Flash_0:FindFirstChild("UIGradient");
                    l_Flash_0.Visible = true;
                    game:GetService("TweenService"):Create(l_UIGradient_4, TweenInfo.new(0.3), {
                        Offset = Vector2.new(-1, 0)
                    }):Play();
                    _G:Play("EggWin2");
                    wait(0.3);
                    game:GetService("TweenService"):Create(l_Flash_0, TweenInfo.new(0.3), {
                        BackgroundTransparency = 1
                    }):Play();
                    if v5:InvokeServer("ClaimQuest", v132) then
                        v3.Data.Quests[v132].Claimed = true;
                        v134:Destroy();
                        v21[v132] = nil;
                        v124();
                        local v142 = 0;
                        for v143, v144 in pairs(v3.Data.Quests) do
                            local v145 = v4[v143];
                            local v146 = v145 and v145.Goal;
                            if (v144.Completed or v144.Amount and v146 and v146 <= v144.Amount) and not v144.Claimed then
                                v142 = v142 + 1;
                            end;
                        end;
                        if v142 ~= v22 then
                            local l_v22_0 = v22;
                            v22 = v142;
                            v6.Fire("ClearNotifications", "Quests");
                            if v142 > 0 then
                                v6.Fire("AddNotifications", v142, "Quests");
                                if l_v22_0 < v142 then
                                    local v148 = v142 == 1 and "Quest ready to claim!" or v142 .. " Quests ready to claim!";
                                    _G:Play("QuestComplete");
                                    v6.Fire("Notification", v148, Color3.fromRGB(92, 255, 81));
                                end;
                            end;
                        end;
                        local v149 = v4[v132];
                        if v149 and v149.Reward then
                            local l_Reward_0 = v149.Reward;
                            if l_Reward_0[1] == "Rebirths" then
                                v6.Fire("Popup", "rebirth", l_Reward_0[3]);
                            elseif l_Reward_0[1] == "Clicks" then
                                v6.Fire("Popup", "tapArea", l_Reward_0[3]);
                            elseif l_Reward_0[1] == "Items" and typeof(l_Reward_0[2]) == "table" then
                                for v151, v152 in pairs(l_Reward_0[2]) do
                                    local v153 = require(l_ReplicatedStorage_0.Game.Items);
                                    if v153[v151] then
                                        local v154 = v153[v151].Name or v151;
                                        v6.Fire("Notification", "You received " .. v152 .. "x " .. v154 .. "!", Color3.fromRGB(92, 255, 81));
                                    end;
                                end;
                            end;
                        end;
                        _G:Play("QuestReward", 1.01);
                        v6.Fire("ScreenGlow", Color3.fromRGB(26, 255, 0), 0.5, 0.45);
                        return;
                    else
                        _G:Play("Broke");
                        return;
                    end;
                end;
            end;
        end;
        v134.Hitbox.Activated:Connect(function() --[[ Line: 605 ]]
            -- upvalues: v135 (copy)
            v135();
        end);
        if not v133.Reward then
            warn("Quest reward not found for:", v132);
            return v134;
        else
            local l_Reward_1 = v133.Reward;
            local l_ItemSlotHolder_0 = v134:FindFirstChild("ItemSlotHolder");
            for _, v158 in ipairs(l_ItemSlotHolder_0:GetChildren()) do
                if v158:IsA("GuiObject") then
                    v158:Destroy();
                end;
            end;
            local v159 = l_Reward_1[2];
            local v160 = l_Reward_1[1];
            local v161 = l_Reward_1[3];
            if v159 and v160 then
                local v162 = {};
                local v163 = {
                    [v160] = v161
                };
                local l_v10_ItemSlot_0, _ = v10:CreateItemSlot(v160, v159, v161, v162, v163);
                if l_v10_ItemSlot_0 then
                    l_v10_ItemSlot_0.Size = UDim2.fromScale(1, 1);
                    l_v10_ItemSlot_0.AnchorPoint = Vector2.new(0.5, 0.5);
                    l_v10_ItemSlot_0.Position = UDim2.fromScale(0.5, 0.5);
                    l_v10_ItemSlot_0.Parent = l_ItemSlotHolder_0;
                    local l_v10_ItemData_1 = v10:GetItemData(v159, v160);
                    if l_v10_ItemData_1 then
                        local v167 = l_v10_ItemSlot_0:FindFirstChild("Hitbox") or l_v10_ItemSlot_0:FindFirstChild("Main");
                        l_v10_ItemSlot_0.Hitbox.Activated:Connect(function() --[[ Line: 658 ]]
                            -- upvalues: v135 (copy)
                            v135();
                        end);
                        if v167 then
                            local v168 = v65(l_v10_ItemData_1, v161);
                            if v168 then
                                v6.Fire("Tooltip", v167, v168);
                            end;
                        end;
                    end;
                end;
            end;
            local _ = v134.Hitbox;
            local _ = v134.Size;
            return v134;
        end;
    end;
end;
v20.UpdateQuest = function(v171, v172) --[[ Line: 679 ]] --[[ Name: UpdateQuest ]]
    -- upvalues: v3 (copy), v4 (copy), v21 (copy), v124 (copy), v8 (copy), l_Quests_0 (copy), v7 (copy)
    local v173 = v3.Data.Quests[v172];
    if not v173 then
        return;
    else
        local v174 = v4[v172];
        if not v174 then
            warn("Quest info not found for:", v172);
            return;
        else
            local l_Goal_3 = v174.Goal;
            if not l_Goal_3 then
                warn("Quest goal not found for:", v172);
                return;
            else
                local v176 = v21[v172];
                if not v173.Claimed then
                    if not v176 then
                        v176 = v171:SetupQuest(v172);
                        if not v176 then
                            return;
                        end;
                    end;
                    local v177 = v173.Amount or 0;
                    local v178 = math.min(v177 / l_Goal_3, 1);
                    v176.Bar.Title.Text = v8:Abbreviate(v177) .. " / " .. v8:Abbreviate(l_Goal_3);
                    if l_Quests_0.Visible then
                        v7:Tween(v176.Bar.Frame, 0.4, "Quad", "Out", {
                            Size = UDim2.fromScale(v178, 1)
                        });
                    else
                        v176.Bar.Frame.Size = UDim2.fromScale(v178, 1);
                    end;
                    if v178 == 1 then
                        local v179 = v4[v172];
                        local v180;
                        if not v179 then
                            v180 = 2000;
                        else
                            local l_Group_2 = v179.Group;
                            local l_Goal_4 = v179.Goal;
                            if not l_Group_2 or not l_Goal_4 then
                                v180 = 2000;
                            else
                                local l_Orders_2 = v4.Orders;
                                v180 = not l_Orders_2 and 2000 or (l_Orders_2[l_Group_2] or 2000) + math.min(l_Goal_4, 1000);
                            end;
                        end;
                        v176.LayoutOrder = -10000000 - v180;
                        v176.Bar.Title.Text = "Completed";
                        game:GetService("CollectionService"):AddTag(v176.Bar.Frame, "Flash");
                        game:GetService("CollectionService"):AddTag(v176, "Flash");
                    end;
                    return;
                else
                    if v176 then
                        v176:Destroy();
                        v21[v172] = nil;
                        v124();
                    end;
                    return;
                end;
            end;
        end;
    end;
end;
v20.Init = function(v184) --[[ Line: 736 ]] --[[ Name: Init ]]
    -- upvalues: v3 (copy), v4 (copy), v22 (ref), v6 (copy)
    v3:Connect("Quests", function(v185) --[[ Line: 737 ]]
        -- upvalues: v184 (copy), v4 (ref), v22 (ref), v6 (ref)
        for v186, _ in pairs(v185.Quests) do
            v184:UpdateQuest(v186);
        end;
        local v188 = 0;
        for v189, v190 in pairs(v185.Quests) do
            local v191 = v4[v189];
            local v192 = v191 and v191.Goal;
            if (v190.Completed or v190.Amount and v192 and v192 <= v190.Amount) and not v190.Claimed then
                v188 = v188 + 1;
            end;
        end;
        if v188 ~= v22 then
            local l_v22_1 = v22;
            v22 = v188;
            v6.Fire("ClearNotifications", "Quests");
            if v188 > 0 then
                v6.Fire("AddNotifications", v188, "Quests");
                if l_v22_1 < v188 then
                    local v194 = v188 == 1 and "A quest is ready to claim!" or v188 .. " quests ready to claim!";
                    v6.Fire("Notification", v194, Color3.fromRGB(0, 255, 0));
                    _G:Play("QuestComplete");
                end;
            end;
        end;
    end);
end;
return v20;