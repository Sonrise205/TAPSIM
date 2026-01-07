local l_Players_0 = game:GetService("Players");
local l_ReplicatedStorage_0 = game:GetService("ReplicatedStorage");
local l_RunService_0 = game:GetService("RunService");
local l_CollectionService_0 = game:GetService("CollectionService");
local l_UserInputService_0 = game:GetService("UserInputService");
local v5 = require(l_ReplicatedStorage_0.Modules.Tweens);
local v6 = require(l_ReplicatedStorage_0.Modules.Network);
local v7 = require(l_ReplicatedStorage_0.Modules.Signal);
local v8 = require(l_ReplicatedStorage_0.Modules.Short);
local v9 = require(l_ReplicatedStorage_0.Modules.ItemData);
local v10 = require(l_ReplicatedStorage_0.Game.Replication);
local v11 = require(l_ReplicatedStorage_0.Game.PetStats.Rarities);
local l_LocalPlayer_0 = l_Players_0.LocalPlayer;
local l_Mouse_0 = l_Players_0.LocalPlayer:GetMouse();
local v14 = Instance.new("Model", workspace);
local v15 = Instance.new("Highlight", v14);
v15.DepthMode = Enum.HighlightDepthMode.Occluded;
v15.OutlineTransparency = 1;
v15.FillTransparency = 0.6;
v15.OutlineColor = Color3.fromRGB(255, 255, 255);
v15.FillColor = Color3.fromRGB(255, 255, 255);
local v16 = Instance.new("Model", workspace);
local v17 = Instance.new("Highlight", v16);
v17.DepthMode = Enum.HighlightDepthMode.Occluded;
v17.OutlineTransparency = 1;
v17.FillTransparency = 0.3;
v17.OutlineColor = Color3.fromRGB(255, 255, 255);
v17.FillColor = Color3.fromRGB(255, 255, 255);
local v18 = nil;
local v19 = nil;
local v20 = nil;
local l_RightHud_0 = l_LocalPlayer_0.PlayerGui:WaitForChild("RightHud");
local v22 = nil;
local v23 = nil;
local v24 = nil;
local l_Items_0 = l_RightHud_0.Main.RightUI.Items;
local l_Holder_0 = l_Items_0.List.Holder;
local v27 = l_Holder_0:FindFirstChildWhichIsA("UIListLayout") or l_Holder_0:FindFirstChildWhichIsA("UIGridLayout");
local v28 = {};
local v29 = {};
local v30 = {};
local v31 = {};
local v32 = false;
local v33 = false;
local v34 = false;
local v35 = {};
local v36 = {};
local v37 = {
    "Eggs", 
    "Items", 
    "Treats", 
    "Boosts"
};
local v38 = (#v37 + 1) * 1000000;
local v39 = {
    ["Secret III"] = 1, 
    ["Secret II"] = 2, 
    ["Secret I"] = 3, 
    Secret = 4, 
    Exclusive = 5, 
    Godly = 6, 
    Mythical = 7, 
    Mythic = 7, 
    Legendary = 8, 
    Epic = 9, 
    Rare = 10, 
    Uncommon = 11, 
    Common = 12, 
    Basic = 13
};
local v40 = {
    Eggs = {
        LabelName = "EggsCategory", 
        ItemCount = 0
    }, 
    Items = {
        LabelName = "ItemsCategory", 
        ItemCount = 0
    }, 
    Treats = {
        LabelName = "TreatsCategory", 
        ItemCount = 0
    }, 
    Boosts = {
        LabelName = "BoostsCategory", 
        ItemCount = 0
    }
};
local v41 = {
    Header = "#FFD369", 
    Quantity = "#7CFFCA", 
    Type = "#FFE099", 
    Description = "#E6ECFF"
};
local function v43(v42) --[[ Line: 110 ]] --[[ Name: colorToHex ]]
    -- upvalues: v41 (copy)
    if typeof(v42) ~= "Color3" then
        return v41.Header;
    else
        return string.format("#%02X%02X%02X", math.floor(v42.R * 255 + 0.5), math.floor(v42.G * 255 + 0.5), (math.floor(v42.B * 255 + 0.5)));
    end;
end;
local _ = function() --[[ Line: 123 ]] --[[ Name: updateNoItemsVisibility ]]
    -- upvalues: v28 (copy), l_Holder_0 (copy)
    local v44 = false;
    for _, _ in pairs(v28) do
        v44 = true;
        break;
    end;
    local l_NoItems_0 = l_Holder_0:FindFirstChild("NoItems");
    if l_NoItems_0 then
        l_NoItems_0.Visible = not v44;
    end;
end;
local function _() --[[ Line: 138 ]] --[[ Name: getItemsListLayout ]]
    -- upvalues: v27 (ref), l_Holder_0 (copy)
    if v27 and v27.Parent == l_Holder_0 then
        return v27;
    else
        v27 = l_Holder_0:FindFirstChildWhichIsA("UIListLayout") or l_Holder_0:FindFirstChildWhichIsA("UIGridLayout");
        return v27;
    end;
end;
local function _() --[[ Line: 147 ]] --[[ Name: getItemsListPaddingPixels ]]
    -- upvalues: l_Holder_0 (copy)
    local l_UIPadding_0 = l_Holder_0:FindFirstChildWhichIsA("UIPadding");
    if not l_UIPadding_0 then
        return 0;
    else
        local l_Y_0 = l_Holder_0.AbsoluteSize.Y;
        return l_UIPadding_0.PaddingTop.Scale * l_Y_0 + l_UIPadding_0.PaddingTop.Offset + (l_UIPadding_0.PaddingBottom.Scale * l_Y_0 + l_UIPadding_0.PaddingBottom.Offset);
    end;
end;
local function v62(v53) --[[ Line: 175 ]] --[[ Name: updateItemListCanvas ]]
    -- upvalues: v34 (ref), l_Holder_0 (copy), v27 (ref)
    if v34 then
        return;
    elseif not l_Holder_0 or not l_Holder_0:IsA("ScrollingFrame") then
        return;
    else
        local v54;
        if v27 and v27.Parent == l_Holder_0 then
            v54 = v27;
        else
            v27 = l_Holder_0:FindFirstChildWhichIsA("UIListLayout") or l_Holder_0:FindFirstChildWhichIsA("UIGridLayout");
            v54 = v27;
        end;
        if not v54 then
            return;
        else
            v34 = true;
            l_Holder_0.AutomaticCanvasSize = Enum.AutomaticSize.None;
            local l_UIPadding_1 = l_Holder_0:FindFirstChildWhichIsA("UIPadding");
            local v56;
            if not l_UIPadding_1 then
                v56 = 0;
            else
                local l_Y_1 = l_Holder_0.AbsoluteSize.Y;
                v56 = l_UIPadding_1.PaddingTop.Scale * l_Y_1 + l_UIPadding_1.PaddingTop.Offset + (l_UIPadding_1.PaddingBottom.Scale * l_Y_1 + l_UIPadding_1.PaddingBottom.Offset);
            end;
            local v58 = v54.AbsoluteContentSize.Y + v56;
            local l_CanvasPosition_0 = l_Holder_0.CanvasPosition;
            l_Holder_0.CanvasSize = UDim2.new(0, 0, 0, v58);
            local v60 = math.max(0, v58 - l_Holder_0.AbsoluteSize.Y);
            local v61 = math.clamp(l_CanvasPosition_0.Y, 0, v60);
            if v53 == false then
                v61 = 0;
            end;
            if math.abs(l_CanvasPosition_0.Y - v61) > 0.001 or v60 < l_CanvasPosition_0.Y then
                l_Holder_0.CanvasPosition = Vector2.new(l_CanvasPosition_0.X, v61);
            end;
            v34 = false;
            return;
        end;
    end;
end;
local function v64() --[[ Line: 214 ]] --[[ Name: bindItemsLayoutListener ]]
    -- upvalues: v27 (ref), l_Holder_0 (copy), v22 (ref), v62 (copy)
    local v63;
    if v27 and v27.Parent == l_Holder_0 then
        v63 = v27;
    else
        v27 = l_Holder_0:FindFirstChildWhichIsA("UIListLayout") or l_Holder_0:FindFirstChildWhichIsA("UIGridLayout");
        v63 = v27;
    end;
    if not v63 then
        return;
    else
        if v22 then
            v22:Disconnect();
        end;
        v22 = v63:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function() --[[ Line: 224 ]]
            -- upvalues: v62 (ref)
            v62();
        end);
        return;
    end;
end;
local function v66() --[[ Line: 229 ]] --[[ Name: bindItemsPaddingListener ]]
    -- upvalues: v23 (ref), v24 (ref), l_Holder_0 (copy), v62 (copy)
    if v23 then
        v23:Disconnect();
        v23 = nil;
    end;
    if v24 then
        v24:Disconnect();
        v24 = nil;
    end;
    local l_UIPadding_2 = l_Holder_0:FindFirstChildWhichIsA("UIPadding");
    if not l_UIPadding_2 then
        return;
    else
        v23 = l_UIPadding_2:GetPropertyChangedSignal("PaddingTop"):Connect(function() --[[ Line: 245 ]]
            -- upvalues: v62 (ref)
            v62();
        end);
        v24 = l_UIPadding_2:GetPropertyChangedSignal("PaddingBottom"):Connect(function() --[[ Line: 249 ]]
            -- upvalues: v62 (ref)
            v62();
        end);
        return;
    end;
end;
v64();
v66();
v62(true);
l_Holder_0.ChildAdded:Connect(function(v67) --[[ Line: 258 ]]
    -- upvalues: v27 (ref), v64 (copy), v62 (copy), v66 (copy)
    if v67:IsA("UIListLayout") or v67:IsA("UIGridLayout") then
        v27 = v67;
        v64();
        v62();
        return;
    else
        if v67:IsA("UIPadding") then
            v66();
            v62();
        end;
        return;
    end;
end);
l_Holder_0.ChildRemoved:Connect(function(v68) --[[ Line: 269 ]]
    -- upvalues: v27 (ref), v22 (ref), v64 (copy), v62 (copy), v66 (copy)
    if v68 == v27 then
        if v22 then
            v22:Disconnect();
            v22 = nil;
        end;
        v27 = nil;
        v64();
        v62();
        return;
    else
        if v68:IsA("UIPadding") then
            v66();
            v62();
        end;
        return;
    end;
end);
l_Holder_0:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 284 ]]
    -- upvalues: v62 (copy)
    v62();
end);
local function _(v69) --[[ Line: 288 ]] --[[ Name: getRarityHex ]]
    -- upvalues: v11 (copy), v43 (copy), v41 (copy)
    local v70 = v69 and v11[v69];
    if typeof(v70) == "table" and v70[1] then
        return v43(v70[1]);
    else
        return v41.Header;
    end;
end;
local function v84(v72, v73, v74) --[[ Line: 297 ]] --[[ Name: buildItemTooltip ]]
    -- upvalues: v9 (copy), v11 (copy), v41 (copy), v8 (copy)
    if not v72 or not v73 then
        return nil;
    else
        local l_v9_ItemData_0 = v9:GetItemData(v73, v72);
        if not l_v9_ItemData_0 then
            return nil;
        else
            local v76 = {};
            local v77 = l_v9_ItemData_0.rarity or l_v9_ItemData_0.data and l_v9_ItemData_0.data.Rarity;
            local l_v76_0 = v76;
            local l_format_0 = string.format;
            local v80 = "<font color=\"%s\"><b>%s</b></font>";
            local v81 = v77 and v11[v77];
            local v82;
            if typeof(v81) == "table" and v81[1] then
                local v83 = v81[1];
                v82 = if typeof(v83) ~= "Color3" then v41.Header else string.format("#%02X%02X%02X", math.floor(v83.R * 255 + 0.5), math.floor(v83.G * 255 + 0.5), (math.floor(v83.B * 255 + 0.5)));
            else
                v82 = v41.Header;
            end;
            table.insert(l_v76_0, l_format_0(v80, v82, l_v9_ItemData_0.name or v72));
            if v74 and v74 > 0 then
                table.insert(v76, string.format("<font color=\"%s\">Quantity: x%s</font>", v41.Quantity, v8:Abbreviate(v74)));
            end;
            if v73 then
                table.insert(v76, string.format("<font color=\"%s\">Type: %s</font>", v41.Type, v73));
            end;
            if l_v9_ItemData_0.description and l_v9_ItemData_0.description ~= "" then
                table.insert(v76, string.format("<font color=\"%s\">%s</font>", v41.Description, l_v9_ItemData_0.description));
            end;
            return table.concat(v76, "\n");
        end;
    end;
end;
local function _(v85) --[[ Line: 342 ]] --[[ Name: getTooltipTarget ]]
    if not v85 then
        return nil;
    else
        return v85:FindFirstChild("Main") or v85:FindFirstChild("Hitbox");
    end;
end;
local function v87(v88, v89) --[[ Line: 351 ]] --[[ Name: attachTooltip ]]
    -- upvalues: v28 (copy), v87 (copy), v84 (copy), v30 (copy), v29 (copy), v7 (copy), v36 (copy)
    v89 = v89 or 0;
    local v90 = v28[v88];
    if not v90 then
        return nil;
    elseif not v90.Parent and v89 < 3 then
        task.wait(0.1);
        return v87(v88, v89 + 1);
    else
        local v91 = if not v90 then nil else v90:FindFirstChild("Main") or v90:FindFirstChild("Hitbox");
        if not v91 then
            if v89 < 3 then
                task.wait(0.1);
                return v87(v88, v89 + 1);
            else
                return nil;
            end;
        else
            local v92 = v84(v88, v30[v88], v29[v88]);
            if v92 then
                v7.Fire("Tooltip", v91, v92);
            else
                v7.Fire("RemoveTooltip", v91);
            end;
            if v36[v88] then
                v36[v88]:Disconnect();
                v36[v88] = nil;
            end;
            v36[v88] = v90.Destroying:Connect(function() --[[ Line: 390 ]]
                -- upvalues: v91 (copy), v7 (ref), v36 (ref), v88 (copy)
                if v91 then
                    v7.Fire("RemoveTooltip", v91);
                end;
                v36[v88] = nil;
            end);
            return true;
        end;
    end;
end;
local function v96() --[[ Line: 400 ]] --[[ Name: removeAllTooltips ]]
    -- upvalues: v28 (copy), v7 (copy)
    for _, v94 in pairs(v28) do
        local v95 = if not v94 then nil else v94:FindFirstChild("Main") or v94:FindFirstChild("Hitbox");
        if v95 then
            v7.Fire("RemoveTooltip", v95);
        end;
    end;
end;
local function v107() --[[ Line: 409 ]] --[[ Name: setupCategoryFrames ]]
    -- upvalues: v37 (copy), v40 (copy), v38 (copy), l_Holder_0 (copy), v32 (ref)
    for v97, v98 in ipairs(v37) do
        local v99 = v40[v98];
        if v99 then
            v99.BaseOrder = v97 * 1000000;
            v99.ItemCount = v99.ItemCount or 0;
        end;
    end;
    for _, v101 in pairs(v40) do
        if not v101.BaseOrder then
            v101.BaseOrder = v38;
            v101.ItemCount = v101.ItemCount or 0;
        end;
    end;
    if not l_Holder_0 then
        return;
    else
        for _, v103 in ipairs(v37) do
            local v104 = v40[v103];
            if v104 then
                local v105 = v104.LabelName or v103 .. "Category";
                local l_l_Holder_0_FirstChild_0 = l_Holder_0:FindFirstChild(v105);
                v104.Label = l_l_Holder_0_FirstChild_0;
                if l_l_Holder_0_FirstChild_0 then
                    l_l_Holder_0_FirstChild_0.LayoutOrder = v104.BaseOrder;
                    l_l_Holder_0_FirstChild_0.Visible = v104.ItemCount > 0;
                else
                    warn(("[RightHudItems] Missing category label '%s' in Items UI."):format(v105));
                end;
            end;
        end;
        v32 = true;
        return;
    end;
end;
local function _() --[[ Line: 448 ]] --[[ Name: ensureCategoriesInitialized ]]
    -- upvalues: v32 (ref), v107 (copy)
    if not v32 then
        v107();
    end;
end;
local function _(v109, v110) --[[ Line: 454 ]] --[[ Name: adjustCategoryCount ]]
    -- upvalues: v40 (copy), v32 (ref)
    if not v109 then
        return;
    else
        local v111 = v40[v109];
        if not v111 then
            return;
        else
            v111.ItemCount = math.max(0, (v111.ItemCount or 0) + (v110 or 0));
            if v32 and v111.Label then
                v111.Label.Visible = v111.ItemCount > 0;
            end;
            return;
        end;
    end;
end;
local function _(v113) --[[ Line: 471 ]] --[[ Name: getItemTypeLower ]]
    if typeof(v113) == "string" then
        return string.lower(v113);
    else
        return "";
    end;
end;
local function _(v115, v116) --[[ Line: 479 ]] --[[ Name: isTreatItem ]]
    if v115 ~= "item" and v115 ~= "items" then
        return false;
    else
        local v117 = v116 and v116.data;
        local v118 = false;
        if v117 ~= nil then
            v118 = v117.XP ~= nil;
        end;
        return v118;
    end;
end;
local function v124(v120, v121) --[[ Line: 488 ]] --[[ Name: isExclusiveEgg ]]
    if v120 == "egg" or v120 == "eggs" then
        return true;
    elseif v120 ~= "item" and v120 ~= "items" then
        return false;
    else
        local v122 = v121 and v121.data;
        if not v122 then
            return false;
        elseif v122.Exclusive == true or v122.ExclusiveEgg == true then
            return true;
        else
            if typeof(v122.Type) == "string" then
                local v123 = string.lower(v122.Type);
                if v123 == "exclusiveegg" or v123 == "egg" then
                    return true;
                end;
            end;
            if typeof(v122.Category) == "string" and string.lower(v122.Category) == "exclusiveegg" then
                return true;
            else
                return false;
            end;
        end;
    end;
end;
local function v130(v125, v126) --[[ Line: 523 ]] --[[ Name: resolveCategory ]]
    -- upvalues: v124 (copy)
    local v127 = if typeof(v125) == "string" then string.lower(v125) else "";
    if v127 == "boost" or v127 == "boosts" then
        return "Boosts";
    else
        local v128;
        if v127 ~= "item" and v127 ~= "items" then
            v128 = false;
        else
            local v129 = v126 and v126.data;
            v128 = false;
            if v129 ~= nil then
                v128 = v129.XP ~= nil;
            end;
        end;
        if v128 then
            return "Treats";
        elseif v127 == "egg" or v127 == "eggs" or v124(v127, v126) then
            return "Eggs";
        elseif v127 == "item" or v127 == "items" then
            return "Items";
        else
            return "Items";
        end;
    end;
end;
local function _(v131) --[[ Line: 545 ]] --[[ Name: computeRarityWeight ]]
    -- upvalues: v39 (copy)
    local v132 = v131 and v131.data;
    local v133 = v132 and v132.Rarity or v131 and v131.rarity;
    if typeof(v133) == "string" then
        local v134 = v39[v133];
        if v134 then
            return v134;
        end;
    elseif typeof(v133) == "number" then
        return (math.clamp(math.floor(v133), 1, 999999));
    end;
    return 50000;
end;
local function _(v136, v137, v138) --[[ Line: 561 ]] --[[ Name: applyItemLayoutOrder ]]
    -- upvalues: v32 (ref), v107 (copy), v40 (copy), v38 (copy), v39 (copy)
    if not v136 then
        return;
    else
        if not v32 then
            v107();
        end;
        local v139 = v40[v137];
        local v140 = v139 and v139.BaseOrder or v38;
        local v141 = v138 and v138.data;
        local v142 = v141 and v141.Rarity or v138 and v138.rarity;
        v136.LayoutOrder = v140 + math.clamp(if typeof(v142) == "string" then v39[v142] or 50000 else if typeof(v142) == "number" then math.clamp(math.floor(v142), 1, 999999) else 50000, 1, 999999);
        return;
    end;
end;
local function _(v144, v145) --[[ Line: 575 ]] --[[ Name: registerItemCategory ]]
    -- upvalues: v31 (copy), v40 (copy), v32 (ref)
    v145 = v145 or "Items";
    v31[v144] = v145;
    local l_v145_0 = v145;
    if not l_v145_0 then
        return;
    else
        local v147 = v40[l_v145_0];
        if not v147 then
            return;
        else
            v147.ItemCount = math.max(0, (v147.ItemCount or 0) + 1);
            if v32 and v147.Label then
                v147.Label.Visible = v147.ItemCount > 0;
            end;
            return;
        end;
    end;
end;
local function _(v149) --[[ Line: 581 ]] --[[ Name: unregisterItemCategory ]]
    -- upvalues: v31 (copy), v40 (copy), v32 (ref)
    local v150 = v31[v149];
    if v150 then
        if v150 then
            local v151 = v40[v150];
            if v151 then
                v151.ItemCount = math.max(0, (v151.ItemCount or 0) + -1);
                if v32 and v151.Label then
                    v151.Label.Visible = v151.ItemCount > 0;
                end;
            end;
        end;
        v31[v149] = nil;
    end;
end;
local function v158(v153) --[[ Line: 589 ]] --[[ Name: destroyItemFrame ]]
    -- upvalues: v28 (copy), v7 (copy), v36 (copy), v31 (copy), v40 (copy), v32 (ref), v29 (copy), v30 (copy)
    local v154 = v28[v153];
    if v154 then
        local v155 = if not v154 then nil else v154:FindFirstChild("Main") or v154:FindFirstChild("Hitbox");
        if v155 then
            v7.Fire("RemoveTooltip", v155);
        end;
        if v36[v153] then
            v36[v153]:Disconnect();
            v36[v153] = nil;
        end;
        v154:Destroy();
        v28[v153] = nil;
    end;
    local v156 = v31[v153];
    if v156 then
        if v156 then
            local v157 = v40[v156];
            if v157 then
                v157.ItemCount = math.max(0, (v157.ItemCount or 0) + -1);
                if v32 and v157.Label then
                    v157.Label.Visible = v157.ItemCount > 0;
                end;
            end;
        end;
        v31[v153] = nil;
    end;
    v29[v153] = nil;
    v30[v153] = nil;
end;
local v170 = {
    Egg = function(v159) --[[ Line: 616 ]]
        -- upvalues: v7 (copy), v10 (copy)
        v7.Fire("OpenMessage", "Open Eggs", "How many " .. v159 .. "'s do you want to open?", {
            {
                "x1", 
                function() --[[ Line: 618 ]]
                    -- upvalues: v7 (ref), v159 (copy)
                    v7.Fire("OpenExclusiveEgg", v159, 1);
                end
            }, 
            {
                "x3", 
                function() --[[ Line: 621 ]]
                    -- upvalues: v7 (ref), v159 (copy)
                    v7.Fire("OpenExclusiveEgg", v159, 3);
                end, 
                (v10.Data.Eggs[v159] or 0) >= 3
            }, 
            {
                "x8", 
                function() --[[ Line: 625 ]]
                    -- upvalues: v7 (ref), v159 (copy)
                    v7.Fire("OpenExclusiveEgg", v159, 8);
                end, 
                (v10.Data.Eggs[v159] or 0) >= 8
            }
        });
    end, 
    Item = function(v160) --[[ Line: 633 ]]
        -- upvalues: v6 (copy)
        if v160 == "New Years Gift" then
            v6:FireServer("OpenGift", v160, 1);
        end;
    end, 
    Boost = function(v161, v162) --[[ Line: 640 ]]
        -- upvalues: v6 (copy), v10 (copy), v8 (copy), v158 (copy), v28 (copy), l_Holder_0 (copy), v7 (copy), l_RightHud_0 (copy)
        if v6:InvokeServer("UseBoost", v161) == true then
            v10.Data.Boosts[v161] = v10.Data.Boosts[v161] - 1;
            local v163 = v10.Data.Boosts[v161] > 999999;
            v162.Main.Quantity.Text = "x" .. (v163 and v8:Abbreviate(v10.Data.Boosts[v161]) or v8:Commas(v10.Data.Boosts[v161]));
            if v10.Data.Boosts[v161] <= 0 then
                v158(v161);
                local v164 = false;
                for _, _ in pairs(v28) do
                    v164 = true;
                    break;
                end;
                local l_NoItems_1 = l_Holder_0:FindFirstChild("NoItems");
                if l_NoItems_1 then
                    l_NoItems_1.Visible = not v164;
                end;
            end;
            v7.Fire("ScreenGlow", Color3.fromRGB(0, 255, 0), 0.5, 0.35, 0.04, l_RightHud_0);
            _G:Play("Potion");
        end;
    end, 
    _startDrag = function(v168, v169) --[[ Line: 662 ]]
        -- upvalues: v20 (ref)
        if not selectedTreat then
            v20 = v168;
            startDrag(v169);
            return;
        else
            selectedTreat = nil;
            stopDrag();
            return;
        end;
    end
};
movePets = function(v171) --[[ Line: 673 ]] --[[ Name: movePets ]]
    -- upvalues: l_CollectionService_0 (copy), l_LocalPlayer_0 (copy), v14 (copy)
    local l_l_CollectionService_0_Tagged_0 = l_CollectionService_0:GetTagged("Pet");
    for _, v174 in pairs(l_l_CollectionService_0_Tagged_0) do
        if v174:GetAttribute("Owner") == l_LocalPlayer_0.UserId then
            if v171 == true then
                v174.Parent = v14;
            else
                v174.Parent = v174:GetAttribute("Golden") and workspace.GoldPets or v174:GetAttribute("Rainbow") and workspace.RainbowPets or workspace.Pets;
            end;
        end;
    end;
end;
stopDrag = function() --[[ Line: 687 ]] --[[ Name: stopDrag ]]
    -- upvalues: v18 (ref), v19 (ref)
    if v18 then
        v18:Disconnect();
        v18 = nil;
    end;
    if v19 then
        v19:Destroy();
        v19 = nil;
    end;
    task.spawn(movePets, false);
end;
local v175 = nil;
startDrag = function(v176) --[[ Line: 702 ]] --[[ Name: startDrag ]]
    -- upvalues: v19 (ref), l_LocalPlayer_0 (copy), v14 (copy), v16 (copy), v18 (ref), l_RunService_0 (copy), l_Mouse_0 (copy), l_CollectionService_0 (copy), v175 (ref), v5 (copy)
    stopDrag();
    movePets(true);
    v19 = v176.Main.Icon:Clone();
    v19.Size = UDim2.fromScale(0.08, 0.08);
    local l_UIAspectRatioConstraint_0 = Instance.new("UIAspectRatioConstraint");
    l_UIAspectRatioConstraint_0.Parent = v19;
    l_UIAspectRatioConstraint_0.AspectRatio = 1;
    v19.Parent = l_LocalPlayer_0.PlayerGui.InfoUI;
    local v178 = RaycastParams.new();
    v178.FilterType = Enum.RaycastFilterType.Include;
    v178.FilterDescendantsInstances = {
        v14, 
        v16
    };
    v18 = l_RunService_0.Heartbeat:Connect(function() --[[ Line: 721 ]]
        -- upvalues: v19 (ref), l_Mouse_0 (ref), v178 (copy), l_CollectionService_0 (ref), v175 (ref), v5 (ref), v16 (ref), v14 (ref)
        v19.Position = UDim2.fromOffset(l_Mouse_0.X, l_Mouse_0.Y);
        local v179 = workspace:Raycast(l_Mouse_0.UnitRay.Origin, l_Mouse_0.UnitRay.Direction * 1000, v178);
        if v179 and v179.Instance then
            local l_Instance_0 = v179.Instance;
            repeat
                l_Instance_0 = l_Instance_0.Parent;
            until l_Instance_0:IsA("Model") and l_CollectionService_0:HasTag(l_Instance_0, "Pet") or l_Instance_0.Name == "Workspace";
            if l_Instance_0 and l_Instance_0:HasTag("Pet") then
                if v175 ~= l_Instance_0 then
                    v5:Tween(v19, 0.2, "Back", "Out", {
                        Size = UDim2.fromScale(0.12, 0.12)
                    });
                end;
                v175 = l_Instance_0;
                v175.Parent = v16;
                return;
            elseif v175 then
                v175.Parent = v14;
                v175 = nil;
                v5:Tween(v19, 0.2, "Back", "Out", {
                    Size = UDim2.fromScale(0.08, 0.08)
                });
                return;
            end;
        elseif v175 then
            v175.Parent = v14;
            v175 = nil;
            v5:Tween(v19, 0.2, "Back", "Out", {
                Size = UDim2.fromScale(0.08, 0.08)
            });
        end;
    end);
end;
mouseClicked = function() --[[ Line: 758 ]] --[[ Name: mouseClicked ]]
    -- upvalues: v18 (ref), v175 (ref), v6 (copy), v20 (ref), v7 (copy)
    if not v18 then
        return;
    else
        stopDrag();
        if v175 and v175:HasTag("Pet") then
            local v181 = v6:InvokeServer("ConvertToXP", v175:GetAttribute("PetId"), {
                {
                    v20, 
                    1
                }
            });
            if v181 and typeof(v181) == "number" then
                v7.Fire("PetTreatAnimation", v175);
                v7.Fire("Popup", "xp", v181);
            end;
        end;
        v20 = nil;
        v175 = nil;
        return;
    end;
end;
local function v189() --[[ Line: 777 ]] --[[ Name: updateVisibleCategories ]]
    -- upvalues: v32 (ref), v107 (copy), v40 (copy), v31 (copy)
    if not v32 then
        v107();
    end;
    for _, v183 in pairs(v40) do
        v183.ItemCount = 0;
    end;
    for _, v185 in pairs(v31) do
        local v186 = v40[v185];
        if v186 then
            v186.ItemCount = (v186.ItemCount or 0) + 1;
        end;
    end;
    for _, v188 in pairs(v40) do
        if v188.Label then
            v188.Label.Visible = (v188.ItemCount or 0) > 0;
        end;
    end;
end;
local function v196(v190) --[[ Line: 800 ]] --[[ Name: updateQuantity ]]
    -- upvalues: v29 (copy), v28 (copy), v8 (copy), v158 (copy), v189 (copy), l_Holder_0 (copy), v87 (copy)
    if not v29[v190] then
        return;
    elseif not v28[v190] then
        return;
    else
        local v191 = v29[v190] > 999999;
        v28[v190].Main.Quantity.Text = "x" .. (v191 and v8:Abbreviate(v29[v190]) or v8:Commas(v29[v190]));
        if v29[v190] <= 0 then
            v158(v190);
            v189();
            local v192 = false;
            for _, _ in pairs(v28) do
                v192 = true;
                break;
            end;
            local l_NoItems_2 = l_Holder_0:FindFirstChild("NoItems");
            if l_NoItems_2 then
                l_NoItems_2.Visible = not v192;
                return;
            end;
        else
            task.spawn(function() --[[ Line: 815 ]]
                -- upvalues: v87 (ref), v190 (copy)
                v87(v190);
            end);
        end;
        return;
    end;
end;
v35.AddItem = function(_, v198, v199, v200) --[[ Line: 821 ]] --[[ Name: AddItem ]]
    -- upvalues: v28 (copy), v30 (copy), v9 (copy), v170 (copy), v29 (copy), v130 (copy), v31 (copy), v40 (copy), v32 (ref), v107 (copy), v38 (copy), v39 (copy), l_Holder_0 (copy), v189 (copy), v87 (copy), v33 (ref), v7 (copy), v196 (copy)
    if not v28[v198] then
        local v201 = v200 or v30[v198];
        if not v201 then
            warn("AddItem: Cannot create item without itemType for " .. tostring(v198));
            return;
        else
            local l_status_0, _ = pcall(function() --[[ Line: 831 ]]
                -- upvalues: v9 (ref), v201 (copy), v198 (copy)
                return (v9:GetItemData(v201, v198));
            end);
            if not l_status_0 then
                return;
            else
                local l_v9_ItemData_1 = v9:GetItemData(v201, v198);
                if l_v9_ItemData_1 then
                    local l_v9_ItemSlot_0 = v9:CreateItemSlot(v198, v201, v199, v170, v29);
                    if not l_v9_ItemSlot_0 then
                        warn("AddItem: Failed to create slot for " .. tostring(v198));
                        return;
                    else
                        v28[v198] = l_v9_ItemSlot_0;
                        v29[v198] = v199;
                        v30[v198] = v201;
                        local v206 = v130(v201, l_v9_ItemData_1);
                        local v207 = v206 or "Items";
                        v31[v198] = v207;
                        local l_v207_0 = v207;
                        if l_v207_0 then
                            local v209 = v40[l_v207_0];
                            if v209 then
                                v209.ItemCount = math.max(0, (v209.ItemCount or 0) + 1);
                                if v32 and v209.Label then
                                    v209.Label.Visible = v209.ItemCount > 0;
                                end;
                            end;
                        end;
                        if l_v9_ItemSlot_0 then
                            if not v32 then
                                v107();
                            end;
                            v207 = v40[v206];
                            l_v207_0 = v207 and v207.BaseOrder or v38;
                            local v210 = l_v9_ItemData_1 and l_v9_ItemData_1.data;
                            local v211 = v210 and v210.Rarity or l_v9_ItemData_1 and l_v9_ItemData_1.rarity;
                            l_v9_ItemSlot_0.LayoutOrder = l_v207_0 + math.clamp(if typeof(v211) == "string" then v39[v211] or 50000 else if typeof(v211) == "number" then math.clamp(math.floor(v211), 1, 999999) else 50000, 1, 999999);
                        end;
                        if l_Holder_0 then
                            l_v9_ItemSlot_0.Parent = l_Holder_0;
                        else
                            warn("AddItem: itemsList is not available for " .. tostring(v198));
                        end;
                        v189();
                        v207 = false;
                        for _, _ in pairs(v28) do
                            v207 = true;
                            break;
                        end;
                        l_v207_0 = l_Holder_0:FindFirstChild("NoItems");
                        if l_v207_0 then
                            l_v207_0.Visible = not v207;
                        end;
                        task.spawn(function() --[[ Line: 867 ]]
                            -- upvalues: v87 (ref), v198 (copy)
                            v87(v198);
                        end);
                        if v33 then
                            v7.Fire("ShowRightHudNotification", "Items");
                        end;
                    end;
                end;
            end;
        end;
    else
        v29[v198] = (v29[v198] or 0) + v199;
        if v33 and v199 >= 1 then
            v7.Fire("ShowRightHudNotification", "Items");
        end;
    end;
    v196(v198);
end;
v35.RemoveItem = function(_, v215, v216) --[[ Line: 889 ]] --[[ Name: RemoveItem ]]
    -- upvalues: v28 (copy), v29 (copy), v158 (copy), v189 (copy), l_Holder_0 (copy), v196 (copy)
    v216 = v216 or 1;
    if v28[v215] then
        v29[v215] = (v29[v215] or 0) - v216;
        if v29[v215] <= 0 then
            v158(v215);
            v189();
            local v217 = false;
            for _, _ in pairs(v28) do
                v217 = true;
                break;
            end;
            local l_NoItems_3 = l_Holder_0:FindFirstChild("NoItems");
            if l_NoItems_3 then
                l_NoItems_3.Visible = not v217;
                return;
            end;
        else
            v196(v215);
        end;
    end;
end;
v35.UpdateItem = function(v221, v222, v223, v224) --[[ Line: 905 ]] --[[ Name: UpdateItem ]]
    -- upvalues: v29 (copy), v30 (copy), v28 (copy)
    if not v29[v222] then
        v29[v222] = 0;
    end;
    local v225 = v29[v222] or 0;
    if v225 < v223 then
        local v226 = v223 - v225;
        local v227 = v224 or v30[v222];
        if not v227 then
            warn("UpdateItem: Cannot add items without itemType for " .. tostring(v222));
            return;
        else
            v221:AddItem(v222, v226, v227);
            return;
        end;
    elseif v223 < v225 then
        v221:RemoveItem(v222, v225 - v223);
        return;
    else
        if v223 == 0 and v28[v222] then
            v221:RemoveItem(v222, v225);
        end;
        return;
    end;
end;
v35.Init = function(_) --[[ Line: 934 ]] --[[ Name: Init ]]
    -- upvalues: v32 (ref), v107 (copy), v189 (copy), v28 (copy), l_Holder_0 (copy), l_Items_0 (copy), v96 (copy), v87 (copy), l_RightHud_0 (copy), l_UserInputService_0 (copy), v18 (ref), v6 (copy), v35 (copy), v10 (copy), v33 (ref), v30 (copy), v29 (copy)
    if not v32 then
        v107();
    end;
    v189();
    local v229 = false;
    for _, _ in pairs(v28) do
        v229 = true;
        break;
    end;
    local l_NoItems_4 = l_Holder_0:FindFirstChild("NoItems");
    if l_NoItems_4 then
        l_NoItems_4.Visible = not v229;
    end;
    l_Items_0:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 948 ]]
        -- upvalues: l_Items_0 (ref), v96 (ref), v28 (ref), v87 (ref)
        if not l_Items_0.Visible then
            v96();
            return;
        else
            for v233, _ in pairs(v28) do
                task.spawn(function() --[[ Line: 954 ]]
                    -- upvalues: v87 (ref), v233 (copy)
                    v87(v233);
                end);
            end;
            return;
        end;
    end);
    l_RightHud_0:GetPropertyChangedSignal("Enabled"):Connect(function() --[[ Line: 962 ]]
        -- upvalues: l_RightHud_0 (ref), v96 (ref)
        if not l_RightHud_0.Enabled then
            v96();
        end;
    end);
    l_UserInputService_0.InputEnded:Connect(function(v235, v236) --[[ Line: 970 ]]
        -- upvalues: l_UserInputService_0 (ref), v18 (ref)
        if v236 then
            return;
        elseif l_UserInputService_0:GetFocusedTextBox() ~= nil then
            return;
        else
            if v235.UserInputType == Enum.UserInputType.MouseButton1 and v18 then
                mouseClicked();
            end;
            return;
        end;
    end);
    l_UserInputService_0.TouchTap:Connect(function(_, v238) --[[ Line: 978 ]]
        -- upvalues: l_UserInputService_0 (ref), v18 (ref)
        if v238 then
            return;
        elseif l_UserInputService_0:GetFocusedTextBox() ~= nil then
            return;
        else
            if v18 then
                mouseClicked();
            end;
            return;
        end;
    end);
    v6:BindEvents({
        AddItem = function(v239, v240, v241) --[[ Line: 988 ]] --[[ Name: AddItem ]]
            -- upvalues: v35 (ref)
            v35:AddItem(v239, v241, v240);
        end, 
        RemoveItem = function(v242, _, v244) --[[ Line: 992 ]] --[[ Name: RemoveItem ]]
            -- upvalues: v35 (ref)
            v35:RemoveItem(v242, v244);
        end
    });
    v10:Connect("DataLoaded", function(v245) --[[ Line: 998 ]]
        -- upvalues: v35 (ref), v33 (ref), v28 (ref), l_Holder_0 (ref)
        local l_Eggs_0 = v245.Eggs;
        for v247, v248 in pairs(l_Eggs_0) do
            v35:AddItem(v247, v248, "Egg");
        end;
        local l_Boosts_0 = v245.Boosts;
        for v250, v251 in pairs(l_Boosts_0) do
            v35:AddItem(v250, v251, "Boost");
        end;
        local l_Items_1 = v245.Items;
        for v253, v254 in pairs(l_Items_1) do
            v35:AddItem(v253, v254, "Item");
        end;
        v33 = true;
        local v255 = false;
        for _, _ in pairs(v28) do
            v255 = true;
            break;
        end;
        local l_NoItems_5 = l_Holder_0:FindFirstChild("NoItems");
        if l_NoItems_5 then
            l_NoItems_5.Visible = not v255;
        end;
    end);
    v10:Connect("Eggs", function(v259) --[[ Line: 1021 ]]
        -- upvalues: v28 (ref), v35 (ref), v30 (ref), v29 (ref)
        local v260 = {};
        for v261, v262 in pairs(v259.Eggs) do
            v260[v261] = true;
            if not v28[v261] then
                v35:AddItem(v261, v262, "Egg");
            else
                v35:UpdateItem(v261, v262, "Egg");
            end;
        end;
        for v263, _ in pairs(v28) do
            if v30[v263] == "Egg" and not v260[v263] then
                v35:RemoveItem(v263, v29[v263] or 0);
            end;
        end;
    end);
    v10:Connect("Boosts", function(v265) --[[ Line: 1041 ]]
        -- upvalues: v28 (ref), v35 (ref)
        for v266, v267 in pairs(v265.Boosts) do
            if not v28[v266] then
                v35:AddItem(v266, v267, "Boost");
            else
                v35:UpdateItem(v266, v267, "Boost");
            end;
        end;
    end);
    v10:Connect("Items", function(v268) --[[ Line: 1051 ]]
        -- upvalues: v28 (ref), v35 (ref)
        for v269, v270 in pairs(v268.Items) do
            if not v28[v269] then
                v35:AddItem(v269, v270, "Item");
            else
                v35:UpdateItem(v269, v270, "Item");
            end;
        end;
    end);
end;
return v35;