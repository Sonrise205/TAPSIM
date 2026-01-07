local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local v3 = require(l_ReplicatedStorage_0.Modules.Network);
local v4 = require(l_ReplicatedStorage_0.Modules.Signal);
local v5 = require(l_ReplicatedStorage_0.Modules.Short);
local v6 = require(l_ReplicatedStorage_0.Game.Replication);
local v7 = require(l_ReplicatedStorage_0.Game.PetFrames);
local v8 = require(l_ReplicatedStorage_0.Game.PetFrames.Info);
local v9 = require(l_ReplicatedStorage_0.Game.PetStats);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_PlayerGui_0 = l_LocalPlayer_0:WaitForChild("PlayerGui");
local l_Tabs_0 = l_PlayerGui_0:WaitForChild("Tabs");
local l_Trade_0 = l_Tabs_0:WaitForChild("Trade");
local l_Menu_0 = l_Trade_0:WaitForChild("Menu");
local l_TradeQuest_0 = l_Tabs_0:WaitForChild("TradeQuest");
local l_Menu_1 = l_TradeQuest_0:WaitForChild("Menu");
local l_Trading_0 = l_PlayerGui_0:WaitForChild("Trading");
local l_Trading_1 = l_Trading_0:WaitForChild("Trading");
local l_Processing_0 = l_Trading_0:WaitForChild("Processing");
local l_Other_0 = l_Trading_1:WaitForChild("Other");
local l_Inner_0 = l_Other_0:WaitForChild("Inner");
local l_List_0 = l_Inner_0:WaitForChild("List");
local l_UIGridLayout_0 = l_List_0:WaitForChild("UIGridLayout");
local l_Amount_0 = l_Other_0:WaitForChild("Tokens"):WaitForChild("Amount");
local l_Username_0 = l_Other_0:WaitForChild("Username");
local l_UIStroke_0 = l_Username_0:FindFirstChildWhichIsA("UIStroke");
local l_You_0 = l_Trading_1:WaitForChild("You");
local l_Inner_1 = l_You_0:WaitForChild("Inner");
local l_MainList_0 = l_Inner_1:WaitForChild("MainList");
local l_UIGridLayout_1 = l_MainList_0:WaitForChild("UIGridLayout");
local l_TextBox_0 = l_Inner_1:WaitForChild("Search"):WaitForChild("TextBox");
local l_TextBox_1 = l_You_0:WaitForChild("Tokens"):WaitForChild("TextBox");
local l_Actions_0 = l_You_0:WaitForChild("Actions");
local l_Ready_0 = l_Actions_0:WaitForChild("Ready");
local l_Button_0 = l_Ready_0:WaitForChild("Button");
local l_Main_0 = l_Ready_0:WaitForChild("Main");
local l_Title_0 = l_Main_0:WaitForChild("Title");
local l_UIStroke_1 = l_Main_0:FindFirstChildWhichIsA("UIStroke");
local l_Button_1 = l_Actions_0:WaitForChild("Close"):WaitForChild("Button");
local l_OtherPlayerHeadshot_0 = l_Trading_1:WaitForChild("OtherPlayerHeadshot");
local l_YourHeadshot_0 = l_Trading_1:WaitForChild("YourHeadshot");
local v42 = nil;
local v43 = nil;
local v44 = false;
local v45 = false;
local v46 = {};
local v47 = {};
local v48 = nil;
local v49 = nil;
local v50 = nil;
local v51 = nil;
local v52 = {};
local v53 = {};
local v54 = "";
local v55 = 0;
local v56 = false;
local v57 = false;
local _ = {
    "Kairos", 
    "Chronos", 
    "Paradox"
};
local _ = {};
local function v62(v60) --[[ Line: 79 ]] --[[ Name: formatDisplay ]]
    local v61 = v60.DisplayName or v60.Name;
    return string.format("%s <font color=\"rgb(0,180,255)\"> @ %s</font>", v61, v60.Name);
end;
local function v64(v63) --[[ Line: 84 ]] --[[ Name: formatPetPower ]]
    -- upvalues: v5 (copy)
    if not v63 or v63 <= 0 then
        return "--";
    elseif v63 >= 1000 then
        return v5:Abbreviate(v63, true, false);
    else
        return string.format("%.2f", v63);
    end;
end;
local function _(v65) --[[ Line: 96 ]] --[[ Name: headshotFor ]]
    return string.format("https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=150&height=150&format=png", (math.abs(v65)));
end;
local function _(v67) --[[ Line: 103 ]] --[[ Name: normalizeButtonText ]]
    if typeof(v67) ~= "string" then
        return "";
    else
        return string.lower((v67:gsub("<.->", "")));
    end;
end;
local function _(v69) --[[ Line: 111 ]] --[[ Name: centerMenu ]]
    if not v69 then
        return;
    else
        v69.AnchorPoint = Vector2.new(0.5, 0.5);
        v69.Position = UDim2.fromScale(0.5, 0.5);
        return;
    end;
end;
if l_Menu_0 then
    l_Menu_0.AnchorPoint = Vector2.new(0.5, 0.5);
    l_Menu_0.Position = UDim2.fromScale(0.5, 0.5);
end;
if l_Menu_1 then
    l_Menu_1.AnchorPoint = Vector2.new(0.5, 0.5);
    l_Menu_1.Position = UDim2.fromScale(0.5, 0.5);
end;
local function _(v71) --[[ Line: 123 ]] --[[ Name: isMenuOpen ]]
    if not v71 then
        return false;
    else
        local l_v71_Attribute_0 = v71:GetAttribute("Enabled");
        if l_v71_Attribute_0 ~= nil then
            return l_v71_Attribute_0 == true;
        else
            return v71.Enabled;
        end;
    end;
end;
local function _() --[[ Line: 136 ]] --[[ Name: clearHistoryEntries ]]

end;
local function v78() --[[ Line: 151 ]] --[[ Name: openTradeMenu ]]
    -- upvalues: l_Menu_0 (copy), v4 (copy)
    local l_Inner_2 = l_Menu_0:FindFirstChild("Inner");
    if l_Inner_2 then
        local l_Trade_1 = l_Inner_2:FindFirstChild("Trade");
        local l_History_0 = l_Inner_2:FindFirstChild("History");
        if l_Trade_1 then
            l_Trade_1.Visible = true;
        end;
        if l_History_0 then
            l_History_0.Visible = false;
        end;
    end;
    v4.Fire("OpenMenu", "Trade");
end;
local function _() --[[ Line: 165 ]] --[[ Name: closeTradeMenu ]]
    -- upvalues: v4 (copy)
    v4.Fire("CloseMenu", "Trade");
end;
local function _() --[[ Line: 169 ]] --[[ Name: toggleTradeMenu ]]
    -- upvalues: l_Trade_0 (copy), v4 (copy), v78 (copy)
    local l_l_Trade_0_0 = l_Trade_0;
    local v81;
    if not l_l_Trade_0_0 then
        v81 = false;
    else
        local l_l_l_Trade_0_0_Attribute_0 = l_l_Trade_0_0:GetAttribute("Enabled");
        v81 = if l_l_l_Trade_0_0_Attribute_0 ~= nil then l_l_l_Trade_0_0_Attribute_0 == true else l_l_Trade_0_0.Enabled;
    end;
    if v81 then
        v4.Fire("CloseMenu", "Trade");
        return false;
    else
        v78();
        return true;
    end;
end;
local function _() --[[ Line: 179 ]] --[[ Name: clearRequest ]]
    -- upvalues: v48 (ref), l_TradeQuest_0 (copy), v47 (copy)
    v48 = nil;
    l_TradeQuest_0.Enabled = false;
    if #v47 > 0 then
        table.remove(v47, 1);
    end;
end;
local function v85() --[[ Line: 187 ]] --[[ Name: showNextRequest ]]
    -- upvalues: v48 (ref), v47 (copy), l_Players_0 (copy), v85 (copy), l_Menu_1 (copy), v62 (copy), v64 (copy), l_TradeQuest_0 (copy)
    if v48 or #v47 == 0 then
        return;
    else
        local v86 = v47[1];
        local l_l_Players_0_PlayerByUserId_0 = l_Players_0:GetPlayerByUserId(v86.userId);
        if not l_l_Players_0_PlayerByUserId_0 then
            table.remove(v47, 1);
            return v85();
        else
            v48 = v86;
            l_Menu_1.PlayerSent.RichText = true;
            l_Menu_1.PlayerSent.Text = string.format("%s<br /><font color=\"rgb(174,174,174)\">has sent a trade request!</font>", v62(l_l_Players_0_PlayerByUserId_0));
            local l_Headshot_0 = l_Menu_1.Headshot;
            local l_UserId_0 = l_l_Players_0_PlayerByUserId_0.UserId;
            l_Headshot_0.Image = string.format("https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=150&height=150&format=png", (math.abs(l_UserId_0)));
            l_Menu_1.PetPower.Text = string.format("Pet Power [%s]", v64(v86.petPower));
            l_TradeQuest_0.Enabled = true;
            return;
        end;
    end;
end;
local function v91() --[[ Line: 211 ]] --[[ Name: handleAcceptRequestClick ]]
    -- upvalues: v48 (ref), l_Players_0 (copy), v3 (copy), l_TradeQuest_0 (copy), v47 (copy), v85 (copy)
    if not v48 then
        return;
    else
        local l_l_Players_0_PlayerByUserId_1 = l_Players_0:GetPlayerByUserId(v48.userId);
        if l_l_Players_0_PlayerByUserId_1 then
            v3:FireServer("AcceptTrade", l_l_Players_0_PlayerByUserId_1);
        end;
        v48 = nil;
        l_TradeQuest_0.Enabled = false;
        if #v47 > 0 then
            table.remove(v47, 1);
        end;
        v85();
        return;
    end;
end;
local function v93() --[[ Line: 225 ]] --[[ Name: handleDeclineRequestClick ]]
    -- upvalues: v48 (ref), l_Players_0 (copy), v3 (copy), l_TradeQuest_0 (copy), v47 (copy), v85 (copy)
    if not v48 then
        return;
    else
        local l_l_Players_0_PlayerByUserId_2 = l_Players_0:GetPlayerByUserId(v48.userId);
        if l_l_Players_0_PlayerByUserId_2 then
            v3:FireServer("DeclineTrade", l_l_Players_0_PlayerByUserId_2);
        end;
        v48 = nil;
        l_TradeQuest_0.Enabled = false;
        if #v47 > 0 then
            table.remove(v47, 1);
        end;
        v85();
        return;
    end;
end;
local function v101(v94, v95) --[[ Line: 239 ]] --[[ Name: enqueueRequest ]]
    -- upvalues: v47 (copy), l_Trade_0 (copy), v4 (copy), v85 (copy)
    for _, v97 in ipairs(v47) do
        if v97.userId == v94.UserId then
            v97.petPower = v95;
            return;
        end;
    end;
    table.insert(v47, {
        player = v94, 
        userId = v94.UserId, 
        petPower = v95 or 0
    });
    local l_l_Trade_0_1 = l_Trade_0;
    local v99;
    if not l_l_Trade_0_1 then
        v99 = false;
    else
        local l_l_l_Trade_0_1_Attribute_0 = l_l_Trade_0_1:GetAttribute("Enabled");
        v99 = if l_l_l_Trade_0_1_Attribute_0 ~= nil then l_l_l_Trade_0_1_Attribute_0 == true else l_l_Trade_0_1.Enabled;
    end;
    if v99 then
        v4.Fire("CloseMenu", "Trade");
    end;
    v85();
end;
local v102 = nil;
local function _(v103, v104) --[[ Line: 256 ]] --[[ Name: setReadyButtonState ]]
    -- upvalues: l_Title_0 (copy), l_Button_0 (copy)
    if v103 then
        l_Title_0.Text = v103;
    end;
    l_Button_0.Active = v104;
    l_Button_0.AutoButtonColor = v104;
end;
local function _() --[[ Line: 265 ]] --[[ Name: resetReadyVisuals ]]
    -- upvalues: l_Title_0 (copy), l_Button_0 (copy), l_UIStroke_1 (copy), v102 (ref), l_Main_0 (copy)
    l_Title_0.Text = "Ready";
    l_Button_0.Active = true;
    l_Button_0.AutoButtonColor = true;
    if l_UIStroke_1 then
        l_UIStroke_1.Color = Color3.fromRGB(255, 255, 255);
    end;
    if v102 and l_Main_0 then
        l_Main_0.BackgroundColor3 = v102;
    end;
end;
local function v111(v107) --[[ Line: 276 ]] --[[ Name: triggerReadyCooldown ]]
    -- upvalues: v56 (ref), v50 (ref), l_Title_0 (copy), l_Button_0 (copy), l_UIStroke_1 (copy), v102 (ref), l_Main_0 (copy), l_RunService_0 (copy)
    v56 = true;
    if v50 then
        v50:Disconnect();
        v50 = nil;
    end;
    if v107 <= 0 then
        v56 = false;
        l_Title_0.Text = "Ready";
        l_Button_0.Active = true;
        l_Button_0.AutoButtonColor = true;
        if l_UIStroke_1 then
            l_UIStroke_1.Color = Color3.fromRGB(255, 255, 255);
        end;
        if v102 and l_Main_0 then
            l_Main_0.BackgroundColor3 = v102;
        end;
        return;
    else
        local v108 = string.format("Ready (%d)", v107);
        if v108 then
            l_Title_0.Text = v108;
        end;
        l_Button_0.Active = false;
        l_Button_0.AutoButtonColor = false;
        v50 = l_RunService_0.Heartbeat:Connect(function(v109) --[[ Line: 292 ]]
            -- upvalues: v107 (ref), v56 (ref), l_Title_0 (ref), l_Button_0 (ref), l_UIStroke_1 (ref), v102 (ref), l_Main_0 (ref), v50 (ref)
            v107 = v107 - v109;
            if v107 <= 0 then
                v56 = false;
                l_Title_0.Text = "Ready";
                l_Button_0.Active = true;
                l_Button_0.AutoButtonColor = true;
                if l_UIStroke_1 then
                    l_UIStroke_1.Color = Color3.fromRGB(255, 255, 255);
                end;
                if v102 and l_Main_0 then
                    l_Main_0.BackgroundColor3 = v102;
                end;
                v50:Disconnect();
                v50 = nil;
                return;
            else
                local v110 = string.format("Ready (%d)", (math.ceil(v107)));
                if v110 then
                    l_Title_0.Text = v110;
                end;
                l_Button_0.Active = false;
                l_Button_0.AutoButtonColor = false;
                return;
            end;
        end);
        return;
    end;
end;
local function v115(v112) --[[ Line: 305 ]] --[[ Name: clearOfferFrames ]]
    for _, v114 in ipairs(v112:GetChildren()) do
        if v114:IsA("Frame") and v114.Name ~= "AddPass" then
            v114:Destroy();
        end;
    end;
end;
local function v118() --[[ Line: 313 ]] --[[ Name: clearTradeUI ]]
    -- upvalues: v115 (copy), l_List_0 (copy), l_MainList_0 (copy), l_Amount_0 (copy), l_TextBox_1 (copy), l_UIStroke_0 (copy), l_Username_0 (copy), l_Title_0 (copy), l_Button_0 (copy), l_UIStroke_1 (copy), v102 (ref), l_Main_0 (copy), l_Inner_1 (copy), l_Inner_0 (copy), v51 (ref), v50 (ref)
    v115(l_List_0);
    v115(l_MainList_0);
    l_Amount_0.Text = "0";
    l_TextBox_1.Text = "";
    if l_UIStroke_0 then
        l_UIStroke_0.Color = Color3.fromRGB(0, 0, 0);
    end;
    l_Username_0.Text = "@";
    l_Title_0.Text = "Ready";
    l_Button_0.Active = true;
    l_Button_0.AutoButtonColor = true;
    if l_UIStroke_1 then
        l_UIStroke_1.Color = Color3.fromRGB(255, 255, 255);
    end;
    if v102 and l_Main_0 then
        l_Main_0.BackgroundColor3 = v102;
    end;
    local l_isReady_0 = l_Inner_1:FindFirstChild("isReady");
    if l_isReady_0 then
        l_isReady_0.Visible = false;
    end;
    local l_isReady_1 = l_Inner_0:FindFirstChild("isReady");
    if l_isReady_1 then
        l_isReady_1.Visible = false;
    end;
    if v51 then
        v51:Disconnect();
        v51 = nil;
    end;
    if v50 then
        v50:Disconnect();
        v50 = nil;
    end;
end;
local function v126(v119, v120) --[[ Line: 343 ]] --[[ Name: markPetTrading ]]
    -- upvalues: v53 (copy), v52 (ref), v5 (copy)
    local v121 = v53[v119];
    if not v121 or not v121:FindFirstChild("Main") then
        return;
    else
        local l_Button_2 = v121.Main:FindFirstChild("Button");
        if l_Button_2 then
            l_Button_2.AutoButtonColor = true;
            l_Button_2.Active = true;
        end;
        local l_Trading_2 = v121:FindFirstChild("Trading");
        if l_Trading_2 then
            l_Trading_2.Visible = v120;
        end;
        local v124 = v52[v119];
        if v124 then
            local v125 = v5.layoutLimit - v5:Compress(v124.Multiplier1 or 0);
            if v120 then
                v121.LayoutOrder = -100000000 + v125;
                return;
            else
                v121.LayoutOrder = v125;
            end;
        end;
        return;
    end;
end;
local function v129() --[[ Line: 375 ]] --[[ Name: clearPetFrames ]]
    -- upvalues: v53 (copy)
    for _, v128 in pairs(v53) do
        if v128 then
            v128:Destroy();
        end;
    end;
    table.clear(v53);
end;
local function v134() --[[ Line: 384 ]] --[[ Name: closeActiveTrade ]]
    -- upvalues: v49 (ref), l_Trading_0 (copy), l_Processing_0 (copy), v8 (copy), v52 (ref), v118 (copy), v129 (copy), l_Actions_0 (copy)
    local v130 = v49 and v49.isHistoryView or false;
    v49 = nil;
    l_Trading_0.Enabled = false;
    l_Processing_0.Visible = false;
    v8:Close();
    for _, v132 in pairs(v52) do
        if v132.Trading then
            v132.Trading = nil;
        end;
    end;
    v118();
    v129();
    if v130 then
        local l_Ready_1 = l_Actions_0:FindFirstChild("Ready");
        if l_Ready_1 then
            l_Ready_1.Visible = true;
        end;
    end;
end;
local function v138(v135, v136) --[[ Line: 410 ]] --[[ Name: applyPetInfo ]]
    -- upvalues: v8 (copy)
    if not v135 or not v136 then
        return;
    else
        local l_v135_FirstChild_0 = v135:FindFirstChild("Button", true);
        if not l_v135_FirstChild_0 then
            return;
        else
            l_v135_FirstChild_0.MouseEnter:Connect(function() --[[ Line: 420 ]]
                -- upvalues: v8 (ref), v136 (copy)
                v8:Prompt(v136);
            end);
            l_v135_FirstChild_0.MouseLeave:Connect(function() --[[ Line: 424 ]]
                -- upvalues: v8 (ref)
                v8:Close();
            end);
            return;
        end;
    end;
end;
local function _(v139, v140) --[[ Line: 429 ]] --[[ Name: createOfferFrame ]]
    -- upvalues: v7 (copy), v5 (copy), v138 (copy)
    local l_v7_Frame_0 = v7:CreateFrame(v139, "Trade");
    l_v7_Frame_0.LayoutOrder = v5.layoutLimit - v5:Compress(v139.Multiplier1 or 0);
    l_v7_Frame_0.Parent = v140;
    v138(l_v7_Frame_0.Main, v139);
    return l_v7_Frame_0;
end;
local function _(v143) --[[ Line: 437 ]] --[[ Name: updatePartnerTokens ]]
    -- upvalues: l_Amount_0 (copy), v5 (copy)
    l_Amount_0.Text = v5:Abbreviate(math.max(v143 or 0, 0), true, true);
end;
local function _(v145) --[[ Line: 441 ]] --[[ Name: setAvailableTokens ]]
    -- upvalues: v55 (ref), l_TextBox_1 (copy), v5 (copy)
    v55 = math.max(v145 or 0, 0);
    l_TextBox_1.PlaceholderText = v5:Abbreviate(v55, true, true) .. " available";
end;
local function v154() --[[ Line: 446 ]] --[[ Name: filterInventory ]]
    -- upvalues: v54 (ref), v53 (copy), v52 (ref)
    local v147 = string.lower(v54);
    for v148, v149 in pairs(v53) do
        local v150 = v52[v148];
        local v151 = true;
        if v147 ~= "" and v150 then
            local v152 = string.find(string.lower(v150.Name), v147, 1, true);
            local v153 = v150.Tier and string.find(string.lower(v150.Tier), v147, 1, true);
            v151 = v152 or v153;
        end;
        if v149 then
            v149.Visible = v151;
        end;
    end;
end;
local function _(v155, v156) --[[ Line: 463 ]] --[[ Name: rebuildCanvasSize ]]
    if not v156 then
        return;
    else
        local l_AbsoluteContentSize_0 = v156.AbsoluteContentSize;
        v155.CanvasSize = UDim2.fromOffset(l_AbsoluteContentSize_0.X, l_AbsoluteContentSize_0.Y + 20);
        return;
    end;
end;
local function v160(v159) --[[ Line: 472 ]] --[[ Name: addPetToTrade ]]
    -- upvalues: v49 (ref), v52 (ref), v3 (copy), v126 (copy), v111 (copy)
    if not v49 or not v52[v159] then
        return;
    elseif v52[v159].Trading then
        return;
    else
        if v3:InvokeServer("AddTradeItem", {
            "Pet", 
            v159
        }) then
            v52[v159].Trading = true;
            v126(v159, true);
            v111(5);
        end;
        return;
    end;
end;
local function v162(v161) --[[ Line: 489 ]] --[[ Name: removePetFromTrade ]]
    -- upvalues: v49 (ref), v52 (ref), v3 (copy), v126 (copy), v111 (copy)
    if not v49 or not v52[v161] then
        return;
    elseif not v52[v161].Trading then
        return;
    else
        if v3:InvokeServer("RemoveTradeItem", {
            "Pet", 
            v161
        }) then
            v52[v161].Trading = nil;
            v126(v161, false);
            v111(5);
        end;
        return;
    end;
end;
local function v171(v163, v164) --[[ Line: 506 ]] --[[ Name: createPetFrame ]]
    -- upvalues: v7 (copy), v5 (copy), l_MainList_0 (copy), v49 (ref), v52 (ref), v162 (copy), v160 (copy), v138 (copy), v53 (copy), l_UIGridLayout_1 (copy)
    local l_status_0, l_result_0 = pcall(function() --[[ Line: 507 ]]
        -- upvalues: v7 (ref), v164 (copy)
        return v7:CreateFrame(v164, "Trade");
    end);
    if not l_status_0 or not l_result_0 then
        warn("[Trade] Failed to create pet frame:", l_result_0);
        return;
    else
        l_result_0.Name = tostring(v163);
        l_result_0.LayoutOrder = v5.layoutLimit - v5:Compress(v164.Multiplier1 or 0);
        l_result_0.Visible = true;
        l_result_0.Parent = l_MainList_0;
        local v167 = l_result_0.Main and l_result_0.Main:FindFirstChild("Button");
        if not v167 then
            warn("[Trade] No button found in pet frame for:", v164.Name);
            return;
        else
            v167.Activated:Connect(function() --[[ Line: 527 ]]
                -- upvalues: v49 (ref), v52 (ref), v163 (copy), v162 (ref), v160 (ref)
                if not v49 then
                    return;
                elseif v52[v163].Trading then
                    v162(v163);
                    return;
                else
                    v160(v163);
                    return;
                end;
            end);
            v138(l_result_0.Main, v164);
            v53[v163] = l_result_0;
            local l_l_MainList_0_0 = l_MainList_0;
            local l_l_UIGridLayout_1_0 = l_UIGridLayout_1;
            if not l_l_UIGridLayout_1_0 then
                return;
            else
                local l_AbsoluteContentSize_1 = l_l_UIGridLayout_1_0.AbsoluteContentSize;
                l_l_MainList_0_0.CanvasSize = UDim2.fromOffset(l_AbsoluteContentSize_1.X, l_AbsoluteContentSize_1.Y + 20);
                return;
            end;
        end;
    end;
end;
local function v178() --[[ Line: 544 ]] --[[ Name: rebuildInventory ]]
    -- upvalues: v52 (ref), v53 (copy), v171 (copy), v154 (copy)
    local v172 = 0;
    for _ in pairs(v52) do
        v172 = v172 + 1;
    end;
    for _, v175 in pairs(v53) do
        if v175 then
            v175:Destroy();
        end;
    end;
    table.clear(v53);
    for v176, v177 in pairs(v52) do
        v171(v176, v177);
    end;
    v154();
end;
local function _(v179) --[[ Line: 565 ]] --[[ Name: onAddPet ]]
    -- upvalues: v52 (ref), v49 (ref), v171 (copy), v154 (copy)
    if not v179 or not v179.Id then
        return;
    else
        v52[v179.Id] = v179;
        if v49 then
            v171(v179.Id, v179);
            v154();
        end;
        return;
    end;
end;
local function _(v181) --[[ Line: 578 ]] --[[ Name: onRemovePet ]]
    -- upvalues: v53 (copy), v52 (ref)
    local v182 = v53[v181];
    if v182 then
        v182:Destroy();
        v53[v181] = nil;
    end;
    v52[v181] = nil;
end;
local function _(v184, v185) --[[ Line: 589 ]] --[[ Name: onUpdatePet ]]
    -- upvalues: v52 (ref), v49 (ref), v53 (copy), v171 (copy), v154 (copy)
    v52[v184] = v185;
    if v49 then
        if v53[v184] then
            v53[v184]:Destroy();
            v53[v184] = nil;
        end;
        v171(v184, v185);
        v154();
    end;
end;
local function v195() --[[ Line: 602 ]] --[[ Name: bindInventoryEvents ]]
    -- upvalues: v3 (copy), v52 (ref), v49 (ref), v171 (copy), v154 (copy), v53 (copy)
    v3:BindEvents({
        AddPet = function(v187) --[[ Line: 604 ]] --[[ Name: AddPet ]]
            -- upvalues: v52 (ref), v49 (ref), v171 (ref), v154 (ref)
            if v187 then
                if not v187.Id then
                    return;
                else
                    v52[v187.Id] = v187;
                    if v49 then
                        v171(v187.Id, v187);
                        v154();
                    end;
                end;
            end;
        end, 
        RemovePet = function(v188) --[[ Line: 608 ]] --[[ Name: RemovePet ]]
            -- upvalues: v53 (ref), v52 (ref)
            if typeof(v188) == "string" then
                local v189 = v53[v188];
                if v189 then
                    v189:Destroy();
                    v53[v188] = nil;
                end;
                v52[v188] = nil;
                return;
            else
                if typeof(v188) == "table" then
                    for _, v191 in ipairs(v188) do
                        local v192 = v53[v191];
                        if v192 then
                            v192:Destroy();
                            v53[v191] = nil;
                        end;
                        v52[v191] = nil;
                    end;
                end;
                return;
            end;
        end, 
        UpdatePetData = function(v193, v194) --[[ Line: 618 ]] --[[ Name: UpdatePetData ]]
            -- upvalues: v52 (ref), v49 (ref), v53 (ref), v171 (ref), v154 (ref)
            v52[v193] = v194;
            if v49 then
                if v53[v193] then
                    v53[v193]:Destroy();
                    v53[v193] = nil;
                end;
                v171(v193, v194);
                v154();
            end;
        end
    });
end;
local function v208(v196) --[[ Line: 624 ]] --[[ Name: handleStartTrade ]]
    -- upvalues: v49 (ref), l_LocalPlayer_0 (copy), l_TradeQuest_0 (copy), l_Trading_0 (copy), l_Processing_0 (copy), v118 (copy), l_Button_1 (copy), l_Actions_0 (copy), l_Inner_1 (copy), l_Inner_0 (copy), v6 (copy), v52 (ref), v178 (copy), v115 (copy), l_MainList_0 (copy), l_List_0 (copy), l_Username_0 (copy), l_OtherPlayerHeadshot_0 (copy), l_YourHeadshot_0 (copy)
    v49 = {
        id = v196.id, 
        role = v196.p1 == l_LocalPlayer_0 and "p1" or "p2", 
        partner = v196.p1 == l_LocalPlayer_0 and v196.p2 or v196.p1, 
        tokens = {
            self = 0, 
            partner = 0
        }, 
        offers = {
            self = {}, 
            partner = {}
        }, 
        ready = {
            self = false, 
            partner = false
        }, 
        isHistoryView = v196.isHistoryView or false
    };
    l_TradeQuest_0.Enabled = false;
    l_Trading_0.Enabled = true;
    l_Processing_0.Visible = false;
    v118();
    if v49.isHistoryView then
        l_Button_1.Visible = true;
        local l_Ready_2 = l_Actions_0:FindFirstChild("Ready");
        if l_Ready_2 then
            l_Ready_2.Visible = false;
        end;
    else
        l_Button_1.Visible = true;
    end;
    local l_isReady_2 = l_Inner_1:FindFirstChild("isReady");
    if l_isReady_2 then
        l_isReady_2.Visible = false;
    end;
    local l_isReady_3 = l_Inner_0:FindFirstChild("isReady");
    if l_isReady_3 then
        l_isReady_3.Visible = false;
    end;
    if not v49.isHistoryView then
        if v6.Loaded and v6.Data.Pets then
            v52 = table.clone(v6.Data.Pets);
            local v200 = 0;
            for _ in pairs(v52) do
                v200 = v200 + 1;
            end;
            v178();
        end;
    else
        v115(l_MainList_0);
        v115(l_List_0);
    end;
    if v49.partner then
        l_Username_0.RichText = true;
        local l_l_Username_0_0 = l_Username_0;
        local l_partner_0 = v49.partner;
        local v204 = l_partner_0.DisplayName or l_partner_0.Name;
        l_l_Username_0_0.Text = string.format("%s <font color=\"rgb(0,180,255)\"> @ %s</font>", v204, l_partner_0.Name) .. ":";
        l_l_Username_0_0 = l_OtherPlayerHeadshot_0;
        local l_UserId_1 = v49.partner.UserId;
        l_l_Username_0_0.Image = string.format("https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=150&height=150&format=png", (math.abs(l_UserId_1)));
    end;
    local l_l_YourHeadshot_0_0 = l_YourHeadshot_0;
    local l_UserId_2 = l_LocalPlayer_0.UserId;
    l_l_YourHeadshot_0_0.Image = string.format("https://www.roblox.com/headshot-thumbnail/image?userId=%d&width=150&height=150&format=png", (math.abs(l_UserId_2)));
end;
local function _() --[[ Line: 694 ]] --[[ Name: handleCloseTrade ]]
    -- upvalues: v134 (copy), v85 (copy)
    v134();
    v85();
end;
local function v214(v210) --[[ Line: 699 ]] --[[ Name: handleAddTradeItem ]]
    -- upvalues: v49 (ref), l_List_0 (copy), v7 (copy), v5 (copy), v138 (copy), v111 (copy)
    if not v49 or typeof(v210) ~= "table" then
        return;
    elseif v210[1] ~= "Pet" then
        return;
    else
        local v211 = v210[2];
        if not v211 or not v211.Id then
            return;
        else
            local l_l_List_0_0 = l_List_0;
            local l_v7_Frame_1 = v7:CreateFrame(v211, "Trade");
            l_v7_Frame_1.LayoutOrder = v5.layoutLimit - v5:Compress(v211.Multiplier1 or 0);
            l_v7_Frame_1.Parent = l_l_List_0_0;
            v138(l_v7_Frame_1.Main, v211);
            v49.offers.partner[v211.Id] = l_v7_Frame_1;
            v111(5);
            return;
        end;
    end;
end;
local function v219(v215) --[[ Line: 719 ]] --[[ Name: handleRemoveTradeItem ]]
    -- upvalues: v49 (ref), v111 (copy)
    if not v49 or typeof(v215) ~= "table" then
        return;
    else
        local v216 = v215[1];
        local v217 = v215[2];
        if v216 ~= "Pet" then
            return;
        else
            local v218 = v49.offers.partner[v217];
            if v218 then
                v218:Destroy();
                v49.offers.partner[v217] = nil;
            end;
            v111(5);
            return;
        end;
    end;
end;
local function _(v220, v221) --[[ Line: 738 ]] --[[ Name: setReadyIndicator ]]
    -- upvalues: l_Inner_1 (copy), l_Inner_0 (copy)
    (v220 and l_Inner_1 or l_Inner_0):FindFirstChild("isReady").Visible = v221;
end;
local function v227(v223, v224, v225) --[[ Line: 749 ]] --[[ Name: handleReadyChange ]]
    -- upvalues: v49 (ref), l_LocalPlayer_0 (copy), l_Inner_1 (copy), l_Inner_0 (copy), l_UIStroke_0 (copy), v57 (ref), v51 (ref), l_Title_0 (copy), l_Button_0 (copy), l_UIStroke_1 (copy), v102 (ref), l_Main_0 (copy), v111 (copy)
    if not v49 then
        return;
    else
        local v226 = v223 == l_LocalPlayer_0;
        if v226 then
            v49.ready.self = v224;
        else
            v49.ready.partner = v224;
        end;
        (v226 and l_Inner_1 or l_Inner_0):FindFirstChild("isReady").Visible = v224;
        if not v226 and l_UIStroke_0 then
            l_UIStroke_0.Color = v224 and Color3.fromRGB(0, 200, 0) or Color3.fromRGB(255, 255, 255);
        end;
        if not v224 then
            v57 = false;
            if v51 then
                v51:Disconnect();
                v51 = nil;
            end;
            if v226 then
                l_Title_0.Text = "Ready";
                l_Button_0.Active = true;
                l_Button_0.AutoButtonColor = true;
                if l_UIStroke_1 then
                    l_UIStroke_1.Color = Color3.fromRGB(255, 255, 255);
                end;
                if v102 and l_Main_0 then
                    l_Main_0.BackgroundColor3 = v102;
                end;
            end;
            if v225 then
                v111(5);
            end;
            return;
        else
            if v226 then
                l_Title_0.Text = "Unready";
                l_Button_0.Active = true;
                l_Button_0.AutoButtonColor = true;
                if l_UIStroke_1 then
                    l_UIStroke_1.Color = Color3.fromRGB(0, 200, 0);
                end;
            end;
            return;
        end;
    end;
end;
local function v232(v228) --[[ Line: 801 ]] --[[ Name: handleCountdown ]]
    -- upvalues: v57 (ref), v51 (ref), v102 (ref), l_Main_0 (copy), l_Title_0 (copy), l_Button_0 (copy), l_UIStroke_1 (copy), l_RunService_0 (copy)
    v57 = true;
    if v51 then
        v51:Disconnect();
    end;
    if not v102 and l_Main_0 then
        v102 = l_Main_0.BackgroundColor3;
    end;
    local v229 = string.format("Trading in %d (Click to Cancel)", v228);
    if v229 then
        l_Title_0.Text = v229;
    end;
    l_Button_0.Active = true;
    l_Button_0.AutoButtonColor = true;
    if l_UIStroke_1 then
        l_UIStroke_1.Color = Color3.fromRGB(255, 60, 60);
    end;
    if l_Main_0 then
        l_Main_0.BackgroundColor3 = Color3.fromRGB(200, 50, 50);
    end;
    v51 = l_RunService_0.Heartbeat:Connect(function(v230) --[[ Line: 819 ]]
        -- upvalues: v228 (ref), v57 (ref), v51 (ref), l_Title_0 (ref), l_Button_0 (ref)
        v228 = v228 - v230;
        if v228 <= 0 then
            v57 = false;
            v51:Disconnect();
            v51 = nil;
            return;
        else
            local v231 = string.format("Trading in %d (click to cancel)", (math.ceil(v228)));
            if v231 then
                l_Title_0.Text = v231;
            end;
            l_Button_0.Active = true;
            l_Button_0.AutoButtonColor = true;
            return;
        end;
    end);
end;
local function v233() --[[ Line: 833 ]] --[[ Name: handleTradeProcess ]]
    -- upvalues: l_Processing_0 (copy), l_Button_1 (copy), l_Title_0 (copy), l_Button_0 (copy)
    l_Processing_0.Visible = true;
    l_Button_1.Visible = false;
    l_Title_0.Text = "Processing...";
    l_Button_0.Active = false;
    l_Button_0.AutoButtonColor = false;
end;
local function v235(v234) --[[ Line: 839 ]] --[[ Name: handleTokensUpdate ]]
    -- upvalues: l_Amount_0 (copy), v5 (copy), v111 (copy)
    l_Amount_0.Text = v5:Abbreviate(math.max(v234 or 0, 0), true, true);
    v111(5);
end;
local function v237(v236) --[[ Line: 844 ]] --[[ Name: handleMyTokensUpdated ]]
    -- upvalues: v55 (ref), l_TextBox_1 (copy), v5 (copy)
    v55 = math.max(v236 or 0, 0);
    l_TextBox_1.PlaceholderText = v5:Abbreviate(v55, true, true) .. " available";
end;
local function _(v238) --[[ Line: 848 ]] --[[ Name: formatTimestamp ]]
    if not v238 then
        return "Unknown";
    else
        local v239 = os.date("*t", v238);
        return string.format("%d/%d/%d %02d:%02d", v239.month, v239.day, v239.year, v239.hour, v239.min);
    end;
end;
local function v277(v241) --[[ Line: 854 ]] --[[ Name: openHistoryTradeView ]]
    -- upvalues: v9 (copy), l_LocalPlayer_0 (copy), v208 (copy), l_MainList_0 (copy), v7 (copy), v5 (copy), v138 (copy), l_List_0 (copy), l_TextBox_1 (copy), v49 (ref), l_Amount_0 (copy), l_Inner_1 (copy), l_Inner_0 (copy)
    local v242 = {
        UserId = v241.partnerId, 
        Name = v241.partnerName, 
        DisplayName = v241.partnerDisplayName or v241.partnerName
    };
    local v243 = {};
    if v241.receivedPets then
        for _, v245 in ipairs(v241.receivedPets) do
            local v246, v247 = v245:match("(.+) %((.+)%)");
            if v246 and v247 then
                local v248 = 1;
                local v249 = 0;
                local l_status_1, l_result_1 = pcall(function() --[[ Line: 868 ]]
                    -- upvalues: v9 (ref), v246 (copy)
                    return v9:GetMultiplier(v246, 1);
                end);
                if l_status_1 and l_result_1 and l_result_1 > 0 then
                    v248 = l_result_1;
                end;
                local l_status_2, l_result_2 = pcall(function() --[[ Line: 875 ]]
                    -- upvalues: v9 (ref), v246 (copy)
                    return v9:GetMultiplier(v246, 2);
                end);
                if l_status_2 and l_result_2 then
                    v249 = l_result_2;
                end;
                table.insert(v243, {
                    Name = v246, 
                    Tier = v247, 
                    Id = "history_received_" .. #v243 + 1, 
                    Multi1 = v248, 
                    Multi2 = v249, 
                    Multiplier1 = v248, 
                    Multiplier2 = v249, 
                    Level = 1, 
                    XP = 0, 
                    Equipped = false, 
                    Locked = false
                });
            end;
        end;
    end;
    local v254 = {};
    if v241.gavePets then
        for _, v256 in ipairs(v241.gavePets) do
            local v257, v258 = v256:match("(.+) %((.+)%)");
            if v257 and v258 then
                local v259 = 1;
                local v260 = 0;
                local l_status_3, l_result_3 = pcall(function() --[[ Line: 906 ]]
                    -- upvalues: v9 (ref), v257 (copy)
                    return v9:GetMultiplier(v257, 1);
                end);
                if l_status_3 and l_result_3 and l_result_3 > 0 then
                    v259 = l_result_3;
                end;
                local l_status_4, l_result_4 = pcall(function() --[[ Line: 913 ]]
                    -- upvalues: v9 (ref), v257 (copy)
                    return v9:GetMultiplier(v257, 2);
                end);
                if l_status_4 and l_result_4 then
                    v260 = l_result_4;
                end;
                table.insert(v254, {
                    Name = v257, 
                    Tier = v258, 
                    Id = "history_gave_" .. #v254 + 1, 
                    Multi1 = v259, 
                    Multi2 = v260, 
                    Multiplier1 = v259, 
                    Multiplier2 = v260, 
                    Level = 1, 
                    XP = 0, 
                    Equipped = false, 
                    Locked = false
                });
            end;
        end;
    end;
    local v265 = {
        id = "history_" .. (v241.timestamp or 0), 
        p1 = l_LocalPlayer_0, 
        p2 = v242, 
        p1_tokens = v241.gaveTokens or 0, 
        p2_tokens = v241.receivedTokens or 0, 
        p1_Pet = {}, 
        p2_Pet = {}, 
        isHistoryView = true, 
        receivedPetsData = v243, 
        gavePetsData = v254
    };
    v208(v265);
    task.wait();
    for _, v267 in ipairs(v254) do
        local l_l_MainList_0_1 = l_MainList_0;
        local l_v7_Frame_2 = v7:CreateFrame(v267, "Trade");
        l_v7_Frame_2.LayoutOrder = v5.layoutLimit - v5:Compress(v267.Multiplier1 or 0);
        l_v7_Frame_2.Parent = l_l_MainList_0_1;
        v138(l_v7_Frame_2.Main, v267);
    end;
    for _, v271 in ipairs(v243) do
        local l_l_List_0_1 = l_List_0;
        local l_v7_Frame_3 = v7:CreateFrame(v271, "Trade");
        l_v7_Frame_3.LayoutOrder = v5.layoutLimit - v5:Compress(v271.Multiplier1 or 0);
        l_v7_Frame_3.Parent = l_l_List_0_1;
        v138(l_v7_Frame_3.Main, v271);
    end;
    if v265.p1_tokens > 0 then
        l_TextBox_1.Text = tostring(v265.p1_tokens);
        v49.tokens.self = v265.p1_tokens;
    end;
    if v265.p2_tokens > 0 then
        local l_p2_tokens_0 = v265.p2_tokens;
        l_Amount_0.Text = v5:Abbreviate(math.max(l_p2_tokens_0 or 0, 0), true, true);
        v49.tokens.partner = v265.p2_tokens;
    end;
    v49.ready.self = true;
    v49.ready.partner = true;
    local l_isReady_4 = l_Inner_1:FindFirstChild("isReady");
    if l_isReady_4 then
        l_isReady_4.Visible = false;
    end;
    local l_isReady_5 = l_Inner_0:FindFirstChild("isReady");
    if l_isReady_5 then
        l_isReady_5.Visible = false;
    end;
end;
local function v309(v278, v279, v280) --[[ Line: 981 ]] --[[ Name: createHistoryEntry ]]
    -- upvalues: v5 (copy), v4 (copy), v277 (copy), v9 (copy), v7 (copy), v138 (copy)
    local v281 = v279:Clone();
    v281.Name = "HistoryEntry_" .. (v278.timestamp or 0);
    v281.Visible = true;
    v281.Parent = v280;
    local l_v281_FirstChild_0 = v281:FindFirstChild("Username", true);
    if l_v281_FirstChild_0 and l_v281_FirstChild_0:IsA("TextLabel") then
        local l_partnerDisplayName_0 = v278.partnerDisplayName;
        local l_partnerName_0 = v278.partnerName;
        if l_partnerDisplayName_0 ~= "" and l_partnerDisplayName_0 ~= "" then
            l_v281_FirstChild_0.Text = ("@%* (%*)"):format(l_partnerDisplayName_0, l_partnerName_0);
        else
            l_v281_FirstChild_0.Text = l_partnerName_0;
        end;
    end;
    local l_v281_FirstChild_1 = v281:FindFirstChild("Currency", true);
    if l_v281_FirstChild_1 then
        local l_l_v281_FirstChild_1_FirstChild_0 = l_v281_FirstChild_1:FindFirstChild("Amount", true);
        if l_l_v281_FirstChild_1_FirstChild_0 and l_l_v281_FirstChild_1_FirstChild_0:IsA("TextLabel") then
            local v287 = v278.receivedTokens or 0;
            if v287 > 0 then
                l_l_v281_FirstChild_1_FirstChild_0.Text = v5:Abbreviate(v287, true, true);
            else
                l_l_v281_FirstChild_1_FirstChild_0.Text = "0";
            end;
        end;
    end;
    local l_v281_FirstChild_2 = v281:FindFirstChild("Equip", true);
    if l_v281_FirstChild_2 then
        local l_l_v281_FirstChild_2_FirstChild_0 = l_v281_FirstChild_2:FindFirstChild("Button", true);
        if l_l_v281_FirstChild_2_FirstChild_0 then
            v4.Fire("InitButton", l_l_v281_FirstChild_2_FirstChild_0);
            l_l_v281_FirstChild_2_FirstChild_0.Activated:Connect(function() --[[ Line: 1017 ]]
                -- upvalues: v277 (ref), v278 (copy)
                v277(v278);
            end);
        end;
    end;
    local l_v281_FirstChild_3 = v281:FindFirstChild("Contents", true);
    local v291 = #v278.receivedPets - 3;
    if l_v281_FirstChild_3 then
        local v292 = v278.receivedPets or {};
        local v293 = {};
        table.insert(v293, v292[1]);
        table.insert(v293, v292[2]);
        table.insert(v293, v292[3]);
        for v294, v295 in ipairs(v293) do
            local v296, v297 = v295:match("(.+) %((.+)%)");
            local v298 = 1;
            local v299 = 0;
            local l_status_5, l_result_5 = pcall(function() --[[ Line: 1036 ]]
                -- upvalues: v9 (ref), v296 (copy)
                return v9:GetMultiplier(v296, 1);
            end);
            if l_status_5 and l_result_5 and l_result_5 > 0 then
                v298 = l_result_5;
            end;
            local l_status_6, l_result_6 = pcall(function() --[[ Line: 1043 ]]
                -- upvalues: v9 (ref), v296 (copy)
                return v9:GetMultiplier(v296, 2);
            end);
            if l_status_6 and l_result_6 then
                v299 = l_result_6;
            end;
            local v304 = "history_received_" .. v294;
            local v305 = {
                Name = v296, 
                Id = v304, 
                Tier = v297, 
                Multi1 = v298, 
                Multi2 = v299, 
                Multiplier1 = v298, 
                Multiplier2 = v299, 
                Level = 1, 
                XP = 0, 
                Equipped = false, 
                Locked = false
            };
            local l_status_7, l_result_7 = pcall(function() --[[ Line: 1066 ]]
                -- upvalues: v7 (ref), v305 (copy)
                return v7:CreateFrame(v305, "Trade");
            end);
            if not l_status_7 or not l_result_7 then
                warn("[Trade] Failed to create pet frame:", l_result_7);
                return;
            else
                l_result_7.Size = UDim2.fromScale(0.25, 1);
                l_result_7.Name = tostring(v304);
                l_result_7.LayoutOrder = v5.layoutLimit - v5:Compress(v305.Multiplier1 or 0);
                l_result_7.Visible = true;
                l_result_7.Parent = l_v281_FirstChild_3;
                v138(l_result_7.Main, v305);
            end;
        end;
        local l_l_v281_FirstChild_3_FirstChild_0 = l_v281_FirstChild_3:FindFirstChild("Filler", true);
        if l_l_v281_FirstChild_3_FirstChild_0 then
            l_l_v281_FirstChild_3_FirstChild_0.Visible = v291 > 0;
            l_l_v281_FirstChild_3_FirstChild_0.Main.Label.Text = ("+%* more"):format(v291);
            l_l_v281_FirstChild_3_FirstChild_0.LayoutOrder = 1e999;
        end;
    end;
    return v281;
end;
local function v330(v310) --[[ Line: 1095 ]] --[[ Name: showTradeHistory ]]
    -- upvalues: l_Trade_0 (copy), v78 (copy), l_Menu_0 (copy), l_LocalPlayer_0 (copy), l_Players_0 (copy), v3 (copy), v309 (copy)
    if not l_Trade_0.Enabled then
        v78();
        task.wait(0.1);
    end;
    local l_Inner_3 = l_Menu_0:FindFirstChild("Inner");
    if not l_Inner_3 then
        warn("[Trade History] Inner frame not found");
        return;
    else
        local l_Trade_2 = l_Inner_3:FindFirstChild("Trade");
        local l_History_1 = l_Inner_3:FindFirstChild("History");
        if not l_Trade_2 then
            warn("[Trade History] Trade frame not found in UI");
            return;
        elseif not l_History_1 then
            warn("[Trade History] History frame not found in UI - make sure it exists in the Trade menu");
            return;
        else
            l_Trade_2.Visible = false;
            l_History_1.Visible = true;
            local l_Template_0 = l_History_1:FindFirstChild("Template");
            if not l_Template_0 then
                warn("[Trade History] Template not found in History frame");
                return;
            else
                l_Template_0.Visible = false;
                for _, v316 in ipairs(l_History_1:GetChildren()) do
                    if v316:IsA("Frame") and v316.Name:match("^HistoryEntry_") or v316.Name == "EmptyState" then
                        v316:Destroy();
                    end;
                end;
                local v317 = v310 or l_LocalPlayer_0.UserId;
                local v318 = v317 == l_LocalPlayer_0.UserId;
                local l_Name_0 = l_LocalPlayer_0.Name;
                if not v318 then
                    local l_l_Players_0_PlayerByUserId_3 = l_Players_0:GetPlayerByUserId(v317);
                    if l_l_Players_0_PlayerByUserId_3 then
                        l_Name_0 = l_l_Players_0_PlayerByUserId_3.DisplayName or l_l_Players_0_PlayerByUserId_3.Name;
                    else
                        local l_status_8, l_result_8 = pcall(function() --[[ Line: 1146 ]]
                            -- upvalues: l_Players_0 (ref), v317 (copy)
                            return l_Players_0:GetNameFromUserIdAsync(v317);
                        end);
                        l_Name_0 = l_status_8 and l_result_8 or "User " .. v317;
                    end;
                end;
                local l_status_9, l_result_9 = pcall(function() --[[ Line: 1157 ]]
                    -- upvalues: v3 (ref), v318 (copy), v317 (copy)
                    local l_v3_0 = v3;
                    local v324 = "GetTradeHistory";
                    if v318 then

                    end;
                    return l_v3_0:InvokeServer(v324, v317);
                end);
                if not l_status_9 or not l_result_9 then
                    warn("[Trade History] Failed to load trade history - success:", l_status_9, "history:", l_result_9);
                    return;
                else
                    local l_Title_1 = l_History_1:FindFirstChild("Title");
                    if l_Title_1 then
                        if v318 then
                            l_Title_1.Text = "Trade History";
                        else
                            l_Title_1.Text = string.format("Trade History - %s", l_Name_0);
                        end;
                    end;
                    if #l_result_9 ~= 0 then
                        for _, v329 in ipairs(l_result_9) do
                            v309(v329, l_Template_0, l_History_1);
                        end;
                    end;
                    l_Trade_2.Visible = false;
                    l_History_1.Visible = true;
                    return;
                end;
            end;
        end;
    end;
end;
local function v335() --[[ Line: 1197 ]] --[[ Name: bindNetworkEvents ]]
    -- upvalues: v3 (copy), l_LocalPlayer_0 (copy), v101 (copy), v208 (copy), v134 (copy), v85 (copy), v214 (copy), v219 (copy), v235 (copy), v232 (copy), v227 (copy), v233 (copy), v237 (copy), v330 (copy)
    v3:BindEvents({
        TradeRequest = function(v331, v332) --[[ Line: 1199 ]] --[[ Name: TradeRequest ]]
            -- upvalues: l_LocalPlayer_0 (ref), v101 (ref)
            if typeof(v331) ~= "Instance" or not v331:IsA("Player") or v331 == l_LocalPlayer_0 then
                return;
            else
                v101(v331, v332);
                return;
            end;
        end, 
        StartTrade = function(v333) --[[ Line: 1206 ]] --[[ Name: StartTrade ]]
            -- upvalues: v208 (ref)
            v208(v333);
        end, 
        CloseTrade = function() --[[ Line: 1210 ]] --[[ Name: CloseTrade ]]
            -- upvalues: v134 (ref), v85 (ref)
            v134();
            v85();
        end, 
        AddTradeItem = v214, 
        RemoveTradeItem = v219, 
        UpdateTradeTokens = v235, 
        TradeCountdown = v232, 
        ChangeReady = v227, 
        TradeProcess = v233, 
        TokensUpd = v237, 
        OpenTradeHistory = function(v334) --[[ Line: 1221 ]] --[[ Name: OpenTradeHistory ]]
            -- upvalues: v330 (ref), l_LocalPlayer_0 (ref)
            v330(v334 or l_LocalPlayer_0.UserId);
        end
    });
end;
local function v340(v336) --[[ Line: 1228 ]] --[[ Name: classifyRequestButton ]]
    -- upvalues: v42 (ref), v43 (ref)
    if not v336 then
        return;
    elseif v336.Name == "Accept" or v336.Name == "AcceptButton" then
        v42 = v336:FindFirstChild("Button") or v336;
        return;
    elseif v336.Name == "Decline" or v336.Name == "Cancel" or v336.Name == "DeclineButton" then
        v43 = v336:FindFirstChild("Button") or v336;
        return;
    else
        local l_v336_FirstChild_0 = v336:FindFirstChild("Title", true);
        if l_v336_FirstChild_0 and l_v336_FirstChild_0:IsA("TextLabel") then
            local l_Text_0 = l_v336_FirstChild_0.Text;
            local v339 = typeof(l_Text_0) ~= "string" and "" or string.lower((l_Text_0:gsub("<.->", "")));
            if v339:find("accept") then
                v42 = v336:FindFirstChild("Button") or v336;
                return;
            elseif v339:find("decline") or v339:find("cancel") then
                v43 = v336:FindFirstChild("Button") or v336;
            end;
        end;
        return;
    end;
end;
local function v377() --[[ Line: 1253 ]] --[[ Name: bindUI ]]
    -- upvalues: l_Menu_0 (copy), v4 (copy), v330 (copy), l_LocalPlayer_0 (copy), l_PlayerGui_0 (copy), l_Trade_0 (copy), v78 (copy), l_Menu_1 (copy), v340 (copy), v42 (ref), v43 (ref), v44 (ref), v91 (copy), v45 (ref), v93 (copy), l_Button_0 (copy), v49 (ref), v56 (ref), v57 (ref), v3 (copy), l_Button_1 (copy), v134 (copy), l_TextBox_1 (copy), v55 (ref), v111 (copy), l_TextBox_0 (copy), v54 (ref), v154 (copy), l_UIGridLayout_1 (copy), l_MainList_0 (copy), l_UIGridLayout_0 (copy), l_List_0 (copy), l_Players_0 (copy), v47 (copy), v48 (ref), l_TradeQuest_0 (copy), v85 (copy)
    local l_Close_0 = l_Menu_0:FindFirstChild("Close");
    if l_Close_0 and l_Close_0:FindFirstChild("Button") then
        v4.Fire("InitButton", l_Close_0.Button);
        l_Close_0.Button.Activated:Connect(function() --[[ Line: 1258 ]]
            -- upvalues: v4 (ref)
            v4.Fire("CloseMenu", "Trade");
        end);
    end;
    local l_Inner_4 = l_Menu_0:FindFirstChild("Inner");
    if l_Inner_4 then
        local l_Buttons_0 = l_Inner_4:FindFirstChild("Buttons");
        if l_Buttons_0 then
            local l_Trade_3 = l_Buttons_0:FindFirstChild("Trade");
            if l_Trade_3 and l_Trade_3:FindFirstChild("Button") then
                local l_Button_3 = l_Trade_3.Button;
                v4.Fire("InitButton", l_Button_3);
                l_Button_3.Activated:Connect(function() --[[ Line: 1273 ]]
                    -- upvalues: l_Inner_4 (copy)
                    local l_Trade_4 = l_Inner_4:FindFirstChild("Trade");
                    local l_History_2 = l_Inner_4:FindFirstChild("History");
                    if l_Trade_4 then
                        l_Trade_4.Visible = true;
                    end;
                    if l_History_2 then
                        l_History_2.Visible = false;
                    end;
                    _G:Play("Click");
                end);
            end;
            local l_History_3 = l_Buttons_0:FindFirstChild("History");
            if l_History_3 and l_History_3:FindFirstChild("Button") then
                local l_Button_4 = l_History_3.Button;
                v4.Fire("InitButton", l_Button_4);
                l_Button_4.Activated:Connect(function() --[[ Line: 1289 ]]
                    -- upvalues: v330 (ref), l_LocalPlayer_0 (ref)
                    _G:Play("Click");
                    v330(l_LocalPlayer_0.UserId);
                end);
            end;
        end;
    end;
    local l_status_10, l_result_10 = pcall(function() --[[ Line: 1298 ]]
        -- upvalues: l_PlayerGui_0 (ref)
        return l_PlayerGui_0:WaitForChild("Game");
    end);
    if l_status_10 and l_result_10 then
        local l_Left_0 = l_result_10:FindFirstChild("Left");
        if l_Left_0 then
            local l_Buttons_1 = l_Left_0:FindFirstChild("Buttons");
            if l_Buttons_1 then
                local l_Trading_3 = l_Buttons_1:FindFirstChild("Trading");
                if l_Trading_3 and l_Trading_3:FindFirstChild("Button") then
                    v4.Fire("InitButton", l_Trading_3.Button);
                    l_Trading_3.Button.Activated:Connect(function() --[[ Line: 1310 ]]
                        -- upvalues: l_Trade_0 (ref), v4 (ref), v78 (ref)
                        local l_l_Trade_0_2 = l_Trade_0;
                        local v356;
                        if not l_l_Trade_0_2 then
                            v356 = false;
                        else
                            local l_l_l_Trade_0_2_Attribute_0 = l_l_Trade_0_2:GetAttribute("Enabled");
                            v356 = if l_l_l_Trade_0_2_Attribute_0 ~= nil then l_l_l_Trade_0_2_Attribute_0 == true else l_l_Trade_0_2.Enabled;
                        end;
                        local v358;
                        if v356 then
                            v4.Fire("CloseMenu", "Trade");
                            v358 = false;
                        else
                            v78();
                            v358 = true;
                        end;
                        if v358 then
                            _G:Play("Click");
                        end;
                    end);
                end;
            end;
        end;
    end;
    for _, v360 in ipairs(l_Menu_1:GetChildren()) do
        v340(v360);
        if v42 and v43 then
            break;
        end;
    end;
    local function v363() --[[ Line: 1328 ]] --[[ Name: bindRequestButtons ]]
        -- upvalues: l_Menu_1 (ref), v42 (ref), v43 (ref), v44 (ref), v4 (ref), v91 (ref), v45 (ref), v93 (ref)
        local l_Accept_0 = l_Menu_1:FindFirstChild("Accept");
        local l_Decline_0 = l_Menu_1:FindFirstChild("Decline");
        if l_Accept_0 and l_Accept_0:FindFirstChild("Button") then
            v42 = l_Accept_0.Button;
        end;
        if l_Decline_0 and l_Decline_0:FindFirstChild("Button") then
            v43 = l_Decline_0.Button;
        end;
        if v42 and not v44 then
            v44 = true;
            v4.Fire("InitButton", v42);
            v42.Activated:Connect(v91);
        end;
        if v43 and not v45 then
            v45 = true;
            v4.Fire("InitButton", v43);
            v43.Activated:Connect(v93);
        end;
    end;
    v363();
    if not v44 or not v45 then
        l_Menu_1.ChildAdded:Connect(function(v364) --[[ Line: 1356 ]]
            -- upvalues: v340 (ref), v363 (copy)
            v340(v364);
            v363();
        end);
    end;
    v4.Fire("InitButton", l_Button_0);
    l_Button_0.Activated:Connect(function() --[[ Line: 1364 ]]
        -- upvalues: v49 (ref), v56 (ref), v4 (ref), v57 (ref), v3 (ref)
        if not v49 then
            return;
        elseif v56 then
            _G:Play("Error");
            v4.Fire("Notification", "Please wait before readying up!", Color3.fromRGB(255, 39, 8));
            return;
        elseif v57 then
            if v49.ready.self then
                v3:FireServer("ReadyUp", true, true);
            end;
            return;
        elseif v49.ready.self then
            v3:FireServer("ReadyUp", true, true);
            return;
        else
            v3:FireServer("ReadyUp", false, true);
            return;
        end;
    end);
    v4.Fire("InitButton", l_Button_1);
    l_Button_1.Activated:Connect(function() --[[ Line: 1389 ]]
        -- upvalues: v49 (ref), v134 (ref), v3 (ref)
        if v49 then
            if v49.isHistoryView then
                v134();
                return;
            else
                v3:FireServer("CloseTrade");
            end;
        end;
    end);
    l_TextBox_1.FocusLost:Connect(function(_) --[[ Line: 1401 ]]
        -- upvalues: v49 (ref), l_TextBox_1 (ref), v55 (ref), v3 (ref), v111 (ref)
        if not v49 then
            l_TextBox_1.Text = "";
            return;
        elseif l_TextBox_1.Text == "" then
            return;
        else
            local v366 = tonumber(l_TextBox_1.Text);
            if not v366 then
                l_TextBox_1.Text = "";
                return;
            else
                local v367 = math.min(math.max(0, (math.floor(v366))), v55);
                local v368 = v3:InvokeServer("UpdateTradeTokens1", false, v367);
                if typeof(v368) == "number" then
                    l_TextBox_1.Text = tostring(v368);
                    v49.tokens.self = v368;
                    v111(5);
                    return;
                else
                    l_TextBox_1.Text = "";
                    return;
                end;
            end;
        end;
    end);
    l_TextBox_0:GetPropertyChangedSignal("Text"):Connect(function() --[[ Line: 1430 ]]
        -- upvalues: v54 (ref), l_TextBox_0 (ref), v154 (ref)
        v54 = l_TextBox_0.Text;
        v154();
    end);
    l_UIGridLayout_1:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() --[[ Line: 1436 ]]
        -- upvalues: l_MainList_0 (ref), l_UIGridLayout_1 (ref)
        local l_l_MainList_0_2 = l_MainList_0;
        local l_l_UIGridLayout_1_1 = l_UIGridLayout_1;
        if not l_l_UIGridLayout_1_1 then
            return;
        else
            local l_AbsoluteContentSize_2 = l_l_UIGridLayout_1_1.AbsoluteContentSize;
            l_l_MainList_0_2.CanvasSize = UDim2.fromOffset(l_AbsoluteContentSize_2.X, l_AbsoluteContentSize_2.Y + 20);
            return;
        end;
    end);
    l_UIGridLayout_0:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() --[[ Line: 1440 ]]
        -- upvalues: l_List_0 (ref), l_UIGridLayout_0 (ref)
        local l_l_List_0_2 = l_List_0;
        local l_l_UIGridLayout_0_0 = l_UIGridLayout_0;
        if not l_l_UIGridLayout_0_0 then
            return;
        else
            local l_AbsoluteContentSize_3 = l_l_UIGridLayout_0_0.AbsoluteContentSize;
            l_l_List_0_2.CanvasSize = UDim2.fromOffset(l_AbsoluteContentSize_3.X, l_AbsoluteContentSize_3.Y + 20);
            return;
        end;
    end);
    l_Players_0.PlayerRemoving:Connect(function(v375) --[[ Line: 1444 ]]
        -- upvalues: v47 (ref), v48 (ref), l_TradeQuest_0 (ref), v85 (ref)
        for v376 = #v47, 1, -1 do
            if v47[v376].userId == v375.UserId then
                table.remove(v47, v376);
            end;
        end;
        if v48 and v48.userId == v375.UserId then
            v48 = nil;
            l_TradeQuest_0.Enabled = false;
            if #v47 > 0 then
                table.remove(v47, 1);
            end;
            v85();
        end;
    end);
end;
local function _(v378) --[[ Line: 1459 ]] --[[ Name: getTradableTokens ]]
    if not v378 then
        return 0;
    else
        return v378.PaidTokens or 0;
    end;
end;
local function v392() --[[ Line: 1464 ]] --[[ Name: initInventory ]]
    -- upvalues: v6 (copy), v52 (ref), v55 (ref), l_TextBox_1 (copy), v5 (copy), v195 (copy), v49 (ref), v178 (copy)
    if not v6.Loaded then
        v6:Connect("DataLoaded", function(v380) --[[ Line: 1467 ]]
            -- upvalues: v52 (ref), v55 (ref), l_TextBox_1 (ref), v5 (ref)
            if v380 and v380.Pets then
                v52 = table.clone(v380.Pets);
                local v381 = 0;
                for _ in pairs(v52) do
                    v381 = v381 + 1;
                end;
                local l_Items_0 = v380.Items;
                v55 = math.max(not l_Items_0 and 0 or l_Items_0.PaidTokens or 0 or 0, 0);
                l_TextBox_1.PlaceholderText = v5:Abbreviate(v55, true, true) .. " available";
            end;
        end);
    else
        v52 = table.clone(v6.Data.Pets or {});
        local v384 = 0;
        for _ in pairs(v52) do
            v384 = v384 + 1;
        end;
        print("[Trade] Init: Loaded", v384, "pets into inventory (lazy - no frames yet)");
        local l_Items_1 = v6.Data.Items;
        v55 = math.max(not l_Items_1 and 0 or l_Items_1.PaidTokens or 0 or 0, 0);
        l_TextBox_1.PlaceholderText = v5:Abbreviate(v55, true, true) .. " available";
    end;
    v195();
    v6:Connect("Pets", function(v387) --[[ Line: 1490 ]]
        -- upvalues: v52 (ref), v49 (ref), v178 (ref)
        if v387 and v387.Pets then
            v52 = table.clone(v387.Pets);
            local v388 = 0;
            for _ in pairs(v52) do
                v388 = v388 + 1;
            end;
            print("[Trade] Pets updated:", v388, "pets (data only)");
            if v49 then
                v178();
            end;
        end;
    end);
    v6:Connect("Items", function(v390) --[[ Line: 1505 ]]
        -- upvalues: v55 (ref), l_TextBox_1 (ref), v5 (ref)
        if not v390 or not v390.Items then
            return;
        else
            local l_Items_2 = v390.Items;
            v55 = math.max(not l_Items_2 and 0 or l_Items_2.PaidTokens or 0 or 0, 0);
            l_TextBox_1.PlaceholderText = v5:Abbreviate(v55, true, true) .. " available";
            return;
        end;
    end);
end;
v46.Init = function(_) --[[ Line: 1514 ]] --[[ Name: Init ]]
    -- upvalues: l_Trade_0 (copy), l_TradeQuest_0 (copy), l_Trading_0 (copy), l_Processing_0 (copy), v8 (copy), v377 (copy), v335 (copy), v392 (copy)
    l_Trade_0.Enabled = false;
    l_TradeQuest_0.Enabled = false;
    l_Trading_0.Enabled = false;
    l_Processing_0.Visible = false;
    v8:Start();
    v377();
    v335();
    v392();
end;
return v46;