local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_TweenService_0 = game:GetService("TweenService");
local l_CollectionService_0 = game:GetService("CollectionService");
local v5 = require(l_ReplicatedStorage_0.Game.Replication);
local v6 = require(l_ReplicatedStorage_0.Game.Ranks);
local v7 = require(l_ReplicatedStorage_0.Game.Titles);
local v8 = require(l_ReplicatedStorage_0.Game.Skins);
local v9 = require(l_ReplicatedStorage_0.Game.PetStats.Rarities);
local v10 = require(l_ReplicatedStorage_0.Modules.Short);
local v11 = require(l_ReplicatedStorage_0.Modules.Network);
local v12 = require(l_ReplicatedStorage_0.Modules.ItemData);
local v13 = require(l_ReplicatedStorage_0.Modules.Signal);
local l_PlayerGui_0 = l_Players_0.LocalPlayer:WaitForChild("PlayerGui");
local v15 = nil;
local v16 = nil;
local v17 = nil;
local v18 = nil;
local v19 = nil;
local v20 = false;
local v21 = {};
local v22 = {};
local v23 = {};
local v24 = {
    Header = "#FFD369", 
    Quantity = "#7CFFCA", 
    Type = "#FFE099", 
    Description = "#E6ECFF"
};
local v25 = nil;
local v26 = nil;
local v27 = false;
local v28 = {};
local v29 = false;
local function _() --[[ Line: 53 ]] --[[ Name: safeDisconnect ]]
    -- upvalues: v25 (ref), v27 (ref)
    if v25 then
        pcall(function() --[[ Line: 55 ]]
            -- upvalues: v25 (ref)
            v25:Disconnect();
        end);
        v25 = nil;
    end;
    v27 = false;
end;
local function v42() --[[ Line: 63 ]] --[[ Name: EnableClaim ]]
    -- upvalues: l_CollectionService_0 (copy)
    local v31 = 0;
    for _, v33 in pairs(l_CollectionService_0:GetTagged("RankText")) do
        v33.Visible = false;
        v31 = v31 + 1;
    end;
    local v34 = 0;
    for _, v36 in pairs(l_CollectionService_0:GetTagged("RankClaimText")) do
        v36.Visible = true;
        v34 = v34 + 1;
    end;
    for _, v38 in pairs(l_CollectionService_0:GetTagged("RankCountdown")) do
        v38.Visible = false;
    end;
    local v39 = 0;
    for _, v41 in pairs(l_CollectionService_0:GetTagged("RankRewardsClaimable")) do
        if v41:IsA("BillboardGui") or v41:IsA("SurfaceGui") then
            v41.Enabled = true;
            v39 = v39 + 1;
        elseif v41:IsA("GuiObject") then
            v41.Visible = true;
            v39 = v39 + 1;
        end;
    end;
end;
local function v54() --[[ Line: 92 ]] --[[ Name: DisableClaim ]]
    -- upvalues: l_CollectionService_0 (copy)
    local v43 = 0;
    for _, v45 in pairs(l_CollectionService_0:GetTagged("RankText")) do
        v45.Visible = true;
        v43 = v43 + 1;
    end;
    local v46 = 0;
    for _, v48 in pairs(l_CollectionService_0:GetTagged("RankClaimText")) do
        v48.Visible = false;
        v46 = v46 + 1;
    end;
    for _, v50 in pairs(l_CollectionService_0:GetTagged("RankCountdown")) do
        v50.Visible = false;
    end;
    local v51 = 0;
    for _, v53 in pairs(l_CollectionService_0:GetTagged("RankRewardsClaimable")) do
        if v53:IsA("BillboardGui") or v53:IsA("SurfaceGui") then
            v53.Enabled = false;
            v51 = v51 + 1;
        elseif v53:IsA("GuiObject") then
            v53.Visible = false;
            v51 = v51 + 1;
        end;
    end;
end;
local function v63() --[[ Line: 122 ]] --[[ Name: EnableCountdown ]]
    -- upvalues: l_CollectionService_0 (copy)
    for _, v56 in pairs(l_CollectionService_0:GetTagged("RankText")) do
        v56.Visible = false;
    end;
    for _, v58 in pairs(l_CollectionService_0:GetTagged("RankClaimText")) do
        v58.Visible = false;
    end;
    for _, v60 in pairs(l_CollectionService_0:GetTagged("RankCountdown")) do
        v60.Visible = true;
    end;
    for _, v62 in pairs(l_CollectionService_0:GetTagged("RankRewardsClaimable")) do
        if v62:IsA("BillboardGui") or v62:IsA("SurfaceGui") then
            v62.Enabled = false;
        elseif v62:IsA("GuiObject") then
            v62.Visible = false;
        end;
    end;
end;
local function v75() --[[ Line: 145 ]] --[[ Name: startCountdown ]]
    -- upvalues: v63 (copy), v27 (ref), v25 (ref), v5 (copy), v15 (ref), v42 (copy), l_CollectionService_0 (copy)
    v63();
    if v27 then
        return;
    else
        if v25 then
            pcall(function() --[[ Line: 55 ]]
                -- upvalues: v25 (ref)
                v25:Disconnect();
            end);
            v25 = nil;
        end;
        v27 = false;
        v27 = true;
        v25 = game:GetService("RunService").Heartbeat:Connect(function() --[[ Line: 159 ]]
            -- upvalues: v5 (ref), v25 (ref), v27 (ref), v15 (ref), v42 (ref), l_CollectionService_0 (ref)
            if not v5.Data or not v5.Data.Ranks or not v5.Data.Ranks.NextRewardTime then
                if v25 then
                    pcall(function() --[[ Line: 55 ]]
                        -- upvalues: v25 (ref)
                        v25:Disconnect();
                    end);
                    v25 = nil;
                end;
                v27 = false;
                return;
            else
                local v64 = os.time();
                local v65 = v5.Data.Ranks.NextRewardTime - v64;
                local v66 = v15 and v15.Menu and v15.Menu.Right and v15.Menu.Right:FindFirstChild("ClaimButton");
                if v65 <= 0 then
                    if v66 then
                        v66.Visible = true;
                    end;
                    v42();
                    if v25 then
                        pcall(function() --[[ Line: 55 ]]
                            -- upvalues: v25 (ref)
                            v25:Disconnect();
                        end);
                        v25 = nil;
                    end;
                    v27 = false;
                    return;
                else
                    local v67 = math.floor(v65 / 3600);
                    local v68 = math.floor(v65 % 3600 / 60);
                    local v69 = v65 % 60;
                    local v70 = "";
                    v70 = if v67 > 0 then string.format("%dh %dm %ds", v67, v68, v69) else if v68 > 0 then string.format("%dm %ds", v68, v69) else string.format("%ds", v69);
                    for _, v72 in pairs(l_CollectionService_0:GetTagged("RankCountdown")) do
                        v72.Visible = true;
                        v72.Text = v70;
                    end;
                    if v66 then
                        v66.Visible = false;
                    end;
                    for _, v74 in pairs(l_CollectionService_0:GetTagged("RankRewardsClaimable")) do
                        if v74:IsA("BillboardGui") or v74:IsA("SurfaceGui") then
                            v74.Enabled = false;
                        elseif v74:IsA("GuiObject") then
                            v74.Visible = false;
                        end;
                    end;
                    return;
                end;
            end;
        end);
        return;
    end;
end;
local function _() --[[ Line: 213 ]] --[[ Name: stopCountdown ]]
    -- upvalues: v25 (ref), v27 (ref)
    if v25 then
        pcall(function() --[[ Line: 55 ]]
            -- upvalues: v25 (ref)
            v25:Disconnect();
        end);
        v25 = nil;
    end;
    v27 = false;
end;
v21.updateGui = function() --[[ Line: 219 ]] --[[ Name: updateGui ]]
    -- upvalues: v5 (copy), v6 (copy), v17 (ref), l_CollectionService_0 (copy), v15 (ref), v10 (copy), v42 (copy), v25 (ref), v27 (ref), v75 (copy), v54 (copy), v7 (copy)
    if not v5.Data or not v5.Data.Total then
        warn("RankRewards: Data not loaded yet");
        return;
    else
        local l_Clicks_0 = v5.Data.Total.Clicks;
        local v78 = v6.GetRank(l_Clicks_0);
        local l_CurrentRank_0 = v17.CurrentRank;
        l_CurrentRank_0.Text = v78.DisplayText;
        local v80 = l_CollectionService_0:GetTagged("TotalClicks")[1];
        if v80 then
            v80.Text = "";
        end;
        local v81 = l_CollectionService_0:GetTagged("RankRewardsTimeLeft")[1];
        local l_ClaimButton_0 = v15.Menu.Right:FindFirstChild("ClaimButton");
        local v83 = l_CollectionService_0:GetTagged("RankRewardLock")[1];
        local _ = l_CollectionService_0:GetTagged("RankRewardsClaimable")[1];
        if v80 then
            if l_Clicks_0 < 1000000 then
                v80.Text = "+" .. v10:Commas((math.ceil(l_Clicks_0))) .. " Total Clicks!";
            else
                v80.Text = "+" .. v10:Abbreviate(l_Clicks_0) .. " Total Clicks!";
            end;
        end;
        if v5.Data.Ranks.NextRewardTime then
            if os.time() >= v5.Data.Ranks.NextRewardTime then
                if l_ClaimButton_0 then
                    l_ClaimButton_0.Visible = true;
                end;
                if v83 then
                    v83.Visible = false;
                end;
                if v81 then
                    v81.Text = "";
                end;
                v42();
                if v25 then
                    pcall(function() --[[ Line: 55 ]]
                        -- upvalues: v25 (ref)
                        v25:Disconnect();
                    end);
                    v25 = nil;
                end;
                v27 = false;
            else
                if l_ClaimButton_0 then
                    l_ClaimButton_0.Visible = false;
                end;
                if v83 then
                    v83.Visible = false;
                end;
                v75();
            end;
        else
            if v78 and v78.Rewards and #v78.Rewards > 0 and v78.DisplayText ~= "Noob" then
                if l_ClaimButton_0 then
                    l_ClaimButton_0.Visible = true;
                end;
                if v83 then
                    v83.Visible = false;
                end;
                v42();
            else
                if v83 then
                    v83.Visible = true;
                end;
                if l_ClaimButton_0 then
                    l_ClaimButton_0.Visible = false;
                end;
                v54();
                for _, v86 in pairs(l_CollectionService_0:GetTagged("RankText")) do
                    v86.Text = "(None)";
                end;
            end;
            if v81 then
                v81.Text = "";
            end;
            if v25 then
                pcall(function() --[[ Line: 55 ]]
                    -- upvalues: v25 (ref)
                    v25:Disconnect();
                end);
                v25 = nil;
            end;
            v27 = false;
        end;
        for _, v88 in pairs(l_CurrentRank_0:GetChildren()) do
            if v88:IsA("UIGradient") then
                v88:Destroy();
            end;
        end;
        v7.ApplyLabel(l_CurrentRank_0, v78.Title.label.Name);
        for _, v90 in pairs(l_CollectionService_0:GetTagged("RankText")) do
            local l_Clicks_1 = v5.Data.Total.Clicks;
            local v92 = v6.GetRank(l_Clicks_1);
            for _, v94 in pairs(v90:GetChildren()) do
                if v94:IsA("UIGradient") then
                    v94:Destroy();
                end;
            end;
            v7.ApplyLabel(v90, v92.Title.label.Name);
        end;
        return;
    end;
end;
local function v96(v95) --[[ Line: 305 ]] --[[ Name: colorToHex ]]
    -- upvalues: v24 (copy)
    if typeof(v95) ~= "Color3" then
        return v24.Header;
    else
        return string.format("#%02X%02X%02X", math.floor(v95.R * 255 + 0.5), math.floor(v95.G * 255 + 0.5), (math.floor(v95.B * 255 + 0.5)));
    end;
end;
local function _(v97) --[[ Line: 318 ]] --[[ Name: getRarityHex ]]
    -- upvalues: v9 (copy), v96 (copy), v24 (copy)
    local v98 = v97 and v9[v97];
    if typeof(v98) == "table" and v98[1] then
        return v96(v98[1]);
    else
        return v24.Header;
    end;
end;
local function v111(v100) --[[ Line: 327 ]] --[[ Name: buildRewardTooltip ]]
    -- upvalues: v12 (copy), v9 (copy), v24 (copy), v10 (copy)
    if not v100 or not v100.Name or not v100.Type then
        return nil;
    else
        local l_v12_ItemData_0 = v12:GetItemData(v100.Type, v100.Name);
        if not l_v12_ItemData_0 then
            return nil;
        else
            local v102 = {};
            local v103 = l_v12_ItemData_0.rarity or l_v12_ItemData_0.data and l_v12_ItemData_0.data.Rarity;
            local l_v102_0 = v102;
            local l_format_0 = string.format;
            local v106 = "<font color=\"%s\"><b>%s</b></font>";
            local v107 = v103 and v9[v103];
            local v108;
            if typeof(v107) == "table" and v107[1] then
                local v109 = v107[1];
                v108 = if typeof(v109) ~= "Color3" then v24.Header else string.format("#%02X%02X%02X", math.floor(v109.R * 255 + 0.5), math.floor(v109.G * 255 + 0.5), (math.floor(v109.B * 255 + 0.5)));
            else
                v108 = v24.Header;
            end;
            table.insert(l_v102_0, l_format_0(v106, v108, l_v12_ItemData_0.name or v100.Name));
            local v110 = v100.Amount or 1;
            if v110 > 0 then
                table.insert(v102, string.format("<font color=\"%s\">Quantity: x%s</font>", v24.Quantity, v10:Abbreviate(v110)));
            end;
            table.insert(v102, string.format("<font color=\"%s\">Type: %s</font>", v24.Type, (tostring(v100.Type))));
            if l_v12_ItemData_0.description and l_v12_ItemData_0.description ~= "" then
                table.insert(v102, string.format("<font color=\"%s\">%s</font>", v24.Description, l_v12_ItemData_0.description));
            end;
            return table.concat(v102, "\n");
        end;
    end;
end;
local function _(v112) --[[ Line: 371 ]] --[[ Name: getTooltipTargetForSlot ]]
    if not v112 then
        return nil;
    else
        return v112:FindFirstChild("Hitbox") or v112:FindFirstChild("Main");
    end;
end;
local function _(v114) --[[ Line: 379 ]] --[[ Name: detachRewardTooltip ]]
    -- upvalues: v22 (copy), v23 (copy), v13 (copy)
    local v115 = v22[v114];
    if v115 then
        v115:Disconnect();
        v22[v114] = nil;
    end;
    local v116 = v23[v114];
    if v116 then
        v13.Fire("RemoveTooltip", v116);
        v23[v114] = nil;
    end;
end;
local function v126(v118, v119) --[[ Line: 393 ]] --[[ Name: attachRewardTooltip ]]
    -- upvalues: v22 (copy), v23 (copy), v13 (copy), v111 (copy)
    if not v118 or not v119 then
        return;
    else
        local v120 = if not v118 then nil else v118:FindFirstChild("Hitbox") or v118:FindFirstChild("Main");
        if not v120 then
            return;
        else
            local v121 = v22[v118];
            if v121 then
                v121:Disconnect();
                v22[v118] = nil;
            end;
            local v122 = v23[v118];
            if v122 then
                v13.Fire("RemoveTooltip", v122);
                v23[v118] = nil;
            end;
            v121 = v111(v119);
            if not v121 then
                return;
            else
                v13.Fire("Tooltip", v120, v121);
                v23[v118] = v120;
                v22[v118] = v118.Destroying:Connect(function() --[[ Line: 412 ]]
                    -- upvalues: v118 (copy), v22 (ref), v23 (ref), v13 (ref)
                    local l_v118_0 = v118;
                    local v124 = v22[l_v118_0];
                    if v124 then
                        v124:Disconnect();
                        v22[l_v118_0] = nil;
                    end;
                    local v125 = v23[l_v118_0];
                    if v125 then
                        v13.Fire("RemoveTooltip", v125);
                        v23[l_v118_0] = nil;
                    end;
                end);
                return;
            end;
        end;
    end;
end;
local function v133() --[[ Line: 417 ]] --[[ Name: clearRewardTooltips ]]
    -- upvalues: v23 (copy), v22 (copy), v13 (copy)
    local v127 = {};
    for v128 in pairs(v23) do
        table.insert(v127, v128);
    end;
    for _, v130 in ipairs(v127) do
        local v131 = v22[v130];
        if v131 then
            v131:Disconnect();
            v22[v130] = nil;
        end;
        local v132 = v23[v130];
        if v132 then
            v13.Fire("RemoveTooltip", v132);
            v23[v130] = nil;
        end;
    end;
end;
local function v140(v134, v135, v136) --[[ Line: 428 ]] --[[ Name: setupRewardSlot ]]
    -- upvalues: v12 (copy), v10 (copy)
    local l_Type_0 = v135.Type;
    local l_v12_ItemData_1 = v12:GetItemData(l_Type_0, v135.Name);
    if not l_v12_ItemData_1 then
        warn("Failed to get item data for:", l_Type_0, v135.Name);
        return;
    else
        if v136 then
            v134.Main.Icon.Image = "rbxassetid://9461433634";
            v134.Main.Icon.ImageColor3 = Color3.fromRGB(150, 150, 150);
            v134.Main.Icon.ImageTransparency = 0.3;
            v134.Main.Quantity.Text = "???";
            v134.Main.Quantity.TextTransparency = 0.5;
        else
            local v139 = v135.Amount or 1;
            if string.lower(l_Type_0) == "currency" then
                v134.Main.Quantity.Text = v10:Abbreviate(v139);
            else
                v134.Main.Quantity.Text = "x" .. v10:Abbreviate(v139);
            end;
        end;
        v134.Size = UDim2.new(0.38, 0, 0.38, 0);
        if l_v12_ItemData_1.data.Rarity == "Common" then
            v134.Main.Background.ImageColor3 = Color3.fromRGB(143, 143, 143);
        end;
        return;
    end;
end;
v21.loadRewardsSlots = function() --[[ Line: 464 ]] --[[ Name: loadRewardsSlots ]]
    -- upvalues: v5 (copy), v6 (copy), v133 (copy), v18 (ref), v26 (ref), l_CollectionService_0 (copy), v15 (ref), l_RunService_0 (copy), v12 (copy), v140 (copy), v126 (copy)
    if not v5.Data or not v5.Data.Total then
        warn("RankRewards: Data not loaded yet");
        return;
    else
        local l_Clicks_2 = v5.Data.Total.Clicks;
        local v142 = v6.GetRank(l_Clicks_2);
        v133();
        for _, v144 in pairs(v18:GetChildren()) do
            if v144:IsA("Frame") and v144.Name ~= "Template" then
                v144:Destroy();
            end;
        end;
        if v18.Parent:FindFirstChild("NoRewardsMessage") then
            if v26 then
                pcall(function() --[[ Line: 486 ]]
                    -- upvalues: v26 (ref)
                    v26:Disconnect();
                end);
                v26 = nil;
            end;
            v18.Parent.NoRewardsMessage:Destroy();
        end;
        local v145 = v142 and v142.Rewards or {};
        local v146 = l_CollectionService_0:GetTagged("RankRewardLock")[1];
        local l_ClaimButton_1 = v15.Menu.Right:FindFirstChild("ClaimButton");
        if v145 and #v145 > 0 and v142.DisplayText ~= "Noob" then
            if v146 then
                v146.Visible = false;
            end;
            if l_ClaimButton_1 then
                l_ClaimButton_1.Visible = true;
            end;
        else
            if v146 then
                v146.Visible = true;
            end;
            if l_ClaimButton_1 then
                l_ClaimButton_1.Visible = false;
            end;
        end;
        if not v145 or #v145 == 0 or v142 and v142.DisplayText == "Noob" then
            local l_Frame_0 = Instance.new("Frame");
            l_Frame_0.Name = "NoRewardsMessage";
            l_Frame_0.Size = UDim2.fromScale(1, 1);
            l_Frame_0.Position = UDim2.fromScale(0, 0);
            l_Frame_0.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
            l_Frame_0.BackgroundTransparency = 0.3;
            l_Frame_0.BorderSizePixel = 0;
            l_Frame_0.Parent = v18.Parent;
            local l_UICorner_0 = v18.Parent:FindFirstChildOfClass("UICorner");
            if l_UICorner_0 then
                l_UICorner_0:Clone().Parent = l_Frame_0;
            end;
            for _, v151 in pairs(v18.Parent:GetChildren()) do
                if v151 ~= l_Frame_0 and v151:IsA("GuiObject") then
                    v151.Visible = false;
                end;
            end;
            local l_TextLabel_0 = Instance.new("TextLabel");
            l_TextLabel_0.Name = "MessageText";
            l_TextLabel_0.Size = UDim2.fromScale(0.8, 0.2);
            l_TextLabel_0.Position = UDim2.fromScale(0.1, 0.15);
            l_TextLabel_0.BackgroundTransparency = 1;
            l_TextLabel_0.Text = "Rank up to unlock cool rewards!";
            l_TextLabel_0.TextColor3 = Color3.fromRGB(255, 255, 255);
            l_TextLabel_0.TextScaled = true;
            l_TextLabel_0.Font = Enum.Font.GothamBold;
            l_TextLabel_0.TextStrokeTransparency = 0.5;
            l_TextLabel_0.TextStrokeColor3 = Color3.fromRGB(0, 0, 0);
            l_TextLabel_0.Parent = l_Frame_0;
            local l_ImageLabel_0 = Instance.new("ImageLabel");
            l_ImageLabel_0.Name = "MessageIcon";
            l_ImageLabel_0.Size = UDim2.fromScale(0.5, 0.5);
            l_ImageLabel_0.Position = UDim2.fromScale(0.25, 0.4);
            l_ImageLabel_0.BackgroundTransparency = 1;
            l_ImageLabel_0.Image = "rbxassetid://9461433634";
            l_ImageLabel_0.ScaleType = Enum.ScaleType.Fit;
            l_ImageLabel_0.ImageTransparency = 0.2;
            l_ImageLabel_0.ImageColor3 = Color3.fromRGB(255, 255, 255);
            l_ImageLabel_0.Parent = l_Frame_0;
            local v154 = tick();
            v26 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 560 ]]
                -- upvalues: v154 (copy), l_ImageLabel_0 (copy)
                local v155 = math.sin((tick() - v154) * 3) * 0.02;
                l_ImageLabel_0.Position = UDim2.fromScale(0.25, v155 + 0.4);
            end);
            local l_ClaimButton_2 = v15.Menu.Right:FindFirstChild("ClaimButton");
            if l_ClaimButton_2 then
                l_ClaimButton_2.Visible = false;
            end;
            return;
        else
            for _, v158 in pairs(v18.Parent:GetChildren()) do
                if v158.Name ~= "NoRewardsMessage" and v158:IsA("GuiObject") then
                    v158.Visible = true;
                end;
            end;
            local v159 = v5.Data.Ranks.NextRewardTime and os.time() < v5.Data.Ranks.NextRewardTime;
            for v160, v161 in ipairs(v145) do
                local v162 = v161.Amount or 1;
                local l_Type_1 = v161.Type;
                local l_v12_ItemSlot_0 = v12:CreateItemSlot(v161.Name, l_Type_1, v162, {}, {});
                if l_v12_ItemSlot_0 then
                    l_v12_ItemSlot_0.Name = "Reward" .. v160;
                    l_v12_ItemSlot_0.Visible = true;
                    v140(l_v12_ItemSlot_0, v161, v159);
                    local l_Hitbox_0 = l_v12_ItemSlot_0:FindFirstChild("Hitbox");
                    if l_Hitbox_0 then
                        l_Hitbox_0:Destroy();
                    end;
                    l_v12_ItemSlot_0.LayoutOrder = v160;
                    l_v12_ItemSlot_0.Parent = v18;
                    v126(l_v12_ItemSlot_0, v161);
                else
                    warn("Failed to create item slot for:", v161.Name, l_Type_1);
                end;
            end;
            return;
        end;
    end;
end;
v21.rigSlots = function() --[[ Line: 623 ]] --[[ Name: rigSlots ]]
    -- upvalues: v17 (ref), v6 (copy), v7 (copy), v8 (copy)
    for _, v167 in pairs(v17.List:GetChildren()) do
        if v167:IsA("Frame") and v6.Ranks[v167.Name] then
            local v168 = v6.Ranks[v167.Name];
            if v168.Title and v168.Title.label then
                local l_Rank_0 = v167.Template.Rank;
                for _, v171 in pairs(l_Rank_0:GetChildren()) do
                    if v171:IsA("UIGradient") then
                        v171:Destroy();
                    end;
                end;
                v7.ApplyLabel(l_Rank_0, v168.Title.label.Name);
            end;
            if v168.Skin then
                local v172 = v8[v168.Skin];
                if v172 and v172.Icon then
                    local l_ImageLabel_1 = v167:FindFirstChild("ImageLabel");
                    if l_ImageLabel_1 and l_ImageLabel_1:IsA("ImageLabel") then
                        l_ImageLabel_1.Image = "rbxassetid://" .. v172.Icon;
                    end;
                end;
            end;
        end;
    end;
end;
v21.Init = function(_) --[[ Line: 653 ]] --[[ Name: Init ]]
    -- upvalues: v15 (ref), l_PlayerGui_0 (copy), v18 (ref), v17 (ref), v16 (ref), v19 (ref), v133 (copy), l_CollectionService_0 (copy), v5 (copy), v21 (copy), v6 (copy), v10 (copy), v20 (ref), v13 (copy), v11 (copy), l_TweenService_0 (copy), v29 (ref), v28 (copy), v7 (copy)
    v15 = l_PlayerGui_0:WaitForChild("Tabs"):WaitForChild("Ranks");
    v18 = v15.Menu.Right.List;
    v17 = v15.Menu.Left;
    v16 = l_PlayerGui_0:WaitForChild("RankedUp");
    v19 = v17.Template.TotalClicks;
    local v175 = v18 and v18.Parent;
    if v175 then
        v175:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 662 ]]
            -- upvalues: v175 (copy), v133 (ref)
            if not v175.Visible then
                v133();
            end;
        end);
    end;
    for _, v177 in pairs(l_CollectionService_0:GetTagged("RankRewardsClaimable")) do
        if v177:IsA("BillboardGui") or v177:IsA("SurfaceGui") then
            v177.Enabled = false;
        elseif v177:IsA("GuiObject") then
            v177.Visible = false;
        end;
    end;
    v5:Connect("DataLoaded", function() --[[ Line: 678 ]]
        -- upvalues: v21 (ref)
        task.wait(0.1);
        v21.updateGui();
        v21.rigSlots();
        v21.loadRewardsSlots();
    end);
    v5:Connect("Total", function() --[[ Line: 686 ]]
        -- upvalues: v15 (ref), v5 (ref), v6 (ref), v17 (ref), v21 (ref), v19 (ref), v10 (ref)
        if v15.Enabled then
            local l_Clicks_3 = v5.Data.Total.Clicks;
            local v179 = v6.GetRank(l_Clicks_3);
            if v17.CurrentRank.Text ~= v179.DisplayText then
                v21.updateGui();
                v21.loadRewardsSlots();
            end;
            local l_v19_0 = v19;
            if l_v19_0 then
                l_v19_0.Text = "";
            end;
            if l_v19_0 then
                if l_Clicks_3 < 1000000 then
                    l_v19_0.Text = "+" .. v10:Commas((math.ceil(l_Clicks_3))) .. " Total Clicks!";
                    return;
                else
                    l_v19_0.Text = "+" .. v10:Abbreviate(l_Clicks_3) .. " Total Clicks!";
                end;
            end;
        end;
    end);
    v5:Connect("Ranks", function() --[[ Line: 714 ]]
        -- upvalues: v21 (ref), v15 (ref), v5 (ref), v6 (ref), v20 (ref), v13 (ref)
        v21.updateGui();
        if v15.Enabled then
            v21.loadRewardsSlots();
        end;
        task.delay(6, function() --[[ Line: 722 ]]
            -- upvalues: v5 (ref), v6 (ref), v20 (ref), v13 (ref)
            if not v5.Data or not v5.Data.Total then
                return;
            else
                local l_Clicks_4 = v5.Data.Total.Clicks;
                local v182 = v6.GetRank(l_Clicks_4);
                local v183 = v182 and v182.Rewards and #v182.Rewards > 0 and v182.DisplayText ~= "Noob";
                local v184 = v5.Data.Ranks.NextRewardTime and os.time() < v5.Data.Ranks.NextRewardTime;
                if v183 and not v184 and not v20 then
                    v20 = true;
                    v13.Fire("Notification", "You have claimable rank rewards!", Color3.fromRGB(70, 255, 41));
                    _G:Play("PopUp");
                    task.delay(3, function() --[[ Line: 740 ]]
                        -- upvalues: v20 (ref)
                        v20 = false;
                    end);
                end;
                return;
            end;
        end);
    end);
    v15:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 748 ]]
        -- upvalues: v15 (ref), v21 (ref), v133 (ref)
        if v15.Enabled then
            v21.updateGui();
            v21.loadRewardsSlots();
            return;
        else
            v133();
            return;
        end;
    end);
    local l_ClaimButton_3 = v15.Menu.Right:FindFirstChild("ClaimButton");
    if l_ClaimButton_3 then
        local l_Button_0 = l_ClaimButton_3:FindFirstChild("Button");
        if l_Button_0 then
            v13.Fire("InitButton", l_Button_0);
            local l_l_Button_0_0 = l_Button_0 --[[ copy: 3 -> 7 ]];
            l_Button_0.Activated:Connect(function() --[[ Line: 765 ]]
                -- upvalues: l_l_Button_0_0 (copy), v11 (ref), v18 (ref), l_TweenService_0 (ref), v13 (ref)
                l_l_Button_0_0.Active = false;
                local v188, v189 = v11:InvokeServer("ClaimRankReward");
                if v188 then
                    _G:Play("PowerUp");
                    for _, v191 in pairs(v18:GetChildren()) do
                        if v191:IsA("GuiObject") and v191.Name ~= "Template" and v191.Name:match("^Reward") then
                            l_TweenService_0:Create(v191, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
                                Size = UDim2.fromScale(0, 0), 
                                BackgroundTransparency = 1
                            }):Play();
                        end;
                    end;
                    _G:Play("QuestReward");
                    task.wait(0.5);
                    v13.Fire("ScreenGlow", Color3.fromRGB(255, 215, 0), 1.5, 0.5);
                    local v192 = {};
                    if v189 and #v189 > 0 then
                        for _, v194 in ipairs(v189) do
                            if v194.Type == "Gems" or v194.Type == "Tokens" or v194.Type == "Coins" then
                                table.insert(v192, {
                                    "Currency", 
                                    v194.Type, 
                                    v194.Amount
                                });
                            elseif v194.Type == "Pet" then
                                table.insert(v192, {
                                    "Pet", 
                                    v194.Name
                                });
                            elseif v194.Type == "Potion" then
                                table.insert(v192, {
                                    "Potion", 
                                    v194.Name
                                });
                            end;
                        end;
                    end;
                    if #v192 > 0 then
                        task.wait(0.2);
                        v13.Fire("Reward", v192, true);
                    end;
                    task.wait(0.4);
                    task.wait(0.5);
                    v13.Fire("Notification", "Come back later for more rewards!", Color3.fromRGB(100, 200, 255));
                    l_l_Button_0_0.Active = true;
                    return;
                else
                    _G:Play("Broke");
                    v13.Fire("Notification", "Rewards on cooldown!", Color3.fromRGB(255, 100, 100));
                    warn("\226\157\140 Failed to claim rewards:", v189);
                    l_l_Button_0_0.Active = true;
                    return;
                end;
            end);
        else
            warn("DEBUG: Button not found in ClaimButton");
        end;
    else
        warn("DEBUG: ClaimButton not found in Right frame");
    end;
    local function _() --[[ Line: 857 ]] --[[ Name: processRankUpQueue ]]
        -- upvalues: v29 (ref), v28 (ref), v13 (ref)
        if v29 or #v28 == 0 then
            return;
        else
            v29 = true;
            task.spawn(function() --[[ Line: 867 ]]
                -- upvalues: v28 (ref), v13 (ref), v29 (ref)
                while #v28 > 0 do
                    local v195 = table.remove(v28, 1);
                    _G:Play("RankUp");
                    v13.Fire("RankUpAnimation", v195);
                    v13.Fire("ScreenGlow", Color3.fromRGB(255, 215, 0), 1.5, 2);
                    task.wait(2.5);
                end;
                v29 = false;
            end);
            return;
        end;
    end;
    v11:BindEvents({
        RankUp = function(v197) --[[ Line: 886 ]]
            -- upvalues: v28 (ref), v29 (ref), v13 (ref)
            table.insert(v28, v197);
            if not v29 then
                if #v28 == 0 then
                    return;
                else
                    v29 = true;
                    task.spawn(function() --[[ Line: 867 ]]
                        -- upvalues: v28 (ref), v13 (ref), v29 (ref)
                        while #v28 > 0 do
                            local v198 = table.remove(v28, 1);
                            _G:Play("RankUp");
                            v13.Fire("RankUpAnimation", v198);
                            v13.Fire("ScreenGlow", Color3.fromRGB(255, 215, 0), 1.5, 2);
                            task.wait(2.5);
                        end;
                        v29 = false;
                    end);
                end;
            end;
        end
    });
    l_CollectionService_0:GetInstanceAddedSignal("RankText"):Connect(function(v199) --[[ Line: 894 ]]
        -- upvalues: v5 (ref), v6 (ref), v7 (ref)
        repeat
            task.wait();
        until v5.Data and v5.Data.Total;
        local l_Clicks_5 = v5.Data.Total.Clicks;
        local v201 = v6.GetRank(l_Clicks_5);
        for _, v203 in pairs(v199:GetChildren()) do
            if v203:IsA("UIGradient") then
                v203:Destroy();
            end;
        end;
        v7.ApplyLabel(v199, v201.Title.label.Name);
    end);
    l_CollectionService_0:GetInstanceAddedSignal("RankRewardsClaimable"):Connect(function(v204) --[[ Line: 910 ]]
        -- upvalues: v5 (ref), v6 (ref)
        task.wait();
        if not v5.Data or not v5.Data.Total then
            if v204:IsA("BillboardGui") or v204:IsA("SurfaceGui") then
                v204.Enabled = false;
                return;
            else
                if v204:IsA("GuiObject") then
                    v204.Visible = false;
                end;
                return;
            end;
        else
            local l_Clicks_6 = v5.Data.Total.Clicks;
            local v206 = v6.GetRank(l_Clicks_6);
            local v207 = v206 and v206.Rewards and #v206.Rewards > 0 and v206.DisplayText ~= "Noob";
            local v208 = v5.Data.Ranks.NextRewardTime and os.time() < v5.Data.Ranks.NextRewardTime;
            local v209 = v207 and (not v5.Data.Ranks.NextRewardTime or not v208);
            if v204:IsA("BillboardGui") or v204:IsA("SurfaceGui") then
                v204.Enabled = v209;
                return;
            else
                if v204:IsA("GuiObject") then
                    v204.Visible = v209;
                end;
                return;
            end;
        end;
    end);
end;
return v21;