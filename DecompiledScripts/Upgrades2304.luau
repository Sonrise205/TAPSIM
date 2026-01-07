local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local _ = game:GetService("RunService");
local _ = require(l_ReplicatedStorage_0.Modules.Tweens);
local v4 = require(l_ReplicatedStorage_0.Modules.Network);
local v5 = require(l_ReplicatedStorage_0.Modules.Signal);
local v6 = require(l_ReplicatedStorage_0.Modules.Short);
local v7 = require(l_ReplicatedStorage_0.Game.Replication);
local v8 = require(l_ReplicatedStorage_0.Game.DoubleJumps);
local v9 = require(l_ReplicatedStorage_0.Game.GemShop);
local v10 = require(l_ReplicatedStorage_0.Game.Rebirths);
local v11 = require(l_ReplicatedStorage_0.Game.Portals);
local v12 = require(script.Parent.Parent.Controllers["Interaction Points"]);
local v13 = nil;
local v14 = nil;
local _ = nil;
local v16 = {};
local v17 = {
    RebirthButtons = "Hint_RebirthButtons", 
    Jumps = "Hint_Jumps"
};
local function _(v18) --[[ Line: 31 ]] --[[ Name: hasShownHint ]]
    -- upvalues: v7 (copy)
    if not v7.Loaded or not v7.Data.PromptedUIs then
        return false;
    else
        return v7.Data.PromptedUIs[v18] == true;
    end;
end;
local function v21(v20) --[[ Line: 38 ]] --[[ Name: markHintAsShown ]]
    -- upvalues: v7 (copy), v4 (copy)
    if not v7.Loaded then
        return;
    else
        if not v7.Data.PromptedUIs then
            v7.Data.PromptedUIs = {};
        end;
        v7.Data.PromptedUIs[v20] = true;
        v4:FireServer("MarkUIPrompted", v20);
        return;
    end;
end;
local function v26(v22) --[[ Line: 53 ]] --[[ Name: showHintIfNeeded ]]
    -- upvalues: v14 (ref), v17 (copy), v7 (copy), v21 (copy)
    if not v14 or not v14.Categories then
        return;
    else
        local v23 = v17[v22];
        if not v23 then
            return;
        elseif if v7.Loaded and v7.Data.PromptedUIs then v7.Data.PromptedUIs[v23] == true else false then
            return;
        else
            local l_FirstChild_0 = v14.Categories:FindFirstChild(v22);
            if not l_FirstChild_0 then
                return;
            else
                local l_Hint_0 = l_FirstChild_0:FindFirstChild("Hint");
                if not l_Hint_0 then
                    return;
                else
                    l_Hint_0.Visible = true;
                    v21(v23);
                    task.delay(10, function() --[[ Line: 85 ]]
                        -- upvalues: l_Hint_0 (copy)
                        if l_Hint_0 and l_Hint_0.Parent then
                            l_Hint_0.Visible = false;
                        end;
                    end);
                    return;
                end;
            end;
        end;
    end;
end;
local function v34(v27, v28) --[[ Line: 93 ]] --[[ Name: CheckRequirement ]]
    -- upvalues: v8 (copy)
    local l_IslandRequirements_0 = v8[v28].IslandRequirements;
    local v30 = nil;
    local v31 = 1e999;
    for v32, v33 in pairs(l_IslandRequirements_0) do
        if v27 <= v33 and v33 < v31 then
            v30 = v32;
            v31 = v33;
        end;
    end;
    return v30;
end;
refreshDoubleJumps = function() --[[ Line: 109 ]] --[[ Name: refreshDoubleJumps ]]
    -- upvalues: v14 (ref), v7 (copy), v8 (copy), v34 (copy), v11 (copy)
    local l_Jumps_0 = v14.Categories.Jumps;
    local l_List_0 = l_Jumps_0.Inner.List;
    local v37 = l_Jumps_0:GetAttribute("World") or "Main";
    local v38 = v7.Loaded and v7.Data.DoubleJumps[v37] or 1;
    for _, v40 in pairs(l_List_0:GetChildren()) do
        if v40:IsA("Frame") and v40.Name ~= "Template" then
            local v41 = tonumber(v40.Name);
            if v41 then
                local v42 = v8[v37].Prices[v41];
                local v43 = v34(v41, v37);
                local v44 = v41 == v38;
                local v45 = v41 < v38;
                local v46 = v7.Loaded and v7.Data.Portals[v43] or v43 == "Spawn";
                local v47 = v7.Loaded and v42 <= v7.Data.Statistics.Gems or false;
                if v46 then
                    v40.IslandLock.Visible = false;
                    if v45 then
                        v40.Upgrade.Visible = false;
                        v40.UpgradeLocked.Visible = false;
                        v40.Unlocked.Visible = true;
                    elseif v44 then
                        if v47 then
                            v40.Upgrade.Visible = true;
                            v40.UpgradeLocked.Visible = false;
                        else
                            v40.Upgrade.Visible = false;
                            v40.UpgradeLocked.Visible = true;
                        end;
                        v40.Unlocked.Visible = false;
                    else
                        v40.Upgrade.Visible = false;
                        v40.UpgradeLocked.Visible = true;
                        v40.Unlocked.Visible = false;
                    end;
                else
                    v40.IslandLock.Visible = true;
                    v40.IslandLock.Title.Text = "Unlock " .. v43 .. " Island first!";
                    v40.IslandLock.Icon.Image = v11[v43].Image;
                    v40.Upgrade.Visible = false;
                    v40.UpgradeLocked.Visible = false;
                    v40.Unlocked.Visible = false;
                end;
            end;
        end;
    end;
end;
setupDoubleJumps = function() --[[ Line: 165 ]] --[[ Name: setupDoubleJumps ]]
    -- upvalues: v14 (ref), v7 (copy), v8 (copy), v6 (copy), v12 (copy), v5 (copy), v4 (copy), v34 (copy), v11 (copy)
    local l_Jumps_1 = v14.Categories.Jumps;
    local l_List_1 = l_Jumps_1.Inner.List;
    local l_Template_0 = l_List_1.Template;
    local v51 = v7.Loaded and v7.Data.World or "Main";
    l_Jumps_1:SetAttribute("World", v51);
    local v52 = v7.Loaded and v7.Data.DoubleJumps[v51] or 1;
    for v53, v54 in pairs(v8[v51].Prices) do
        local v55 = l_Template_0:Clone();
        v55.Name = v53;
        v55.LayoutOrder = v53;
        v55.Title.Text = v53 + 1 .. " Jumps";
        v55.Upgrade.Main.Currency.Amount.Text = v6:Abbreviate(v54, false, true);
        v55.UpgradeLocked.Main.Currency.Amount.Text = v6:Abbreviate(v54, false, true);
        v55.Parent = l_List_1;
        v55.Upgrade.Button.Activated:Connect(function() --[[ Line: 183 ]]
            -- upvalues: v7 (ref), v51 (copy), v12 (ref), v5 (ref), v4 (ref)
            local v56 = v7.Loaded and v7.Data.DoubleJumps[v51] or 1;
            if v12.CurrentPoint ~= "Jumps" then
                _G:Play("Broke");
                v5.Fire("Notification", "Visit a Jumps interaction point to purchase!", Color3.fromRGB(255, 100, 100), nil, 3);
                return;
            elseif v4:InvokeServer("UpgradeDoubleJump", v51) then
                _G:Play("QuestReward", 1.1);
                _G:Play("Shine", 0.9, 0.8);
                local v57 = "Double Jumps upgraded to " .. v56 + 1 .. "!";
                local v58 = Color3.fromRGB(100, 200, 255);
                v5.Fire("Notification", v57, v58, nil, 3);
                refreshDoubleJumps();
                return;
            else
                _G:Play("Broke");
                return;
            end;
        end);
        v5.Fire("InitButton", v55.Upgrade.Button);
        v55.UpgradeLocked.Button.Activated:Connect(function() --[[ Line: 217 ]]
            -- upvalues: v8 (ref), v51 (copy), v53 (copy), v6 (ref), v5 (ref)
            _G:Play("Broke");
            local v59 = v8[v51].Prices[v53];
            local v60 = "Not enough gems! Need " .. v6:Abbreviate(v59, false, true) .. " gems.";
            v5.Fire("Notification", v60, Color3.fromRGB(255, 100, 100), nil, 3);
        end);
        v5.Fire("InitButton", v55.UpgradeLocked.Button);
        local v61 = v34(v53, v51);
        local v62 = v53 == v52;
        local v63 = v53 < v52;
        local v64 = v7.Loaded and v7.Data.Portals[v61] or v61 == "Spawn";
        local v65 = v8[v51].Prices[v53];
        local v66 = v7.Loaded and v65 <= v7.Data.Statistics.Gems or false;
        if v64 then
            v55.IslandLock.Visible = false;
            if v63 then
                v55.Upgrade.Visible = false;
                v55.UpgradeLocked.Visible = false;
                v55.Unlocked.Visible = true;
            elseif v62 then
                if v66 then
                    v55.Upgrade.Visible = true;
                    v55.UpgradeLocked.Visible = false;
                else
                    v55.Upgrade.Visible = false;
                    v55.UpgradeLocked.Visible = true;
                end;
                v55.Unlocked.Visible = false;
            else
                v55.Upgrade.Visible = false;
                v55.UpgradeLocked.Visible = true;
                v55.Unlocked.Visible = false;
            end;
        else
            v55.IslandLock.Visible = true;
            v55.IslandLock.Title.Text = "Unlock " .. v61 .. " Island first!";
            v55.IslandLock.Icon.Image = v11[v61].Image;
            v55.Upgrade.Visible = false;
            v55.UpgradeLocked.Visible = false;
            v55.Unlocked.Visible = false;
        end;
    end;
    l_Template_0.Visible = false;
end;
clearDoubleJumps = function() --[[ Line: 273 ]] --[[ Name: clearDoubleJumps ]]
    -- upvalues: v14 (ref)
    local l_List_2 = v14.Categories.Jumps.Inner.List;
    local l_Template_1 = l_List_2.Template;
    for _, v70 in pairs(l_List_2:GetChildren()) do
        if v70:IsA("Frame") and v70.Name ~= "Template" then
            v70:Destroy();
        end;
    end;
    l_Template_1.Visible = true;
end;
local function _(v71, v72) --[[ Line: 290 ]] --[[ Name: getPrice ]]
    -- upvalues: v9 (copy)
    local v73 = v9[v71];
    if v73.Function then
        return math.round(v73.Function(v72) * v73.Price / 10) * 10;
    else
        return v73.Price * v72;
    end;
end;
local function v81(v75, _) --[[ Line: 299 ]] --[[ Name: CheckRebirthRequirement ]]
    -- upvalues: v9 (copy)
    local l_IslandRequirements_1 = v9.RebirthButtons.IslandRequirements;
    local v78 = nil;
    for v79, v80 in pairs(l_IslandRequirements_1) do
        if v75 < v80 and (not v78 or v80 < l_IslandRequirements_1[v78]) then
            v78 = v79;
        end;
    end;
    return v78;
end;
local function _(v82, v83) --[[ Line: 315 ]] --[[ Name: setSelectedFrameVisible ]]
    if not v82 then
        return;
    else
        local l_v82_FirstChild_0 = v82:FindFirstChild("Selected", true);
        if l_v82_FirstChild_0 then
            l_v82_FirstChild_0.Visible = v83 and true or false;
        end;
        return;
    end;
end;
local function v95() --[[ Line: 326 ]] --[[ Name: getNextAffordableRebirthButtonInfo ]]
    -- upvalues: v7 (copy), v9 (copy), v81 (copy), v10 (copy)
    if not v7.Loaded or not v7.Data or not v7.Data.GemShop then
        return nil;
    else
        local l_Data_0 = v7.Data;
        local l_GemShop_0 = l_Data_0.GemShop;
        local l_Statistics_0 = l_Data_0.Statistics;
        local v89 = l_GemShop_0.RebirthButtons or 0;
        if v9.RebirthButtons.Total <= v89 then
            return nil;
        else
            local v90 = v89 + 1;
            local l_RebirthButtons_0 = v9.RebirthButtons;
            local v92 = if l_RebirthButtons_0.Function then math.round(l_RebirthButtons_0.Function(v90) * l_RebirthButtons_0.Price / 10) * 10 else l_RebirthButtons_0.Price * v90;
            l_RebirthButtons_0 = l_Statistics_0 and l_Statistics_0.Gems or 0;
            local v93 = v81(v90, "Main");
            local v94 = true;
            if v93 and v93 ~= "Spawn" then
                v94 = l_Data_0.Portals and l_Data_0.Portals[v93] or false;
            end;
            if not v94 or l_RebirthButtons_0 < v92 then
                return nil;
            else
                return {
                    Index = v90, 
                    Price = v92, 
                    Gems = l_RebirthButtons_0, 
                    RequiredIsland = v93, 
                    RebirthAmount = v10:fromIndex(v90 + 3)
                };
            end;
        end;
    end;
end;
local function v106() --[[ Line: 364 ]] --[[ Name: updateNextRebirthSelectedState ]]
    -- upvalues: v14 (ref), v7 (copy), v95 (copy)
    if not v14 or not v14.Categories or not v14.Categories:FindFirstChild("RebirthButtons") then
        return;
    else
        local l_List_3 = v14.Categories.RebirthButtons.Inner.List;
        local v97 = 0;
        if v7.Loaded and v7.Data.GemShop then
            v97 = v7.Data.GemShop.RebirthButtons or 0;
        end;
        local v98 = v97 + 1;
        local l_l_List_3_FirstChild_0 = l_List_3:FindFirstChild((tostring(v98)));
        local v100 = v95();
        local v101 = false;
        if v100 ~= nil then
            v101 = false;
            if v100.Index == v98 then
                v101 = l_l_List_3_FirstChild_0 ~= nil;
            end;
        end;
        for _, v103 in ipairs(l_List_3:GetChildren()) do
            if v103:IsA("Frame") and v103.Name ~= "Template" then
                local v104 = false;
                if v103 == l_l_List_3_FirstChild_0 then
                    v104 = v101;
                end;
                if v103 then
                    local l_v103_FirstChild_0 = v103:FindFirstChild("Selected", true);
                    if l_v103_FirstChild_0 then
                        l_v103_FirstChild_0.Visible = v104 and true or false;
                    end;
                end;
            end;
        end;
        return;
    end;
end;
setupRebirthButtons = function() --[[ Line: 389 ]] --[[ Name: setupRebirthButtons ]]
    -- upvalues: v14 (ref), v9 (copy), v7 (copy), v10 (copy), v6 (copy), v4 (copy), v5 (copy), v81 (copy), v11 (copy), v106 (copy)
    local l_List_4 = v14.Categories.RebirthButtons.Inner.List;
    local l_Template_2 = l_List_4.Template;
    l_List_4.CanvasSize = UDim2.fromScale(0, v9.RebirthButtons.Total / 3.5);
    local v109 = v7.Loaded and v7.Data.GemShop.RebirthButtons or 0;
    for v110 = 1, v9.RebirthButtons.Total do
        local v111 = l_Template_2:Clone();
        v111.Name = v110;
        v111.LayoutOrder = v110;
        local v112 = v10:fromIndex(v110 + 3);
        v111.Title.Text = v6:Adaptive(v112, 1000000) .. " Rebirths Button";
        local l_RebirthButtons_1 = v9.RebirthButtons;
        local v114 = if l_RebirthButtons_1.Function then math.round(l_RebirthButtons_1.Function(v110) * l_RebirthButtons_1.Price / 10) * 10 else l_RebirthButtons_1.Price * v110;
        v111.Price.Text = v6:Adaptive(v114);
        v111.Parent = l_List_4;
        v111.Upgrade.Button.Activated:Connect(function() --[[ Line: 413 ]]
            -- upvalues: v7 (ref), v4 (ref), v10 (ref), v5 (ref)
            local v115 = v7.Loaded and v7.Data.GemShop.RebirthButtons or 0;
            if v4:InvokeServer("UpgradeGemShop", "RebirthButtons", nil) then
                _G:Play("QuestReward", 1.1);
                _G:Play("Shine", 0.9, 0.8);
                local v116 = v115 + 1;
                local v117 = "Rebirth Buttons upgraded! (" .. v10:fromIndex(v116 + 3) .. " Rebirths)";
                local v118 = Color3.fromRGB(255, 200, 100);
                v5.Fire("Notification", v117, v118, nil, 3);
                refreshRebirthButtons();
                return;
            else
                _G:Play("Broke");
                print("asdasdasd");
                return;
            end;
        end);
        v5.Fire("InitButton", v111.Upgrade.Button);
        v111.UpgradeLocked.Button.Activated:Connect(function() --[[ Line: 440 ]]
            -- upvalues: v7 (ref), v110 (copy), v9 (ref), v6 (ref), v5 (ref)
            _G:Play("Broke");
            local v119 = v7.Loaded and v7.Data.GemShop.RebirthButtons or 0;
            local v120 = v110 == v119 + 1;
            local v121 = nil;
            if v120 then
                local l_v110_0 = v110;
                local l_RebirthButtons_2 = v9.RebirthButtons;
                local v124 = if l_RebirthButtons_2.Function then math.round(l_RebirthButtons_2.Function(l_v110_0) * l_RebirthButtons_2.Price / 10) * 10 else l_RebirthButtons_2.Price * l_v110_0;
                v121 = "Not enough gems! Need " .. v6:Abbreviate(v124, false, true) .. " gems.";
            else
                v121 = "Purchase previous rebirth button first!";
            end;
            v5.Fire("Notification", v121, Color3.fromRGB(255, 100, 100), nil, 3);
        end);
        v5.Fire("InitButton", v111.UpgradeLocked.Button);
        l_RebirthButtons_1 = v81(v110, "Main");
        local v125 = v110 == v109 + 1;
        local v126 = v110 <= v109;
        local v127 = v7.Loaded and v7.Data.Portals[l_RebirthButtons_1] or l_RebirthButtons_1 == "Spawn";
        local v128 = v7.Loaded and v114 <= v7.Data.Statistics.Gems or false;
        if v127 and v125 then
            local _ = v128;
        end;
        if v127 then
            v111.IslandLock.Visible = false;
            if v126 then
                v111.Upgrade.Visible = false;
                v111.UpgradeLocked.Visible = false;
                v111.Unlocked.Visible = true;
            elseif v125 then
                if v128 then
                    v111.Upgrade.Visible = true;
                    v111.UpgradeLocked.Visible = false;
                else
                    v111.Upgrade.Visible = false;
                    v111.UpgradeLocked.Visible = true;
                end;
                v111.Unlocked.Visible = false;
            else
                v111.Upgrade.Visible = false;
                v111.UpgradeLocked.Visible = true;
                v111.Unlocked.Visible = false;
            end;
        else
            v111.IslandLock.Visible = true;
            v111.IslandLock.Title.Text = "Unlock " .. l_RebirthButtons_1 .. " Island for more rebirth buttons!";
            v111.IslandLock.Icon.Image = v11[l_RebirthButtons_1].Image;
            v111.Upgrade.Visible = false;
            v111.UpgradeLocked.Visible = false;
            v111.Unlocked.Visible = false;
        end;
    end;
    l_Template_2.Visible = false;
    v106();
end;
refreshRebirthButtons = function() --[[ Line: 509 ]] --[[ Name: refreshRebirthButtons ]]
    -- upvalues: v14 (ref), v7 (copy), v81 (copy), v9 (copy), v11 (copy), v106 (copy)
    local v130 = false;
    local l_List_5 = v14.Categories.RebirthButtons.Inner.List;
    local v132 = v7.Loaded and v7.Data.GemShop.RebirthButtons or 0;
    for _, v134 in pairs(l_List_5:GetChildren()) do
        if v134:IsA("Frame") and v134.Name ~= "Template" then
            local v135 = tonumber(v134.Name);
            if v135 then
                local v136 = v81(v135, "Main");
                local v137 = v135 == v132 + 1;
                local v138 = v135 <= v132;
                local v139 = v7.Loaded and v7.Data.Portals[v136] or v136 == "Spawn";
                local v140;
                if v7.Loaded then
                    v140 = true;
                    local l_Gems_0 = v7.Data.Statistics.Gems;
                    local l_RebirthButtons_3 = v9.RebirthButtons;
                    v130 = (if l_RebirthButtons_3.Function then math.round(l_RebirthButtons_3.Function(v135) * l_RebirthButtons_3.Price / 10) * 10 else l_RebirthButtons_3.Price * v135) <= l_Gems_0;
                end;
                if not v130 then
                    v140 = false;
                end;
                v130 = false;
                if v139 then
                    v134.IslandLock.Visible = false;
                    if v138 then
                        v134.Upgrade.Visible = false;
                        v134.UpgradeLocked.Visible = false;
                        v134.Unlocked.Visible = true;
                    elseif v137 then
                        if v140 then
                            v134.Upgrade.Visible = true;
                            v134.UpgradeLocked.Visible = false;
                        else
                            v134.Upgrade.Visible = false;
                            v134.UpgradeLocked.Visible = true;
                        end;
                        v134.Unlocked.Visible = false;
                    else
                        v134.Upgrade.Visible = false;
                        v134.UpgradeLocked.Visible = true;
                        v134.Unlocked.Visible = false;
                    end;
                else
                    v134.IslandLock.Visible = true;
                    v134.IslandLock.Title.Text = "Unlock " .. v136 .. " for more rebirth buttons!";
                    v134.IslandLock.Icon.Image = v11[v136].Image;
                    v134.Upgrade.Visible = false;
                    v134.UpgradeLocked.Visible = false;
                    v134.Unlocked.Visible = false;
                end;
            end;
        end;
    end;
    v106();
end;
clearRebirthButtons = function() --[[ Line: 566 ]] --[[ Name: clearRebirthButtons ]]
    -- upvalues: v14 (ref)
    local l_List_6 = v14.Categories.RebirthButtons.Inner.List;
    local l_Template_3 = l_List_6.Template;
    for _, v146 in pairs(l_List_6:GetChildren()) do
        if v146:IsA("Frame") and v146.Name ~= "Template" then
            v146:Destroy();
        end;
    end;
    l_Template_3.Visible = true;
end;
v16.HasAffordableRebirthButton = function(_) --[[ Line: 582 ]] --[[ Name: HasAffordableRebirthButton ]]
    -- upvalues: v95 (copy)
    local v148 = v95();
    if not v148 then
        return false;
    else
        return true, v148;
    end;
end;
v16.Init = function(_, v150, v151) --[[ Line: 592 ]] --[[ Name: Init ]]
    -- upvalues: v13 (ref), v14 (ref), v7 (copy), l_Players_0 (copy), v16 (copy), v6 (copy), v26 (copy), v5 (copy)
    v13 = v150;
    v14 = v151;
    v7:Connect("DataLoaded", function() --[[ Line: 597 ]]
        clearDoubleJumps();
        setupDoubleJumps();
        clearRebirthButtons();
        setupRebirthButtons();
    end);
    local l_List_7 = l_Players_0.LocalPlayer.PlayerGui.RightHud.Main.RightUI.Rebirths.List;
    v7:Connect("Statistics", function() --[[ Line: 606 ]]
        -- upvalues: v16 (ref), l_List_7 (copy), v14 (ref), v6 (ref), v7 (ref)
        refreshDoubleJumps();
        refreshRebirthButtons();
        if v16:HasAffordableRebirthButton() then
            l_List_7.BuyMoreButtons.Visible = true;
        else
            l_List_7.BuyMoreButtons.Visible = false;
        end;
        v14.Tabs.Gems.Amount.Text = v6:Abbreviate(v7.Data.Statistics.Gems, true);
    end);
    v7:Connect("GemShop", function() --[[ Line: 620 ]]
        refreshRebirthButtons();
    end);
    v13:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 625 ]]
        -- upvalues: v13 (ref), v14 (ref), v7 (ref), v26 (ref)
        if v13.Enabled == true then
            if (v14.Categories.Jumps:GetAttribute("World") or "Main") ~= (v7.Loaded and v7.Data.World or "Main") then
                clearDoubleJumps();
                setupDoubleJumps();
            else
                refreshDoubleJumps();
            end;
            for _, v154 in ipairs(v14.Categories:GetChildren()) do
                if v154:IsA("Frame") and v154.Visible then
                    v26(v154.Name);
                    return;
                end;
            end;
        end;
    end);
    for _, v156 in ipairs(v14.Tabs:GetChildren()) do
        if v156:IsA("Frame") and v156:FindFirstChild("Button") then
            v156.Button.Activated:Connect(function() --[[ Line: 654 ]]
                -- upvalues: v156 (copy), v5 (ref), v14 (ref), v26 (ref)
                if v156.Name == "Upgrades" then
                    v5.Fire("OpenMenu", "Upgrades");
                    return;
                else
                    if v14.Categories:FindFirstChild(v156.Name) then
                        for _, v158 in ipairs(v14.Categories:GetChildren()) do
                            if v158:IsA("Frame") then
                                v158.Visible = v158.Name == v156.Name;
                            end;
                        end;
                        for _, v160 in pairs(v14.Tabs:GetChildren()) do
                            if v160:IsA("Frame") and v160:FindFirstChild("Button") then
                                v160.Shadow.Visible = true;
                                v160.Main.Title.TextColor3 = Color3.new(0.06666666666666667, 0.06666666666666667, 0.06666666666666667);
                                v160.Main.Title.UIStroke.Enabled = false;
                            end;
                        end;
                        v156.Shadow.Visible = false;
                        v156.Main.Title.TextColor3 = Color3.new(1, 1, 1);
                        v156.Main.Title.UIStroke.Enabled = true;
                        v26(v156.Name);
                        v5.Fire("OpenMenu", "Upgrades2");
                    end;
                    return;
                end;
            end);
            v5.Fire("InitButton", v156.Button);
        end;
    end;
    v5.new("OpenUpgradeMenu"):Connect(function(v161) --[[ Line: 688 ]]
        -- upvalues: v5 (ref), v26 (ref)
        if v161 == "Upgrades" then
            v5.Fire("OpenMenu", "Upgrades");
            return;
        else
            v5.Fire("OpenMenu", "Upgrades2");
            v26(v161);
            return;
        end;
    end);
end;
return v16;