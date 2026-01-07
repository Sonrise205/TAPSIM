local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local _ = require(l_ReplicatedStorage_0.Modules.Tweens);
local v4 = require(l_ReplicatedStorage_0.Modules.Network);
local v5 = require(l_ReplicatedStorage_0.Modules.Signal);
local v6 = require(l_ReplicatedStorage_0.Modules.Short);
local v7 = require(l_ReplicatedStorage_0.Game.Replication);
local v8 = require(l_ReplicatedStorage_0.Game.IslandUpgrades);
local _ = require(l_ReplicatedStorage_0.Game.Portals);
local _ = l_Players_0.LocalPlayer;
local v11 = nil;
local v12 = nil;
local _ = nil;
local v14 = nil;
local v15 = nil;
local v16 = {};
local v17 = false;
local function _(v18, v19) --[[ Line: 25 ]] --[[ Name: getPrice ]]
    -- upvalues: v8 (copy)
    return v8.GetPrice(v18, v19);
end;
local function _(v21, v22) --[[ Line: 29 ]] --[[ Name: getCurrentLevel ]]
    -- upvalues: v7 (copy)
    if not v7.Loaded or not v7.Data.IslandUpgrades then
        return 0;
    else
        local v23 = v7.Data.IslandUpgrades[v22];
        if not v23 then
            return 0;
        else
            return v23[v21] or 0;
        end;
    end;
end;
local function _(v25, v26) --[[ Line: 40 ]] --[[ Name: getBonusText ]]
    -- upvalues: v8 (copy)
    return v8.GetBonusText(v25, v26);
end;
local v28 = {};
local v29 = {};
local function _(v30) --[[ Line: 50 ]] --[[ Name: formatTime ]]
    -- upvalues: v8 (copy)
    return v8.FormatTime((math.floor(v30)));
end;
local function _(v32) --[[ Line: 55 ]] --[[ Name: fetchGoldenMachineStatus ]]
    -- upvalues: v4 (copy), v28 (copy)
    local v33, v34 = v4:InvokeServer("GetGoldenMachineStatus", v32);
    v28[v32] = {
        isActive = v33, 
        remaining = v34, 
        lastFetch = tick()
    };
    return v33, v34;
end;
local function _(v36) --[[ Line: 66 ]] --[[ Name: fetchRainbowMachineStatus ]]
    -- upvalues: v4 (copy), v29 (copy)
    local v37, v38 = v4:InvokeServer("GetRainbowMachineStatus", v36);
    v29[v36] = {
        isActive = v37, 
        remaining = v38, 
        lastFetch = tick()
    };
    return v37, v38;
end;
local function _(v40) --[[ Line: 77 ]] --[[ Name: getGoldenMachineStatus ]]
    -- upvalues: v28 (copy)
    local v41 = v28[v40];
    if not v41 then
        return false, 0;
    else
        local v42 = tick() - v41.lastFetch;
        local v43 = math.max(0, v41.remaining - v42);
        if v43 <= 0 then
            v41.isActive = false;
        end;
        return v41.isActive, v43;
    end;
end;
local function _(v45) --[[ Line: 96 ]] --[[ Name: getRainbowMachineStatus ]]
    -- upvalues: v29 (copy)
    local v46 = v29[v45];
    if not v46 then
        return false, 0;
    else
        local v47 = tick() - v46.lastFetch;
        local v48 = math.max(0, v46.remaining - v47);
        if v48 <= 0 then
            v46.isActive = false;
        end;
        return v46.isActive, v48;
    end;
end;
local function v67(v50, v51) --[[ Line: 114 ]] --[[ Name: updateMeepoFrame ]]
    -- upvalues: v8 (copy), v28 (copy), v6 (copy)
    if not v50 or not v51 then
        return;
    else
        local l_GoldenMachine_0 = v8.GoldenMachine;
        if not l_GoldenMachine_0 then
            return;
        else
            local v53 = v28[v51];
            local v54, v55;
            if not v53 then
                v54 = false;
                v55 = 0;
            else
                local v56 = tick() - v53.lastFetch;
                local v57 = math.max(0, v53.remaining - v56);
                if v57 <= 0 then
                    v53.isActive = false;
                end;
                v54 = v53.isActive;
                v55 = v57;
            end;
            v53 = v50:FindFirstChild("Time");
            if v53 then
                local l_Label_0 = v53:FindFirstChild("Label");
                if l_Label_0 then
                    if v54 then
                        l_Label_0.Text = v8.FormatTime((math.floor(v55)));
                        if v55 <= 60 then
                            l_Label_0.TextColor3 = Color3.fromRGB(255, 0, 0);
                        elseif v55 <= 300 then
                            l_Label_0.TextColor3 = Color3.fromRGB(255, 165, 0);
                        else
                            l_Label_0.TextColor3 = Color3.fromRGB(255, 200, 0);
                        end;
                    else
                        l_Label_0.Text = "Lasts 15 Minutes";
                        l_Label_0.TextColor3 = Color3.fromRGB(0, 255, 0);
                    end;
                end;
            end;
            local l_Upgrade_0 = v50:FindFirstChild("Upgrade");
            if l_Upgrade_0 then
                local l_Main_0 = l_Upgrade_0:FindFirstChild("Main");
                if l_Main_0 then
                    local l_Currency_0 = l_Main_0:FindFirstChild("Currency");
                    if l_Currency_0 then
                        local l_Amount_0 = l_Currency_0:FindFirstChild("Amount");
                        if l_Amount_0 then
                            local v63 = l_GoldenMachine_0.BasePrice or 5000;
                            l_Amount_0.Text = v6:Abbreviate(v63, false, true);
                        end;
                        local l_Icon_0 = l_Currency_0:FindFirstChild("Icon");
                        if l_Icon_0 then
                            local l_Gems_0 = l_Icon_0:FindFirstChild("Gems");
                            local l_Clicks_0 = l_Icon_0:FindFirstChild("Clicks");
                            if l_Gems_0 then
                                l_Gems_0.Visible = not v54;
                            end;
                            if l_Clicks_0 then
                                l_Clicks_0.Visible = false;
                            end;
                        end;
                    end;
                    if v54 then
                        l_Main_0.BackgroundTransparency = 0.5;
                    else
                        l_Main_0.BackgroundTransparency = 0;
                    end;
                end;
                l_Upgrade_0.Visible = not v54;
            end;
            return;
        end;
    end;
end;
local function v85(v68, v69) --[[ Line: 182 ]] --[[ Name: updateDeemoFrame ]]
    -- upvalues: v8 (copy), v29 (copy), v6 (copy)
    if not v68 or not v69 then
        return;
    else
        local l_RainbowMachine_0 = v8.RainbowMachine;
        if not l_RainbowMachine_0 then
            return;
        else
            local v71 = v29[v69];
            local v72, v73;
            if not v71 then
                v72 = false;
                v73 = 0;
            else
                local v74 = tick() - v71.lastFetch;
                local v75 = math.max(0, v71.remaining - v74);
                if v75 <= 0 then
                    v71.isActive = false;
                end;
                v72 = v71.isActive;
                v73 = v75;
            end;
            v71 = v68:FindFirstChild("Time");
            if v71 then
                local l_Label_1 = v71:FindFirstChild("Label");
                if l_Label_1 then
                    if v72 then
                        l_Label_1.Text = v8.FormatTime((math.floor(v73)));
                        if v73 <= 60 then
                            l_Label_1.TextColor3 = Color3.fromRGB(255, 0, 0);
                        elseif v73 <= 300 then
                            l_Label_1.TextColor3 = Color3.fromRGB(255, 165, 0);
                        else
                            l_Label_1.TextColor3 = Color3.fromRGB(255, 100, 255);
                        end;
                    else
                        l_Label_1.Text = "Lasts 30 Minutes";
                        l_Label_1.TextColor3 = Color3.fromRGB(0, 255, 0);
                    end;
                end;
            end;
            local l_Upgrade_1 = v68:FindFirstChild("Upgrade");
            if l_Upgrade_1 then
                local l_Main_1 = l_Upgrade_1:FindFirstChild("Main");
                if l_Main_1 then
                    local l_Currency_1 = l_Main_1:FindFirstChild("Currency");
                    if l_Currency_1 then
                        local l_Amount_1 = l_Currency_1:FindFirstChild("Amount");
                        if l_Amount_1 then
                            local v81 = l_RainbowMachine_0.BasePrice or 10000;
                            l_Amount_1.Text = v6:Abbreviate(v81, false, true);
                        end;
                        local l_Icon_1 = l_Currency_1:FindFirstChild("Icon");
                        if l_Icon_1 then
                            local l_Gems_1 = l_Icon_1:FindFirstChild("Gems");
                            local l_Clicks_1 = l_Icon_1:FindFirstChild("Clicks");
                            if l_Gems_1 then
                                l_Gems_1.Visible = not v72;
                            end;
                            if l_Clicks_1 then
                                l_Clicks_1.Visible = false;
                            end;
                        end;
                    end;
                    if v72 then
                        l_Main_1.BackgroundTransparency = 0.5;
                    else
                        l_Main_1.BackgroundTransparency = 0;
                    end;
                end;
                l_Upgrade_1.Visible = not v72;
            end;
            return;
        end;
    end;
end;
local function v92() --[[ Line: 249 ]] --[[ Name: startMachineTimerLoop ]]
    -- upvalues: v15 (ref), v14 (ref), v4 (copy), v28 (copy), v29 (copy), l_RunService_0 (copy), v12 (ref), v67 (copy), v85 (copy)
    if v15 then
        v15:Disconnect();
        v15 = nil;
    end;
    if v14 then
        local l_v14_0 = v14;
        local v87, v88 = v4:InvokeServer("GetGoldenMachineStatus", l_v14_0);
        v28[l_v14_0] = {
            isActive = v87, 
            remaining = v88, 
            lastFetch = tick()
        };
        l_v14_0 = v14;
        v87, v88 = v4:InvokeServer("GetRainbowMachineStatus", l_v14_0);
        v29[l_v14_0] = {
            isActive = v87, 
            remaining = v88, 
            lastFetch = tick()
        };
    end;
    v15 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 263 ]]
        -- upvalues: v12 (ref), v14 (ref), v67 (ref), v85 (ref)
        if not v12 or not v14 then
            return;
        else
            local v89 = v12.Frame and v12.Frame:FindFirstChild("ScrollingFrame");
            if not v89 then
                return;
            else
                local l_Meepo_0 = v89:FindFirstChild("Meepo");
                if l_Meepo_0 then
                    v67(l_Meepo_0, v14);
                end;
                local l_Deemo_0 = v89:FindFirstChild("Deemo");
                if l_Deemo_0 then
                    v85(l_Deemo_0, v14);
                end;
                return;
            end;
        end;
    end);
end;
local function _() --[[ Line: 283 ]] --[[ Name: stopMachineTimerLoop ]]
    -- upvalues: v15 (ref)
    if v15 then
        v15:Disconnect();
        v15 = nil;
    end;
end;
local function v109(v94) --[[ Line: 290 ]] --[[ Name: handleGoldenMachinePurchase ]]
    -- upvalues: v17 (ref), v28 (copy), v5 (copy), v8 (copy), v7 (copy), v6 (copy), v4 (copy)
    if v17 then
        return;
    else
        v17 = true;
        local v95 = v28[v94];
        local v96, v97;
        if not v95 then
            v96 = false;
            v97 = 0;
        else
            local v98 = tick() - v95.lastFetch;
            local v99 = math.max(0, v95.remaining - v98);
            if v99 <= 0 then
                v95.isActive = false;
            end;
            v96 = v95.isActive;
            v97 = v99;
        end;
        if v96 and v97 > 0 then
            _G:Play("Broke");
            v5.Fire("Notification", "Golden Machine already active! " .. v8.FormatTime((math.floor(v97))) .. " remaining", Color3.fromRGB(255, 165, 0), nil, 3);
            v17 = false;
            return;
        else
            v95 = v8.GoldenMachine;
            local v100 = v95 and v95.BasePrice or 5000;
            if (v7.Loaded and v7.Data.Statistics.Gems or 0) < v100 then
                _G:Play("Broke");
                v5.Fire("Notification", "Not enough gems! Need " .. v6:Abbreviate(v100, false, true), Color3.fromRGB(255, 100, 100), nil, 3);
                v17 = false;
                return;
            else
                local v101, v102, v103 = v4:InvokeServer("PurchaseGoldenMachine", v94);
                if v101 then
                    _G:Play("QuestReward", 1.1);
                    _G:Play("Shine", 0.9, 0.8);
                    v5.Fire("Notification", "Golden Machine spawned! Lasts 15 minutes.", Color3.fromRGB(255, 200, 0), nil, 3);
                    local v104 = v95 and v95.SpawnDuration or 900;
                    v28[v94] = {
                        isActive = true, 
                        remaining = v104, 
                        lastFetch = tick()
                    };
                else
                    _G:Play("Broke");
                    if v102 == "Already active" then
                        local l_Fire_0 = v5.Fire;
                        local v106 = "Notification";
                        local v107 = "Golden Machine already active! ";
                        local v108 = v103 or 0;
                        l_Fire_0(v106, v107 .. v8.FormatTime((math.floor(v108))) .. " remaining", Color3.fromRGB(255, 165, 0), nil, 3);
                        v28[v94] = {
                            isActive = true, 
                            remaining = v103 or 0, 
                            lastFetch = tick()
                        };
                    else
                        v5.Fire("Notification", "Failed to spawn Golden Machine!", Color3.fromRGB(255, 100, 100), nil, 3);
                    end;
                end;
                task.delay(0.5, function() --[[ Line: 346 ]]
                    -- upvalues: v17 (ref)
                    v17 = false;
                end);
                return;
            end;
        end;
    end;
end;
local function v125(v110) --[[ Line: 351 ]] --[[ Name: handleRainbowMachinePurchase ]]
    -- upvalues: v17 (ref), v29 (copy), v5 (copy), v8 (copy), v7 (copy), v6 (copy), v4 (copy)
    if v17 then
        return;
    else
        v17 = true;
        local v111 = v29[v110];
        local v112, v113;
        if not v111 then
            v112 = false;
            v113 = 0;
        else
            local v114 = tick() - v111.lastFetch;
            local v115 = math.max(0, v111.remaining - v114);
            if v115 <= 0 then
                v111.isActive = false;
            end;
            v112 = v111.isActive;
            v113 = v115;
        end;
        if v112 and v113 > 0 then
            _G:Play("Broke");
            v5.Fire("Notification", "Rainbow Machine already active! " .. v8.FormatTime((math.floor(v113))) .. " remaining", Color3.fromRGB(255, 100, 255), nil, 3);
            v17 = false;
            return;
        else
            v111 = v8.RainbowMachine;
            local v116 = v111 and v111.BasePrice or 10000;
            if (v7.Loaded and v7.Data.Statistics.Gems or 0) < v116 then
                _G:Play("Broke");
                v5.Fire("Notification", "Not enough gems! Need " .. v6:Abbreviate(v116, false, true), Color3.fromRGB(255, 100, 100), nil, 3);
                v17 = false;
                return;
            else
                local v117, v118, v119 = v4:InvokeServer("PurchaseRainbowMachine", v110);
                if v117 then
                    _G:Play("QuestReward", 1.1);
                    _G:Play("Shine", 0.9, 0.8);
                    v5.Fire("Notification", "Rainbow Machine spawned! Lasts 30 minutes.", Color3.fromRGB(255, 100, 255), nil, 3);
                    local v120 = v111 and v111.SpawnDuration or 1800;
                    v29[v110] = {
                        isActive = true, 
                        remaining = v120, 
                        lastFetch = tick()
                    };
                else
                    _G:Play("Broke");
                    if v118 == "Already active" then
                        local l_Fire_1 = v5.Fire;
                        local v122 = "Notification";
                        local v123 = "Rainbow Machine already active! ";
                        local v124 = v119 or 0;
                        l_Fire_1(v122, v123 .. v8.FormatTime((math.floor(v124))) .. " remaining", Color3.fromRGB(255, 100, 255), nil, 3);
                        v29[v110] = {
                            isActive = true, 
                            remaining = v119 or 0, 
                            lastFetch = tick()
                        };
                    else
                        v5.Fire("Notification", "Failed to spawn Rainbow Machine!", Color3.fromRGB(255, 100, 100), nil, 3);
                    end;
                end;
                task.delay(0.5, function() --[[ Line: 407 ]]
                    -- upvalues: v17 (ref)
                    v17 = false;
                end);
                return;
            end;
        end;
    end;
end;
local function v152(v126, v127, v128, v129) --[[ Line: 413 ]] --[[ Name: setupUpgradeFrame ]]
    -- upvalues: v7 (copy), v8 (copy), v6 (copy)
    local v130;
    if not v7.Loaded or not v7.Data.IslandUpgrades then
        v130 = 0;
    else
        local v131 = v7.Data.IslandUpgrades[v129];
        v130 = not v131 and 0 or v131[v127] or 0;
    end;
    local v132 = v128.Total or 10;
    local v133 = v130 + 1;
    local l_Label_2 = v126:FindFirstChild("Label");
    if l_Label_2 and l_Label_2:IsA("TextLabel") then
        l_Label_2.Text = v128.Title or v127;
        local l_Label_3 = l_Label_2:FindFirstChild("Label");
        if l_Label_3 then
            l_Label_3.Text = v128.Title or v127;
        end;
    end;
    for _, v137 in ipairs(v126:GetChildren()) do
        if v137:IsA("TextLabel") and v137.Name == "Label" and v137 ~= l_Label_2 then
            v137.Text = v130 .. "/" .. v132;
            local l_Label_4 = v137:FindFirstChild("Label");
            if l_Label_4 then
                l_Label_4.Text = v130 .. "/" .. v132;
                break;
            else
                break;
            end;
        end;
    end;
    local l_ImageLabel_0 = v126:FindFirstChild("ImageLabel");
    if l_ImageLabel_0 and v128.Image then
        l_ImageLabel_0.Image = v128.Image;
    end;
    local l_Frame_0 = v126:FindFirstChild("Frame");
    if l_Frame_0 then
        local l_Label_5 = l_Frame_0:FindFirstChild("Label");
        if l_Label_5 then
            local l_Label_6 = l_Label_5:FindFirstChild("Label");
            if l_Label_6 then
                l_Label_6.Text = v8.GetBonusText(v127, v130);
                l_Label_6.RichText = true;
            end;
        end;
    end;
    local l_Upgrade_2 = v126:FindFirstChild("Upgrade");
    if l_Upgrade_2 then
        local l_Main_2 = l_Upgrade_2:FindFirstChild("Main");
        if l_Main_2 then
            local l_Currency_2 = l_Main_2:FindFirstChild("Currency");
            if l_Currency_2 then
                local l_Amount_2 = l_Currency_2:FindFirstChild("Amount");
                if l_Amount_2 then
                    if v132 <= v130 then
                        l_Amount_2.Text = "MAX";
                    else
                        local v147 = v8.GetPrice(v127, v133);
                        l_Amount_2.Text = v6:Abbreviate(v147, false, true);
                    end;
                end;
                local l_Icon_2 = l_Currency_2:FindFirstChild("Icon");
                if l_Icon_2 then
                    local l_Gems_2 = l_Icon_2:FindFirstChild("Gems");
                    local l_Clicks_2 = l_Icon_2:FindFirstChild("Clicks");
                    if l_Gems_2 then
                        l_Gems_2.Visible = true;
                    end;
                    if l_Clicks_2 then
                        l_Clicks_2.Visible = false;
                    end;
                end;
            end;
        end;
        local l_Button_0 = l_Upgrade_2:FindFirstChild("Button");
        if l_Button_0 then
            l_Button_0:SetAttribute("UpgradeName", v127);
            l_Button_0:SetAttribute("IslandName", v129);
        end;
    end;
    return v126;
end;
local function v161() --[[ Line: 502 ]] --[[ Name: refreshUpgrades ]]
    -- upvalues: v14 (ref), v12 (ref), v8 (copy), v152 (copy), v67 (copy), v85 (copy)
    if not v14 or not v12 then
        return;
    else
        local l_Frame_1 = v12.Frame;
        if not l_Frame_1 then
            return;
        else
            local l_ScrollingFrame_0 = l_Frame_1:FindFirstChild("ScrollingFrame");
            if l_ScrollingFrame_0 then
                local l_IslandBoost_0 = l_ScrollingFrame_0:FindFirstChild("IslandBoost");
                if l_IslandBoost_0 then
                    local v156 = l_IslandBoost_0:GetAttribute("UpgradeName") or "IslandBoost";
                    if v8[v156] then
                        v152(l_IslandBoost_0, v156, v8[v156], v14);
                    end;
                end;
                local l_IslandLuck_0 = l_ScrollingFrame_0:FindFirstChild("IslandLuck");
                if l_IslandLuck_0 then
                    local v158 = l_IslandLuck_0:GetAttribute("UpgradeName") or "IslandLuck";
                    if v8[v158] then
                        v152(l_IslandLuck_0, v158, v8[v158], v14);
                    end;
                end;
                local l_Meepo_1 = l_ScrollingFrame_0:FindFirstChild("Meepo");
                if l_Meepo_1 then
                    v67(l_Meepo_1, v14);
                end;
                local l_Deemo_1 = l_ScrollingFrame_0:FindFirstChild("Deemo");
                if l_Deemo_1 then
                    v85(l_Deemo_1, v14);
                end;
            end;
            return;
        end;
    end;
end;
local function v172(v162) --[[ Line: 542 ]] --[[ Name: setupAllUpgrades ]]
    -- upvalues: v12 (ref), v14 (ref), v8 (copy), v152 (copy), v67 (copy), v85 (copy), v92 (copy)
    if not v12 then
        return;
    else
        v14 = v162;
        local l_Label_7 = v12:FindFirstChild("Label");
        if l_Label_7 then
            local v164 = v162 .. " Island Upgrades";
            l_Label_7.Text = v164;
            local l_Label_8 = l_Label_7:FindFirstChild("Label");
            if l_Label_8 then
                l_Label_8.Text = v164;
            end;
            l_Label_7.Label1.Text = v164;
        end;
        local l_Frame_2 = v12.Frame;
        if not l_Frame_2 then
            return;
        else
            local l_ScrollingFrame_1 = l_Frame_2:FindFirstChild("ScrollingFrame");
            if l_ScrollingFrame_1 then
                local l_IslandBoost_1 = l_ScrollingFrame_1:FindFirstChild("IslandBoost");
                if l_IslandBoost_1 and v8.IslandBoost then
                    l_IslandBoost_1:SetAttribute("UpgradeName", "IslandBoost");
                    v152(l_IslandBoost_1, "IslandBoost", v8.IslandBoost, v162);
                end;
                local l_IslandLuck_1 = l_ScrollingFrame_1:FindFirstChild("IslandLuck");
                if l_IslandLuck_1 and v8.IslandLuck then
                    l_IslandLuck_1:SetAttribute("UpgradeName", "IslandLuck");
                    v152(l_IslandLuck_1, "IslandLuck", v8.IslandLuck, v162);
                end;
                local l_Meepo_2 = l_ScrollingFrame_1:FindFirstChild("Meepo");
                if l_Meepo_2 and v8.GoldenMachine then
                    l_Meepo_2:SetAttribute("UpgradeName", "GoldenMachine");
                    l_Meepo_2.Visible = true;
                    v67(l_Meepo_2, v162);
                end;
                local l_Deemo_2 = l_ScrollingFrame_1:FindFirstChild("Deemo");
                if l_Deemo_2 and v8.RainbowMachine then
                    l_Deemo_2:SetAttribute("UpgradeName", "RainbowMachine");
                    l_Deemo_2.Visible = true;
                    v85(l_Deemo_2, v162);
                end;
            end;
            v92();
            return;
        end;
    end;
end;
local function v182(v173, v174) --[[ Line: 603 ]] --[[ Name: handlePurchase ]]
    -- upvalues: v17 (ref), v8 (copy), v7 (copy), v5 (copy), v6 (copy), v4 (copy), v161 (copy)
    if v17 then
        return;
    else
        v17 = true;
        local v175 = v8[v173];
        if not v175 then
            v17 = false;
            return;
        else
            local v176;
            if not v7.Loaded or not v7.Data.IslandUpgrades then
                v176 = 0;
            else
                local v177 = v7.Data.IslandUpgrades[v174];
                v176 = not v177 and 0 or v177[v173] or 0;
            end;
            if (v175.Total or 10) <= v176 then
                _G:Play("Broke");
                v5.Fire("Notification", "Already at max level!", Color3.fromRGB(255, 100, 100), nil, 3);
                v17 = false;
                return;
            else
                local v178 = v176 + 1;
                local v179 = v8.GetPrice(v173, v178);
                if (v7.Loaded and v7.Data.Statistics.Gems or 0) < v179 then
                    _G:Play("Broke");
                    v5.Fire("Notification", "Not enough gems! Need " .. v6:Abbreviate(v179, false, true), Color3.fromRGB(255, 100, 100), nil, 3);
                    v17 = false;
                    return;
                else
                    if v4:InvokeServer("UpgradeIslandShop", v173, v174) then
                        _G:Play("QuestReward", 1.1);
                        _G:Play("Shine", 0.9, 0.8);
                        local v180 = v176 + 1;
                        local v181 = math.floor(v180 * (v175.BonusPerLevel or 0.1) * 100);
                        v5.Fire("Notification", v175.Title .. " upgraded to level " .. v180 .. "! (" .. v181 .. "% boost)", v175.Color or Color3.fromRGB(0, 200, 100), nil, 3);
                        v161();
                    else
                        _G:Play("Broke");
                        v5.Fire("Notification", "Failed to upgrade!", Color3.fromRGB(255, 100, 100), nil, 3);
                    end;
                    task.delay(0.3, function() --[[ Line: 651 ]]
                        -- upvalues: v17 (ref)
                        v17 = false;
                    end);
                    return;
                end;
            end;
        end;
    end;
end;
v16.Init = function(_, v184, v185, _) --[[ Line: 657 ]] --[[ Name: Init ]]
    -- upvalues: v11 (ref), v12 (ref), v15 (ref), v5 (copy), v14 (ref), v182 (copy), v109 (copy), v125 (copy), v7 (copy), v161 (copy), v4 (copy), v28 (copy), v29 (copy), v172 (copy)
    v11 = v184;
    v12 = v185;
    local l_Close_0 = v12:FindFirstChild("Close");
    if l_Close_0 then
        local l_Button_1 = l_Close_0:FindFirstChild("Button");
        if l_Button_1 then
            l_Button_1.Activated:Connect(function() --[[ Line: 666 ]]
                -- upvalues: v15 (ref), v5 (ref)
                if v15 then
                    v15:Disconnect();
                    v15 = nil;
                end;
                v5.Fire("CloseMenu", "Upgrades3");
            end);
            v5.Fire("InitButton", l_Button_1);
        end;
    end;
    local l_Frame_3 = v12.Frame;
    if l_Frame_3 then
        local l_ScrollingFrame_2 = l_Frame_3:FindFirstChild("ScrollingFrame");
        if l_ScrollingFrame_2 then
            local l_IslandBoost_2 = l_ScrollingFrame_2:FindFirstChild("IslandBoost");
            if l_IslandBoost_2 then
                local l_Upgrade_3 = l_IslandBoost_2:FindFirstChild("Upgrade");
                if l_Upgrade_3 then
                    local l_Button_2 = l_Upgrade_3:FindFirstChild("Button");
                    if l_Button_2 then
                        l_Button_2.Activated:Connect(function() --[[ Line: 687 ]]
                            -- upvalues: l_IslandBoost_2 (copy), v14 (ref), v182 (ref)
                            local v194 = l_IslandBoost_2:GetAttribute("UpgradeName") or "IslandBoost";
                            local l_v14_1 = v14;
                            if l_v14_1 then
                                v182(v194, l_v14_1);
                            end;
                        end);
                        v5.Fire("InitButton", l_Button_2);
                    end;
                end;
            end;
            local l_IslandLuck_2 = l_ScrollingFrame_2:FindFirstChild("IslandLuck");
            if l_IslandLuck_2 then
                local l_Upgrade_4 = l_IslandLuck_2:FindFirstChild("Upgrade");
                if l_Upgrade_4 then
                    local l_Button_3 = l_Upgrade_4:FindFirstChild("Button");
                    if l_Button_3 then
                        l_Button_3.Activated:Connect(function() --[[ Line: 706 ]]
                            -- upvalues: l_IslandLuck_2 (copy), v14 (ref), v182 (ref)
                            local v199 = l_IslandLuck_2:GetAttribute("UpgradeName") or "IslandLuck";
                            local l_v14_2 = v14;
                            if l_v14_2 then
                                v182(v199, l_v14_2);
                            end;
                        end);
                        v5.Fire("InitButton", l_Button_3);
                    end;
                end;
            end;
            local l_Meepo_3 = l_ScrollingFrame_2:FindFirstChild("Meepo");
            if l_Meepo_3 then
                local l_Upgrade_5 = l_Meepo_3:FindFirstChild("Upgrade");
                if l_Upgrade_5 then
                    local l_Button_4 = l_Upgrade_5:FindFirstChild("Button");
                    if l_Button_4 then
                        l_Button_4.Activated:Connect(function() --[[ Line: 725 ]]
                            -- upvalues: v14 (ref), v109 (ref)
                            local l_v14_3 = v14;
                            if l_v14_3 then
                                v109(l_v14_3);
                            end;
                        end);
                        v5.Fire("InitButton", l_Button_4);
                    end;
                end;
            end;
            local l_Deemo_3 = l_ScrollingFrame_2:FindFirstChild("Deemo");
            if l_Deemo_3 then
                local l_Upgrade_6 = l_Deemo_3:FindFirstChild("Upgrade");
                if l_Upgrade_6 then
                    local l_Button_5 = l_Upgrade_6:FindFirstChild("Button");
                    if l_Button_5 then
                        l_Button_5.Activated:Connect(function() --[[ Line: 743 ]]
                            -- upvalues: v14 (ref), v125 (ref)
                            local l_v14_4 = v14;
                            if l_v14_4 then
                                v125(l_v14_4);
                            end;
                        end);
                        v5.Fire("InitButton", l_Button_5);
                    end;
                end;
            end;
        end;
    end;
    v7:Connect("IslandUpgrades", function() --[[ Line: 757 ]]
        -- upvalues: v161 (ref)
        v161();
    end);
    v7:Connect("Statistics", function() --[[ Line: 761 ]]
        -- upvalues: v161 (ref)
        v161();
    end);
    v4:BindEvents({
        GoldenMachineSpawned = function(v209, v210, _) --[[ Line: 767 ]] --[[ Name: GoldenMachineSpawned ]]
            -- upvalues: v28 (ref)
            local v212 = v210 - os.time();
            v28[v209] = {
                isActive = true, 
                remaining = v212, 
                lastFetch = tick()
            };
        end, 
        GoldenMachineDespawned = function(v213) --[[ Line: 777 ]] --[[ Name: GoldenMachineDespawned ]]
            -- upvalues: v28 (ref)
            v28[v213] = {
                isActive = false, 
                remaining = 0, 
                lastFetch = tick()
            };
        end, 
        RainbowMachineSpawned = function(v214, v215, _) --[[ Line: 786 ]] --[[ Name: RainbowMachineSpawned ]]
            -- upvalues: v29 (ref)
            local v217 = v215 - os.time();
            v29[v214] = {
                isActive = true, 
                remaining = v217, 
                lastFetch = tick()
            };
        end, 
        RainbowMachineDespawned = function(v218) --[[ Line: 796 ]] --[[ Name: RainbowMachineDespawned ]]
            -- upvalues: v29 (ref)
            v29[v218] = {
                isActive = false, 
                remaining = 0, 
                lastFetch = tick()
            };
        end
    });
    v5.new("OpenIslandUpgrades"):Connect(function(v219) --[[ Line: 807 ]]
        -- upvalues: v172 (ref), v5 (ref)
        if not v219 then
            v219 = "Spawn";
        end;
        v172(v219);
        v5.Fire("OpenMenu", "Upgrades3");
    end);
    v5.new("CloseMenu"):Connect(function(v220) --[[ Line: 817 ]]
        -- upvalues: v15 (ref)
        if v220 == "Upgrades3" and v15 then
            v15:Disconnect();
            v15 = nil;
        end;
    end);
end;
return v16;