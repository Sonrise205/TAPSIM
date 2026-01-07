local v0 = {};
v0.__index = v0;
local function _(v1, v2, v3) --[[ Line: 20 ]] --[[ Name: connect ]]
    local v4 = v2:Connect(v3);
    v1[#v1 + 1] = v4;
    return v4;
end;
local function _(v6, v7) --[[ Line: 28 ]] --[[ Name: assignInsertOrderIfMissing ]]
    if v6:GetAttribute("_CustomGridInsertOrder") == nil then
        v6:SetAttribute("_CustomGridInsertOrder", v7);
        return v7 + 1;
    else
        return v7;
    end;
end;
local function v13(v9, v10) --[[ Line: 36 ]] --[[ Name: childSorter ]]
    local v11 = v9.LayoutOrder or 0;
    local v12 = v10.LayoutOrder or 0;
    if v11 ~= v12 then
        return v11 < v12;
    else
        return (v9:GetAttribute("_CustomGridInsertOrder") or 0) < (v10:GetAttribute("_CustomGridInsertOrder") or 0);
    end;
end;
local function v18(v14, v15) --[[ Line: 48 ]] --[[ Name: computeMaxColumns ]]
    if v14 <= 0 then
        return 1;
    else
        local v16 = 1;
        for v17 = 1, 1000 do
            if v17 * v14 + (v17 - 1) * v15 <= 1.000001 then
                v16 = v17;
            else
                break;
            end;
        end;
        return (math.max(1, v16));
    end;
end;
local function _(v19, v20, v21) --[[ Line: 63 ]] --[[ Name: computeUsedWidth ]]
    if v21 <= 0 then
        return 0;
    else
        return v21 * v19 + math.max(v21 - 1, 0) * v20;
    end;
end;
local function v35(v23) --[[ Line: 71 ]] --[[ Name: readGridConfig ]]
    -- upvalues: v18 (copy)
    local v24 = nil;
    for _, v26 in ipairs(v23:GetChildren()) do
        if v26:IsA("UIGridLayout") then
            v24 = v26;
            break;
        end;
    end;
    local v27 = 0.2;
    local v28 = 0.2;
    local v29 = 0.02;
    local v30 = 0.02;
    local v31 = nil;
    if v24 then
        local l_CellSize_0 = v24.CellSize;
        local l_CellPadding_0 = v24.CellPadding;
        local v34 = tonumber(v24.FillDirectionMaxCells);
        if v34 and v34 > 0 then
            v31 = v34;
        end;
        if l_CellSize_0.X.Scale ~= 0 then
            v27 = l_CellSize_0.X.Scale;
        elseif l_CellSize_0.X.Offset ~= 0 then
            v27 = l_CellSize_0.X.Offset / 100;
        end;
        if l_CellSize_0.Y.Scale ~= 0 then
            v28 = l_CellSize_0.Y.Scale;
        elseif l_CellSize_0.Y.Offset ~= 0 then
            v28 = l_CellSize_0.Y.Offset / 100;
        end;
        if l_CellPadding_0.X.Scale ~= 0 then
            v29 = l_CellPadding_0.X.Scale;
        elseif l_CellPadding_0.X.Offset ~= 0 then
            v29 = l_CellPadding_0.X.Offset / 100;
        end;
        if l_CellPadding_0.Y.Scale ~= 0 then
            v30 = l_CellPadding_0.Y.Scale;
        elseif l_CellPadding_0.Y.Offset ~= 0 then
            v30 = l_CellPadding_0.Y.Offset / 100;
        end;
        v24:Destroy();
    end;
    return v18(v27, v29), v27, v28, v29, v30, v31;
end;
local function _(v36, v37, v38, v39, v40, v41, v42, v43) --[[ Line: 127 ]] --[[ Name: calcTransform ]]
    return (v36 - 1) * (v40 + v42), (v37 - 1) * (v41 + v43), v38 * v40 + (v38 - 1) * v42, v39 * v41 + (v39 - 1) * v43;
end;
local function _(v45) --[[ Line: 136 ]] --[[ Name: newOccGrid ]]
    return {
        columns = v45, 
        rows = {}
    };
end;
local function v50(v47, v48) --[[ Line: 143 ]] --[[ Name: ensureRows ]]
    while #v47.rows < v48 do
        local v49 = table.create(v47.columns, false);
        v47.rows[#v47.rows + 1] = v49;
    end;
end;
local function v59(v51, v52, v53, v54, v55) --[[ Line: 150 ]] --[[ Name: canPlace ]]
    -- upvalues: v50 (copy)
    if v52 + v54 - 1 > v51.columns then
        return false;
    else
        v50(v51, v53 + v55 - 1);
        for v56 = v53, v53 + v55 - 1 do
            local v57 = v51.rows[v56];
            for v58 = v52, v52 + v54 - 1 do
                if v57[v58] then
                    return false;
                end;
            end;
        end;
        return true;
    end;
end;
local function v68(v60, v61, v62, v63, v64) --[[ Line: 166 ]] --[[ Name: occupy ]]
    -- upvalues: v50 (copy)
    v50(v60, v62 + v64 - 1);
    for v65 = v62, v62 + v64 - 1 do
        local v66 = v60.rows[v65];
        for v67 = v61, v61 + v63 - 1 do
            v66[v67] = true;
        end;
    end;
end;
v0.new = function(v69) --[[ Line: 178 ]] --[[ Name: new ]]
    -- upvalues: v0 (copy), v35 (copy)
    local v70 = false;
    if typeof(v69) == "Instance" then
        v70 = v69:IsA("GuiObject");
    end;
    assert(v70, "CustomGrid.new expects a GuiObject container");
    local v71 = setmetatable({}, v0);
    v71.container = v69;
    v71.connections = {};
    v71.childConnections = {};
    v71.placements = {};
    v71.insertCounter = 1;
    v71.pendingRefresh = nil;
    v71.pendingChanges = {
        added = {}, 
        removed = {}, 
        updated = {}
    };
    v71.isProcessing = false;
    v71.layoutTask = nil;
    local v72, v73, v74, v75, v76;
    v70, v72, v73, v74, v75, v76 = v35(v69);
    v71.columns = v70;
    v71.cellX = v72;
    v71.cellY = v73;
    v71.padX = v74;
    v71.padY = v75;
    v71.fillDirectionMaxCells = v76;
    v71._baseCellX = v71.cellX;
    v71._baseCellY = v71.cellY;
    v71._basePadX = v71.padX;
    v71._basePadY = v71.padY;
    v71._baseColumns = v71.columns;
    v70 = v71.fillDirectionMaxCells;
    if not v70 or v70 <= 0 then
        v70 = 6;
    end;
    v70 = math.max(1, (math.min(v70, v71.columns)));
    v71._baseReferenceColumns = v70;
    v71._basePadRatioX = v71.cellX ~= 0 and v71.padX / v71.cellX or 0;
    v71._basePadRatioY = v71.cellY ~= 0 and v71.padY / v71.cellY or v71._basePadRatioX;
    v73 = v71.cellX;
    v74 = v71.padX;
    v75 = v70;
    v72 = v75 <= 0 and 0 or v75 * v73 + math.max(v75 - 1, 0) * v74;
    if v72 <= 0 then
        v73 = v71.cellX;
        v74 = v71.padX;
        v75 = v71.columns;
        v72 = v75 <= 0 and 0 or v75 * v73 + math.max(v75 - 1, 0) * v74;
    end;
    if v72 <= 0 then
        v72 = v71.cellX;
    end;
    v71._baseWidthUsage = math.max(1.0E-4, (math.min(v72, 1)));
    v71._baseAspectYFromX = v71.cellX ~= 0 and v71.cellY / v71.cellX or 1;
    v71._columnOverride = nil;
    v73 = {};
    for _, v78 in ipairs(v69:GetChildren()) do
        if v78:IsA("GuiObject") and not v78:IsA("UIGridLayout") then
            table.insert(v73, v78);
        end;
    end;
    table.sort(v73, function(v79, v80) --[[ Line: 226 ]]
        return (v79.LayoutOrder or 0) < (v80.LayoutOrder or 0);
    end);
    for _, v82 in ipairs(v73) do
        local l_insertCounter_0 = v71.insertCounter;
        local v84;
        if v82:GetAttribute("_CustomGridInsertOrder") == nil then
            v82:SetAttribute("_CustomGridInsertOrder", l_insertCounter_0);
            v84 = l_insertCounter_0 + 1;
        else
            v84 = l_insertCounter_0;
        end;
        v71.insertCounter = v84;
    end;
    v71:_wire();
    v71:Refresh();
    return v71;
end;
v0.Destroy = function(v85) --[[ Line: 240 ]] --[[ Name: Destroy ]]
    if v85.pendingRefresh then
        task.cancel(v85.pendingRefresh);
        v85.pendingRefresh = nil;
    end;
    for v86, v87 in pairs(v85.childConnections) do
        for _, v89 in ipairs(v87) do
            pcall(function() --[[ Line: 247 ]]
                -- upvalues: v89 (copy)
                v89:Disconnect();
            end);
        end;
        v85.childConnections[v86] = nil;
    end;
    for _, v91 in ipairs(v85.connections) do
        pcall(function() --[[ Line: 252 ]]
            -- upvalues: v91 (copy)
            v91:Disconnect();
        end);
    end;
    v85.connections = {};
    v85.placements = {};
    v85.pendingChanges = {
        added = {}, 
        removed = {}, 
        updated = {}
    };
end;
v0.Refresh = function(v92) --[[ Line: 259 ]] --[[ Name: Refresh ]]
    -- upvalues: v18 (copy), v35 (copy)
    if v92._columnOverride then
        v92.columns = math.max(1, v92._columnOverride);
    elseif v92.cellX then
        v92.columns = v18(v92.cellX, v92.padX);
    else
        local v93 = nil;
        local v94, v95, v96, v97, v98, v99 = v35(v92.container);
        v92.columns = v94;
        v92.cellX = v95;
        v92.cellY = v96;
        v92.padX = v97;
        v92.padY = v98;
        v93 = v99;
        if v93 and v93 > 0 then
            v92.fillDirectionMaxCells = v93;
        end;
    end;
    v92.placements = {};
    v92:_layoutFromIndexAsync(1, true, nil);
end;
v0.SetWidth = function(v100, v101) --[[ Line: 281 ]] --[[ Name: SetWidth ]]
    assert(typeof(v101) == "number", "CustomGrid:SetWidth expects a number");
    local v102 = math.floor(v101 + 0.5);
    if v102 < 1 then
        v102 = 1;
    end;
    local v103 = v100._baseCellX or v100.cellX or 0.2;
    local v104 = v100._baseCellY or v100.cellY or v103;
    local v105 = v100._basePadX or v100.padX or 0;
    local v106 = v100._basePadY or v100.padY or v105;
    local l__basePadRatioX_0 = v100._basePadRatioX;
    l__basePadRatioX_0 = if v103 ~= 0 then l__basePadRatioX_0 ~= nil and l__basePadRatioX_0 or v105 / v103 else 0;
    local l__basePadRatioY_0 = v100._basePadRatioY;
    l__basePadRatioY_0 = if v104 ~= 0 then l__basePadRatioY_0 ~= nil and l__basePadRatioY_0 or v106 / v104 else l__basePadRatioX_0;
    local v109 = v100._baseReferenceColumns or v100.columns or v102;
    if v109 < 1 then
        v109 = 1;
    end;
    local l__baseWidthUsage_0 = v100._baseWidthUsage;
    if not l__baseWidthUsage_0 then
        local l_v109_0 = v109;
        l__baseWidthUsage_0 = l_v109_0 <= 0 and 0 or l_v109_0 * v103 + math.max(l_v109_0 - 1, 0) * v105;
    end;
    if l__baseWidthUsage_0 <= 0 then
        local v112 = v100.columns or v109;
        l__baseWidthUsage_0 = v112 <= 0 and 0 or v112 * v103 + math.max(v112 - 1, 0) * v105;
    end;
    if l__baseWidthUsage_0 <= 0 then
        l__baseWidthUsage_0 = math.max(v103, 1.0E-4);
    end;
    l__baseWidthUsage_0 = math.max(1.0E-4, (math.min(l__baseWidthUsage_0, 1)));
    local v113 = v102 + math.max(v102 - 1, 0) * l__basePadRatioX_0;
    if v113 <= 0 then
        v113 = v102;
    end;
    if v113 <= 0 then
        v113 = 1;
    end;
    local v114 = l__baseWidthUsage_0 / v113;
    local v115 = nil;
    if v103 ~= 0 then
        v115 = v114 / v103;
    else
        v115 = 1;
        if v105 ~= 0 then
            v114 = math.max(1.0E-4, v105 / math.max(v102 - 1, 1));
        end;
    end;
    local v116 = nil;
    v116 = if math.abs(l__basePadRatioX_0) > 1.0E-6 then v114 * l__basePadRatioX_0 else v105 * v115;
    local v117 = v104 * v115;
    local v118 = nil;
    v118 = if math.abs(l__basePadRatioY_0) > 1.0E-6 then v117 * l__basePadRatioY_0 else v106 * v115;
    v100.cellX = v114;
    v100.cellY = v117;
    v100.padX = v116;
    v100.padY = v118;
    v100._columnOverride = v102;
    v100.columns = v102;
    v100:Refresh();
end;
v0.ResetWidth = function(v119) --[[ Line: 363 ]] --[[ Name: ResetWidth ]]
    -- upvalues: v18 (copy)
    if not v119._baseCellX then
        return;
    else
        v119.cellX = v119._baseCellX;
        v119.cellY = v119._baseCellY;
        v119.padX = v119._basePadX;
        v119.padY = v119._basePadY;
        v119._columnOverride = nil;
        v119.columns = v119._baseColumns or v18(v119.cellX, v119.padX);
        v119:Refresh();
        return;
    end;
end;
v0._getSortedChildren = function(v120) --[[ Line: 379 ]] --[[ Name: _getSortedChildren ]]
    -- upvalues: v13 (copy)
    local v121 = {};
    for _, v123 in ipairs(v120.container:GetChildren()) do
        if v123:IsA("GuiObject") and not v123:IsA("UIGridLayout") then
            table.insert(v121, v123);
        end;
    end;
    table.sort(v121, function(v124, v125) --[[ Line: 387 ]]
        return (v124.LayoutOrder or 0) < (v125.LayoutOrder or 0);
    end);
    for _, v127 in ipairs(v121) do
        local l_insertCounter_1 = v120.insertCounter;
        local v129;
        if v127:GetAttribute("_CustomGridInsertOrder") == nil then
            v127:SetAttribute("_CustomGridInsertOrder", l_insertCounter_1);
            v129 = l_insertCounter_1 + 1;
        else
            v129 = l_insertCounter_1;
        end;
        v120.insertCounter = v129;
    end;
    table.sort(v121, v13);
    return v121;
end;
v0._wire = function(v130) --[[ Line: 402 ]] --[[ Name: _wire ]]
    local l_connections_0 = v130.connections;
    local v132 = v130.container:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() --[[ Line: 404 ]]
        -- upvalues: v130 (copy)
        v130:Refresh();
    end);
    l_connections_0[#l_connections_0 + 1] = v132;
    l_connections_0 = v130.connections;
    v132 = v130.container.ChildAdded:Connect(function(v133) --[[ Line: 409 ]]
        -- upvalues: v130 (copy)
        if v133:IsA("UIGridLayout") then
            v133:Destroy();
            v130:Refresh();
            return;
        else
            if v133:IsA("GuiObject") then
                v130:_wireChild(v133);
                v130:_onChildAdded(v133);
            end;
            return;
        end;
    end);
    l_connections_0[#l_connections_0 + 1] = v132;
    l_connections_0 = v130.connections;
    v132 = v130.container.ChildRemoved:Connect(function(v134) --[[ Line: 420 ]]
        -- upvalues: v130 (copy)
        if v130.childConnections[v134] then
            for _, v136 in ipairs(v130.childConnections[v134]) do
                pcall(function() --[[ Line: 423 ]]
                    -- upvalues: v136 (copy)
                    v136:Disconnect();
                end);
            end;
            v130.childConnections[v134] = nil;
        end;
        v130:_onChildRemoved(v134);
    end);
    l_connections_0[#l_connections_0 + 1] = v132;
    for _, v138 in ipairs(v130.container:GetChildren()) do
        if v138:IsA("GuiObject") and not v138:IsA("UIGridLayout") then
            v130:_wireChild(v138);
        end;
    end;
end;
v0._wireChild = function(v139, v140) --[[ Line: 438 ]] --[[ Name: _wireChild ]]
    if not v140:IsA("GuiObject") or v140:IsA("UIGridLayout") then
        return;
    else
        local v141 = v139.childConnections[v140];
        if not v141 then
            v141 = {};
            v139.childConnections[v140] = v141;
        end;
        local l_LayoutOrder_0 = v140.LayoutOrder;
        v141[#v141 + 1] = v140:GetPropertyChangedSignal("LayoutOrder"):Connect(function() --[[ Line: 447 ]]
            -- upvalues: v140 (copy), l_LayoutOrder_0 (ref), v139 (copy)
            if v140.LayoutOrder == l_LayoutOrder_0 then
                return;
            else
                l_LayoutOrder_0 = v140.LayoutOrder;
                v139:_onChildUpdated(v140);
                return;
            end;
        end);
        v141[#v141 + 1] = v140:GetAttributeChangedSignal("Ratio"):Connect(function() --[[ Line: 453 ]]
            -- upvalues: v139 (copy), v140 (copy)
            v139:_onChildUpdated(v140);
        end);
        v141[#v141 + 1] = v140:GetPropertyChangedSignal("Visible"):Connect(function() --[[ Line: 457 ]]
            -- upvalues: v139 (copy), v140 (copy)
            v139:_onChildUpdated(v140);
        end);
        return;
    end;
end;
v0._indexOf = function(_, v144, v145) --[[ Line: 464 ]] --[[ Name: _indexOf ]]
    for v146 = 1, #v144 do
        if v144[v146] == v145 then
            return v146;
        end;
    end;
    return nil;
end;
v0._scheduleBatchedRefresh = function(v147) --[[ Line: 472 ]] --[[ Name: _scheduleBatchedRefresh ]]
    if v147.isProcessing then
        return;
    else
        if v147.pendingRefresh then
            task.cancel(v147.pendingRefresh);
        end;
        v147.pendingRefresh = task.spawn(function() --[[ Line: 484 ]]
            -- upvalues: v147 (copy)
            task.wait();
            if not v147.container or not v147.container.Parent then
                v147.pendingRefresh = nil;
                return;
            else
                v147.isProcessing = true;
                v147.pendingRefresh = nil;
                local v148 = {
                    added = {}, 
                    removed = {}, 
                    updated = {}
                };
                for v149, _ in pairs(v147.pendingChanges.added) do
                    v148.added[v149] = true;
                end;
                for v151, _ in pairs(v147.pendingChanges.removed) do
                    v148.removed[v151] = true;
                end;
                for v153, _ in pairs(v147.pendingChanges.updated) do
                    v148.updated[v153] = true;
                end;
                local v155 = 0;
                local v156 = 0;
                local v157 = 0;
                for _ in pairs(v148.added) do
                    v155 = v155 + 1;
                end;
                for _ in pairs(v148.removed) do
                    v156 = v156 + 1;
                end;
                for _ in pairs(v148.updated) do
                    v157 = v157 + 1;
                end;
                for v161, _ in pairs(v148.removed) do
                    v147.placements[v161] = nil;
                end;
                local v163 = 0;
                local v164 = 0;
                for _, v166 in ipairs(v147.container:GetChildren()) do
                    if v166:IsA("GuiObject") and not v166:IsA("UIGridLayout") then
                        v163 = v163 + 1;
                        if not v147.placements[v166] then
                            v164 = v164 + 1;
                        end;
                    end;
                end;
                local v167 = {};
                for _, v169 in ipairs(v147.container:GetChildren()) do
                    if v169:IsA("GuiObject") and not v169:IsA("UIGridLayout") then
                        v167[v169] = true;
                    end;
                end;
                for v170, _ in pairs(v147.placements) do
                    if not v167[v170] then
                        v147.placements[v170] = nil;
                    end;
                end;
                if v156 >= 3 or v155 >= 3 or v164 >= 3 or v157 >= 20 or v163 > 20 then
                    v147.placements = {};
                    v147:_layoutFromIndexAsync(1, true, nil);
                else
                    local v172 = v147:_getSortedChildren();
                    local v173 = nil;
                    for v174, v175 in ipairs(v172) do
                        if v175:IsA("GuiObject") and not v175:IsA("UIGridLayout") and v175.Visible ~= false and (v148.added[v175] or v147.pendingChanges.added[v175] or v148.updated[v175] or v147.pendingChanges.updated[v175] or not v147.placements[v175] or v175.Parent ~= v147.container) then
                            v173 = v174;
                            break;
                        end;
                    end;
                    if v156 > 0 then
                        v173 = 1;
                    end;
                    if v173 then
                        v147:_layoutFromIndex(v173, v156 > 0);
                    end;
                end;
                for v176, _ in pairs(v148.added) do
                    v147.pendingChanges.added[v176] = nil;
                end;
                for v178, _ in pairs(v148.removed) do
                    v147.pendingChanges.removed[v178] = nil;
                end;
                for v180, _ in pairs(v148.updated) do
                    v147.pendingChanges.updated[v180] = nil;
                end;
                local v182 = false;
                for _ in pairs(v147.pendingChanges.added) do
                    v182 = true;
                    break;
                end;
                if not v182 then
                    for _ in pairs(v147.pendingChanges.removed) do
                        v182 = true;
                        break;
                    end;
                end;
                if not v182 then
                    for _ in pairs(v147.pendingChanges.updated) do
                        v182 = true;
                        break;
                    end;
                end;
                v147.isProcessing = false;
                if v182 then
                    v147:_scheduleBatchedRefresh();
                end;
                return;
            end;
        end);
        return;
    end;
end;
v0._onChildUpdated = function(v186, v187) --[[ Line: 640 ]] --[[ Name: _onChildUpdated ]]
    v186.pendingChanges.updated[v187] = true;
    v186:_scheduleBatchedRefresh();
end;
v0._onChildAdded = function(v188, v189) --[[ Line: 645 ]] --[[ Name: _onChildAdded ]]
    v188.pendingChanges.added[v189] = true;
    v188:_scheduleBatchedRefresh();
end;
v0._onChildRemoved = function(v190, v191) --[[ Line: 651 ]] --[[ Name: _onChildRemoved ]]
    v190.pendingChanges.removed[v191] = true;
    v190.pendingChanges.added[v191] = nil;
    v190:_scheduleBatchedRefresh();
end;
v0._reflowFromChild = function(v192, v193) --[[ Line: 658 ]] --[[ Name: _reflowFromChild ]]
    local v194 = v192:_indexOf(v192:_getSortedChildren(), v193);
    if not v194 then
        v192:_layoutFromIndex(1, true);
        return;
    else
        v192:_layoutFromIndex(v194, false);
        return;
    end;
end;
v0._layoutFromIndex = function(v195, v196, v197) --[[ Line: 670 ]] --[[ Name: _layoutFromIndex ]]
    -- upvalues: v59 (copy), v68 (copy)
    local v198 = v195:_getSortedChildren();
    if #v198 == 0 then
        return;
    else
        local v199 = {};
        for _, v201 in ipairs(v198) do
            if v201.Visible ~= false then
                table.insert(v199, v201);
            end;
        end;
        if #v199 == 0 then
            return;
        else
            local v202 = v198[math.max(1, (math.min(v196, #v198)))];
            local v203 = 1;
            for v204 = 1, #v199 do
                if v199[v204] == v202 then
                    v203 = v204;
                    break;
                end;
            end;
            local v205 = {
                columns = v195.columns, 
                rows = {}
            };
            local l_v197_0 = v197;
            local v207 = {};
            for _, v209 in ipairs(v198) do
                v207[v209] = true;
            end;
            for v210, _ in pairs(v195.placements) do
                if not v207[v210] then
                    v195.placements[v210] = nil;
                end;
            end;
            for _, v213 in pairs(v195.placements) do
                if v213.col + v213.w - 1 > v195.columns then
                    l_v197_0 = true;
                    break;
                end;
            end;
            local function _(v214) --[[ Line: 721 ]] --[[ Name: getRatioFor ]]
                if (tonumber((v214:GetAttribute("Ratio"))) or 1) >= 2 then
                    return 2;
                else
                    return 1;
                end;
            end;
            local function v239(v216) --[[ Line: 728 ]] --[[ Name: placeOne ]]
                -- upvalues: v195 (copy), v59 (ref), v205 (ref), v68 (ref)
                if not v216.Parent or v216.Parent ~= v195.container then
                    return;
                else
                    local v217 = (tonumber((v216:GetAttribute("Ratio"))) or 1) >= 2 and 2 or 1;
                    local l_v217_0 = v217;
                    local l_v217_1 = v217;
                    local v220 = false;
                    local v221 = 1;
                    local v222 = 1;
                    for v223 = 1, 10000 do
                        for v224 = 1, v195.columns do
                            if v59(v205, v224, v223, l_v217_0, l_v217_1) then
                                v221 = v224;
                                v222 = v223;
                                v220 = true;
                                break;
                            end;
                        end;
                        if v220 then
                            break;
                        end;
                    end;
                    if not v220 then
                        v221 = v195.columns;
                        v222 = #v205.rows + 1;
                    end;
                    v68(v205, v221, v222, l_v217_0, l_v217_1);
                    local l_v221_0 = v221;
                    local l_v222_0 = v222;
                    local l_cellX_0 = v195.cellX;
                    local l_cellY_0 = v195.cellY;
                    local l_padX_0 = v195.padX;
                    local l_padY_0 = v195.padY;
                    local v231 = (l_v221_0 - 1) * (l_cellX_0 + l_padX_0);
                    local v232 = (l_v222_0 - 1) * (l_cellY_0 + l_padY_0);
                    local v233 = l_v217_0 * l_cellX_0 + (l_v217_0 - 1) * l_padX_0;
                    local v234 = l_v217_1 * l_cellY_0 + (l_v217_1 - 1) * l_padY_0;
                    local l_v231_0 = v231;
                    local l_v232_0 = v232;
                    local l_v233_0 = v233;
                    local l_v234_0 = v234;
                    l_v221_0 = UDim2.new(l_v231_0, 0, l_v232_0, 0);
                    l_v222_0 = UDim2.new(l_v233_0, 0, l_v234_0, 0);
                    l_cellX_0 = v195.placements[v216];
                    if l_cellX_0 and l_cellX_0.col == v221 and l_cellX_0.row == v222 and l_cellX_0.w == l_v217_0 and l_cellX_0.h == l_v217_1 then
                        l_cellY_0 = v216.Position;
                        l_padX_0 = v216.Size;
                        l_padY_0 = v216.AnchorPoint;
                        if math.abs(l_cellY_0.X.Scale - l_v231_0) > 1.0E-6 or math.abs(l_cellY_0.Y.Scale - l_v232_0) > 1.0E-6 or math.abs(l_padX_0.X.Scale - l_v233_0) > 1.0E-6 or math.abs(l_padX_0.Y.Scale - l_v234_0) > 1.0E-6 or l_padY_0 ~= Vector2.new(0, 0) then
                            v216.AnchorPoint = Vector2.new(0, 0);
                            v216.Position = l_v221_0;
                            v216.Size = l_v222_0;
                        end;
                    else
                        v216.AnchorPoint = Vector2.new(0, 0);
                        v216.Position = l_v221_0;
                        v216.Size = l_v222_0;
                    end;
                    v195.placements[v216] = {
                        col = v221, 
                        row = v222, 
                        w = l_v217_0, 
                        h = l_v217_1
                    };
                    return;
                end;
            end;
            if l_v197_0 or v203 <= 1 then
                v195.placements = {};
                v205 = {
                    columns = v195.columns, 
                    rows = {}
                };
                for v240 = 1, #v199 do
                    v239(v199[v240]);
                end;
                return;
            else
                local l_v203_0 = v203;
                for v242 = 1, v203 - 1 do
                    local v243 = v199[v242];
                    local v244 = v195.placements[v243];
                    if not v244 or v243.Parent ~= v195.container then
                        for v245 = v242, #v199 do
                            v195.placements[v199[v245]] = nil;
                        end;
                        v205 = {
                            columns = v195.columns, 
                            rows = {}
                        };
                        for v246 = 1, v242 - 1 do
                            local v247 = v199[v246];
                            local v248 = v195.placements[v247];
                            if v248 and v247.Parent == v195.container then
                                v68(v205, v248.col, v248.row, v248.w, v248.h);
                            else
                                v195.placements = {};
                                v205 = {
                                    columns = v195.columns, 
                                    rows = {}
                                };
                                l_v203_0 = 1;
                                break;
                            end;
                        end;
                        l_v203_0 = v242;
                        break;
                    elseif v244.col >= 1 and v244.col + v244.w - 1 <= v195.columns and v244.row >= 1 then
                        v68(v205, v244.col, v244.row, v244.w, v244.h);
                    else
                        for v249 = v242, #v199 do
                            v195.placements[v199[v249]] = nil;
                        end;
                        v205 = {
                            columns = v195.columns, 
                            rows = {}
                        };
                        for v250 = 1, v242 - 1 do
                            local v251 = v199[v250];
                            local v252 = v195.placements[v251];
                            if v252 and v251.Parent == v195.container and v252.col >= 1 and v252.col + v252.w - 1 <= v195.columns then
                                v68(v205, v252.col, v252.row, v252.w, v252.h);
                            end;
                        end;
                        l_v203_0 = v242;
                        break;
                    end;
                end;
                for v253 = l_v203_0, #v199 do
                    v239(v199[v253]);
                end;
                return;
            end;
        end;
    end;
end;
v0._layoutFromIndexAsync = function(v254, v255, v256, v257) --[[ Line: 858 ]] --[[ Name: _layoutFromIndexAsync ]]
    -- upvalues: v68 (copy), v59 (copy)
    if v254.layoutTask then
        task.cancel(v254.layoutTask);
        v254.layoutTask = nil;
    end;
    v254.layoutTask = task.spawn(function() --[[ Line: 865 ]]
        -- upvalues: v254 (copy), v257 (copy), v256 (copy), v255 (copy), v68 (ref), v59 (ref)
        task.wait();
        local v258 = v254:_getSortedChildren();
        local l_v257_0 = v257;
        if not l_v257_0 then
            l_v257_0 = {};
            for _, v261 in ipairs(v258) do
                if v261:IsA("GuiObject") and not v261:IsA("UIGridLayout") and v261.Visible ~= false then
                    table.insert(l_v257_0, v261);
                end;
            end;
        end;
        if #l_v257_0 == 0 then
            v254.layoutTask = nil;
            return;
        else
            local function _(v262) --[[ Line: 886 ]] --[[ Name: getRatioFor ]]
                if (tonumber((v262:GetAttribute("Ratio"))) or 1) >= 2 then
                    return 2;
                else
                    return 1;
                end;
            end;
            local v264 = {
                columns = v254.columns, 
                rows = {}
            };
            local v265 = 1;
            if v256 or v255 <= 1 then
                v254.placements = {};
                v264 = {
                    columns = v254.columns, 
                    rows = {}
                };
                v265 = 1;
            else
                local v266 = v258[math.max(1, (math.min(v255, #v258)))];
                for v267 = 1, #l_v257_0 do
                    if l_v257_0[v267] == v266 then
                        v265 = v267;
                        break;
                    end;
                end;
                for v268 = 1, v265 - 1 do
                    local v269 = l_v257_0[v268];
                    local v270 = v254.placements[v269];
                    if v270 and v269.Parent == v254.container and v270.col >= 1 and v270.col + v270.w - 1 <= v254.columns and v270.row >= 1 then
                        v68(v264, v270.col, v270.row, v270.w, v270.h);
                    else
                        v265 = v268;
                        break;
                    end;
                end;
            end;
            local function v294(v271) --[[ Line: 927 ]] --[[ Name: placeOne ]]
                -- upvalues: v254 (ref), v59 (ref), v264 (ref), v68 (ref)
                if not v271.Parent or v271.Parent ~= v254.container then
                    return;
                else
                    local v272 = (tonumber((v271:GetAttribute("Ratio"))) or 1) >= 2 and 2 or 1;
                    local l_v272_0 = v272;
                    local l_v272_1 = v272;
                    local v275 = false;
                    local v276 = 1;
                    local v277 = 1;
                    for v278 = 1, 10000 do
                        for v279 = 1, v254.columns do
                            if v59(v264, v279, v278, l_v272_0, l_v272_1) then
                                v276 = v279;
                                v277 = v278;
                                v275 = true;
                                break;
                            end;
                        end;
                        if v275 then
                            break;
                        end;
                    end;
                    if not v275 then
                        v276 = v254.columns;
                        v277 = #v264.rows + 1;
                    end;
                    v68(v264, v276, v277, l_v272_0, l_v272_1);
                    local l_v276_0 = v276;
                    local l_v277_0 = v277;
                    local l_cellX_1 = v254.cellX;
                    local l_cellY_1 = v254.cellY;
                    local l_padX_1 = v254.padX;
                    local l_padY_1 = v254.padY;
                    local v286 = (l_v276_0 - 1) * (l_cellX_1 + l_padX_1);
                    local v287 = (l_v277_0 - 1) * (l_cellY_1 + l_padY_1);
                    local v288 = l_v272_0 * l_cellX_1 + (l_v272_0 - 1) * l_padX_1;
                    local v289 = l_v272_1 * l_cellY_1 + (l_v272_1 - 1) * l_padY_1;
                    local l_v286_0 = v286;
                    local l_v287_0 = v287;
                    local l_v288_0 = v288;
                    local l_v289_0 = v289;
                    l_v276_0 = UDim2.new(l_v286_0, 0, l_v287_0, 0);
                    l_v277_0 = UDim2.new(l_v288_0, 0, l_v289_0, 0);
                    l_cellX_1 = v254.placements[v271];
                    if l_cellX_1 and l_cellX_1.col == v276 and l_cellX_1.row == v277 and l_cellX_1.w == l_v272_0 and l_cellX_1.h == l_v272_1 then
                        l_cellY_1 = v271.Position;
                        l_padX_1 = v271.Size;
                        l_padY_1 = v271.AnchorPoint;
                        if math.abs(l_cellY_1.X.Scale - l_v286_0) > 1.0E-6 or math.abs(l_cellY_1.Y.Scale - l_v287_0) > 1.0E-6 or math.abs(l_padX_1.X.Scale - l_v288_0) > 1.0E-6 or math.abs(l_padX_1.Y.Scale - l_v289_0) > 1.0E-6 or l_padY_1 ~= Vector2.new(0, 0) then
                            v271.AnchorPoint = Vector2.new(0, 0);
                            v271.Position = l_v276_0;
                            v271.Size = l_v277_0;
                        end;
                    else
                        v271.AnchorPoint = Vector2.new(0, 0);
                        v271.Position = l_v276_0;
                        v271.Size = l_v277_0;
                    end;
                    v254.placements[v271] = {
                        col = v276, 
                        row = v277, 
                        w = l_v272_0, 
                        h = l_v272_1
                    };
                    return;
                end;
            end;
            local v295 = #l_v257_0;
            local v296 = os.clock();
            for v297 = v265, v295 do
                v294(l_v257_0[v297]);
                if v297 % 5 == 0 and os.clock() - v296 > 0.004 then
                    task.wait();
                    v296 = os.clock();
                end;
            end;
            v254.layoutTask = nil;
            return;
        end;
    end);
end;
return v0;