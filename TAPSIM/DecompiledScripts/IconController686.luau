local l_StarterGui_0 = game:GetService("StarterGui");
local l_GuiService_0 = game:GetService("GuiService");
local l_HapticService_0 = game:GetService("HapticService");
local l_RunService_0 = game:GetService("RunService");
local l_UserInputService_0 = game:GetService("UserInputService");
local l_TweenService_0 = game:GetService("TweenService");
local l_Players_0 = game:GetService("Players");
local v7 = {};
local _ = game:GetService("ReplicatedStorage");
local v9 = require(script.Parent.Signal);
local v10 = require(script.Parent.TopbarPlusGui);
local v11 = {};
local v12 = false;
local v13 = nil;
local v14 = false;
local _ = function() --[[ Line: 166 ]] --[[ Name: checkTopbarEnabled ]]
    -- upvalues: l_StarterGui_0 (copy)
    local v16, v17 = xpcall(function() --[[ Line: 167 ]]
        -- upvalues: l_StarterGui_0 (ref)
        return l_StarterGui_0:GetCore("TopbarEnabled");
    end, function(_) --[[ Line: 169 ]]
        return true;
    end);
    return v16 and v17;
end;
local _ = function() --[[ Line: 176 ]] --[[ Name: checkTopbarEnabledAccountingForMimic ]]
    -- upvalues: l_StarterGui_0 (copy), v7 (copy)
    local v20, v21 = xpcall(function() --[[ Line: 167 ]]
        -- upvalues: l_StarterGui_0 (ref)
        return l_StarterGui_0:GetCore("TopbarEnabled");
    end, function(_) --[[ Line: 169 ]]
        return true;
    end);
    return v20 and v21 or not v7.mimicCoreGui;
end;
local v23 = {};
v23.left = {
    startScale = 0, 
    getOffset = function() --[[ Line: 187 ]] --[[ Name: getOffset ]]
        -- upvalues: v7 (copy), l_StarterGui_0 (copy)
        local v24 = 48 + v7.leftOffset;
        local v26, v27 = xpcall(function() --[[ Line: 167 ]]
            -- upvalues: l_StarterGui_0 (ref)
            return l_StarterGui_0:GetCore("TopbarEnabled");
        end, function(_) --[[ Line: 169 ]]
            return true;
        end);
        if v26 and v27 and l_StarterGui_0:GetCoreGuiEnabled("Chat") then
            v24 = v24 + 44;
        end;
        return v24;
    end, 
    getStartOffset = function() --[[ Line: 194 ]] --[[ Name: getStartOffset ]]
        -- upvalues: v7 (copy), v23 (copy)
        local l_leftGap_0 = v7.leftGap;
        return v23.left.getOffset() + l_leftGap_0;
    end, 
    records = {}
};
v23.mid = {
    startScale = 0.5, 
    getOffset = function() --[[ Line: 203 ]] --[[ Name: getOffset ]]
        return 0;
    end, 
    getStartOffset = function(v29) --[[ Line: 206 ]] --[[ Name: getStartOffset ]]
        -- upvalues: v7 (copy)
        local l_midGap_0 = v7.midGap;
        return -v29 / 2 + l_midGap_0 / 2;
    end, 
    records = {}
};
v23.right = {
    startScale = 1, 
    getOffset = function() --[[ Line: 214 ]] --[[ Name: getOffset ]]
        -- upvalues: v7 (copy), l_StarterGui_0 (copy)
        local l_rightOffset_0 = v7.rightOffset;
        local v33, v34 = xpcall(function() --[[ Line: 167 ]]
            -- upvalues: l_StarterGui_0 (ref)
            return l_StarterGui_0:GetCore("TopbarEnabled");
        end, function(_) --[[ Line: 169 ]]
            return true;
        end);
        if v33 and v34 and (l_StarterGui_0:GetCoreGuiEnabled(Enum.CoreGuiType.PlayerList) or l_StarterGui_0:GetCoreGuiEnabled(Enum.CoreGuiType.Backpack) or l_StarterGui_0:GetCoreGuiEnabled(Enum.CoreGuiType.EmotesMenu)) then
            l_rightOffset_0 = l_rightOffset_0 + 48;
        end;
        return l_rightOffset_0;
    end, 
    getStartOffset = function(v35) --[[ Line: 221 ]] --[[ Name: getStartOffset ]]
        -- upvalues: v23 (copy)
        return -v35 - v23.right.getOffset();
    end, 
    records = {}
};
v7.topbarEnabled = true;
v7.controllerModeEnabled = false;
local v37, v38 = xpcall(function() --[[ Line: 167 ]]
    -- upvalues: l_StarterGui_0 (copy)
    return l_StarterGui_0:GetCore("TopbarEnabled");
end, function(_) --[[ Line: 169 ]]
    return true;
end);
v7.previousTopbarEnabled = v37 and v38;
v7.leftGap = 12;
v7.midGap = 12;
v7.rightGap = 12;
v7.leftOffset = 0;
v7.rightOffset = 0;
v7.mimicCoreGui = true;
v7.healthbarDisabled = false;
v7.iconAdded = v9.new();
v7.iconRemoved = v9.new();
v7.controllerModeStarted = v9.new();
v7.controllerModeEnded = v9.new();
v7.healthbarDisabledSignal = v9.new();
local v39 = 0;
v7.iconAdded:Connect(function(v40) --[[ Line: 256 ]]
    -- upvalues: v11 (copy), v7 (copy), v39 (ref)
    v11[v40] = true;
    if v7.gameTheme then
        v40:setTheme(v7.gameTheme);
    end;
    v40.updated:Connect(function() --[[ Line: 261 ]]
        -- upvalues: v7 (ref)
        v7.updateTopbar();
    end);
    v40.selected:Connect(function() --[[ Line: 265 ]]
        -- upvalues: v7 (ref), v40 (copy)
        local v41 = v7.getIcons();
        for _, v43 in pairs(v41) do
            if v40.deselectWhenOtherIconSelected and v43 ~= v40 and v43.deselectWhenOtherIconSelected and v43:getToggleState() == "selected" then
                v43:deselect(v40);
            end;
        end;
    end);
    v39 = v39 + 1;
    v40:setOrder(v39);
    if v7.controllerModeEnabled then
        v7._enableControllerModeForIcon(v40, true);
    end;
    v7:_updateSelectionGroup();
    v7.updateTopbar();
end);
v7.iconRemoved:Connect(function(v44) --[[ Line: 284 ]]
    -- upvalues: v11 (copy), v7 (copy)
    v11[v44] = nil;
    v44:setEnabled(false);
    v44:deselect();
    v44.updated:Fire();
    v7:_updateSelectionGroup();
end);
v7.setGameTheme = function(v45) --[[ Line: 295 ]] --[[ Name: setGameTheme ]]
    -- upvalues: v7 (copy)
    v7.gameTheme = v45;
    local v46 = v7.getIcons();
    for _, v48 in pairs(v46) do
        v48:setTheme(v45);
    end;
end;
v7.setDisplayOrder = function(v49) --[[ Line: 303 ]] --[[ Name: setDisplayOrder ]]
    -- upvalues: v10 (copy)
    v10.DisplayOrder = tonumber(v49) or v10.DisplayOrder;
end;
v7.setDisplayOrder(0);
v7.getIcons = function() --[[ Line: 309 ]] --[[ Name: getIcons ]]
    -- upvalues: v11 (copy)
    local v50 = {};
    for v51, _ in pairs(v11) do
        table.insert(v50, v51);
    end;
    return v50;
end;
v7.getIcon = function(v53) --[[ Line: 317 ]] --[[ Name: getIcon ]]
    -- upvalues: v11 (copy)
    for v54, _ in pairs(v11) do
        if v54.name == v53 then
            return v54;
        end;
    end;
    return false;
end;
v7.disableHealthbar = function(v56) --[[ Line: 326 ]] --[[ Name: disableHealthbar ]]
    -- upvalues: v7 (copy)
    local v57 = true;
    if v56 ~= nil then
        v57 = v56;
    end;
    v7.healthbarDisabled = v57;
    v7.healthbarDisabledSignal:Fire(v57);
end;
v7.canShowIconOnTopbar = function(v58) --[[ Line: 332 ]] --[[ Name: canShowIconOnTopbar ]]
    if (v58.enabled == true or v58.accountForWhenDisabled) and v58.presentOnTopbar then
        return true;
    else
        return false;
    end;
end;
v7.getMenuOffset = function(v59) --[[ Line: 339 ]] --[[ Name: getMenuOffset ]]
    -- upvalues: v7 (copy)
    local v60 = v7[v59:get("alignment") .. "Gap"];
    local _ = (v59:get("iconSize") or UDim2.new(0, 32, 0, 32)).X.Offset + v60;
    local v62 = 0;
    local v63 = 0;
    local v64 = 0;
    if v59.menuOpen then
        local l_Offset_0 = v59:get("menuSize").X.Offset;
        local v66 = v59:_getMenuDirection();
        if v66 == "right" then
            return v62, v63 + (l_Offset_0 + v60 / 6), v64;
        elseif v66 == "left" then
            v62 = l_Offset_0 + 4;
            v63 = v63 + v60 / 3;
            v64 = l_Offset_0;
        end;
    end;
    return v62, v63, v64;
end;
v37 = false;
v7.updateTopbar = function() --[[ Line: 365 ]] --[[ Name: updateTopbar ]]
    -- upvalues: v7 (copy), v14 (ref), v37 (ref), l_RunService_0 (copy), v23 (copy), v11 (copy), v10 (copy), l_TweenService_0 (copy)
    local function v74(v67, v68) --[[ Line: 366 ]] --[[ Name: getIncrement ]]
        -- upvalues: v7 (ref)
        local v69 = (v67:get("iconSize", v67:getIconState()) or UDim2.new(0, 32, 0, 32)).X.Offset + v7[v68 .. "Gap"];
        local v70 = 0;
        if v67._parentIcon == nil then
            local v71, v72, v73 = v7.getMenuOffset(v67);
            v70 = v70 + v71;
            v69 = v69 + (v72 + v73);
        end;
        return v69, v70;
    end;
    if v14 then
        v37 = true;
        return false;
    else
        coroutine.wrap(function() --[[ Line: 386 ]]
            -- upvalues: v14 (ref), l_RunService_0 (ref), v23 (ref), v11 (ref), v7 (ref), v74 (copy), v10 (ref), l_TweenService_0 (ref), v37 (ref)
            v14 = true;
            l_RunService_0.Heartbeat:Wait();
            v14 = false;
            for _, v76 in pairs(v23) do
                v76.records = {};
            end;
            for v77, _ in pairs(v11) do
                if v7.canShowIconOnTopbar(v77) then
                    table.insert(v23[v77:get("alignment")].records, v77);
                end;
            end;
            local l_ViewportSize_0 = workspace.CurrentCamera.ViewportSize;
            for v80, v81 in pairs(v23) do
                local l_records_0 = v81.records;
                if #l_records_0 > 1 then
                    if v81.reverseSort then
                        table.sort(l_records_0, function(v83, v84) --[[ Line: 406 ]]
                            return v83:get("order") > v84:get("order");
                        end);
                    else
                        table.sort(l_records_0, function(v85, v86) --[[ Line: 408 ]]
                            return v85:get("order") < v86:get("order");
                        end);
                    end;
                end;
                local v87 = 0;
                for _, v89 in pairs(l_records_0) do
                    v87 = v87 + v74(v89, v80);
                end;
                local v90 = v81.getStartOffset(v87, v80);
                local l_v90_0 = v90;
                local l_X_0 = v10.TopbarContainer.AbsoluteSize.X;
                for _, v94 in pairs(l_records_0) do
                    local v95, v96 = v74(v94, v80);
                    local _ = v81.startScale * l_X_0 + l_v90_0 + v96;
                    l_v90_0 = l_v90_0 + v95;
                end;
                for _, v99 in pairs(l_records_0) do
                    local l_iconContainer_0 = v99.instances.iconContainer;
                    local v101, v102 = v74(v99, v80);
                    local l_topPadding_0 = v99.topPadding;
                    local v104 = UDim2.new(v81.startScale, v90 + v102, l_topPadding_0.Scale, l_topPadding_0.Offset);
                    local _ = string.match(v99.name, "_overflowIcon-");
                    local v106 = v99:get("repositionInfo");
                    if v106 then
                        l_TweenService_0:Create(l_iconContainer_0, v106, {
                            Position = v104
                        }):Play();
                    else
                        l_iconContainer_0.Position = v104;
                    end;
                    v90 = v90 + v101;
                    v99.targetPosition = UDim2.new(0, v104.X.Scale * l_ViewportSize_0.X + v104.X.Offset, 0, v104.Y.Scale * l_ViewportSize_0.Y + v104.Y.Offset);
                end;
            end;
            local function v115(v107, v108, v109) --[[ Line: 444 ]] --[[ Name: getBoundaryX ]]
                -- upvalues: v7 (ref)
                local v110 = v109 or 0;
                local l_Offset_1 = v107:get("iconSize", v107:getIconState()).X.Offset;
                local v112, v113 = v7.getMenuOffset(v107);
                local v114 = v108 == "left" and -v110 - v112 or v108 == "right" and l_Offset_1 + v110 + v113;
                return v107.targetPosition.X.Offset + v114;
            end;
            local function v124(v116, v117) --[[ Line: 453 ]] --[[ Name: getSizeX ]]
                -- upvalues: v7 (ref)
                local v118, v119 = v116:get("iconSize", v116:getIconState(), "beforeDropdown");
                local v120 = v116:get("iconSize", "hovering");
                if v116.wasHoveringBeforeOverflow and v119 and v120 and v120.X.Offset > v119.X.Offset then
                    v119 = v120;
                end;
                local v121 = v117 and v119 or v118;
                local v122, v123 = v7.getMenuOffset(v116);
                return v121.X.Offset + v122 + v123;
            end;
            for v125, v126 in pairs(v23) do
                local l_overflowIcon_0 = v126.overflowIcon;
                if l_overflowIcon_0 then
                    local v128 = v7[v125 .. "Gap"];
                    local v129 = v125 == "left" and "right" or "left";
                    local v130 = v23[v129];
                    local v131 = v7.getIcon("_overflowIcon-" .. v129);
                    local l_Offset_2 = l_overflowIcon_0:get("iconSize", l_overflowIcon_0:getIconState()).X.Offset;
                    local v133, v134 = v7.getMenuOffset(l_overflowIcon_0);
                    local v135 = v125 == "left" and -0 - v133 or v125 == "right" and l_Offset_2 + 0 + v134;
                    local v136 = l_overflowIcon_0.targetPosition.X.Offset + v135;
                    if l_overflowIcon_0.enabled then
                        v136 = v115(l_overflowIcon_0, v129, v128);
                    end;
                    do
                        local l_v136_0, l_v134_0, l_v135_0 = v136, v134, v135;
                        local function _(v140) --[[ Line: 479 ]] --[[ Name: doesExceed ]]
                            -- upvalues: v125 (copy), l_v136_0 (ref)
                            return v125 == "left" and v140 < l_v136_0 or v125 == "right" and l_v136_0 < v140;
                        end;
                        l_Offset_2 = v130.getOffset();
                        if not l_overflowIcon_0.enabled then
                            l_Offset_2 = l_Offset_2 + 10;
                        end;
                        l_v134_0 = v125 == "left" and l_ViewportSize_0.X - l_Offset_2 or v125 == "right" and l_Offset_2;
                        local l_l_v134_0_0 = l_v134_0;
                        l_v135_0 = v125 == "left" and l_l_v134_0_0 < l_v136_0 or v125 == "right" and l_v136_0 < l_l_v134_0_0;
                        l_l_v134_0_0 = function(v143) --[[ Line: 490 ]] --[[ Name: checkBoundaryExceeded ]]
                            -- upvalues: v7 (ref), l_overflowIcon_0 (copy), v115 (copy), v125 (copy), l_v134_0 (ref), l_v136_0 (ref), l_v135_0 (ref)
                            local v144 = #v143;
                            for v145 = 1, v144 do
                                local v146 = v143[v144 + 1 - v145];
                                if v7.canShowIconOnTopbar(v146) then
                                    local v147 = string.match(v146.name, "_overflowIcon-");
                                    if v147 and v144 ~= 1 then
                                        return;
                                    elseif not v147 or v146.enabled then
                                        local v148 = 0;
                                        if not l_overflowIcon_0.enabled then
                                            v148 = 10;
                                        end;
                                        local v149 = v115(v146, v125, v148);
                                        if v125 == "left" and v149 < l_v134_0 or v125 == "right" and l_v134_0 < v149 then
                                            l_v134_0 = v149;
                                            if v125 == "left" and v149 < l_v136_0 or v125 == "right" and l_v136_0 < v149 then
                                                l_v135_0 = true;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                        l_l_v134_0_0(v23[v129].records);
                        l_l_v134_0_0(v23.mid.records);
                        if l_v135_0 then
                            local l_records_1 = v126.records;
                            local v151 = #l_records_1;
                            for v152 = 1, v151 do
                                local v153 = v125 == "left" and l_records_1[v151 + 1 - v152] or v125 == "right" and l_records_1[v152];
                                if v153 ~= l_overflowIcon_0 and v7.canShowIconOnTopbar(v153) then
                                    local l_v128_0 = v128;
                                    local l_Offset_3 = l_overflowIcon_0:get("iconSize", l_overflowIcon_0:getIconState()).X.Offset;
                                    if l_overflowIcon_0.enabled then
                                        l_v128_0 = l_v128_0 + (v128 + l_Offset_3);
                                    end;
                                    local v156 = v115(v153, v129, l_v128_0);
                                    if v125 == "left" and l_v134_0 <= v156 or v125 == "right" and v156 <= l_v134_0 then
                                        if not l_overflowIcon_0.enabled then
                                            local l_iconContainer_1 = l_overflowIcon_0.instances.iconContainer;
                                            local l_Y_0 = l_iconContainer_1.Position.Y;
                                            local v159 = v115(v153, v129, v125 == "left" and -l_iconContainer_1.Size.X.Offset or 0);
                                            l_iconContainer_1.Position = UDim2.new(0, v159, l_Y_0.Scale, l_Y_0.Offset);
                                            l_overflowIcon_0:setEnabled(true);
                                        end;
                                        if #v153.dropdownIcons > 0 then
                                            v153._overflowConvertedToMenu = true;
                                            local l_isSelected_0 = v153.isSelected;
                                            v153:deselect();
                                            local v161 = {};
                                            for _, v163 in pairs(v153.dropdownIcons) do
                                                table.insert(v161, v163);
                                            end;
                                            for _, v165 in pairs(v153.dropdownIcons) do
                                                v165:leave();
                                            end;
                                            v153:setMenu(v161);
                                            if l_isSelected_0 and l_overflowIcon_0.isSelected then
                                                v153:select();
                                            end;
                                        end;
                                        if v153.hovering then
                                            v153.wasHoveringBeforeOverflow = true;
                                        end;
                                        v153:join(l_overflowIcon_0, "dropdown");
                                        if #v153.menuIcons > 0 and v153.menuOpen then
                                            v153:deselect();
                                            v153:select();
                                            l_overflowIcon_0:select();
                                            break;
                                        else
                                            break;
                                        end;
                                    else
                                        break;
                                    end;
                                end;
                            end;
                        else
                            local v166 = nil;
                            local v167 = nil;
                            local v168 = #l_overflowIcon_0.dropdownIcons;
                            if not v131 or not v131.enabled or #v126.records ~= 1 or #v130.records == 1 then
                                for _, v170 in pairs(l_overflowIcon_0.dropdownIcons) do
                                    local v171 = v170:get("order");
                                    if v167 == nil or v125 == "left" and v171 < v166 or v125 == "right" and v166 < v171 then
                                        v166 = v171;
                                        v167 = v170;
                                    end;
                                end;
                            end;
                            if v167 then
                                local v172 = v124(v167, true);
                                local l_Offset_4 = l_overflowIcon_0:get("iconSize", l_overflowIcon_0:getIconState()).X.Offset;
                                local v174, v175 = v7.getMenuOffset(l_overflowIcon_0);
                                local v176 = v129 == "left" and -0 - v174 or v129 == "right" and l_Offset_4 + 0 + v175;
                                local v177 = l_overflowIcon_0.targetPosition.X.Offset + v176;
                                if v168 == 1 then
                                    v177 = v115(l_overflowIcon_0, v125, v128 - 10);
                                end;
                                if v172 < math.abs(l_v134_0 - v177) - v128 * 2 then
                                    if #l_overflowIcon_0.dropdownIcons == 1 then
                                        l_overflowIcon_0:setEnabled(false);
                                    end;
                                    v174 = l_overflowIcon_0.instances.iconContainer;
                                    v175 = v174.Position.Y;
                                    v174.Position = UDim2.new(0, v177, v175.Scale, v175.Offset);
                                    v167:leave();
                                    v167.wasHoveringBeforeOverflow = nil;
                                    if v167._overflowConvertedToMenu then
                                        v167._overflowConvertedToMenu = nil;
                                        v176 = {};
                                        for _, v179 in pairs(v167.menuIcons) do
                                            table.insert(v176, v179);
                                        end;
                                        for _, v181 in pairs(v167.menuIcons) do
                                            v181:leave();
                                        end;
                                        v167:setDropdown(v176);
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
            if v37 then
                v37 = false;
                v7.updateTopbar();
            end;
            return true;
        end)();
        return;
    end;
end;
v7.setTopbarEnabled = function(v182, v183) --[[ Line: 631 ]] --[[ Name: setTopbarEnabled ]]
    -- upvalues: v10 (copy), v12 (ref), l_StarterGui_0 (copy), v7 (copy), v13 (ref), l_HapticService_0 (copy), l_RunService_0 (copy), v11 (copy), l_GuiService_0 (copy)
    if v183 == nil then
        v183 = true;
    end;
    local l_Indicator_0 = v10.Indicator;
    if v183 and not v182 then
        v12 = true;
    elseif v183 and v182 then
        v12 = false;
    end;
    local v186, v187 = xpcall(function() --[[ Line: 167 ]]
        -- upvalues: l_StarterGui_0 (ref)
        return l_StarterGui_0:GetCore("TopbarEnabled");
    end, function(_) --[[ Line: 169 ]]
        return true;
    end);
    local v188 = v186 and v187 or not v7.mimicCoreGui;
    if v7.controllerModeEnabled then
        if v182 then
            if v10.TopbarContainer.Visible or v12 or v13 or not v188 then
                return;
            elseif v183 then
                l_Indicator_0.Visible = v188;
                return;
            else
                if l_HapticService_0:IsVibrationSupported(Enum.UserInputType.Gamepad1) and l_HapticService_0:IsMotorSupported(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Small) then
                    l_HapticService_0:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Small, 1);
                    delay(0.2, function() --[[ Line: 650 ]]
                        -- upvalues: l_HapticService_0 (ref)
                        pcall(function() --[[ Line: 651 ]]
                            -- upvalues: l_HapticService_0 (ref)
                            l_HapticService_0:SetMotor(Enum.UserInputType.Gamepad1, Enum.VibrationMotor.Small, 0);
                        end);
                    end);
                end;
                v10.TopbarContainer.Visible = true;
                v10.TopbarContainer:TweenPosition(UDim2.new(0, 0, 0, 37), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true);
                local v189 = nil;
                v186 = 0;
                v7:_updateSelectionGroup();
                l_RunService_0.Heartbeat:Wait();
                for v190, _ in pairs(v11) do
                    if v7.canShowIconOnTopbar(v190) and (v189 == nil or v190:get("order") > v189:get("order")) then
                        v189 = v190;
                    end;
                    local v192 = -27 + v190.instances.iconContainer.AbsoluteSize.Y + 50;
                    if v186 < v192 then
                        v186 = v192;
                    end;
                end;
                if l_GuiService_0:GetEmotesMenuOpen() then
                    l_GuiService_0:SetEmotesMenuOpen(false);
                end;
                if l_GuiService_0:GetInspectMenuEnabled() then
                    l_GuiService_0:CloseInspectMenu();
                end;
                v187 = v7._previousSelectedObject or v189.instances.iconButton;
                v7._setControllerSelectedObject(v187);
                l_Indicator_0.Image = "rbxassetid://5278151071";
                l_Indicator_0:TweenPosition(UDim2.new(0.5, 0, 0, v186 + 32), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true);
                return;
            end;
        else
            if v183 then
                l_Indicator_0.Visible = false;
            else
                l_Indicator_0.Visible = v188;
            end;
            if not v10.TopbarContainer.Visible then
                return;
            else
                l_GuiService_0.AutoSelectGuiEnabled = true;
                v7:_updateSelectionGroup(true);
                v10.TopbarContainer:TweenPosition(UDim2.new(0, 0, 0, -v10.TopbarContainer.Size.Y.Offset + 32), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true, function() --[[ Line: 713 ]]
                    -- upvalues: v10 (ref)
                    v10.TopbarContainer.Visible = false;
                end);
                l_Indicator_0.Image = "rbxassetid://5278151556";
                l_Indicator_0:TweenPosition(UDim2.new(0.5, 0, 0, 5), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true);
                return;
            end;
        end;
    else
        local l_TopbarContainer_0 = v10.TopbarContainer;
        if v188 then
            l_TopbarContainer_0.Visible = v182;
            return;
        else
            l_TopbarContainer_0.Visible = false;
            return;
        end;
    end;
end;
v7.setGap = function(v194, v195) --[[ Line: 736 ]] --[[ Name: setGap ]]
    -- upvalues: v7 (copy)
    local v196 = tonumber(v194) or 12;
    local v197 = tostring(v195):lower();
    if v197 == "left" or v197 == "mid" or v197 == "right" then
        v7[v197 .. "Gap"] = v196;
        v7.updateTopbar();
        return;
    else
        v7.leftGap = v196;
        v7.midGap = v196;
        v7.rightGap = v196;
        v7.updateTopbar();
        return;
    end;
end;
v7.setLeftOffset = function(v198) --[[ Line: 750 ]] --[[ Name: setLeftOffset ]]
    -- upvalues: v7 (copy)
    v7.leftOffset = tonumber(v198) or 0;
    v7.updateTopbar();
end;
v7.setRightOffset = function(v199) --[[ Line: 755 ]] --[[ Name: setRightOffset ]]
    -- upvalues: v7 (copy)
    v7.rightOffset = tonumber(v199) or 0;
    v7.updateTopbar();
end;
v38 = l_Players_0.LocalPlayer;
local v200 = {};
v38.CharacterAdded:Connect(function() --[[ Line: 762 ]]
    -- upvalues: v200 (ref)
    for _, v202 in pairs(v200) do
        v202:destroy();
    end;
    v200 = {};
end);
v7.clearIconOnSpawn = function(v203) --[[ Line: 768 ]] --[[ Name: clearIconOnSpawn ]]
    -- upvalues: v38 (copy), v200 (ref)
    coroutine.wrap(function() --[[ Line: 769 ]]
        -- upvalues: v38 (ref), v200 (ref), v203 (copy)
        if not v38.Character then
            local _ = v38.CharacterAdded:Wait();
        end;
        table.insert(v200, v203);
    end)();
end;
v7._updateSelectionGroup = function(_, v206) --[[ Line: 778 ]] --[[ Name: _updateSelectionGroup ]]
    -- upvalues: v7 (copy), l_GuiService_0 (copy)
    if v7._navigationEnabled then
        l_GuiService_0:RemoveSelectionGroup("TopbarPlusIcons");
    end;
    if v206 then
        l_GuiService_0.CoreGuiNavigationEnabled = v7._originalCoreGuiNavigationEnabled;
        l_GuiService_0.GuiNavigationEnabled = v7._originalGuiNavigationEnabled;
        v7._navigationEnabled = nil;
        return;
    else
        if v7.controllerModeEnabled then
            local v207 = v7.getIcons();
            local v208 = {};
            for _, v210 in pairs(v207) do
                if not v210.joinedFeatureName or v210._parentIcon[v210.joinedFeatureName .. "Open"] == true then
                    table.insert(v208, v210.instances.iconButton);
                end;
            end;
            l_GuiService_0:AddSelectionTuple("TopbarPlusIcons", table.unpack(v208));
            if not v7._navigationEnabled then
                v7._originalCoreGuiNavigationEnabled = l_GuiService_0.CoreGuiNavigationEnabled;
                v7._originalGuiNavigationEnabled = l_GuiService_0.GuiNavigationEnabled;
                l_GuiService_0.CoreGuiNavigationEnabled = false;
                l_GuiService_0.GuiNavigationEnabled = true;
                v7._navigationEnabled = true;
            end;
        end;
        return;
    end;
end;
local function _() --[[ Line: 806 ]] --[[ Name: getScaleMultiplier ]]
    -- upvalues: l_GuiService_0 (copy)
    if l_GuiService_0:IsTenFootInterface() then
        return 3;
    else
        return 1.3;
    end;
end;
v7._setControllerSelectedObject = function(v212) --[[ Line: 814 ]] --[[ Name: _setControllerSelectedObject ]]
    -- upvalues: v7 (copy), l_GuiService_0 (copy)
    local v213 = v7._controllerSetCount and v7._controllerSetCount + 1 or 0;
    v7._controllerSetCount = v213;
    l_GuiService_0.SelectedObject = v212;
    delay(0.1, function() --[[ Line: 818 ]]
        -- upvalues: v7 (ref), v213 (copy), l_GuiService_0 (ref), v212 (copy)
        if v7._controllerSetCount == v213 then
            l_GuiService_0.SelectedObject = v212;
        end;
    end);
end;
v7._enableControllerMode = function(v214) --[[ Line: 826 ]] --[[ Name: _enableControllerMode ]]
    -- upvalues: v10 (copy), v7 (copy), l_GuiService_0 (copy), l_StarterGui_0 (copy), v11 (copy)
    local l_Indicator_1 = v10.Indicator;
    local _ = v7.getIcon("_TopbarControllerOption");
    if v7.controllerModeEnabled == v214 then
        return;
    else
        v7.controllerModeEnabled = v214;
        if v214 then
            v10.TopbarContainer.Position = UDim2.new(0, 0, 0, 5);
            v10.TopbarContainer.Visible = false;
            local v217 = l_GuiService_0:IsTenFootInterface() and 3 or 1.3;
            l_Indicator_1.Position = UDim2.new(0.5, 0, 0, 5);
            l_Indicator_1.Size = UDim2.new(0, 18 * v217, 0, 18 * v217);
            l_Indicator_1.Image = "rbxassetid://5278151556";
            local v219, v220 = xpcall(function() --[[ Line: 167 ]]
                -- upvalues: l_StarterGui_0 (ref)
                return l_StarterGui_0:GetCore("TopbarEnabled");
            end, function(_) --[[ Line: 169 ]]
                return true;
            end);
            l_Indicator_1.Visible = v219 and v220 or not v7.mimicCoreGui;
            l_Indicator_1.Position = UDim2.new(0.5, 0, 0, 5);
        else
            v10.TopbarContainer.Position = UDim2.new(0, 0, 0, 0);
            local l_TopbarContainer_1 = v10.TopbarContainer;
            local v223, v224 = xpcall(function() --[[ Line: 167 ]]
                -- upvalues: l_StarterGui_0 (ref)
                return l_StarterGui_0:GetCore("TopbarEnabled");
            end, function(_) --[[ Line: 169 ]]
                return true;
            end);
            l_TopbarContainer_1.Visible = v223 and v224 or not v7.mimicCoreGui;
            l_Indicator_1.Visible = false;
            v7._setControllerSelectedObject(nil);
        end;
        for v225, _ in pairs(v11) do
            v7._enableControllerModeForIcon(v225, v214);
        end;
        return;
    end;
end;
v7._enableControllerModeForIcon = function(v227, v228) --[[ Line: 853 ]] --[[ Name: _enableControllerModeForIcon ]]
    -- upvalues: l_GuiService_0 (copy)
    local l__parentIcon_0 = v227._parentIcon;
    local l_joinedFeatureName_0 = v227.joinedFeatureName;
    if l__parentIcon_0 then
        v227:leave();
    end;
    if v228 then
        local v231 = l_GuiService_0:IsTenFootInterface() and 3 or 1.3;
        local v232 = v227:get("iconSize", "deselected");
        local v233 = v227:get("iconSize", "selected");
        local v234 = v227:getHovering("iconSize");
        v227:set("iconSize", UDim2.new(0, v232.X.Offset * v231, 0, v232.Y.Offset * v231), "deselected", "controllerMode");
        v227:set("iconSize", UDim2.new(0, v233.X.Offset * v231, 0, v233.Y.Offset * v231), "selected", "controllerMode");
        if v234 then
            v227:set("iconSize", UDim2.new(0, v233.X.Offset * v231, 0, v233.Y.Offset * v231), "hovering", "controllerMode");
        end;
        v227:set("alignment", "mid", "deselected", "controllerMode");
        v227:set("alignment", "mid", "selected", "controllerMode");
    else
        for _, v236 in pairs({
            "deselected", 
            "selected", 
            "hovering"
        }) do
            local _, v238 = v227:get("alignment", v236, "controllerMode");
            if v238 then
                v227:set("alignment", v238, v236);
            end;
            local _, v240 = v227:get("iconSize", v236, "controllerMode");
            if v240 then
                v227:set("iconSize", v240, v236);
            end;
        end;
    end;
    if l__parentIcon_0 then
        v227:join(l__parentIcon_0, l_joinedFeatureName_0);
    end;
end;
local v241 = false;
v7.setupHealthbar = function() --[[ Line: 890 ]] --[[ Name: setupHealthbar ]]
    -- upvalues: v241 (ref), l_RunService_0 (copy), l_StarterGui_0 (copy), v7 (copy), v38 (copy)
    if v241 then
        return;
    else
        v241 = true;
        task.defer(function() --[[ Line: 898 ]]
            -- upvalues: l_RunService_0 (ref), l_StarterGui_0 (ref), v7 (ref), v38 (ref)
            l_RunService_0.Heartbeat:Wait();
            require(script.Parent).new():setProperty("internalIcon", true):setName("_FakeHealthbar"):setRight():setOrder(-420):setSize(80, 32):lock():set("iconBackgroundTransparency", 1):give(function(v242) --[[ Line: 910 ]]
                -- upvalues: l_StarterGui_0 (ref), v7 (ref), v38 (ref)
                local l_Frame_0 = Instance.new("Frame");
                l_Frame_0.Name = "HealthContainer";
                l_Frame_0.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
                l_Frame_0.BorderSizePixel = 0;
                l_Frame_0.AnchorPoint = Vector2.new(0, 0.5);
                l_Frame_0.Position = UDim2.new(0, 0, 0.5, 0);
                l_Frame_0.Size = UDim2.new(1, 0, 0.2, 0);
                l_Frame_0.Visible = true;
                l_Frame_0.ZIndex = 11;
                l_Frame_0.Parent = v242.instances.iconButton;
                local l_UICorner_0 = Instance.new("UICorner");
                l_UICorner_0.CornerRadius = UDim.new(1, 0);
                l_UICorner_0.Parent = l_Frame_0;
                local v245 = l_Frame_0:Clone();
                v245.Name = "HealthFrame";
                v245.BackgroundColor3 = Color3.fromRGB(167, 167, 167);
                v245.BorderSizePixel = 0;
                v245.AnchorPoint = Vector2.new(0.5, 0.5);
                v245.Position = UDim2.new(0.5, 0, 0.5, 0);
                v245.Size = UDim2.new(1, -2, 1, -2);
                v245.Visible = true;
                v245.ZIndex = 12;
                v245.Parent = l_Frame_0;
                local v246 = v245:Clone();
                v246.Name = "HealthBar";
                v246.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
                v246.BorderSizePixel = 0;
                v246.AnchorPoint = Vector2.new(0, 0.5);
                v246.Position = UDim2.new(0, 0, 0.5, 0);
                v246.Size = UDim2.new(0.5, 0, 1, 0);
                v246.Visible = true;
                v246.ZIndex = 13;
                v246.Parent = v245;
                local v247 = Color3.fromRGB(27, 252, 107);
                local v248 = Color3.fromRGB(250, 235, 0);
                local v249 = Color3.fromRGB(255, 28, 0);
                local function v252(v250, v251) --[[ Line: 953 ]] --[[ Name: powColor3 ]]
                    return Color3.new(math.pow(v250.R, v251), math.pow(v250.G, v251), (math.pow(v250.B, v251)));
                end;
                local function _(v253, v254, v255, v256) --[[ Line: 961 ]] --[[ Name: lerpColor ]]
                    -- upvalues: v252 (copy)
                    v256 = v256 or 2;
                    local l_v256_0 = v256;
                    local v258 = Color3.new(math.pow(v253.R, l_v256_0), math.pow(v253.G, l_v256_0), (math.pow(v253.B, l_v256_0)));
                    local l_v256_1 = v256;
                    l_v256_0 = Color3.new(math.pow(v254.R, l_v256_1), math.pow(v254.G, l_v256_1), (math.pow(v254.B, l_v256_1)));
                    return v252(v258:Lerp(l_v256_0, v255), 1 / v256);
                end;
                local v261 = true;
                local function v279(v262) --[[ Line: 969 ]] --[[ Name: listenToHealth ]]
                    -- upvalues: l_StarterGui_0 (ref), v7 (ref), v261 (ref), v242 (copy), v247 (copy), v248 (copy), v249 (copy), v246 (copy)
                    if not v262 then
                        return;
                    else
                        local v263 = v262:WaitForChild("Humanoid", 10);
                        if not v263 then
                            return;
                        else
                            local function v278() --[[ Line: 978 ]] --[[ Name: updateHealthBar ]]
                                -- upvalues: l_StarterGui_0 (ref), v263 (copy), v7 (ref), v261 (ref), v242 (ref), v247 (ref), v248 (ref), v249 (ref), v246 (ref)
                                local l_l_StarterGui_0_CoreGuiEnabled_0 = l_StarterGui_0:GetCoreGuiEnabled(Enum.CoreGuiType.Health);
                                local v265 = v263.Health / v263.MaxHealth;
                                if v265 == 1 or v7.healthbarDisabled or v261 and l_l_StarterGui_0_CoreGuiEnabled_0 == false then
                                    if v242.enabled then
                                        v242:setEnabled(false);
                                    end;
                                    return;
                                else
                                    if v265 < 1 then
                                        if not v242.enabled then
                                            v242:setEnabled(true);
                                        end;
                                        v261 = false;
                                        if l_l_StarterGui_0_CoreGuiEnabled_0 then
                                            l_StarterGui_0:SetCoreGuiEnabled(Enum.CoreGuiType.Health, false);
                                        end;
                                    end;
                                    local v266 = 1.25 * v265 + -0.125;
                                    local v267 = v266 > 1 and 1 or v266 < 0 and 0 or v266;
                                    local v268 = v265 > 0.5 and v247 or v248;
                                    local v269 = v265 > 0.5 and v248 or v249;
                                    local v270 = (1 - v267) * 2;
                                    local v271 = v265 > 0.5 and 1 - v270 or 2 - v270;
                                    local v272 = nil or 2;
                                    local l_v272_0 = v272;
                                    local v274 = Color3.new(math.pow(v269.R, l_v272_0), math.pow(v269.G, l_v272_0), (math.pow(v269.B, l_v272_0)));
                                    local l_v272_1 = v272;
                                    l_v272_1 = v274:Lerp(Color3.new(math.pow(v268.R, l_v272_1), math.pow(v268.G, l_v272_1), (math.pow(v268.B, l_v272_1))), v271);
                                    local v276 = 1 / v272;
                                    local v277 = Color3.new(math.pow(l_v272_1.R, v276), math.pow(l_v272_1.G, v276), (math.pow(l_v272_1.B, v276)));
                                    v272 = UDim2.new(v265, 0, 1, 0);
                                    v246.BackgroundColor3 = v277;
                                    v246.Size = v272;
                                    return;
                                end;
                            end;
                            v263.HealthChanged:Connect(v278);
                            v7.healthbarDisabledSignal:Connect(v278);
                            v278();
                            return;
                        end;
                    end;
                end;
                v38.CharacterAdded:Connect(function(v280) --[[ Line: 1015 ]]
                    -- upvalues: v279 (copy)
                    v279(v280);
                end);
                task.spawn(v279, v38.Character);
            end);
        end);
        return;
    end;
end;
coroutine.wrap(function() --[[ Line: 1027 ]]
    -- upvalues: l_RunService_0 (copy), l_UserInputService_0 (copy), v7 (copy), l_GuiService_0 (copy), l_StarterGui_0 (copy), v23 (copy)
    l_RunService_0.Heartbeat:Wait();
    local v281 = require(script.Parent);
    local v282 = v281.new():setProperty("internalIcon", true):setName("_TopbarControllerOption"):setOrder(100):setImage("rbxassetid://5278150942"):setRight():setEnabled(false):setTip("Controller mode"):setProperty("deselectWhenOtherIconSelected", false);
    local function v286() --[[ Line: 1045 ]] --[[ Name: determineDisplay ]]
        -- upvalues: l_UserInputService_0 (ref), v282 (copy), v7 (ref)
        local l_MouseEnabled_0 = l_UserInputService_0.MouseEnabled;
        local l_GamepadEnabled_0 = l_UserInputService_0.GamepadEnabled;
        local _ = v282.isSelected;
        if l_MouseEnabled_0 and l_GamepadEnabled_0 then
            v282:setEnabled(true);
            return;
        elseif l_MouseEnabled_0 and not l_GamepadEnabled_0 then
            v282:setEnabled(false);
            v7._enableControllerMode(false);
            v282:deselect();
            return;
        else
            if not l_MouseEnabled_0 and l_GamepadEnabled_0 then
                v282:setEnabled(false);
                v7._enableControllerMode(true);
            end;
            return;
        end;
    end;
    l_UserInputService_0:GetPropertyChangedSignal("MouseEnabled"):Connect(v286);
    l_UserInputService_0.GamepadConnected:Connect(v286);
    l_UserInputService_0.GamepadDisconnected:Connect(v286);
    v286();
    local function v289() --[[ Line: 1069 ]] --[[ Name: iconClicked ]]
        -- upvalues: v282 (copy), v7 (ref)
        local l_isSelected_2 = v282.isSelected;
        local v288 = l_isSelected_2 and "Normal mode" or "Controller mode";
        v282:setTip(v288);
        v7._enableControllerMode(l_isSelected_2);
    end;
    v282.selected:Connect(v289);
    v282.deselected:Connect(v289);
    l_UserInputService_0.InputBegan:Connect(function(v290, _) --[[ Line: 1079 ]]
        -- upvalues: v7 (ref), l_GuiService_0 (ref), l_StarterGui_0 (ref)
        if not v7.controllerModeEnabled then
            return;
        else
            if v290.KeyCode == Enum.KeyCode.DPadDown then
                if not l_GuiService_0.SelectedObject then
                    local v293, v294 = xpcall(function() --[[ Line: 167 ]]
                        -- upvalues: l_StarterGui_0 (ref)
                        return l_StarterGui_0:GetCore("TopbarEnabled");
                    end, function(_) --[[ Line: 169 ]]
                        return true;
                    end);
                    if v293 and v294 or not v7.mimicCoreGui then
                        v7.setTopbarEnabled(true, false);
                    end;
                end;
            elseif v290.KeyCode == Enum.KeyCode.ButtonB then
                v7._previousSelectedObject = l_GuiService_0.SelectedObject;
                v7._setControllerSelectedObject(nil);
                v7.setTopbarEnabled(false, false);
            end;
            v290:Destroy();
            return;
        end;
    end);
    for v295, v296 in pairs(v23) do
        if v295 ~= "mid" then
            local v297 = "_overflowIcon-" .. v295;
            local v298 = v281.new():setProperty("internalIcon", true):setImage(6069276526):setName(v297):setEnabled(false);
            v296.overflowIcon = v298;
            v298.accountForWhenDisabled = true;
            if v295 == "left" then
                v298:setOrder(1e999);
                v298:setLeft();
                v298:set("dropdownAlignment", "right");
            elseif v295 == "right" then
                v298:setOrder(-1e999);
                v298:setRight();
                v298:set("dropdownAlignment", "left");
            end;
            v298.lockedSettings = {
                iconImage = true, 
                order = true, 
                alignment = true
            };
        end;
    end;
end)();
coroutine.wrap(function() --[[ Line: 1123 ]]
    -- upvalues: l_Players_0 (copy), l_StarterGui_0 (copy), v7 (copy)
    local v299 = l_Players_0.LocalPlayer.PlayerScripts:WaitForChild("ChatScript", 4) or game:GetService("Chat"):WaitForChild("ChatScript", 4);
    if not v299 then
        return;
    else
        local l_ChatMain_0 = v299:FindFirstChild("ChatMain");
        if not l_ChatMain_0 then
            return;
        else
            require(l_ChatMain_0).CoreGuiEnabled:connect(function() --[[ Line: 1129 ]]
                -- upvalues: l_StarterGui_0 (ref), v7 (ref)
                local v302, v303 = xpcall(function() --[[ Line: 167 ]]
                    -- upvalues: l_StarterGui_0 (ref)
                    return l_StarterGui_0:GetCore("TopbarEnabled");
                end, function(_) --[[ Line: 169 ]]
                    return true;
                end);
                local v304 = v302 and v303;
                if v304 == v7.previousTopbarEnabled then
                    v7.updateTopbar();
                    return "SetCoreGuiEnabled was called instead of SetCore";
                else
                    if v7.mimicCoreGui then
                        v7.previousTopbarEnabled = v304;
                        if v7.controllerModeEnabled then
                            v7.setTopbarEnabled(false, false);
                        else
                            v7.setTopbarEnabled(v304, false);
                        end;
                    end;
                    v7.updateTopbar();
                    return;
                end;
            end);
            local v306, v307 = xpcall(function() --[[ Line: 167 ]]
                -- upvalues: l_StarterGui_0 (ref)
                return l_StarterGui_0:GetCore("TopbarEnabled");
            end, function(_) --[[ Line: 169 ]]
                return true;
            end);
            local v308 = v306 and v307 or not v7.mimicCoreGui;
            v7.setTopbarEnabled(v308, false);
            return;
        end;
    end;
end)();
l_GuiService_0.MenuClosed:Connect(function() --[[ Line: 1153 ]]
    -- upvalues: v13 (ref), v7 (copy)
    v13 = false;
    if not v7.controllerModeEnabled then
        v7.setTopbarEnabled(v7.topbarEnabled, false);
    end;
end);
l_GuiService_0.MenuOpened:Connect(function() --[[ Line: 1159 ]]
    -- upvalues: v13 (ref), v7 (copy)
    v13 = true;
    v7.setTopbarEnabled(false, false);
end);
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() --[[ Line: 1165 ]]
    -- upvalues: v7 (copy)
    v7.updateTopbar();
end);
return v7;