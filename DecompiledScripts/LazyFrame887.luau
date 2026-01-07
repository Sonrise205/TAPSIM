local l_HttpService_0 = game:GetService("HttpService");
local l_GuiService_0 = game:GetService("GuiService");
local v2 = require(script.Events);
local v3 = require(script.ObjectPool);
local v4 = require(script.LazySelection);
local v5 = require(script.ScaleUtility);
local v6 = {};
local v7 = Vector2.new(0, 0);
v6.__index = v6;
v6.__iter = function(v8) --[[ Line: 15 ]]
    return next, v8._LoadedFrames;
end;
v6.__newindex = function(v9, v10, v11) --[[ Line: 19 ]]
    if v10 == "Amount" then
        rawset(v9, "_Amount", v11);
        v9:Update();
        v9:UpdateCanvasSize();
        return;
    else
        rawset(v9, v10, v11);
        return;
    end;
end;
v6.RemoveFrame = function(v12, v13) --[[ Line: 30 ]] --[[ Name: RemoveFrame ]]
    v12:RemoveFrameSelection(v12._LoadedFrames[v13], v13);
    v12._ObjectPool:Give(v12._LoadedFrames[v13]);
    v12._LoadedFrames[v13] = nil;
end;
v6.AddFrame = function(v14, v15) --[[ Line: 37 ]] --[[ Name: AddFrame ]]
    -- upvalues: v5 (copy), v7 (copy)
    local v16, v17 = v14._ObjectPool:Get();
    if v17 then
        v14.Added:Fire(v16);
    end;
    v14:UpdateSelection(v16, v15, true);
    v14.Updated:Fire(v16, v15, v16:GetAttribute(v14._Key));
    v16:SetAttribute(v14._Key, v15);
    v16.Position = v5.OffsetAnchorPoint(v16, v7, v14._GridLayout:GetOffsetPositionFromIndex(v15, v14._Amount));
    v14._LoadedFrames[v15] = v16;
    v16.Parent = v14._ScrollingFrame;
    return v16;
end;
v6.UpdateCanvasSize = function(v18) --[[ Line: 64 ]] --[[ Name: UpdateCanvasSize ]]
    v18._ScrollingFrame.CanvasSize = UDim2.new(v18._ScrollingFrame.CanvasSize.X.Scale, v18._ScrollingFrame.CanvasSize.X.Offset, 0, (math.max(1, v18._GridLayout.AbsoluteCellSize.Y * v18._GridLayout.AbsoluteCellCount.Y + v18._GridLayout.AbsoluteCellPadding.Y * (v18._GridLayout.AbsoluteCellCount.Y - 1))));
end;
v6.GetIndex = function(v19, v20) --[[ Line: 78 ]] --[[ Name: GetIndex ]]
    return v20:GetAttribute(v19._Key);
end;
v6.GetFrame = function(v21, v22) --[[ Line: 82 ]] --[[ Name: GetFrame ]]
    return v21._LoadedFrames[v22];
end;
v6.Update = function(v23) --[[ Line: 86 ]] --[[ Name: Update ]]
    if not v23._GridLayout then
        return;
    else
        local l_ContentRange_0, v25, v26, v27, v28, v29 = v23._GridLayout:GetContentRange(v23._ScrollingFrame.CanvasPosition, v23._ScrollingFrame.CanvasPosition + v23._ScrollingFrame.AbsoluteWindowSize, v23._Amount, true);
        if v23._Checklist.StartX == l_ContentRange_0 and v23._Checklist.EndX == v25 and v23._Checklist.StartY == v26 and v23._Checklist.EndY == v27 and v23._Checklist.GridCellLength == v28 then
            return;
        else
            v23._Checklist.StartX = l_ContentRange_0;
            v23._Checklist.EndX = v25;
            v23._Checklist.StartY = v26;
            v23._Checklist.EndY = v27;
            v23._Checklist.GridCellLength = v28;
            local l_CellsInRange_0 = v23._GridLayout:GetCellsInRange(l_ContentRange_0, v25, v26, v27, v28, v29);
            for v31, _ in pairs(v23._LoadedFrames) do
                if not table.find(l_CellsInRange_0, v31) then
                    v23:RemoveFrame(v31);
                end;
            end;
            for _, v34 in pairs(l_CellsInRange_0) do
                if not v23._LoadedFrames[v34] then
                    v23:AddFrame(v34);
                end;
            end;
            for _, v36 in pairs(v23._ObjectPool:GetContents()) do
                local l_v36_Attribute_0 = v36:GetAttribute(v23._Key);
                if l_v36_Attribute_0 then
                    v23.Updated:Fire(v36, nil, l_v36_Attribute_0);
                    v36:SetAttribute(v23._Key, nil);
                end;
            end;
            return;
        end;
    end;
end;
v6.UpdateAll = function(v38) --[[ Line: 137 ]] --[[ Name: UpdateAll ]]
    for v39, v40 in v38 do
        v38.Updated:Fire(v40, v39);
    end;
end;
v6.SetGridLayout = function(v41, v42) --[[ Line: 143 ]] --[[ Name: SetGridLayout ]]
    -- upvalues: v5 (copy), v7 (copy)
    v41._GridLayout = v42;
    v41._Connections.CanvasPosition = v41._Connections.CanvasPosition or v41._ScrollingFrame:GetPropertyChangedSignal("CanvasPosition"):Connect(function() --[[ Line: 147 ]]
        -- upvalues: v41 (copy)
        v41:Update();
    end);
    v41._Connections.GridLayout = v41._Connections.GridLayout or v41._GridLayout.Changed:Connect(function(v43) --[[ Line: 153 ]]
        -- upvalues: v41 (copy), v5 (ref), v7 (ref)
        v41:Update();
        v41:UpdateCanvasSize();
        if v43 == "CellSize" or v43 == "AbsoluteSize" then
            for _, v45 in pairs(v41._ObjectPool:GetContents()) do
                v41.Removed:Fire(v45);
            end;
            v41._ObjectPool:ClearExcess();
            v41._Slot.Size = v41._GridLayout.CellSize;
            for _, v47 in pairs(v41._LoadedFrames) do
                v47.Size = v41._GridLayout.CellSize;
            end;
        end;
        for v48, v49 in pairs(v41._LoadedFrames) do
            v49.Position = v5.OffsetAnchorPoint(v49, v7, v41._GridLayout:GetOffsetPositionFromIndex(v48, v41._Amount));
        end;
        v41:UpdateAllSelections();
    end);
    v41:Update();
    v41:UpdateCanvasSize();
end;
v6.SetSelectionFunction = function(v50, v51) --[[ Line: 186 ]] --[[ Name: SetSelectionFunction ]]
    -- upvalues: l_GuiService_0 (copy)
    v50._SelectionFunction = function(v52, v53) --[[ Line: 187 ]]
        -- upvalues: v51 (copy)
        return v51 and v51(v52, v53) or v52;
    end;
    v50._Connections.Selection = v50._Connections.Selection or l_GuiService_0:GetPropertyChangedSignal("SelectedObject"):Connect(function() --[[ Line: 195 ]]
        -- upvalues: v50 (copy)
        v50:HandleSelectionChanged();
    end);
    v50:UpdateAllSelections();
end;
v6.Destroy = function(v54) --[[ Line: 203 ]] --[[ Name: Destroy ]]
    for v55, v56 in pairs(v54._Connections) do
        v56:Disconnect();
        v54._Connections[v55] = nil;
    end;
end;
v6.new = function(v57, v58, v59) --[[ Line: 210 ]] --[[ Name: new ]]
    -- upvalues: v2 (copy), l_HttpService_0 (copy), v3 (copy), v6 (copy)
    local v60 = setmetatable({
        Added = v2.new(), 
        Removed = v2.new(), 
        Updated = v2.new(), 
        Amount = nil, 
        _Key = string.gsub(l_HttpService_0:GenerateGUID(false), "-", ""), 
        _GridLayout = nil, 
        _SelectionFunction = nil, 
        _SelectionConnection = nil, 
        _ScrollingFrame = v57, 
        _Slot = v58, 
        _Amount = v59, 
        _LoadedFrames = {}, 
        _Connections = {}, 
        _Checklist = {}, 
        _ObjectPool = v3.new(v58)
    }, v6);
    v58.Parent = nil;
    return v60;
end;
v6.HandleSelectionChanged = v4.HandleSelectionChanged;
v6.UpdateAllSelections = v4.UpdateAllSelections;
v6.UpdateSelection = v4.UpdateSelection;
v6.RemoveFrameSelection = v4.RemoveFrameSelection;
return v6;